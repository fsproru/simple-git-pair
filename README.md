## TL;DR
Simple way to add your pair to a git commit message.

## Description
Unlike many other gems it doesn NOT change your email address in git config, so Github can associate your commit to github account properly.
This is especially useful for Github graphs and statistics.

## Usage
`git pair nt ae` # changes your git user.name to "Nicola Tesla & Alfred Einstein"

## Configuration
Create and keep your pairs in `.git_pairs` file in your home directory in yaml format, e.g.
```yml
nt: Nicola Tesla
ae: Alfred Einstein
...
```

## Future Development
 - git pair init # creates simple .git_pairs file
 - git pair add <initial> <full_name> # adds an author to .git_pairs
 - git pair delete <initial> # deletes a pair from .git_pairs
 - git pair list # lists all available pairs

## Issues and Contributions
Feel free to submit [issues](https://github.com/fsproru/simple-git-pair/issues), pull requests or [feedback](mailto: a.tamoykin@gmail.com)