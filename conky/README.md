# Conky setting

This conky configuration is derived from a config found on reddit, hence the name.

## Installation

- Install all of the `.ttf` fonts provided in this directory
- assuming have this repo cloned to `/home/jeff/src/misc`, no script updates are needed
- Place the `conky-toggle.sh` (via ln or renaming to drop the `.sh` suffix, make executable via `chmod +x`) into `/usr/bin` (this seems to be needed so that app picker can validate the `.desktop` file)
- Place `conky-toggle.desktop` into `~/.local/share/applications`

You should now be able to run `conky-toggle` and it should behave as expected.
