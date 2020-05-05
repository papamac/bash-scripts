###############################################################################
#
#  PACKAGE:  papamac's bash scripts and runtime environment (bash-scripts)
#     FILE:  bash_aliases
#    TITLE:  papamac's bash runtime environment for Raspbian and Mac OS
# FUNCTION:  Define commmon environment variables, command aliases and simple
#            functions for general use.
#    USAGE:  Installed in the home directory as the file .bash_aliases.
#   AUTHOR:  papamac
#  VERSION:  1.0.5
#     DATE:  May 5, 2020
#
#
# MIT LICENSE:
#
# Copyright (c) 2019-2020 David A. Krause, aka papamac
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
#
# DESCRIPTION:
#
# **************************** needs work *************************************
#
# DEPENDENCIES/LIMITATIONS:
#
# **************************** needs work *************************************
#
###############################################################################

###############################################################################
#
# ENVIRONMENT VARIABLES
#
###############################################################################

# Color usage in ls -l for Mac OS BSD:

export CLICOLOR=1
export LSCOLORS=ExGxFxFxCxegedabagaced

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
alias indigohost='/Library/Application\ Support/Perceptive\ Automation/Indigo\ 7.4/IndigoPluginHost.app/Contents/MacOS/IndigoPluginHost'

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