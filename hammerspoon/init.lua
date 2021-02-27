hs.logger.defaultLogLevel="info"
-- disable animations
hs.window.animationDuration = 0
-- disable hotkey alerts
hs.hotkey.alertDuration = 0

-- Dark console
if not hs.console.darkMode() then
	hs.console.outputBackgroundColor({ white = 0.1 })
	hs.console.consolePrintColor({ white = 1 })
	hs.console.consoleResultColor({ white = 0.8 })
	hs.console.consoleCommandColor({ white = 1 })
end

-- reload configuration
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "R", function()
	hs.reload()
end)

-- lock screen
hs.hotkey.bind({"alt"}, "L", function()
	hs.caffeinate.lockScreen()
end)

-- windowHints
hs.hints.showTitleThresh = 14
hs.hints.titleMaxSize = 24
hs.hints.fontSize = 18
hs.hotkey.bind({"alt"}, "Tab", function()
	-- display hints for all applications
	hs.hints.windowHints()
end)
hs.hotkey.bind({"alt"}, "S", function()
	-- display hints only for the currently focused application
	hs.hints.windowHints(hs.window.focusedWindow():application():allWindows())
end)

-- hammerspoon console
hs.hotkey.bind({"alt"}, "Z", function()
	hs.toggleConsole()
end)

-- SpoonInstall Spoon
hs.loadSpoon("SpoonInstall")
-- spoon.SpoonInstall.use_syncinstall=true
Install=spoon.SpoonInstall

-- ModalMgr Spoon
Install:andUse("ModalMgr")

Install:andUse("AppLauncher", {
	hotkeys = {
		a = "Alacritty",
		b = "Brave Browser",
		c = "Google Chrome",
		e = "Evernote",
		f = "Firefox",
		i = "IntelliJ IDEA CE",
		j = "Joplin",
		k = "Kitty",
		m = "Mail",
		n = "Notes",
		o = "Finder",
		p = "1Password 7",
		r = "VimR",
		s = "Slack",
		t = "Typora",
		v = "VSCodium",
		x = "KeePassXC",
		y = "Activity Monitor",
		z = "Zscaler",
	},
	config = {
		modifiers = {"alt", "shift"}
	},
})

Install:andUse("Seal",
	{
		hotkeys = { show = { {"cmd"}, "space" } },
		fn = function(s)
			s:loadPlugins({"apps", "calc", "screencapture", "useractions", "pasteboard"})
			s.plugins.pasteboard.historySize=400

			defaultIcon=hs.image.systemImageNames.ApplicationIcon
			s.plugins.useractions.actions = {
				["Sumologic PR"] = {
					url = "https://github.com/Sanyaku/sumologic/pull/${query}",
					icon=hs.image.imageFromName(defaultIcon),
					keyword="pr"
				},
				["Knobs PR"] = {
					url = "https://github.com/Sanyaku/knobs/pull/${query}",
					icon=hs.image.imageFromName(defaultIcon),
					keyword="prk"
				},
				["Jira Ticket"] = {
					url = "https://jira.kumoroku.com/jira/browse/SUMO-${query}",
					icon=hs.image.imageFromName(defaultIcon),
					keyword="jira"
				},
				["Jira Search"] = {
					url = "https://jira.kumoroku.com/jira/secure/QuickSearch.jspa?searchString=${query}",
					icon=hs.image.imageFromName(defaultIcon),
					keyword="jirg"
				},
				["Wiki"] = {
					url = "https://wiki.kumoroku.com/confluence/dosearchsite.action?queryString=${query}",
					icon=hs.image.imageFromName(defaultIcon),
					keyword="wiki"
				},
				["PR Tracker"] = {
					url = "https://is-my-commit-there-yet.kumoroku.com/backend/?id=${query}",
					icon=hs.image.imageFromName(defaultIcon),
					keyword="trk"
				},
				["Mail"] = {
					url = "https://mail.google.com/mail/u/0/#search/${query}",
					icon=hs.image.imageFromName(defaultIcon),
				--   icon="favicon",
					keyword="mail"
				},
				["Dark Mode"] = {
					fn = function()
						toggleDarkMode='tell app "System Events" to tell appearance preferences to set dark mode to not dark mode'
						hs.osascript.applescript(toggleDarkMode)
					end,
				},
			}
			s:refreshAllCommands()
		end,
		start = true,
	}
)

