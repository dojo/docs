#format dojo_rst

dojo.withGlobal
===============

:Project owner: ?
:Available: since V0.9

.. contents::
   :depth: 2

dojo.withGlobal provides a mechanism by which a function can have its dojo.global and dojo.doc scope temporarily changed. This allows complete scope changes without affecting other items in the current dojo applications.


============
Introduction
============

This function provides a quick way to alter both the dojo.global scope and the dojo.doc document scope with a single call. You pass in a global scope (window object) and if it contains a "document" property, it is used in place of the default dojo.doc for the life of the function call. This call makes it possible for widgets that are dojo.global and dojo.doc scope-control away to have their scopes changed temporarily without affecting the rest of the page.


=====
Usage
=====

Use this function to replace the globals for a callback. Only during the callback execution, dojo.global and dojo.doc will be assigned to the values you specify.

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   var ifr = dojo.byId("someIframe");
   var newGlobal = ifr.contentWindow; // get the global scope object from the frame

   //Call a callback with different 'global' values and context. 
   dojo.withGlobal(newGlobal,  function() {
     console.log("The current dojo.global is: ", dojo.global);
     console.log("The current dojo.doc is: ", dojo.doc);
     console.log("The current scope is: ", this);
   }, this); 
 </script>


========
See also
========

* `dojo.global <dojo/global>`_
* `dojo.doc <dojo/doc>`_
* `dojo.withDoc <dojo/withDoc>`_
* `dojo.setContext <dojo/setContext>`_
