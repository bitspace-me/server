#! /bin/bash

# Bitspace.me Server Backend Copyright (C) 2021 The Bitspace.me Team
# File Authored by Jyothiraditya Nellakra
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more 
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program. If not, see <https://www.gnu.org/licenses/>.

checkcmd() { command -v "$1" || { printerr "'$1' not installed."; exit 1; }; }
checkint() { test "$@" -eq "$@" 2> /dev/null; }
printerr() { printf "$0: error: %s\n" "$*" >&2; }

checkcmd "convert" # Used for generating thumbnails.
checkcmd "make" # Makefile does most of the heavy lifting.
checkcmd "nproc" # Used to get the number of CPU threads.

make_name="bitspace.me.server.make" # Makefile backend command name.
checkcmd "$make_name"; make_exec="$(command -v "$make_name")"

threads_free="1" # Leave one thread free for other things by default.
total_threads="$(("$(nproc --all)" - "$threads_free"))"

checkint "$total_threads" || { printerr "non-integer thread count."; exit 2; }
[ "$total_threads" -ge 1 ] || { printerr "invalid thread count."; exit 3; }

upload_dir="/var/bitspace.me/upload" # The file upload folder.

# There should be no metadata files here, only file contents, and they should
# already have their filenames set to their UIDs.

if [ ! -d "$upload_dir" ]; then (set -x; mkdir -p "$upload_dir"); fi
cd "$upload_dir" || { printerr "Cannot enter file upload folder."; exit 4; }

while true; do # Infinite loop, Make invocations are throttled to 10Hz.
	(set -x; sleep "0.1"; make -j "$total_threads" -f "$make_exec")
	[ "$?" -eq "0" ] || { printerr "make errored out."; exit 6; }
done