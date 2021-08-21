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

thumbs_dir ?= /var/www/cache
thumbs_dim ?= 256x256
thumbs_ext ?= jpg

storage_dir ?= /var/bitspace.me/storage
dirs = $(thumbs_dir) $(storage_dir)

jpg_imgs = $(wildcard *.jpg)
png_imgs = $(wildcard *.png)

jpg_thumbs = $(patsubst %.jpg,$(thumbs_dir)/%.$(thumbs_ext),$(jpg_imgs))
png_thumbs = $(patsubst %.png,$(thumbs_dir)/%.$(thumbs_ext),$(png_imgs))

$(dirs) : % :
	mkdir -p $@

$(jpg_thumbs) : $(thumbs_dir)/%.$(thumbs_ext) : %.jpg $(dirs)
	convert -resize $(thumbs_dim) $< $@
	mv $< $(storage_dir)/

$(png_thumbs) : $(thumbs_dir)/%.$(thumbs_ext) : %.png $(dirs)
	convert -resize $(thumbs_dim) $< $@
	mv $< $(storage_dir)/

.DEFAULT_GOAL = all
.PHONY : all

img_thumbs = $(jpg_thumbs) $(png_thumbs)

all : $(img_thumbs)