# -*- coding: utf-8 -*-
# autostart = true

import re
from xkeysnail.transform import *  # noqa

define_global_bypassed_combo([
    K("C-Key_1"),
    K("C-Key_2"),
    K("C-Key_3"),
    K("C-Key_4"),
    K("C-Key_5"),
    K("Super-Tab"),
    K("Super-Grave"),
    K("Super-Shift-Tab"),
    K("Super-Shift-Grave"),
    K("Shift-Ctrl-H"),
    K("Shift-Ctrl-L")
])

# Use the following for testing terminal keymaps
# terminals = [ "", ... ]
# xbindkeys -mk
terminals = [
    "alacritty",
    "cutefish-terminal",
    "io.elementary.terminal",
    "kinto-gui.py",
    "kitty",
    "yakuake",
    "konsole",
    "mate-terminal",
    "station",
    "terminator",
    "termite",
    "urxvt",
    "code",
]
terminals = [term.casefold() for term in terminals]
termStr = "|".join(str('^'+x+'$') for x in terminals)

# Add remote desktop clients & VM software here
# Ideally we'd only exclude the client window,
# but that may not be easily done.
remotes = [
    "Gnome-boxes",
    "org.remmina.Remmina",
    "remmina",
    "qemu-system-.*",
    "qemu",
    "Spicy",
    "Virt-manager",
    "VirtualBox",
    "VirtualBox Machine",
    "xfreerdp",
    "Wfica",
]
remotes = [client.casefold() for client in remotes]
remotesStr = "|".join(str('^'+x+'$') for x in remotes)

# Add remote desktop clients & VMs for no remapping
terminals.extend(remotes)

# Use for browser specific hotkeys
browsers = [
    "Brave-browser",
    "Chromium",
    "Chromium-browser",
    "Discord",
    "Epiphany",
    "Firefox",
    "Firefox Developer Edition",
    "Navigator",
    "firefoxdeveloperedition",
    "Waterfox",
    "Google-chrome",
    "microsoft-edge",
    "microsoft-edge-dev",
    "org.deepin.browser",
]
browsers = [browser.casefold() for browser in browsers]
browserStr = "|".join(str('^'+x+'$') for x in browsers)

chromes = [
    "Brave-browser",
    "Chromium",
    "Chromium-browser",
    "Google-chrome",
    "microsoft-edge",
    "microsoft-edge-dev",
    "org.deepin.browser",
]
chromes = [chrome.casefold() for chrome in chromes]
chromeStr = "|".join(str('^'+x+'$') for x in chromes)

# edges = ["microsoft-edge-dev","microsoft-edge"]
# edges = [edge.casefold() for edge in edges]
# edgeStr = "|".join(str('^'+x+'$') for x in edges)

# Fix for avoiding modmapping when using Synergy keyboard/mouse sharing.
# Synergy doesn't set a wm_class, so this may cause issues with other
# applications that also don't set the wm_class.
# Enable only if you use Synergy.
# define_conditional_modmap(lambda wm_class: wm_class == '', {})

# [Global modemap] Change modifier keys as in xmodmap
define_conditional_modmap(lambda wm_class: wm_class.casefold() not in terminals, {
    # - Mac Only
    Key.LEFT_META: Key.RIGHT_CTRL,  # Mac
    Key.LEFT_CTRL: Key.LEFT_META,   # Mac
    # Key.RIGHT_META: Key.RIGHT_CTRL, # Mac - Multi-language (Remove)
    # Key.RIGHT_CTRL: Key.RIGHT_META, # Mac - Multi-language (Remove)
})

##############################################
### START OF FILE MANAGER GROUP OF KEYMAPS ###
##############################################

# Keybindings overrides for Dolphin
# (overrides some bindings from general file manager code block below)
define_keymap(re.compile("^dolphin$", re.IGNORECASE), {
    K("RC-KEY_2"):      K("C-KEY_3"),           # View as List (Detailed)
    K("RC-KEY_3"):      K("C-KEY_2"),           # View as List (Compact)
    ##########################################################################################
    # "Open in new window" requires manually setting custom shortcut of Ctrl+Shift+o
    # in Dolphin's keyboard shortcuts. There is no default shortcut set for this function.
    ##########################################################################################
    # "Open in new tab" requires manually setting custom shortcut of Ctrl+Shift+o in
    # Dolphin's keyboard shortcuts. There is no default shortcut set for this function.
    ##########################################################################################
    # Open in new window (or new tab, user's choice, see above)
    K("RC-Super-o"):    K("RC-Shift-o"),
    K("RC-Shift-N"):    K("F10"),               # Create new folder
    K("RC-comma"):      K("RC-Shift-comma"),    # Open preferences dialog
}, "Overrides for Dolphin - Finder Mods")


