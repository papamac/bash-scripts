###############################################################################
#
#     PACKAGE:  papamac's bash scripts and runtime environment (bash-scripts)
#        FILE:  bash_aliases
#       TITLE:  papamac's bash runtime environment for Raspbian and Mac OS
#    FUNCTION:  Define commmon environment variables, command aliases and
#               simple functions for general use.
#       USAGE:  Installed in the home directory as the file .bash_aliases.
#      AUTHOR:  papamac
#        DATE:  September 25, 2019
#
###############################################################################

###############################################################################
#
# ENVIRONMENT VARIABLES
#
###############################################################################

# ANSI escape sequences:

n=$'\e[0m'                              # Reset all attributes (normal).
t=$'\e[1m'                              # Set character attribute to bright.
d=$'\e[2m'                              # Set character attribute to dim.
u=$'\e[4m'                              # Set character attribute to underscore.
i=$'\e[5m'                              # Set character attribute to blink.
v=$'\e[7m'                              # Set character attribute to reverse.

k=$'\e[30m'                             # Set foreground color to black.
r=$'\e[31m'                             # Set foreground color to red.
g=$'\e[32m'                             # Set foreground color to green.
y=$'\e[33m'                             # Set foreground color to yellow.
b=$'\e[34m'                             # Set foreground color to blue.
m=$'\e[35m'                             # Set foreground color to magenta.
c=$'\e[36m'                             # Set foreground color to cyan.
w=$'\e[37m'                             # Set foreground color to white.

K=$'\e[40m'                             # Set background color to black.
R=$'\e[41m'                             # Set background color to red.
G=$'\e[42m'                             # Set background color to green.
Y=$'\e[43m'                             # Set background color to yellow.
B=$'\e[44m'                             # Set background color to blue.
M=$'\e[45m'                             # Set background color to magenta.
C=$'\e[46m'                             # Set background color to cyan.
W=$'\e[47m'                             # Set background color to white.

export n t d u i v k r g y b m c w K R G Y B M C W

###############################################################################
#
# COMMAND LINE ALIASES
#
###############################################################################

alias l='ls -lah'
alias sudo='sudo -E'
alias ping='sudo ping'
alias reboot='sudo reboot'
alias shutdown='sudo shutdown -h now'
alias indigohost='/Library/Application\ Support/Perceptive\ Automation/Indigo\ 7.3/IndigoPluginHost.app/Contents/MacOS/IndigoPluginHost'

###############################################################################
#
#    FUNCTION:  c
#       TITLE:  change directory
#    FUNCTION:  Change the working directory and list the contents of the new
#               directory.
#       USAGE:  c [dir]
#
###############################################################################

function c {
    local dir=$1
    if cd $dir; then
        ls -lah
    fi
}

###############################################################################
#
#    FUNCTION:  cp2bin
#       TITLE:  copy to bin
#    FUNCTION:  Copy files to ~/bin and make them executable.
#       USAGE:  cp2bin [files]
#
###############################################################################

function cp2bin {
    local files=$1
    cp ${files:=*.py} ~/bin
    chmod +x ~/bin/$files
}

###############################################################################
#
#    FUNCTION:  mv2bin
#       TITLE:  move to bin
#    FUNCTION:  Move files to ~/bin and make them executable.
#       USAGE:  mv2bin [files]
#
###############################################################################

function mv2bin {
    local files=$1
    mv ${files:=*.py} ~/bin
    chmod +x ~/bin/$files
}

export -f c cp2bin mv2bin