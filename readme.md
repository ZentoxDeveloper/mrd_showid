# MRD Show ID Script

A standalone FiveM script that allows players to show their IDs to nearby players within a configurable distance. The script includes features such as:

- Displaying player IDs
- Configurable ID formats (Steam, License, or Name)
- Draw distance and visibility settings

## Features

- IDs are hidden through walls.
- Option to display IDs in different formats (`steam`, `license`, or `name`).
- Configurable key and chat command to toggle the ID display.

## Requirements

- This is a standalone script; the only requirement is a running FiveM server.

## Installation

### 1. Download & Extract

1. Download the latest version of the script from the [GitHub Releases](https://github.com/ZentoxDeveloper/mrd_showid).
2. Extract the contents into your FiveM resources folder.

### 2. Add to `server.cfg`

Add the following line to your `server.cfg` to ensure the script starts with your server:

```bash
ensure mrd_showid
```

### 3. Configuration

Open the `config.lua` file to adjust the script to your preferences:

- **Keybinding**: Change the key used to display the ID by modifying the `mrd_showid.key` value. Default is `323` (X).
- **Display Method**: Select how the ID is displayed by setting `mrd_showid.which` to either `"steam"`, `"license"`, or `"name"`.
- **Chat Command**: The chat command used to show IDs can be customized by changing `mrd_showid.commandName`. Default is `/id`.
- **Draw Distance**: Adjust how far players can see IDs by changing the `mrd_showid.drawDistance`. Default is `15` meters.

Example config:

```lua
mrd_showid.key = 323 -- The keybind for showing players their IDs
mrd_showid.which = "" -- Keep empty for player ID. Optional settings: "steam", "steamv2", "license", "licensev2", "name"
mrd_showid.commandName = "id" -- The chat command to show IDs of players for a few seconds
mrd_showid.drawDistance = 15 -- The maximum distance between the players
```

## Usage

- **Toggling ID Display**:
  Players can temporarily enable the ID display for 5 seconds by using the `/id` chat command or by pressing the configured key (`X` by default).

- **ID Display**:
  Once the ID display is enabled, the script automatically shows the IDs of nearby players who are within the configured distance and have a clear line of sight. This means you need to enable the display via the command or key to see the IDs.

## Contributing

If you wish to contribute to this project, feel free to fork the repository and submit a pull request with your improvements!

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
