#!/bin/sh

# Set GIT to use colors
git config --global color.ui auto

# Load up some default values from the environment!
GIT_NAME_CURRENT=$(git config --global user.name)
GIT_EMAIL_CURRENT=$(git config --global user.email)

# Ask what name to use?
printf "Git Name [$GIT_NAME_CURRENT]:"
read GIT_NAME_NEW

# Ask what email to use?
printf "Git Email [$GIT_EMAIL_CURRENT]:"
read GIT_EMAIL_NEW

# Save the GIT_NAME
if [ "$GIT_NAME_NEW" != "" ]
then
	git config --global user.name "$GIT_NAME_NEW"
fi

# Save the GIT_EMAIL
if [ "$GIT_EMAIL_NEW" != "" ]
then
	git config --global user.email "$GIT_EMAIL_NEW"
fi

# Where is the temp DIR for dotfiles?
DOTFILES_TMP="${HOME}/.serverdots"

# Check if we already have a copy
if [ ! -d $DOTFILES_TMP ]
then
	# Now clone the repo...
	git clone https://github.com/reilg/serverdots.git $DOTFILES_TMP
else
	# Or update existing shiz
	cd $DOTFILES_TMP && git fetch && git checkout origin/master
fi

# Overwrite vimrc file
cp -r $DOTFILES_TMP/.vimrc ~/.vimrc

# Overwrite bashrc 
cp -r $DOTFILES_TMP/.bashrc ~/.bashrc

# Check if we want to install/update plugins
if [ "$UPDATE_PLUGINS" != "n" ]
then
	# Install Vim Plugins
	printf "Installing Vim Plugins, Will take a while depending on connection speed!\n"
	vi +PlugUpgrade +PlugClean! +PlugUpdate +qall
fi

printf "ERROR! Virus Detected!\n.\n.\n.\n.\n.\n.\n.\n.\n.\n"
printf "Just kidding. We good."