filemanagers = [
    "caja",
    "cutefish-filemanager",
    "dde-file-manager",
    "dolphin",
    "io.elementary.files",
    "nautilus",
    "nemo",
    "org.gnome.nautilus",
    "pcmanfm",
    "pcmanfm-qt",
    "spacefm",
    "thunar",
]
filemanagers = [filemanager.casefold() for filemanager in filemanagers]
filemanagerStr = "|".join(str('^'+x+'$') for x in filemanagers)

# Currently supported Linux file managers (file browsers):
#
# Caja File Browser (MATE file manager, fork of Nautilus)
# DDE File Manager (Deepin Linux file manager)
# Dolphin (KDE file manager)
# Nautilus (GNOME file manager, may be named "Files")
# Nemo (Cinnamon file manager, fork of Nautilus, may be named "Files")
# Pantheon Files (elementary OS file manager, may be named "Files")
# PCManFM (LXDE file manager)
# PCManFM-Qt (LXQt file manager)
# SpaceFM (Fork of PCManFM file manager)
# Thunar File Manager (Xfce file manager)
#
# Keybindings for general Linux file managers group:
define_keymap(re.compile(filemanagerStr, re.IGNORECASE), {
    ###########################################################################################################
    ###  Show Properties (Get Info) | Open Settings/Preferences | Show/Hide hidden files                    ###
    ###########################################################################################################
    # File properties dialog (Get Info)
    K("RC-i"):                  K("Alt-Enter"),
    # Open preferences dialog
    K("RC-comma"):              [K("Alt-E"), K("N")],
    # Show/hide hidden files ("dot" files)
    K("RC-Shift-dot"):          K("RC-H"),
    ###########################################################################################################
    ###  Navigation                                                                                         ###
    ###########################################################################################################
    K("RC-Left_Brace"):         K("Alt-Left"),        # Go Back
    K("RC-Right_Brace"):        K("Alt-Right"),       # Go Forward
    K("RC-Left"):               K("Alt-Left"),        # Go Back
    K("RC-Right"):              K("Alt-Right"),       # Go Forward
    K("RC-Up"):                 K("Alt-Up"),          # Go Up dir
    # K("RC-Down"):               K("Alt-Down"),        # Go Down dir (only works on folders) [not universal]
    # K("RC-Down"):               K("RC-O"),          # Go Down dir (open folder/file) [not universal]
    # Go Down dir (open folder/file) [universal]
    K("RC-Down"):               K("Enter"),
    K("RC-Shift-Left_Brace"):   K("C-Page_Up"),     # Go to prior tab
    K("RC-Shift-Right_Brace"):  K("C-Page_Down"),   # Go to next tab
    K("RC-Shift-Left"):         K("C-Page_Up"),     # Go to prior tab
    K("RC-Shift-Right"):        K("C-Page_Down"),   # Go to next tab
    ###########################################################################################################
    ###  Open in New Window | Move to Trash | Duplicate file/folder                                         ###
    ###########################################################################################################
    # Open in new window (or tab, depends on FM setup) [not universal]
    K("RC-Super-o"):    K("RC-Shift-o"),
    K("RC-Backspace"):  K("Delete"),	        # Move to Trash (delete)
    # K("RC-D"):          [K("RC-C"),K("RC-V")],  # Duplicate file/folder (Copy, then Paste) [conflicts with "Add Bookmark"]
    ###########################################################################################################
    ###  To enable renaming files with the Enter key, uncomment the two keymapping lines just below this.   ###
    ###  Use Ctrl+Shift+Enter to escape or activate text fields such as "[F]ind" and "[L]ocation" fields.   ###
    ###########################################################################################################
    # K("Enter"):             K("F2"),            # Rename with Enter key
    # K("RC-Shift-Enter"):    K("Enter"),         # Remap alternative "Enter" key to easily activate/exit text fields
    # K("RC-Shift-Enter"):    K("F2"),            # Rename with Cmd+Shift+Enter
}, "General File Managers - Finder Mods")

############################################
### END OF FILE MANAGER GROUP OF KEYMAPS ###
############################################

define_keymap(re.compile(chromeStr, re.IGNORECASE), {
    K("C-comma"): [K("Alt-e"), K("Shift-s")],         # Open preferences
    # Quit Chrome(s) browsers with Cmd+Q
    K("RC-q"):              K("Alt-F4"),
    K("RC-Y"):              K("C-h"),                              # History

    # Page nav: Back to prior page in history
    K("RC-Left_Brace"):     K("Alt-Left"),
    # Page nav: Forward to next page in history
    K("RC-Right_Brace"):    K("Alt-Right"),
}, "Chrome Browsers")