Install:andUse("ClipboardTool", {
		hotkeys = {
			toggle_clipboard = { {"alt"}, "v"},
		},
		config =  {
			hist_size = 500,
			paste_on_select = true,
			show_copied_alert = false,
			show_in_menubar = false,
		},
		start = true,
})

Install:andUse("HCalendar", {
	config = {
		showProgress = true
	},
})

Install:andUse("AClock", {
	config = {
		format = "%HH:%MM"
	},
	fn = function(s)
		-- spoon.ModalMgr.supervisor:bind("{alt}", "T" "Toggle Floating Clock", function() spoon.AClock:toggleShow() end)
		hs.hotkey.bind({"alt"}, "T", function()
			s:toggleShow()
		end)
	end,
})

Install:andUse("KSheet", {
	fn = function(s)
		hs.hotkey.bind({"alt"}, "K", function()
			spoon.KSheet:show()
		end)
		hs.hotkey.bind({"ctrl", "alt"}, "K", function()
			spoon.KSheet:hide()
		end)
	end,
})

Install:andUse("SpeedMenu")

-- resizeM modal environment
Install:andUse("WinWin")
if spoon.WinWin then
	spoon.ModalMgr:new("resizeM")
	local cmodal = spoon.ModalMgr.modal_list["resizeM"]
	cmodal:bind('', 'escape', 'Deactivate resizeM', function() spoon.ModalMgr:deactivate({"resizeM"}) end)
	cmodal:bind('', 'Q', 'Deactivate resizeM', function() spoon.ModalMgr:deactivate({"resizeM"}) end)
	cmodal:bind('', 'tab', 'Toggle Cheatsheet', function() spoon.ModalMgr:toggleCheatsheet() end)
	cmodal:bind('', 'A', 'Move Leftward', function() spoon.WinWin:stepMove("left") end, nil, function() spoon.WinWin:stepMove("left") end)
	cmodal:bind('', 'D', 'Move Rightward', function() spoon.WinWin:stepMove("right") end, nil, function() spoon.WinWin:stepMove("right") end)
	cmodal:bind('', 'W', 'Move Upward', function() spoon.WinWin:stepMove("up") end, nil, function() spoon.WinWin:stepMove("up") end)
	cmodal:bind('', 'S', 'Move Downward', function() spoon.WinWin:stepMove("down") end, nil, function() spoon.WinWin:stepMove("down") end)
	cmodal:bind('', 'Y', 'NorthWest Corner', function() spoon.WinWin:moveAndResize("cornerNW") end)
	cmodal:bind('', 'O', 'NorthEast Corner', function() spoon.WinWin:moveAndResize("cornerNE") end)
	cmodal:bind('', 'U', 'SouthWest Corner', function() spoon.WinWin:moveAndResize("cornerSW") end)
	cmodal:bind('', 'I', 'SouthEast Corner', function() spoon.WinWin:moveAndResize("cornerSE") end)
	cmodal:bind('', 'C', 'Center Window', function() spoon.WinWin:moveAndResize("center") end)
	cmodal:bind('', '=', 'Stretch Outward', function() spoon.WinWin:moveAndResize("expand") end, nil, function() spoon.WinWin:moveAndResize("expand") end)
	cmodal:bind('', '-', 'Shrink Inward', function() spoon.WinWin:moveAndResize("shrink") end, nil, function() spoon.WinWin:moveAndResize("shrink") end)
	cmodal:bind('shift', 'H', 'Move Leftward', function() spoon.WinWin:stepResize("left") end, nil, function() spoon.WinWin:stepResize("left") end)
	cmodal:bind('shift', 'L', 'Move Rightward', function() spoon.WinWin:stepResize("right") end, nil, function() spoon.WinWin:stepResize("right") end)
	cmodal:bind('shift', 'K', 'Move Upward', function() spoon.WinWin:stepResize("up") end, nil, function() spoon.WinWin:stepResize("up") end)
	cmodal:bind('shift', 'J', 'Move Downward', function() spoon.WinWin:stepResize("down") end, nil, function() spoon.WinWin:stepResize("down") end)
	cmodal:bind('', 'left', 'Move to Left Monitor', function() spoon.WinWin:moveToScreen("left") end)
	cmodal:bind('', 'right', 'Move to Right Monitor', function() spoon.WinWin:moveToScreen("right") end)
	cmodal:bind('', 'up', 'Move to Above Monitor', function() spoon.WinWin:moveToScreen("up") end)
	cmodal:bind('', 'down', 'Move to Below Monitor', function() spoon.WinWin:moveToScreen("down") end)
	cmodal:bind('', 'space', 'Move to Next Monitor', function() spoon.WinWin:moveToScreen("next") end)
	cmodal:bind('', '[', 'Undo Window Manipulation', function() spoon.WinWin:undo() end)
	cmodal:bind('', ']', 'Redo Window Manipulation', function() spoon.WinWin:redo() end)
	cmodal:bind('', '`', 'Center Cursor', function() spoon.WinWin:centerCursor() end)

	cmodal:bind('', 'H', 'Lefthalf of Screen', function()
		spoon.WinWin:moveAndResize("halfleft")
		spoon.ModalMgr:deactivate({"resizeM"})
	end)
	cmodal:bind('', 'L', 'Righthalf of Screen', function()
		spoon.WinWin:moveAndResize("halfright")
		spoon.ModalMgr:deactivate({"resizeM"})
	end)
	cmodal:bind('', 'K', 'Uphalf of Screen', function()
		spoon.WinWin:moveAndResize("halfup")
		spoon.ModalMgr:deactivate({"resizeM"})
	end)
	cmodal:bind('', 'J', 'Downhalf of Screen', function()
		spoon.WinWin:moveAndResize("halfdown")
		spoon.ModalMgr:deactivate({"resizeM"})
	end)
	cmodal:bind('', 'F', 'Fullscreen', function()
		hs.window.focusedWindow():toggleFullScreen()
		spoon.ModalMgr:deactivate({"resizeM"})
	end)
	cmodal:bind('', 'M', 'Maximized', function()
		hs.window.focusedWindow():maximize()
		spoon.ModalMgr:deactivate({"resizeM"})
	end)
	cmodal:bind('shift', 'M', 'Minimized', function()
		hs.window.focusedWindow():minimize()
		spoon.ModalMgr:deactivate({"resizeM"})
	end)

	-- Register resizeM with modal supervisor
	spoon.ModalMgr.supervisor:bind({"alt"}, "R", "Enter resizeM Environment", function()
		-- Deactivate some modal environments or not before activating a new one
		spoon.ModalMgr:deactivateAll()
		-- Show an status indicator so we know we're in some modal environment now
		spoon.ModalMgr:activate({"resizeM"}, "#C51837")
	end)
end

-- initialize ModalMgr supervisor
spoon.ModalMgr.supervisor:enter()

-- Install:andUse("ClipShow", {
	-- fn = function(s)
	--     spoon.ModalMgr:new("clipshowM")
	--     local cmodal = spoon.ModalMgr.modal_list["clipshowM"]
	--     cmodal:bind('', 'escape', 'Deactivate clipshowM', function()
	--         spoon.ClipShow:toggleShow()
	--         spoon.ModalMgr:deactivate({"clipshowM"})
	--     end)
	--     cmodal:bind('', 'B', 'Open in Browser', function()
	--         spoon.ClipShow:openInBrowserWithRef()
	--         spoon.ClipShow:toggleShow()
	--         spoon.ModalMgr:deactivate({"clipshowM"})
	--     end)

	--     hsclipsM_keys = hsclipsM_keys or {"alt", "C"}
	--     spoon.ModalMgr.supervisor:bind(hsclipsM_keys[1], hsclipsM_keys[2], "Enter clipshowM Environment", function()
	--         spoon.ClipShow:toggleShow()
	--     end)
	-- end,
-- })


hs.notify.show("Mjolnir loaded... 🔨", "️", "")

