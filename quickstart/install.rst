## page was renamed from install
## page was renamed from 1.2/install
## page was renamed from Install
#format dojo_rst

Installing Dojo
===============

:Authors: Peter Higgins, Nikolai Onken

.. contents::
    :depth: 2

Good news! Dojo's just a bunch of files on disk so it doesn't require any special setup. There are three main ways to get Dojo:

* Install nothing! Use Dojo from AOL's Content Distribution Network (`CDN <http://dev.aol.com/dojo>`_) or from the `CDN of Google <http://code.google.com/apis/ajaxlibs/documentation/index.html#dojo>`_.
* Install the `latest release <http://download.dojotoolkit.org/current-stable>`_ on your server
* Install directly from `source control <developer/svn>`_

=================
Use Dojo from CDN
=================

This method is quick and painless! You simply load Dojo through ``<script>`` tags pointing to the AOL (or Google) CDN. You don't need to invest any of your own server disk space or resources nor will you need to install Dojo locally in many cases. Instructions are available on using Dojo from the CDN.

=============================
Use Dojo from your Own Server
=============================

For you traditionalists out there, you can download, install and use Dojo the old fashioned way.

* Download the latest build from `dojo downloads <http://dojotoolkit.org/downloads>`_
* Uncompress the files (dojo/, dijit/ dojox/ and possibly util/) into some web-accessible folder. Assuming you install it under the directory /js, when you're done, the file system should look something like this: ``FIXME``
* With your browser, open ``http://yoursite.com/js/dijit/themes/themeTester.html`` You should see a page like this: ``FIXME``

And now you've got a working Dojo! Anything can be accomplished now based on the inclusion of ``dojo.js`` at whatever relative position on your server it exists:

.. code-block :: html

  <html>
  <head>
     <title>Installed!</title>
     <script src="js/dojo/dojo.js"></script>
  </head>
  <body>
     <h1>Hello, Dojo</h1>
  </body>
  </html>

=========================
Getting the Nightly Build
=========================

For the truly dedicated: you can get the latest and greatest code directly from the `nightly archives <http://archive.dojotoolkit.org/nightly/>`_, or directly from the Subversion repository. Use this repository URL: ``http://svn.dojotoolkit.org/src/view/anon/all/trunk``, like this:

``svn checkout http://svn.dojotoolkit.org/src/view/anon/all/trunk dojo-toolkit-readonly``

The README in the link explains why the directory looks empty: It is a collection of ``svn:externals`` pointing to the various project root folders. For instance, if you desire only the Dojo project (excluding Dijit, DojoX, and util/), use this URL ``http://svn.dojotoolkit.org/src/dojo/trunk``:

``svn checkout http://svn.dojotoolkit.org/src/dojo/trunk dojo-only-readonly``

It is worth noting: when working from Subversion, the code is **not** optimized or otherwise built. For optimum performance, download the source files from SVN, and run a build. ``FIXME: link`` 
