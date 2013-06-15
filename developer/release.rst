.. _developer/release:

==============
How to release
==============

Let’s make some magic together.

.. contents ::


Creating a Dojo Release/RC/Beta
===============================

1. Log into your shell account at <username>.dojotoolkit.org
2. ``git clone https://github.com/dojo/util.git``
3. Run ``util/buildscripts/build_release.sh -c -b <branch> -u <username> <version>``, where:

   ``-c`` should be used ONLY if you want to include a build for CDN (e.g. final release)

   ``-b <branch>`` is the branch to use as the source for the release (e.g. 1.7). If unspecified, the master branch will be used

   ``-u <username>`` is your Dojo Foundation username. If unspecified, auto-loading to the downloads server will be unavailable

   ``<version>`` is the version number for the new release (e.g. 1.7.1rc1)

4. Follow the prompts
5. Update download.dojotoolkit.org/index.html with the new version information. If it’s a new major release, make sure to list the previous release under “Releases”.
6. If it is a new release of the current latest release branch, update dojotoolkit.org/download too.
7. Add new version and milestone numbers to Trac.
8. Bulk move all open tickets to the next release number in Trac.
9. Send an email to dojo-contributors and dojo-interest mailing lists. If possible, include a picture of a puppy or
   something.
10. Send an email to your friendly CDN manager asking them to copy over the new CDN build.
11. Celebrate!

Creating a new DTK branch (for new major versions)
==================================================

** Not updated for git yet **

1. Run ``mk_branch.sh <version> <revision>``, where:

   ``version`` is the new branch number, e.g. 1.7
   ``revision`` is the revision of the version to branch from

2. Check out the new branch and update ``build_release.sh`` to point to the release branch, not trunk.
3. Have a beer.
