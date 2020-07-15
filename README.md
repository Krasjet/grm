git repo manager
================

`grm` is a minimal, POSIX-compliant shell script for managing git repositories
on self-hosted git servers. It is mainly designed to work with [git daemon][1]
and [stagit][2], though you don't necessarily need them to run the script.

Installation
------------

Before installing `grm`, make sure you have set up your git server following
the instructions in [section 4.4][3] of Pro Git. Optionally, you should also
have [git daemon][1] ready for the public access of the repositories, which is
documented in [section 4.5][4] of Pro Git. Your git repositories root should
have the following structure:

```
$GRM_REPOS_ROOT
├── private-repo.git
│   ├── branches
│   ├── HEAD
│   └── ...
├── public-repo.git
│   ├── branches
│   ├── HEAD
│   ├── ...
│   └── git-daemon-export-ok
└── hidden-repo.git
    ├── branches
    ├── HEAD
    ├── ...
    ├── git-daemon-export-ok
    └── stagit-no-index
```

If you want to have a web interface for your repositories, you should also have
[stagit][2] compiled and installed on your server.

To use git repo manager, edit the `grm` script to fill in some configurations,

```sh
# root directory of git repositories
GRM_REPOS_ROOT="/home/git"

# default owner
GRM_OWNER="yourname"

# default url prefix (without ending slash)
GRM_URL_PREFIX="git://git.domain.tld"

# path of the post-receive hooks for stagit
GRM_POSTRECV_HOOK="/home/git/.post-receive"

# root directory of stagit web pages
STAGIT_WEB_ROOT="/srv/git"
```

and copy it to `$PATH`.

An example of the `post-receive` hook for stagit can be found [here][5]. Note
that the hook itself needs some further configuration. You could also write
your own `post-receive` hook.

Usage
-----

```
$ grm help
usage: grm <command> [<args>]

Git repo manager, manage git repositories on self-hosted git servers.

commands:
    new                  create a new repo
    info repo_name       display metadata of the repo
    ls                   list all repos
    ls public            list public repos
    ls private           list private repos
    ls hidden            list hidden (unlisted) repos
    rm repo1 [repo2..]   remove repos
    rc                   recompile stagit index
    rc repo1 [repo2..]   recompile stagit pages for repos,
                         and recompile index
    rca                  recompile all public repos
    help                 show help
```

If you have created a `git` user for managing git repositories, make sure the
`git` user has write access to all the directories in the config, and run the
script on the server as:

```sh
$ doas -u git -- grm <command> [<args>]
```

or

```sh
$ sudo -u git -- grm <command> [<args>]
```

You could also run the script on your local machine using ssh,

```sh
$ ssh git@domain.tld -- grm <command> [<args>]
```

or simply create an alias if you find it cumbersome:

```sh
alias grm="ssh git@domain.tld -- grm"
```

Examples
--------

```
$ grm new
repo name: grmr
public? [y/N] y
description (a work in progress): grm redux
owner (yourname): kst
clone url (git://domain.tld/grmr): git://git.domain.tld/grmr
Initialized empty Git repository in /home/git/grmr.git/
writing stagit metadata...
exporting repo for git daemon...
installing stagit post-receive hook
done!
$ grm ls
grm
grmr
$ grm info grmr
name: grmr
visibility: public
description: grm redux
owner: kst
url: git://git.domain.tld/grmr
$ grm rc grmr
[grmr] recompiling stagit pages...
[index] rebuilding index...
[grmr] done!
[index] done!
recompilation done!
$ grm rm grmr
remove grmr? [y/N] y
[index] rebuilding index...
[index] done!
$ grm ls
grm
```

License
-------

`grm` is licensed under the MIT license.

[1]: https://git-scm.com/docs/git-daemon
[2]: https://codemadness.org/git/stagit/
[3]: https://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the-Server
[4]: https://git-scm.com/book/en/v2/Git-on-the-Server-Git-Daemon
[5]: https://sink.krj.st/stagit/file/post-receive.html
