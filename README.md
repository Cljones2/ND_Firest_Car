# Raxon's Server - ND_First_Car


Discord : https://discord.gg/VHDbgpnBbR

Welcome to **Raxon's Server**! This repository contains the **ND_First_Car** starter vehicle script for **FiveM**. New players automatically receive a free Asbo when they join the server if they don't already own one.

## Features

- **Starter Vehicle**: Players receive an Asbo as their first vehicle.
- **Unique License Plates**: Automatically generates unique plates with a customizable prefix.
- **Database Integration**: Uses `oxmysql` for seamless MySQL database operations.
- **Player Notification**: Sends a welcome message with vehicle details.
- **Debug Logging**: Clear console messages for easy troubleshooting.

## Configuration

### Default Settings

- **Starter Car**: `asbo`
- **Plate Prefix**: `NEW`

Modify these values at the top of the script to fit your server's needs:

```lua
local carModel = "asbo"          -- Change this to any vehicle model you prefer
local carPlatePrefix = "NEW"     -- Customize the plate prefix
```

## Installation


1. **Add to `server.cfg`**:
   ```cfg
   ensure ND_First_Car
   ```

2. **Restart the Server**:
   ```bash
   restart ND_First_Car
   ```

## Dependencies

- **oxmysql**: Ensure `oxmysql` is installed and properly configured on your server.

## How It Works

1. When a player joins, the script checks if they already own an Asbo.
2. If they don't, it generates a unique plate and adds the vehicle to their garage.
3. The player receives a welcome message with their new vehicle details.

## Contribution

We welcome contributions! If you have ideas, enhancements, or bug fixes, feel free to create a pull request.

## License

This project is licensed under the [MIT License](LICENSE).

## Contact

- **Discord**: [Join Our Community](https://discord.gg/raxons-server)
- **Website**: [raxons-server.com](https://www.raxons-server.com)

---

Happy driving on **Raxon's Server**! ⚙️ 🚗

![Banner](https://via.placeholder.com/728x90.png?text=Raxon's+Server)

