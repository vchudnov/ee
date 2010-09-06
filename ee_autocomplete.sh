# ee_autocomplete.sh: Bash autocompletion file for the ee utility
# Copyright 2010 Victor Chudnovsky
#
# Author:  victor.chudnovsky+ee@gmail.com
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# Description: Once this file is sourced by the bash shell (typically
# in ~/.bashrc), it will autocomplete the ee flags and existing emacs
# server sessions.

set -o nounset
shopt -s extglob
function _ee() {
    COMPREPLY=()
    local cur="$2"
    local prev="$3"
    if [[ "$COMP_CWORD" == "1" ]]; then
	local user_flags="$(ee --user_flags)"
	COMPREPLY=( $(compgen -W "${user_flags}" -- "${cur}") )
    else
	local flags_taking_sessions="$(ee --flags_taking_sessions)"
	local sessions="$(ee -l)"
	case "$prev" in
 	    @($flags_taking_sessions)) COMPREPLY=( $(compgen -W "${sessions}" -- "${cur}") );;
	esac  
    fi
}
complete -F _ee ee
