#format dojo_rst

dojo.doc
========

:Status: Draft
:Version: 1.0
:Available: since V0.9

.. contents::
   :depth: 2

dojo.withGlobal provides a mechanism by with a particular function can have its dojo.global and dojo.doc temporarily changed.  This allows complete scope changes without affecting other items in the current dojo applications.

============
Introduction
============

This function provides a quick way to alter both the dojo.global scope and the dojo.doc document scope with a dingle call.  This call makes it possible for widgets that are dojo.global and dojo.doc scope-control away to have their scopes changed temporarily in a function call without affecting the rest of the page.

=====
Usage
=====

Use this function to replace the globals for a callback.  Only during the callback execution, dojo.global and dojo.doc will be assigned to the values you specify.

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   var newScope = {};
   newScope.global = someOtherScope;  //Assign this to have an object scope other than dojo.global.
   newScope.document = someIframeDoc;  //Assign the dojo.doc to be something other than the current document.

   //Call a callback with different 'global' values and context. 
   dojo.withGlobal(newScope,  function() {
     console.log("The current dojo.global is: ", dojo.global);
     console.log("The current dojo.doc is: ", dojo.doc);
     console.log("The current scope is: ", this);
   }, this); 
 </script>


========
See also
========

* `dojo.doc <dojo/doc>`_
* `dojo.withDoc <dojo/withDoc>`_
* `dojo.setContext <dojo/setContext>`_
