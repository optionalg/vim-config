# Samwho's Vim Configuration

It appears that you've stumbled upon my vim configuration file repo! Welcome.
This is where I keep all of the files that are relevant to setting up vim just
the way I like it. I've tried my best to lay it out in a sensible way that's
easy to understand and use should you so desire.

I can't promise that the configuration is cross-platform because, well, I don't
know of anyone that uses it apart from me. I know that you should get fairly
good cross-platform mileage on Linux based systems but beyond that you're on
your own.

# Usage

To get going with this configuration you'll need to clone this repository:

    $ git clone git://github.com/samwho/vim-config.git

Then you can cd into that directory and run the handy install script:

    $ cd vim-config
    $ ./bin/vim_install

The install script will backup your current configuration, if it finds one, into
the backups/ directory of the repository. When it's finished with that, it will
create symbolic links in your home directory that point to the files in here.
Nifty, right?

# Plugin Layout and Updating

I've taken a bit of time recently and made my vim configuration pathogen based.
Pathogen is an excellent plugin by Tim Pope that makes it easy to manage vim
plugins. Instead of having files spread out all over the place, which makes you
forget what belongs to what, all of your plugins go into a .vim/bundle
directory.

In this case, all of the plugins are git repositories and there's another handy
script that will update them all in turn:

    $ ./bin/vim_update_plugins

The script will cd into each of the plugin directories and run the following
commands:

    $ git fetch origin
    $ git rebase origin/master

This will pull down any changes from the origin and rebase your current master
branch on top of them. Thus bringing them up to the latest version.

# Clearing out backups

If you've run the `./bin/vim_install` command a few too many times and you've
acquired a lot of backups, the following command will clear them out for you:

    $ ./bin/vim_clear_backups

# Contributing

Feel free to fork this repository and correct stupid mistakes I've made. I'm
bound to make them.

Please don't fork the repo, make a peference based change and submit a pull
request. A person's vim configuration is very specific and any preference based
changes should be just that: preference.
