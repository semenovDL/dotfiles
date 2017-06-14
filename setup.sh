#!/usr/bin/env bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Set global variables
PREF_FILES=()
AFFECTED_APPS=()

# Source lib tools
source 'lib/loginitem.sh'

# Add preference file followed by any number of affected applications
function set_prefs {
  PREF_FILES+=("apps/$1.sh")
  shift
  AFFECTED_APPS+=("$@")
}

# Sources all the preference files
function source_prefs {
  for file in "${PREF_FILES[@]}"; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
  done
}

# Check for open application
function get_open_affected_apps {
  open_apps=()

  # Store the open apps in an array
  for app in "${AFFECTED_APPS[@]}"; do
    (( $(osascript -e "tell app \"System Events\" to count processes whose name is \"${app}\"") > 0 )) \
    && open_apps+=("$app")
  done

  echo "The following open applications will be affected:"

  # Print the open apps in columns
  printf -- '%s\n' "${open_apps[@]}" | column -x

  echo "Would you like to quit these apps now? [Y/n] "
}

# Open Application
# open -a "SpeechSynthesisServer"

# Quit affected applications
function quit_apps {
  for app in "${AFFECTED_APPS[@]}"; do
    case "$app" in
      'Quick Look')
        # Restart Quick Look
        qlmanage -r
        ;;
      *)
        killall "$app" &>/dev/null
        # osascript -e "tell application \"${app}\" to quit"
        ;;
    esac
  done
}

# Prompt if user wants to restart the machine
function prompt_restart {
  echo "Done. Note that some of these changes require a logout/restart to take effect."
  read -p "Would you like to restart the computer now? [Y/n] " -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
      osascript -e 'tell app "System Events" to restart'
  fi
}

# System Prefrences
system_preferences=(
  general
  desktop_and_screen_saver
  dock
  mission_control
  language_and_region
  security_and_privacy
  spotlight
  notifications

  displays
  energy_saver
  keyboard
  # mouse
  trackpad
  printers_and_scanners
  sound
  # startup_disk

  icloud
  # internet_accounts
  # wallet_and_apple_pay
  # app_store
  # network
  bluetooth
  extensions
  sharing

  # touch_id
  users_and_groups
  # parental-controls
  siri
  date_and_time
  time_machine
  accessibility
  # profiles

  other
  dashboard
  ssd
)

for pane in "${system_preferences[@]}"; do
  PREF_FILES+=("system/${pane}.sh")
done

for pane in "cfprefsd" "SystemUIServer" "Dock" "SpeechSynthesisServer"; do
  AFFECTED_APPS+=("$pane")
done

# Default Apps
set_prefs activity_monitor "Activity Monitor"
set_prefs app_store "App Store"
set_prefs contacts "Contacts"
set_prefs disk_utility "Disk Utility"
set_prefs finder "Finder"
set_prefs font_book "Font Book"
set_prefs mail "Mail"
set_prefs messages "Messages"
set_prefs photos "Photos"
set_prefs quick_time "QuickTime Player"
set_prefs safari "Safari" "WebKit"
set_prefs terminal # Do not kill "Terminal" - it will stop script execution
set_prefs text_edit "TextEdit"

# Third Party Apps
set_prefs adobe
set_prefs bartender
set_prefs dropbox "Dropbox"
set_prefs google_chrome "Google Chrome"
set_prefs qlcolorcode "Quick Look"
set_prefs transmission "Transmission"

# Run
get_open_affected_apps
source_prefs
quit_apps

prompt_restart
