###############################################################################
#                                                                             #
#  PACKAGE:  papamac's bash scripts and runtime environment (bash-scripts)    #
#     FILE:  bash_aliases                                                     #
#    TITLE:  papamac's bash runtime environment for Raspberry Pi OS and MacOS #
# FUNCTION:  Define common environment variables, command aliases and simple  #
#            functions for general use.                                       #
#    USAGE:  Installed in the home directory as the file .bash_aliases.       #
#   AUTHOR:  papamac                                                          #
#  VERSION:  1.0.11                                                           #
#     DATE:  November 1, 2025                                                 #
#                                                                             #
#                                                                             #
# UNLICENSE:                                                                  #
#                                                                             #
# This is free and unencumbered software released into the public domain.     #
#                                                                             #
# Anyone is free to copy, modify, publish, use, compile, sell, or distribute  #
# this software, either in source code form or as a compiled binary, for any  #
# purpose, commercial or non-commercial, and by any means.                    #
#                                                                             #
# In jurisdictions that recognize copyright laws, the author or authors of    #
# this software dedicate any and all copyright interest in the software to    #
# the public domain. We make this dedication for the benefit of the public at #
# large and to the detriment of our heirs and successors. We intend this      #
# dedication to be an overt act of relinquishment in perpetuity of all        #
# present and future rights to this software under copyright law.             #
#                                                                             #
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  #
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    #
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL    #
# THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN #
# AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN        #
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  #
#                                                                             #
#                                                                             #
# DESCRIPTION:                                                                #
#                                                                             #
# **************************** needs work *************************************
#                                                                             #
#                                                                             #
# DEPENDENCIES/LIMITATIONS:                                                   #
#                                                                             #
# **************************** needs work *************************************
#                                                                             #
###############################################################################


###############################################################################
#                                                                             #
# ENVIRONMENT VARIABLES                                                       #
#                                                                             #
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
#                                                                             #
# COMMAND LINE ALIASES                                                        #
#                                                                             #
###############################################################################

alias l='ls -lah'
alias sudo='sudo -E'
alias ping='sudo ping'
alias reboot='sudo reboot'
alias shutdown='sudo shutdown -h now'
alias restart='sudo systemctl restart'
alias status='systemctl status'
alias mdns_hostname="avahi-resolve -a \$(hostname -I | cut -d' ' -f1) | cut -f2"
alias mdns_log="journalctl -fu avahi-daemon"
alias show="journalctl -fu"


###############################################################################
#                                                                             #
#    FUNCTION:  c                                                             #
#       TITLE:  change directory                                              #
#    FUNCTION:  Change the working directory and list the contents of the new #
#               directory.                                                    #
#       USAGE:  c [dir]                                                       #
#                                                                             #
###############################################################################

function c {
    local dir=$1
    if cd "$dir"; then
        ls -lah
    fi
}


###############################################################################
#                                                                             #
#    FUNCTION:  cp2bin                                                        #
#       TITLE:  copy to bin                                                   #
#    FUNCTION:  Copy files to ~/bin and make them executable.                 #
#       USAGE:  cp2bin [files]                                                #
#                                                                             #
###############################################################################

function cp2bin {
    local files=$1
    cp "${files:=*.py}" ~/bin
    chmod +x ~/bin/"$files"
}


###############################################################################
#                                                                             #
#    FUNCTION:  mv2bin                                                        #
#       TITLE:  move to bin                                                   #
#    FUNCTION:  Move files to ~/bin and make them executable.                 #
#       USAGE:  mv2bin [files]                                                #
#                                                                             #
###############################################################################

function mv2bin {
    local files=$1
    mv "${files:=*.py}" ~/bin
    chmod +x ~/bin/"$files"
}


###############################################################################
#                                                                             #
#    FUNCTION:  check-mdns                                                    #
#       TITLE:  check mdns hostname                                           #
#    FUNCTION:  Check to see that the mdns hostname is equal to               #
#               hostname.local.  If not, restart the avahi-daemon and check   #
#               again.                                                        #
#       USAGE:  check-mdns                                                    #
#                                                                             #
###############################################################################

function check-mdns {
    echo -e "$g${t}check-mdns:$n" "$(date)"
    mdns_hostname=$(mdns_hostname)
    if [[ $mdns_hostname == $(hostname).local ]]; then
        echo "$g${t}check-mdns:$n mdns hostname $b$t$mdns_hostname$n" is correct
    else
        echo "$g${t}check-mdns:$n mdns hostname $b$t$mdns_hostname$n is not equal to $b$t$(hostname).local$n"
        echo "$g${t}check-mdns:$n restarting the avahi daemon"
        restart avahi-daemon
        mdns_hostname=$(mdns_hostname)
        if [[ $mdns_hostname == $(hostname).local ]]; then
            echo "$g${t}check-mdns:$n mdns hostname $b$t$mdns_hostname$n is now correct"
        else
            echo "$g${t}check-mdns:$n mdns hostname $b$t$mdns_hostname$n is still incorrect; try rebooting"
        fi
    fi
}


###############################################################################
#                                                                             #
#                            Startup Script for                               #
#                               Raspberry Pi                                  #
#                                                                             #
###############################################################################

export -f c cp2bin mv2bin check-mdns
