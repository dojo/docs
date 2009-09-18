#format dojo_rst

TODOC - additional details

First, download and unpack a source distribution from http://download.dojotoolkit.org/ or checkout the dojo source from SVN.

Next, go to the utils/buildscripts directory and run the following command:

.. code-block :: text
  
  ./build.sh profile=base action=release

You will also likely want to pass the version= param or your build will have a version string of 0.0.0-dev by default.

Assuming you have java installed, after some time your dojo build will reside in ../../release/dojo

The "base" profile builds dojo without dijit or dojox.  Include ../../release/dojo/dojo.js in your application for your core dojo build.  This is similar to downloading dojo.js from the http://www.dojotoolkit.org/downloads