# Keybindings for General Web Browsers
define_keymap(re.compile(browserStr, re.IGNORECASE), {
    K("RC-Q"): K("C-Q"),           # Close all browsers Instances
    K("Alt-RC-I"): K("RC-Shift-I"),   # Dev tools
    K("Alt-RC-J"): K("RC-Shift-J"),   # Dev tools
    K("RC-Key_1"): K("Alt-Key_1"),    # Jump to Tab #1-#8
    K("RC-Key_2"): K("Alt-Key_2"),
    K("RC-Key_3"): K("Alt-Key_3"),
    K("RC-Key_4"): K("Alt-Key_4"),
    K("RC-Key_5"): K("Alt-Key_5"),
    K("RC-Key_6"): K("Alt-Key_6"),
    K("RC-Key_7"): K("Alt-Key_7"),
    K("RC-Key_8"): K("Alt-Key_8"),
    K("RC-Key_9"): K("Alt-Key_9"),    # Jump to last tab
    # Enable Cmd+Shift+Braces for tab navigation
    K("RC-Shift-Left_Brace"):   K("C-Page_Up"),     # Go to prior tab
    K("RC-Shift-Right_Brace"):  K("C-Page_Down"),   # Go to next tab
    # Enable Cmd+Option+Left/Right for tab navigation
    K("RC-M-Left"):             K("C-Page_Up"),     # Go to prior tab
    K("RC-M-Right"):            K("C-Page_Down"),   # Go to next tab
    # Enable Ctrl+PgUp/PgDn for tab navigation
    K("Super-Page_Up"):         K("C-Page_Up"),     # Go to prior tab
    K("Super-Page_Down"):       K("C-Page_Down"),   # Go to next tab
    # Use Cmd+Braces keys for tab navigation instead of page navigation
    # K("C-Left_Brace"): K("C-Page_Up"),
    # K("C-Right_Brace"): K("C-Page_Down"),
}, "General Web Browsers")

# Tab navigation overrides for apps that use Ctrl+Shift+Tab/Ctrl+Tab instead of Ctrl+PgUp/PgDn
define_keymap(re.compile("^org.gnome.Console$|^Kgx$|^deepin-terminal$|^Angry*IP*Scanner$|^jDownloader$", re.IGNORECASE), {
    # Tab navigation
    # Tab nav: Go to prior tab (left)
    K("RC-Shift-Left_Brace"):   K("C-Shift-Tab"),
    # Tab nav: Go to next tab (right)
    K("RC-Shift-Right_Brace"):  K("C-Tab"),
    # Tab nav: Go to prior tab (left)
    K("RC-Shift-Left"):         K("C-Shift-Tab"),
    # Tab nav: Go to next tab (right)
    K("RC-Shift-Right"):        K("C-Tab"),
}, "Tab Navigation for apps that want Ctrl+Shift+Tab/Ctrl+Tab")


