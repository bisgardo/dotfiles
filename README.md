# Dotfiles

Small framework for and implementation of an extensible cross-platform dotfiles repository.

## Install

* Clone dotfiles into a directory of choice: `git clone git@github.com:halleknast/dotfiles.git`.

* Run install script `install.sh`.

# Main scripts

* `install.sh`: Installs dotfiles such that it's picked up by `.bashrc` and `.bash_profile`.

    In order to accomplish this, the following actions are performed
    (see below for more details of what these actions mean):

    1. Write directory containing script to `~/.dotfiles`.
    2. Symlink `~/.bashrc` and `~/.bash_profile` into `bash/bashrc` and `bash/bash_profile`, respectively.
    3. Set `DOTFILES_BOOTER`to `REFRESH`, and call `bash/init.sh`.

* `bash/boot.sh`: Sourced from (symlinked) `~/.bashrc` and `~/.bash_profile`. At this point, the variable
  `DOTFILES_BOOTER` is expected to be set with the value corresponding to the source of initialization
  (`BASHRC`, `BASHPROFILE`, or `REFRESH`). The purpose of the script is to set the following variables and
  load the rest of the system.

    * Set `DOTFILES_PATH` to the path of the dotfiles file directory by loading it from `~/.dotfiles`,
      which were written by the install script.

    * Set `DOTFILES_OS`, `DOTFILES_OS_DIST`, `DOTFILES_OS_VERS` to the operating system
      (`LINUX`, `OSX`, `WIN`, ...), distribution (if applicable), and version.

    * Append `bash/scripts/` to `PATH`.

    * Source all files in `bash/includes/`. These files are expected to use the variables above to behave
      correctly across the supported platforms and boot scenarios.

# Included scripts

The following files are all contained in `bash/includes/` and get sourced from `bash/boot.sh`.
By convention, the files should set up and call a function.

* `glob.sh`: ...

* `ls.sh`: ...

* `pwd.sh`: ...

* `rm~.sh`: ...

* `util.sh`: ...

* `withhead.sh`: ...
