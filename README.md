# windsurf-debug-devcontainer-example

This is an example Dev Container project for the Windsurf support team to debug their Dev Container implementation. This repository provides a working example that functions correctly in VSCode and Cursor.

## Purpose

This repository demonstrates a functional Dev Container setup that can be used as a reference for debugging Windsurf's Dev Container support.

## How to Use

1. **Clone this repository**
   ```bash
   git clone https://github.com/caylent-solutions/windsurf-debug-devcontainer-example.git
   cd windsurf-debug-devcontainer-example
   ```

2. **Open in VSCode**
   ```bash
   code .
   ```

3. **Reopen in Dev Container**
   - Open the Command Palette (`Ctrl+Shift+P` or `Cmd+Shift+P` on Mac)
   - Type "Dev Containers"
   - Select "Dev Containers: Reopen in Container"

The Dev Container will build and start automatically. This setup works correctly in VSCode and Cursor, and can be used as a reference for Windsurf implementation.

## What's Included

- `.devcontainer/` - Dev Container configuration and setup scripts
- Example environment configuration files
- Post-create setup automation

## Verified Working In

- ✅ VSCode
- ✅ Cursor
- ❌ Windsurf (failing with persistent error)

## Known Issue

The error documented in `devcontainer-build-output.log` has been occurring in Windsurf for approximately 3 months across all releases:

```
[Error - 14:31:42.352] Failed to change server installation script owner: chown: cannot access '/tmp/fb22c3649f560e95548e87ef.sh': No such file or directory
```

This error prevents Dev Containers from functioning properly in Windsurf, while the same configuration works correctly in both VSCode and Cursor.
