.. _developer/github:

===================================
Dojo Development Workflow on GitHub
===================================

.. contents ::
    :depth: 3

This document will provide guidelines for the Dojo Toolkit workflow on GitHub.  As we will no longer be using SVN, it
is important to adjust our workflow to match to GitHub.

The Main Components
===================

The main GitHub Repositories for the Dojo 1.X code are:

  * `dojo/dojo <https://github.com/dojo/dojo>`_
  * `dojo/dijit <https://github.com/dojo/dijit>`_
  * `dojo/dojox <https://github.com/dojo/dojox>`_
  * `dojo/util <https://github.com/dojo/util>`_

You will need a valid GitHub user account.  This can be tied to your Dojo Foundation user account if not already by
contacting the appropriate project lead.

You will need the appropriate tools to manage your GitHub code.  There are a few choice, but the two main ones are the
standard ``git`` command line or the GitHub GUI:

  * `git <http://git-scm.com/downloads>`_
  * `GitHub Mac <http://mac.github.com/>`_
  * `GitHub Windows <http://windows.github.com/>`_

The examples in this document though will focus around using the ``git`` command line interface.  If you need help
setting up ``git`` to work against your GitHub account, please see the
`GitHub Help Article <https://help.github.com/articles/set-up-git>`_ about the topic.

You also should be aware we continue to use `bugs.dojotoolkit.org <http://bugs.dojotoolkit.org>` for ticket management.
While GitHub issues have improved, they still do not give us sufficient features to be able to manage the code as we
would like.

Individual Workflow
===================

As an individual contributor or committer, the workflow is as follow:
 * Fork the repository on GitHub
 * Clone your forked repository on your machine
 * Create a "feature" branch on your local repository
 * Make your changes and commit them to your local repository
 * Push your commits to your GitHub fork/remote repository
 * Issue a Pull Request to the "upstream" repository
 * Your Pull Request is reviewed by a committer and merged into the repository

Forking on GitHub
-----------------

When logged into your GitHub account, and you are viewing one of the main repositories, you will see the *Fork* button:

.. image :: Fork.png

Clicking this button will show you which repositories your can fork to.  Choose your own account.  Once the process
finishes, you will have your own repository that is "forked" from the GitHub one.

Forking is a GitHub term and not a git term.  Git is a wholly distributed source control system and simply worries
about local and remote repositories and allows you to manage your code against them.  GitHub then adds this additional
layer of structure of how repositories can relate to each other.

Cloning Your Fork
-----------------

Once you have successfully forked your repository, you will need to clone it locally to your machine::

    $ git clone --recursive https://github.com/username/dojo.git

You can also use the SSH URI for your repository (e.g. ``git@github.com:username/dojo.git``) if you have configured
SSH properly with your command line git.  It is important that you clone recursively for ``dojox`` because some of the
code is contained in submodules.  You won't be able to submit your changes to the repositories that way though.  If
you are working on any of these sub-projects, you should contact those project leads to see if their workflow differs.

