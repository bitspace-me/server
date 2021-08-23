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

# Files present in the upload directory that need to be processed.
jpg_imgs = $(wildcard *.jpg)
png_imgs = $(wildcard *.png)
files = $(jpg_imgs) $(png_imgs)

# Folders we are going to be moving files to.
storage_dir ?= /var/bitspace.me/storage
thumbs_dir ?= /var/www/cache
dirs = $(thumbs_dir) $(storage_dir)

# Thumbnails we will need to generate for the various file types.
jpg_thumbs = $(patsubst %.jpg,$(thumbs_dir)/%.$(thumbs_ext),$(jpg_imgs))
png_thumbs = $(patsubst %.png,$(thumbs_dir)/%.$(thumbs_ext),$(png_imgs))
img_thumbs = $(jpg_thumbs) $(png_thumbs)

# Properties for the generated thumbnails.
thumbs_dim ?= 256x256
thumbs_ext ?= jpg

# Makes the folders we need.
$(dirs) : % :
	mkdir -p $@

# Generates the thumbnails.
$(jpg_thumbs) : $(thumbs_dir)/%.$(thumbs_ext) : %.jpg $(thumbs_dir)
	convert -resize $(thumbs_dim) $< $@

$(png_thumbs) : $(thumbs_dir)/%.$(thumbs_ext) : %.png $(thumbs_dir)
	convert -resize $(thumbs_dim) $< $@

# Moves uploaded files to storage at the end.
.DEFAULT_GOAL = all
.PHONY : all

all: $(img_thumbs) $(storage_dir)
	for i in $(files); do mv $$i $(storage_dir)/; done