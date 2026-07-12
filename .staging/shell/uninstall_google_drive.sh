#!/usr/bin/env bash

# Quit Google Drive
osascript -e 'tell application "Google Drive" to quit'

# Wait a bit to ensure Google Drive has quit
sleep 2

# Remove the Google Drive application
rm -rf "/Applications/Google Drive.app"

# Remove additional Google Drive data from the Library
rm -rf "${HOME}/Library/Application Support/Google/Drive"
rm -rf "${HOME}/Library/Caches/com.google.GoogleDrive"
rm -rf "${HOME}/Library/Preferences/com.google.GoogleDrive.plist"

# Optional: Uncomment the following line to empty the Trash
# osascript -e 'tell application "Finder" to empty the trash'

echo "Google Drive has been uninstalled."
