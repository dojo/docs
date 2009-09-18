#format dojo_rst

TODOC - additional details

First, download and unpack a source distribution from  http://download.dojotoolkit.org/ or checkout the source from SVN.

Next, go to the utils/buildscripts directory and run the following command:

.. code-block :: text
  
  ./build.sh profile=standard action=release

Assuming you have java installed, after some time your dojo build will reside in ../../release/dojo

The "standard" profile essentially builds the same thing as what you would find in a full Dojo toolkit release - all of base, core, dijit, dojox.  This might be useful if you want to test changes to the Dojo source or create an extended Dojo release.
