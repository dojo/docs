#format dojo_rst

TODOC - additional details

First, download and unpack a source distribution from  http://download.dojotoolkit.org/ or checkout the source from SVN.

Next, go to the utils/buildscripts directory and run the following command:

.. code-block :: text
  
  ./build.sh profile=standard action=release

You will also likely want to pass the version= param or your build will have a version string of 0.0.0-dev by default.

Assuming you have java installed, after some time your dojo build will reside in ../../release/dojo

To make the release the same way the dojo developers do - use this command (changing version and releaseName as appropriate):

.. code-block :: text
  
  ./build.sh profile=standard version=1.3.2-dev releaseName=dojo-release-1.3.2-dev cssOptimize=comments.keepLines optimize=shrinksafe.keepLines cssImportIgnore=../dijit.css action=release 

See util/buildscripts/build_release.sh for more information on how the dojo release is created.

The "standard" profile essentially builds the same thing as what you would find in a full Dojo toolkit release - all of base, core, dijit, dojox.  This might be useful if you want to test changes to the Dojo source or create an extended Dojo release.
