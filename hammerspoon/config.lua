-- Specify Spoons which will be loaded (https://github.com/ashfinal/awesome-hammerspoon/wiki/The-built-in-Spoons)
hspoon_list = {
    "AClock",
    -- "BingDaily",
    -- "Calendar",
    "CircleClock",
    "ClipShow",
    "CountDown",
    "FnMate",
    "HCalendar",
    "HSaria2",
    "HSearch",
    "KSheet",
    "SpeedMenu",
    -- "TimeFlow",
    -- "UnsplashZ",
    "WinWin",
}

-- appM environment keybindings. Bundle `id` is prefered, but application `name` will be ok.
hsapp_list = {
    {key = 'a', name = 'Alacritty'},
    {key = 'b', name = 'Brave Browser'},
    {key = 'c', id   = 'com.google.Chrome'},
    {key = 'd', name = 'darktable'},
    {key = 'e', name = 'Evernote'},
    {key = 'f', name = 'Firefox'},
    {key = 'i', name = 'IntelliJ IDEA CE'},
    {key = 'k', name = 'Kitty'},
    {key = 'l', name = 'Sublime Text'},
    {key = 'm', name = 'Mail'},
    {key = 'o', name = 'Finder'},
    {key = 'p', name = 'Postman'},
    {key = 'r', name = 'VimR'},
    {key = 's', name = 'Slack'},
    {key = 't', name = 'Typora'},
    {key = 'v', name = 'Visual Studio Code'},
    {key = 'w', name = 'KeePassXC'},
    {key = 'x', id   = 'com.apple.ActivityMonitor'},
    {key = 'y', id   = 'com.apple.systempreferences'},
}

-- Modal supervisor keybinding, which can be used to temporarily disable ALL modal environments.
hsupervisor_keys = {{"cmd", "shift", "ctrl"}, "Q"}

-- Reload Hammerspoon configuration
hsreload_keys = {{"cmd", "shift", "ctrl"}, "R"}

-- Toggle help panel of this configuration.
hshelp_keys = {{"alt", "shift"}, "/"}

-- aria2 RPC host address
hsaria2_host = "http://localhost:6800/jsonrpc"
-- aria2 RPC host secret
hsaria2_secret = "token"

----------------------------------------------------------------------------------------------------
-- Those keybindings below could be disabled by setting to {"", ""} or {{}, ""}

-- Window hints keybinding: Focuse to any window you want
hswhints_keys = {"alt", "tab"}

-- appM environment keybinding: Application Launcher
hsappM_keys = {"alt", "A"}

-- clipshowM environment keybinding: System clipboard reader
hsclipsM_keys = {"alt", "C"}

-- Toggle the display of aria2 frontend
hsaria2_keys = {"alt", "D"}

-- Launch Hammerspoon Search
hsearch_keys = {"alt", "G"}

-- Read Hammerspoon and Spoons API manual in default browser
hsman_keys = {"alt", "H"}

-- countdownM environment keybinding: Visual countdown
hscountdM_keys = {"alt", "I"}

-- Lock computer's screen
hslock_keys = {"alt", "L"}

-- resizeM environment keybinding: Windows manipulation
hsresizeM_keys = {"alt", "R"}

-- cheatsheetM environment keybinding: Cheatsheet copycat
hscheats_keys = {"alt", "S"}

-- Show digital clock above all windows
hsaclock_keys = {"alt", "T"}

-- Type the URL and title of the frontmost web page open in Google Chrome or Safari.
hstype_keys = {"alt", "V"}

-- Toggle Hammerspoon console
hsconsole_keys = {"alt", "Z"}
