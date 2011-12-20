.. _dojo/addOnWindowUnload:

======================
dojo.addOnWindowUnload
======================

:since: V?

.. contents ::
   :depth: 2

dojo.addOnWindowUnload registers a function to be triggered when window.onunload fires.


Introduction
============

When a user exits the page to visit another page, the page is unloaded and a `window.onunload` event handler is fired.  During this phase of page loading, it is not recommended that you try to modify the DOM or access JavaScript properties since they may not be available.  You should consider using :ref:`dojo.addOnUnload <dojo/addOnUnload>` if you need to modify the DOM or do heavy JavaScript work since it triggers functions during the `window.onbeforeunload`.


Usage
=====

Dojo 1.7 (AMD)
--------------

.. js ::
 
   require(['dojo/_base/unload'], function(baseUnload){
     // declare a function to do the unload work
     var unLoad = function(){
       // do some unload stuff
       alert("unloading...");
     }
     // pass a function pointer
     baseUnload.addOnWindowUnload(unLoad);

     // call a method of an object
     baseUnload.addOnWindowUnload(window, "unLoad");

     // pass an object and an anonymous function
     baseUnload.addOnWindowUnload(window, function(){ alert("we're out of here!"); });
   });

Dojo < 1.7
----------

.. js ::
 
   // declare a function to do the unload work
   var unLoad = function(){
     // do some unload stuff
     alert("unloading...");
   }
   // pass a function pointer
   dojo.addOnWindowUnload(unLoad);

   // call a method of an object
   dojo.addOnWindowUnload(window, "unLoad");

   // pass an object and an anonymous function
   dojo.addOnWindowUnload(window, function(){ alert("we're out of here!"); });
