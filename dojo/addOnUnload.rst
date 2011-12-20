.. _dojo/addOnUnload:

================
dojo.addOnUnload
================

:since: V?

.. contents ::
   :depth: 2

dojo.addOnUnload registers a function to be called when the page unloads.


Introduction
============

Since working with the DOM or JavaScript during a `window.onunload` event is not recommended, dojo.addOnUnload is triggered during `window.onbeforeunload`.  However, you need to be careful about what work you do during `dojo.addOnUnload/window.onbeforeunload` since this event can be triggered  if the user clicks a link to download a file or a `javascript:` link.  In these cases, the `document` will not be destroyed and so any destructive operations done during a `dojo.addOnUnload` callback may be premature.  If you need to run code during `window.onunload` then you can register a function using :ref:`dojo.addOnWindowUnload <dojo/addOnWindowUnload>`.


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
     baseUnload.addOnUnload(unLoad);

     // call a method of an object
     baseUnload.addOnUnload(window, "unLoad");
  
     // pass an object and an anonymous function
     baseUnload.addOnUnload(window, function(){ alert("we're out of here!"); });
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
   dojo.addOnUnload(unLoad);

   // call a method of an object
   dojo.addOnUnload(window, "unLoad");

   // pass an object and an anonymous function
   dojo.addOnUnload(window, function(){ alert("we're out of here!"); });



Examples
========

This example demonstrates how a `javascript:` link will trigger a `dojo.addOnUnload`.

.. code-example ::

  .. js ::

      // declare a function to do the unload work
      var unLoad = function(){
        // do some unload stuff
        alert("unloading...");
      }
      // pass a function pointer
      dojo.addOnUnload(unLoad);

  .. html ::

    This <a href="javascript:unLoad()">link</a> has an <pre>href="javascript:unLoad()"</pre> which fires dojo.addOnUnload but won't destroy the page.

See also
========

* :ref:`dojo.addOnWindowUnload <dojo/addOnWindowUnload>`