# None referenced here originally
# - but remote clients and VM software ought to be set here
# These are the typical remaps for ALL GUI based apps
define_keymap(lambda wm_class: wm_class.casefold() not in terminals, {
    # toggle opacity
    K("RC-U"): launch(["picom-trans", "-tc"]),

    # Tab nav: Go to prior (left) tab
    K("RC-Shift-Left_Brace"):   K("C-Page_Up"),
    # Tab nav: Go to next (right) tab
    K("RC-Shift-Right_Brace"):  K("C-Page_Down"),
    # Default SL - Launch Application Menu (gnome
    K("RC-Space"): K("Super-Space"),
    # Default SL - Show Desktop (gnome/kde,eos)
    K("RC-F3"): K("Super-d"),
    # Default SL - Maximize app (gnome/kde)
    K("RC-Super-f"): K("Alt-F10"),
    # SL - Toggle maximized window state (kde_neon)``
    K("RC-Super-f"): K("Super-Page_Up"),
    K("RC-Q"): K("Alt-F4"),                         # Default SL - not-popos
    # Default SL - Minimize app (gnome/budgie/popos/fedora)
    K("RC-H"): K("Super-Page_Down"),
    # Default - Cmd Tab - App Switching Default
    K("Alt-Tab"): pass_through_key,
    # Default - Cmd Tab - App Switching Default

    # TODO: remove
    # K("RC-Tab"): K("Super-Tab"),
    # Default - Cmd Tab - App Switching Default
    # K("RC-Shift-Tab"): K("Super-Shift-Tab"),
    # Default not-xfce4 - Cmd ` - Same App Switching
    # K("RC-Grave"): K("Super-Grave"),
    # Default not-xfce4 - Cmd ` - Same App Switching
    # K("RC-Shift-Grave"): K("Super-Shift-Grave"),

    # In-App Tab switching
    K("Super-Tab"): K("LC-Tab"),                  # Default not-chromebook
    K("Super-Shift-Tab"): K("LC-Shift-Tab"),      # Default not-chromebook

    # Fn to Alt style remaps
    K("RAlt-Enter"): K("insert"),                   # Insert

    # K("Alt-RC-Space"): K(""),                       # Open Finder - Placeholder

    # emacs style
    K("Super-a"): K("Home"),                      # Beginning of Line
    K("Super-e"): K("End"),                       # End of Line
    K("Super-b"): K("Left"),
    K("Super-f"): K("Right"),
    K("Super-n"): K("Down"),
    K("Super-p"): K("Up"),
    K("Super-k"): [K("Shift-End"), K("Backspace")],
    K("Super-d"): K("Delete"),
    K("Alt-b"): K("C-Left"),
    K("Alt-f"): K("C-Right"),

    # Wordwise
    K("RC-Left"): K("Home"),                      # Beginning of Line
    # Select all to Beginning of Line
    K("RC-Shift-Left"): K("Shift-Home"),
    K("RC-Right"): K("End"),                      # End of Line
    K("RC-Shift-Right"): K("Shift-End"),          # Select all to End of Line
    K("RC-Up"): K("C-Home"),                      # Beginning of File
    # Select all to Beginning of File
    K("RC-Shift-Up"): K("C-Shift-Home"),
    K("RC-Down"): K("C-End"),                     # End of File
    K("RC-Shift-Down"): K("C-Shift-End"),         # Select all to End of File
    # K("RAlt-Backspace"): K("Delete"),               # Chromebook/IBM - Delete
    K("Super-Backspace"): K("C-Backspace"),       # Delete Left Word of Cursor
    K("Super-Delete"): K("C-Delete"),             # Delete Right Word of Cursor
    # K("LAlt-Backspace"): K("C-Backspace"),          # Chromebook/IBM - Delete Left Word of Cursor
    K("Alt-Backspace"): K("C-Backspace"),           # Default not-chromebook
    # Delete Entire Line Left of Cursor
    K("RC-Backspace"): K("C-Shift-Backspace"),
    K("Alt-Delete"): K("C-Delete"),               # Delete Right Word of Cursor
    # K(""): pass_through_key,                      # cancel
    # K(""): K(""),                                 #
}, "General GUI")


define_keymap(re.compile("^konsole$", re.IGNORECASE), {
    # Ctrl Tab - In App Tab Switching
    K("LC-Tab"): K("Shift-Right"),
    K("LC-Shift-Tab"): K("Shift-Left"),
    K("LC-Grave"): K("Shift-Left"),

}, "Konsole tab switching")

define_keymap(re.compile("^Io.elementary.terminal$|^kitty$", re.IGNORECASE), {
    # Ctrl Tab - In App Tab Switching
    K("LC-Tab"): K("LC-Shift-Right"),
    K("LC-Shift-Tab"): K("LC-Shift-Left"),
    K("LC-Grave"): K("LC-Shift-Left"),

}, "Elementary Terminal tab switching")

##################################################
### START OF SUPER-W BEHAVIOR GROUP OF KEYMAPS ###
##################################################

close_tab_as_hide_apps = [
    "QQ",
    "zoom",
    "apple-music-for-linux",
]
close_tab_as_hide_str = "|".join(str('^'+x+'$')
                                 for x in close_tab_as_hide_apps)

define_keymap(re.compile(close_tab_as_hide_str, re.IGNORECASE), {
    K("RC-W"): K("Super-Page_Down"),

}, "Super-W Hide Window")

close_tab_as_quit_apps = [
    "systemsettings",
    "discord",
    "discover",
    "elisa",
    "whatsdesk",
]

close_tab_as_quit_str = "|".join(str('^'+x+'$')
                                 for x in close_tab_as_quit_apps)

define_keymap(re.compile(close_tab_as_quit_str, re.IGNORECASE), {
    K("RC-W"): K("Alt-F4"),
}, "Super-W Close Window")

define_keymap(re.compile("Kinto-gui.py"), {
    K("Super-W"): K("Alt-F4")
}, "kinto close window")

################################################
### END OF SUPER-W BEHAVIOR GROUP OF KEYMAPS ###
################################################

define_keymap(re.compile("Code"), {
    K("Super-U"): launch(["picom-trans", "-tc"])
}, "vscode toggle opacity")
