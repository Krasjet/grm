git repo manager
================

`grm` is a minimal, POSIX-compliant shell script for managing git repositories
on self-hosted git servers. It is mainly designed to work with [git daemon][1]
and [stagit][2], though the you don't necessarily need them to run the script.

Installation
------------

Before installing `grm`, make sure you have set up your git server following
the instructions in [section 4.4][3] of Pro Git. Optionally, you should also
have [git daemon][1] ready for the public access of repositories, which is
documented in [section 4.5][4] of Pro Git. If you want to have a web interface
for your repository, you should also have [stagit][2] compiled and installed on
your server.

Edit `grm` script to fill in some configurations,

```bash
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

Git repo manager, manage git repositories on self-hosted git server.

commands:
    new               create a new repository
    ls                list existing repositories
    rm repo_name      remove repositories
    rc [repo_name]    recompile stagit pages for repositories, or
                      rebuild index if no repositories are given
    help              show help
```

If you have created a `git` user for managing git repositories, make sure the
`git` user have write access to all the directories in the config, and run the
script on the server as:

```bash
$ doas -u git -- grm <command> [<args>]
```

or

```bash
$ sudo -u git -- grm <command> [<args>]
```

You could also run the script on your local machine using ssh,

```bash
$ ssh git@domain.tld -- grm <command> [<args>]
```

or simply create an alias if you find it cumbersome:

```bash
alias grm="ssh git@domain.tld -- grm"
```

License
-------

`grm` is licensed under the MIT license.

[1]: https://git-scm.com/docs/git-daemon
[2]: https://codemadness.org/git/stagit/
[3]: https://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the-Server
[4]: https://git-scm.com/book/en/v2/Git-on-the-Server-Git-Daemon
[5]: https://codemadness.org/git/stagit/file/example_post-receive.sh.html
