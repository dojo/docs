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

   require(['dojo/_base/unload','dojo/_base/xhr'], function(baseUnload, xhr){
     // pass a function pointer
     baseUnload.addOnUnload(function(){
	   // do some unload stuff
	   console.log("unloading...");
	   // NOTE: some browsers block alerts in onunload
	   alert("unloading...");
     });
     
     baseUnload.addOnUnload(function(){
          // make sync xhr before page unloads
          xhr("POST",{
               url: location.href,
               sync: true,
               handleAs: "text",
               content:{
                   param1:1
               },
               load:function(result){
                    // will return before next handler fires
                    console.log(result);
               }
          });
     });

     // call a method of an object
     // example: calls a method, unLoad, set on the window
     window.unLoad=function(){
         console.log("an unload function");
         return "This is a message that will appear on unLoad.";
     };
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
	         // NOTE: some browsers block alerts in onunload
		 alert("unloading...");
	 });

     // call a method of an object
     baseUnload.addOnWindowUnload(window, "unLoad");
   });
