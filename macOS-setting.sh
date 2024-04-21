# https://github.com/mathiasbynens/dotfiles/blob/master/.macos
# https://github.com/crispgm/dotfiles/blob/main/macOS/settings

sudo -v

# Finder
defaults write com.apple.finder "ShowPathbar" -bool "true"
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "false"
killall Finder

# Desktop
defaults write com.apple.finder "_FXSortFoldersFirstOnDesktop" -bool "true" && killall Finder

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.AppleMultitouchTrackpad "TrackpadThreeFingerDrag" -bool "true"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "Clicking" -bool true
defaults -currentHost write NSGlobalDomain "com.apple.mouse.tapBehavior" -int 1
defaults write NSGlobalDomain "com.apple.mouse.tapBehavior" -int 1

# Dock
defaults write com.apple.dock "orientation" -string "left"
defaults write com.apple.dock "tilesize" -int "48"
defaults write com.apple.dock "show-recents" -bool "false"
killall Dock

