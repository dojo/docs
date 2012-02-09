.. _developer/rstwiki:

==============
How to rstWiki
==============

.. contents ::

Content from http://oksoclap.com/22eEx9Hh4Q needs to be merged here.

Creating reference guide for Web site
=====================================

1. ``git clone --recursive git@github.com:phiggins42/rstwiki.git`` (recursive is important, build will not work if submodules are not checked out)
2. Inside there, ``git clone git@github.com:dojo/docs.git dojodocs`` (edit the Makefile in ``export`` if you want these docs to come from somewhere else)
3. Go into ``dojodocs`` and ``git checkout 1.7`` (or whatever the latest RELEASE branch is; this repo tracks trunk by default!)
3. Go into each of ``_static/{dojo,dijit,dojox,util}`` and ``git checkout 1.7.1`` (or whatever the latest RELEASE version of DTK is; rstwiki tracks some version of trunk by default!)
4. ``cd export``
5. Edit ``Makefile`` to contain the correct Dojo version
6. ``mkdir build``
7. ``export LC_CTYPE=""`` (not sure why this is necessary, but it was in the original docs!)
8. ``make clean dojo data html``
9. In the dtk repo, ``svn rm reference-guide && svn ci -m "Replacing old reference guide"``
10. Move the ``export/build/html`` directory to ``reference-guide`` in the DTK repo
11. ``svn add reference-guide && svn ci -m "Adding new reference guide"``
12. Done, finally!

Updating rstWiki on livedocs
============================

Note: this is in tmpdocs.dojotoolkit.org on the fileserver at the moment. When it moves, init.d
and apache2 conf need to be updated.

1. Make whatever changes you need to the repo at https://github.com/phiggins42/rstwiki
2. ``sudo -u website git pull && sudo -u website git submodule update`` on the server to retrieve the update
3. ``cd _static && sudo -u website ./build.sh`` if any CSS or JS changes were made
4. ``sudo /etc/init.d/rstwiki restart`` to pick up any Python changes
