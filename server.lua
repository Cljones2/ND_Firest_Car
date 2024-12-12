-- Configuration for the starter car
local carModel = "asbo" -- The car model given to players as a starter car
local carPlatePrefix = "NEW" -- Prefix for car plates to identify starter cars

-- Function to generate a unique plate
local function generateUniquePlate()
    local plate
    local isUnique = false

    while not isUnique do
        plate = carPlatePrefix .. math.random(1000, 9999) -- Generate a random plate
        print("Generated plate: " .. plate) -- Debug message
        local result = exports.oxmysql:scalarSync('SELECT COUNT(*) FROM nd_vehicles WHERE plate = @plate', {['@plate'] = plate})
        
        if result == 0 then
            isUnique = true -- Plate is unique, exit loop
            print("Unique plate found: " .. plate) -- Debug message
        end
    end

    return plate
end

-- Function to check if a player owns an Asbo and give it if they don't
RegisterServerEvent('playerJoining')
AddEventHandler('playerJoining', function()
    local src = source
    local playerIdentifier = GetPlayerIdentifier(src)
    print("Player joining with identifier: " .. playerIdentifier) -- Debug message

    -- Fetch the active character's `charid` from `nd_characters`
    exports.oxmysql:scalar('SELECT charid FROM nd_characters WHERE identifier = @identifier', {
        ['@identifier'] = playerIdentifier
    }, function(characterId)
        if not characterId then
            print("Error: Character ID not found for player with identifier: " .. playerIdentifier)
            return -- Exit if no character ID is found
        else
            print("Character ID found: " .. characterId) -- Debug message
        end

        -- Check if this character already owns an Asbo
        exports.oxmysql:scalar('SELECT COUNT(*) FROM nd_vehicles WHERE owner = @characterId AND properties LIKE @vehicleModel', {
            ['@characterId'] = characterId,
            ['@vehicleModel'] = '%' .. carModel .. '%'
        }, function(asboCount)
            print("Asbo count for character " .. characterId .. ": " .. asboCount) -- Debug message

            if asboCount == 0 then
                -- Character doesn't own an Asbo, so give them one with a unique plate
                local plate = generateUniquePlate()
                print("Assigning Asbo to character " .. characterId .. " with plate: " .. plate) -- Debug message

                exports.oxmysql:execute('INSERT INTO nd_vehicles (owner, plate, properties) VALUES (@owner, @plate, @vehicle)', {
                    ['@owner'] = characterId, -- Use character ID here
                    ['@plate'] = plate,
                    ['@vehicle'] = json.encode({ model = carModel, plate = plate })
                }, function(rowsChanged)
                    if rowsChanged > 0 then
                        print("Successfully added Asbo to character " .. characterId .. " with plate " .. plate) -- Success message
                    else
                        print("Failed to insert Asbo for character " .. characterId) -- Failure message
                    end
                end)

                -- Send notification to the player
                TriggerClientEvent('chat:addMessage', src, {
                    color = {255, 0, 0},
                    multiline = true,
                    args = {"Server", "Welcome to the city! You've received an Asbo as a starter vehicle with plate " .. plate .. "!"}
                })
            else
                print("Character " .. characterId .. " already owns an Asbo. No car given.") -- Debug message
            end
        end)
    end)
end)
