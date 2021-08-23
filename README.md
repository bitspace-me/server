# Bitspace.me's Server Backend Code

## Installation

You'll need to have following command-line utilities installed:
- `convert` (from ImageMagick)
- `make` (from GNU Make)
- `nproc` (from GNU Coreutils)

Then open a terminal in the root folder and type `sudo make` to install the
backend code.

## Running It

The program takes files as input in `/var/bitspace.me/upload`.

It then produces thumbnails for the files in the upload directory and places
them in `/var/www/cache`.

Finally, it moves the files to `/var/bitspace.me/storage`.

You can start the process with the command `bitspace.me.backende.main`. You
must ensure that the user account which runs it has both read and write access
to `/var/bitspace.me` and `/var/www` as well as their subdirectories and files.

## Input Requirements

No metadata files are accepted in the upload folder, and all files present
should already have their filenames set to their UIDs.