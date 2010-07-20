#format dojo_rst

Special Dojo Build: WebKit Mobile 
===================================

This is a simple build one can run to remove a percentage of the base ``dojo.js`` by omitting branches of code designed to accommodate Internet Explorer.

To create this special ``dojo.js`` file, invoke the build with a **webkitMobile=true** parameter.

.. code-block :: javascript 

  cd util/buildscripts/
  ./build.sh profile=base webkitMobile=true version=1.5.0 action=release


 
