#!/bin/sh

# Set GIT to use colors
git config --global color.ui auto

# Load up some default values from the environment!
GIT_NAME_CURRENT=$(git config --global user.name)
GIT_EMAIL_CURRENT=$(git config --global user.email)

# Grab vimrc from repo

