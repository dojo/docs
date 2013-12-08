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
7. If you have access to publish on npm, check out the tag for the `dojo` package and `npm publish`.
8. Add new version and milestone numbers to Trac.
9. Bulk move all open tickets to the next release number in Trac.
10. Send an email to dojo-contributors and dojo-interest mailing lists. If possible, include a picture of a puppy or
    something.
11. Send an email to your friendly CDN manager asking them to copy over the new CDN build.
12. Celebrate!

Creating a new DTK branch (for new major versions)
==================================================

After performing the normal release, for each repo:

1. Run `git checkout -b x.x` where `x.x` is the new major version
2. `git push -u origin x.x` to push the new branch upstream
3. `git checkout master`
4. Update all the versioned files with the new major version of the next release;
   see `VERSION_FILES` in `util/buildscripts/build_release.sh` for a list of versioned files in each repo
