# --- your existing config ----------------------------------------------------
oh-my-posh --init --shell pwsh --config "C:\Users\Dusko\Desktop\ohmyposh.json" | Invoke-Expression

Import-Module -Name Terminal-Icons

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

Set-PSReadLineKeyHandler -Key UpArrow   -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
# -----------------------------------------------------------------------------


# === PSReadLine auto light/dark colors =======================================

# Palette for DARK theme (tuned for One Half Dark / typical dark bg)
$script:PsrlDarkColors = @{
    Default           = 'White'
    Command           = 'White'
    Parameter         = 'Cyan'
    Operator          = 'DarkGray'
    Variable          = 'Green'
    String            = 'Cyan'
    Number            = 'Magenta'
    Type              = 'Green'
    Comment           = 'DarkGreen'
    Keyword           = 'Green'
    InlinePrediction  = 'DarkGray'
    Error             = 'Red'
}

# Palette for LIGHT theme (tuned for One Half Light / white-ish bg)
$script:PsrlLightColors = @{
    Default           = 'Black'
    Command           = 'Black'
    Parameter         = 'DarkBlue'
    Operator          = 'DarkGray'
    Variable          = 'DarkCyan'
    String            = 'DarkRed'
    Number            = 'DarkGreen'
    Type              = 'DarkCyan'
    Comment           = 'DarkGreen'
    Keyword           = 'DarkMagenta'
    InlinePrediction  = 'DarkGray'
    Error             = 'Red'
}

function Update-PSReadLineTheme {
    try {
        $keyPath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize'
        $appsLight = (Get-ItemProperty -Path $keyPath -Name AppsUseLightTheme -ErrorAction Stop).AppsUseLightTheme
    }
    catch {
        return
    }

    if ($appsLight -eq 1) {
        # OS apps theme = LIGHT -> apply light palette
        Set-PSReadLineOption -Colors $script:PsrlLightColors
    }
    else {
        # OS apps theme = DARK -> apply dark palette
        Set-PSReadLineOption -Colors $script:PsrlDarkColors
    }
}

# Wrap existing prompt (oh-my-posh) so we can hook the theme update
if (-not $script:OriginalPrompt) {
    $script:OriginalPrompt = $function:prompt
}

function prompt {
    Update-PSReadLineTheme
    if ($script:OriginalPrompt) {
        & $script:OriginalPrompt
    }
    else {
        "PS $PWD> "
    }
}

# === end PSReadLine auto light/dark ==========================================
