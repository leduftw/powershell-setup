# powershell-setup

My PowerShell profile configuration for Windows Terminal.

## Features

- **[Oh My Posh](https://ohmyposh.dev/)** prompt using a custom theme (`ohmyposh.json` in this repo)
- **[Terminal-Icons](https://github.com/devblackops/Terminal-Icons)** for file/folder icons in the shell
- **PSReadLine** enhancements:
  - History-based inline predictions shown as a list
  - Up/Down arrow keys for history search
  - Syntax highlighting colors that automatically switch between a dark and light palette based on the Windows app theme (dark/light mode)

## Files

| File | Description |
|------|-------------|
| `Microsoft.PowerShell_profile.ps1` | PowerShell profile loaded on every session |
| `ohmyposh.json` | Oh My Posh theme configuration |

## Installation

1. Install prerequisites:
   ```powershell
   winget install JanDeDobbeleer.OhMyPosh
   Install-Module -Name Terminal-Icons -Repository PSGallery
   ```

2. Copy `Microsoft.PowerShell_profile.ps1` to your PowerShell profile location:
   ```powershell
   Copy-Item Microsoft.PowerShell_profile.ps1 $PROFILE
   ```

3. Update the Oh My Posh config path in `Microsoft.PowerShell_profile.ps1` to point to where you cloned this repo.

4. Reload the shell.
