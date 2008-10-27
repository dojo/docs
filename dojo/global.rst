#format dojo_rst

dojo.global
===========

:Status: Draft
:Version: 1.0
:Available: since V?

.. contents::
   :depth: 2

dojo.global is an alias for the global scope.  In a browser environment, dojo.global is the window object.  You should refer to `dojo.global` rather than `window` so that your code will run correctly in other contexts (e.g. Rhino on a server).

.. code-block :: javascript
  :linenos:

  // connect a global "onclick" handler
  dojo.connect(dojo.global, "onclick", function(e){ 
     console.log("clicked: ", e.target);
  });

Though this example is clearly targeted at a browser environment, by using `dojo.global` over the `window` object we are ensuring the code will run in any other environments with a defined host environment file (hostenv_something). 
