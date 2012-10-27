[![Build Status](https://secure.travis-ci.org/fsproru/simple-git-pair.png)](http://travis-ci.org/fsproru/simple-git-pair)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/fsproru/simple-git-pair)
[![endorse](http://api.coderwall.com/fsproru/endorsecount.png)](http://coderwall.com/fsproru)

## TL;DR
Simple way to add your pair to a git commit message.

## Description
Unlike many other gems it changes only user.name and does NOT change your email address in git config,
so Github can associate your commit to github account properly. 
This is especially useful for Github graphs and statistics.

## Installation and Usage
```sh
gem install simple-git-pair
git pair init
git pair nt ae # changes your git user.name to "Nikola Tesla & Alfred Einstein"
```

## Available commands
```sh
git pair init                        # create a sample .git_pairs file in your home directory
git pair add <initials> <Full Name>  # add a new pair
git pair delete <initial>            # delete a pair from .git_pairs
git pair list                        # list all available pairs
git pair help                        # display a help page
```

## Supported Rubies
 - 1.9.3
 - 1.9.2
 - 1.8.7

## Issues and Contributions
Feel free to submit [issues](https://github.com/fsproru/simple-git-pair/issues), pull requests or [feedback](mailto: a.tamoykin@gmail.com)