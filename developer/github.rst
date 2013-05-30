.. _developer/github:

=================================
Dojo Committer Workflow on GitHub
=================================

.. contents ::
    :depth: 2

This document will provide guidelines for the Dojo Toolkit workflow on GitHub for a committer.  As we will no longer be
using SVN, it is important to adjust our workflow to match to GitHub.

The Main Components
===================

The main GitHub Repositories for the Dojo 1.X code are:

* `dojo/dojo <https://github.com/dojo/dojo>`_

* `dojo/djijit <https://github.com/dojo/dijit>`_

* `dojo/dojox <https://github.com/dojo/dojox>`_

* `dojo/util <https://github.com/dojo/util>`_

You will need a valid GitHub user account.  This should be tied to your Dojo Foundation user account and you should have
appropriate access to the Dojo Toolkit repositories.  This can be done by contacting one of the Toolkit project leads.

You will need the appropriate tools to manage your GitHub code.  There are a few choices, but the two main ones are the
standard ``git`` command line or the GitHub GUI:

* `git <http://git-scm.com/downloads>`_

* `GitHub Mac <http://mac.github.com/>`_

* `GitHub Windows <http://windows.github.com/>`_

The examples in this document though will focus around using the ``git`` command line interface.  If you need help
setting up ``git`` to work against your GitHub account, please see the
`GitHub Help Article <https://help.github.com/articles/set-up-git>`_ about the topic.

You should ensure that your ``git`` information is using your real name and an appropriate e-mail address (preferably
your GitHub one).  This is very important to make sure that commits are attributed properly when authoring and other
functions are used with ``git``.

You also should be aware we continue to use `bugs.dojotoolkit.org <http://bugs.dojotoolkit.org>`_ for ticket management.
While GitHub issues have improved, they still do not give us sufficient features to be able to manage the code as we
would like.

Contributor Workflow
--------------------

This is documented in the `CONTRIBUTING.md <https://github.com/dojo/dojo/blob/master/CONTRIBUTING.md>`_ which provides
the contribution guidelines for the Toolkit as well as a well defined workflow for submitting Pull Requests to the
repositories.

As a committer, you should use the contribution workflow for landing non-trival changes in areas which you are not
directly responsible for, or you want/need to have a level of peer review prior to the change being merged.

If you prefer the command line, there are several tools which can issue pull requests from the command line.  The most
feature rich appears to be `hub <https://github.com/defunkt/hub>`_ which also provide many other features that make
command line integration with GitHub easier.

Also, since generally you want to be rebasing to avoid merge commits, you may want to set it so that ``git pull`` is
always a rebase pull::

  $ git config --global --bool pull.rebase true

What this will do though is make ``git`` complain when you have unstaged changes.  You will have to commit or stash them
before you can do a ``git pull`` then.

If all you are going to do is make your commits, there is no need to follow that workflow.  Instead you should just
follow the `Accept a Pull Request Workflow`_ below.

Accept a Pull Request Workflow
------------------------------

To accept a pull request, you should be working off a local repository whose remote ``origin`` is the
``github.com/dojo/`` repository you will be accepting the pull request into.  Pull requests should be merged into the
`master` branch of code once you are comfortable the pull request applies cleanly, meets coding standards and passes
appropriate tests.

You will need to know the remote repository and branch that the pull request originates from.  This is identifiable via
the pull request in GitHub by clicking the ``command line`` link in the "merge" box.  You should also assign the Pull
Request to yourself to avoid any confusion that you are working on the Pull Request.

First, make sure you have checked out the correct branch that the pull request is going to land in (typically
``master``) and that it is up-to-date::

  $ git checkout master && git pull origin master

Then, retrieve the Pull Request, squashing it into a single atomic changeset::

  $ git pull --squash --no-commit git://github.com/username/dojo.git t12345

The changes from the pull request will be pulled into your working directory, staged to be committed. You can now review
the changes and do whatever testing and fix-ups are necessary before committing.

When committing, please ensure that in your commit message you reference the appropriate ticket(s). You should also
commit with the appropriate author attribution, like the following::

  $ git commit --author="Some Contributor <some@example.com>"

Once you have committed the changes, push them upstream::

  $ git push origin master

GitHub will not auto-close the pull request because the commits that landed do not match the ones in the pull request,
so you will need to manually close it with a comment containing a reference to the real commit.

Backporting Workflow
--------------------

You may find a need to apply commits to older branches of code.  If the change can be applied cleanly, it is often
useful to "cherry-pick" commits from the other branch.  This provides the benefits of sharing the same commit message
information without creating unnecessary "commit noise".

For example if you were going to take a commit from the ``master`` branch and bring it into the ``1.7`` branch, it would
look something like this::

  $ git checkout -b 1.7 origin/1.7
  $ git cherry-pick -x e7b779e5475633f51f2390aa19cc7f0a7cf42c89
  $ git push origin 1.7

This ``-x`` will modify the commit message so that it is clear that the commit has been cherry picked and will provide
a reference in the commit message to the original commit.

Individual Workflow
-------------------

This is when you as a committer are making changes which you do not need additional feedback, are for areas of the code
you are responsible for or are trivial in nature.  The "traditional" guidelines apply in these situations:

* You should always reference the ticket in the commit message (using "fixes" and "refs" as appropriate).

* Only defect-fixes go into release branches, new features go into the ``master`` branch.

* The unnecessary commit noise should be avoided.  Rebase if needed.

If you are working locally and you have several commits now that you want to "squash" into a single commit to represent
your changes, you can do so by using the interactive rebase feature of ``git``.  More information on this can be found
in `Changing Multiple Commit Messages <http://git-scm.com/book/en/Git-Tools-Rewriting-History#Changing-Multiple-Commit-Messages>`_.  **Warning** do not rebase commits which you have already pushed to GitHub.  This will cause conflicts and if others
have become dependent on your commits, it will cause no end of carnage and swearing.

For a more explicit example, you should start with ensuring you are up to date::

  $ git checkout master && git pull origin master

Even though you plan would to to push directly to the origin repository, you might still benefit from working on your
code in a feature branch.  This could allow you to work on multiple things independently without have to worry about
picking through the changes::

  $ git checkout -b t12345

*Note* do not push your feature branch upstream.  It will cause severe embarrassment and ridicule.

Then you make all of your changes and then commit them.  Be responsible in the number of commits you make.  Generally a
single ticket should be a single atomic commit, which includes all the ancillary changes like test cases.  If through
the development you do not have a single atomic commit, you should ``git rebase -i``.  Rebasing is a complex topic and
is covered in the `Git Rebasing <http://git-scm.com/book/en/Git-Branching-Rebasing>`_ article as well as the article
mentioned above.

If you have made your changes and are staged and you are making a single commit, all you need to do is commit with an
appropriate comment::

  $ git commit -m "Resolve a defect, fixes #12345"

*Note* How you have ``git`` setup means that if you omit the ``-m`` directive, it will open a file in your chosen text
editor for you to edit a commit message.

Now you just need to push your changes upstream.  If you were on a feature branch::

  $ git push origin t12345:master

If you were on ``master``, you should just::

  $ git push origin master
