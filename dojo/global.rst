#format dojo_rst

dojo.global
===========

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V0.9

.. contents::
   :depth: 2

dojo.global is an alias for the global scope.


============
Introduction
============

In a browser environment, dojo.global is the window object. You should refer to `dojo.global` rather than `window` so that your code will run correctly in other contexts (e.g. Rhino on a server).


=====
Usage
=====

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // connect a global "onclick" handler
   dojo.connect(dojo.global, "onclick", function(e){ 
       console.log("clicked: ", e.target);
   });
 </script>

Though this example is clearly targeted at a browser environment, by using `dojo.global` over the `window` object we are ensuring the code will run in any other environments with a defined host environment file (hostenv_something). 


========
See also
========

* `dojo.doc <dojo/doc>`_ 

  Alias for the current document

* `dojo.withGlobal <dojo/withGlobal>`_

  Call callback with globalObject as dojo.global and globalObject.document as dojo.doc
