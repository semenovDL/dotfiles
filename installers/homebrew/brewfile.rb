# rubocop:disable Style/NumericLiterals
# Taps
tap 'caskroom/cask'
tap 'caskroom/fonts'
tap 'caskroom/versions'
tap 'homebrew/bundle'
tap 'homebrew/services'

# Git and GitHub
brew 'git'
brew 'diff-so-fancy'
brew 'hub'

# ZSH
brew 'zsh'
brew 'zsh-completions'
brew 'zsh-syntax-highlighting'

# GNU core utilities (those that come with masOS are outdated)
brew 'coreutils'

# More usefull tools:
#   chronic: runs a command quietly unless it fails
#   combine: combine the lines in two files using boolean operations
#   errno: look up errno names and descriptions
#   ifdata: get network interface info without parsing ifconfig output
#   ifne: run a program if the standard input is not empty
#   isutf8: check if a file or standard input is utf-8
#   lckdo: execute a program with a lock held
#   mispipe: pipe two commands, returning the exit status of the first
#   parallel: run multiple jobs at once
#   pee: tee standard input to pipes
#   sponge: soak up standard input and write to a file
#   ts: timestamp standard input
#   vidir: edit a directory in your text editor
#   vipe: insert a text editor into a pipe
#   zrun: automatically uncompress arguments to command
brew 'moreutils'

# Data transformations
brew 'jsmin'
brew 'jq'
cask 'rq'

# Databases
brew 'postgresql', restart_service: true
brew 'redis', restart_service: true

# Languages support
brew 'node'
brew 'yarn'
brew 'ruby-build'
brew 'rbenv'
brew 'haskell-stack'

# Mac OS X tools
brew 'tccutil' # Required for setting preferences

# Other usefull tools
brew 'fzf'
brew 'httpie'
brew 'pv'
brew 'the_silver_searcher'
brew 'youtube-dl'
brew 'vim', args: ['with-override-system-vi']
brew 'watch'
brew 'wget'

# Quicklook
cask 'qlcolorcode'
cask 'qlstephen'
cask 'qlmarkdown'
cask 'quicklook-json'
cask 'quicklook-csv'
cask 'qlimagesize'
cask 'webpquicklook'
cask 'qlvideo'

# Fonts
cask 'font-firacode-nerd-font'

# Apps
cask 'adobe-creative-cloud'
cask 'aerial'
cask 'alfred'
cask 'bartender'
cask 'caffeine'
cask 'dash'
cask 'docker'
cask 'dropbox'
cask 'franz'
cask 'google-chrome'
cask 'iterm2'
cask 'little-snitch'
cask 'postman'
cask 'transmission'
cask 'tunnelbear'
cask 'visual-studio-code'
cask 'vlc'

# Mac App Store apps
brew 'mas'
mas '1Password', id: 443987910
mas 'Be Focused Pro', id: 961632517
mas 'Clean', id: 418412301
mas 'Entropy', id: 437151949
mas 'Timing', id: 431511738
