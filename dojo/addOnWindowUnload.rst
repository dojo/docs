#format dojo_rst

dojo.addOnWindowUnload
======================

:Status: Draft
:Version: 1.0
:Available: since V?

.. contents::
   :depth: 2

dojo.addOnWindowUnload registers a function to be triggered when window.onunload fires.


============
Introduction
============

When a user exits the page to visit another page, the page is unloaded and a `window.onunload` event handler is fired.  During this phase of page loading, it is not recommended that you try to modify the DOM or access JavaScript properties since they may not be available.  You should consider using `dojo.addOnUnload <dojo/addOnUnload>`_ if you need to modify the DOM or do heavy JavaScript work since it triggers functions during the `window.onbeforeunload`.


=====
Usage
=====

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // declare a function to do the unload work
   var unLoad = function() {
     // do some unload stuff
     alert("unloading...");
   }
   // pass a function pointer
   dojo.addOnWindowUnload(unLoad);

   // call a method of an object
   dojo.addOnWindowUnload(window, "unLoad");

   // pass an object and an anonymous function
   dojo.addOnWindowUnload(window, function() {alert("we're out of here!");});
 </script>
