PS1='\[\e[0;34m\]\w\[\e[m\] \[\e[0;37m\]\$ \[\e[m\]\[\e[0;37m\]'

export JAVA_HOME=$(/usr/libexec/java_home)

HISTFILESIZE=100000

export M2_HOME=/usr/local/Cellar/maven/3.3.3/libexec/
export M2=$M2_HOME/bin
export PATH=$PATH:$M2
export PATH="/usr/local/sbin:$PATH"

# Ignore files
export FIGNORE=bat:"test-output"

# Git
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Hadoop
export HADOOP_HOME=$(/usr/local/Cellar/hadoop/2.7.1/)

# Kafka
export KAFKA_HOME=$(/usr/local/Cellar/kafka/0.8.2.1)

# Oracle
export DYLD_LIBRARY_PATH=/opt/oracle/instantclient_11_2:$DYLD_LIBRARY_PATH
export PATH=/opt/oracle/instantclient_11_2:$PATH

# Alias
alias ll="ls -lahG"
alias bp="nano ~/.bash_profile"
alias sbp="source ~/.bash_profile"
alias reboot='sudo shutdown -r now "Rebooting Now"'
alias edithosts='sudo cp /private/etc/hosts ~/Documents/hosts-backup && sudo nano /private/etc/hosts'
alias hidedesktop="defaults write com.apple.finder CreateDesktop false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop true && killall Finder"
alias showhiddenfiles="defaults write com.apple.finder AppleShowAllFiles YES && killall Finder"
alias hidehiddenfiles="defaults write com.apple.finder AppleShowAllFiles NO && killall Finder"
alias startdashboard="defaults write com.apple.dashboard mcx-disabled -boolean false && killall Dock"
alias stopdashboard="defaults write com.apple.dashboard mcx-disabled -boolean true && killall Dock"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias speedtest="wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip"
alias disablescreenshotshadow="defaults write com.apple.screencapture disable-shadow -bool true && killall SystemUIServer"
alias deletedsstore="find . -type f -name '*.DS_Store' -ls -delete"


# Create icons from 1024px
function mkicns() {
    if [[ -z "$@" ]]; then
        echo "Input file missing"
    else
        filename=${1%.*}
        mkdir $filename.iconset
        sips -z 16 16   $1 --out $filename.iconset/icon_16x16.png
        sips -z 32 32   $1 --out $filename.iconset/icon_16x16@2x.png
        sips -z 32 32   $1 --out $filename.iconset/icon_32x32.png
        sips -z 64 64   $1 --out $filename.iconset/icon_32x32@2x.png
        sips -z 128 128 $1 --out $filename.iconset/icon_128x128.png
        sips -z 256 256 $1 --out $filename.iconset/icon_128x128@2x.png
        sips -z 256 256 $1 --out $filename.iconset/icon_256x256.png
        sips -z 512 512 $1 --out $filename.iconset/icon_256x256@2x.png
        sips -z 512 512 $1 --out $filename.iconset/icon_512x512.png
        cp $1 $filename.iconset/icon_512x512@2x.png
        iconutil -c icns $filename.iconset
        rm -r $filename.iconset
    fi
}
