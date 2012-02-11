.. _developer/release:

==============
How to release
==============

Let’s make some magic together.

.. contents ::


Creating a Dojo Release/RC/Beta
===============================

1. Log into your shell account at <username>.dojotoolkit.org
2. Check out a copy of the appropriate branch
3. Run ``util/buildscripts/build_release.sh <version> <username> <revision>``, where:

   ``version`` is the version number, e.g. 1.7.1rc1

   ``username`` is your subversion username

   ``revision`` is the revision of the version to tag as the release. If unspecified, the head revision will be used.
4. Press a key to start the build
5. Press "Enter" when asked whether you want to do any manual packaging
6. Move the release to ``download.dojotoolkit.org:/srv/www/vhosts.d/download.dojotoolkit.org/``
   (if you built it locally, then copy it to <username>.dojotoolkit.org first, using the command suggested by the
   build script)
7. Untar the files to download.dojotoolkit.org, then delete the tarball
8. Update download.dojotoolkit.org/index.html with the new version information. If it’s a new major release, make sure to list the previous release under “Releases”.
9. Update the tags on the GitHub repos.
10. Add new version and milestone numbers to Trac.
11. Bulk move all open tickets to the next release number in Trac.
12. Do a CDN build! Ant 1.8 does not work, so use peller’s copy of 1.7.1:

    ``ANT_HOME=/home/peller/ant-1.7.1/ ./cdnBuild.sh <version>``, where:

    ``version`` is the version number, just like before

    If this is the first time you have run ant, it will not work. You will need to ctrl+c after it fails and start over.

    You will also need to comment out the <property name="locales"/> node in ``util/buildscripts/cldr/build.xml``.

    **READ THE CDNBUILD.TXT INSTRUCTIONS OR YOU MIGHT BUILD THE WRONG VERSION**.
13. Transfer the CDN build directory to archive.dojotoolkit.org/cdn. You probably wanna archive it first or else it
    will take forever and ever.
14. Send an email to dojo-contributors and dojo-interest mailing lists. If possible, include a picture of a puppy or
    something.
15. Send an email to your friendly CDN manager asking them to copy over the new CDN build.
16. Celebrate!

Creating a new DTK branch (for new major versions)
==================================================

1. Run ``mk_branch.sh <version> <revision>``, where:

   ``version`` is the new branch number, e.g. 1.7
   ``revision`` is the revision of the version to branch from

2. Check out the new branch and update ``build_release.sh`` to point to the release branch, not trunk.
3. Have a beer.
