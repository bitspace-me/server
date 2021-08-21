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

DESTDIR = /bin

.DEFAULT_GOAL = all
.PHONY : all

all :
	cp main.mk $(DESTDIR)/bitspace.me.server.make
	cp main.sh $(DESTDIR)/bitspace.me.server.main