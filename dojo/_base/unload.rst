.. _dojo/_base/unload:

=================
dojo/_base/unload
=================

.. contents ::
    :depth: 2

Introduction
============

Contains addOnUnload() and addOnWindowUnload() methods.


addOnUnload()
-------------
addOnUnload() registers a function to be called when the page unloads.


Since working with the DOM or JavaScript during a `window.onunload` event is not recommended, addOnUnload() is triggered during `window.onbeforeunload`.  However, you need to be careful about what work you do during `addOnUnload/window.onbeforeunload` since this event can be triggered  if the user clicks a link to download a file or a `javascript:` link.  In these cases, the `document` will not be destroyed and so any destructive operations done during a `addOnUnload` callback may be premature.  If you need to run code during `window.onunload` then you can register a function using `addOnWindowUnload()`.


Usage
-----

.. js ::

   require(['dojo/_base/unload'], function(baseUnload){
     // pass a function pointer
     baseUnload.addOnUnload(function(){
	   // do some unload stuff
	   alert("unloading...");
	 });

     // call a method of an object
     baseUnload.addOnUnload(window, "unLoad");
   });



addOnWindowUnload()
===================
addOnWindowUnload registers a function to be triggered when window.onunload fires.


When a user exits the page to visit another page, the page is unloaded and a `window.onunload` event handler is fired.  During this phase of page loading, it is not recommended that you try to modify the DOM or access JavaScript properties since they may not be available.  You should consider using ``addOnUnload()`` if you need to modify the DOM or do heavy JavaScript work since it triggers functions during the `window.onbeforeunload`.


Usage
-----

.. js ::

   require(['dojo/_base/unload'], function(baseUnload){
     // pass a function pointer
     baseUnload.addOnWindowUnload(function(){
		 // do some unload stuff
		 alert("unloading...");
	 });

     // call a method of an object
     baseUnload.addOnWindowUnload(window, "unLoad");
   });
