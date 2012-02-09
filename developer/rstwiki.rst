.. _developer/rstwiki:

==============
How to rstWiki
==============

.. contents ::

Content from http://oksoclap.com/22eEx9Hh4Q needs to be merged here.

Creating reference guide for Web site
=====================================

TODOC

Updating rstWiki on livedocs
============================

Note: this is in tmpdocs.dojotoolkit.org on the fileserver at the moment. When it moves, init.d
and apache2 conf need to be updated.

1. Make whatever changes you need to the repo at https://github.com/phiggins42/rstwiki
2. ``sudo -u website git pull`` on the server to retrieve the update
3. ``cd _static && sudo -u website ./build.sh`` if any CSS or JS changes were made
4. ``sudo /etc/init.d/rstwiki restart`` to pick up any Python changes
