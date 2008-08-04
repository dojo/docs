#format dojo_rst

Functions used Everywhere
=========================

It would be near impossible to explain any one aspect of the Dojo Toolkit without first explaining a few simple functions that appear literally *everywhere* within the codebase.  These a dojo-fundamentals, and should be memorized if possible. 

dojo.require
------------

This is the core of the Dojo package system, and loads functionality not provided for in the Base dojo.js. Simply pass it a string:

.. code-block :: javascript

  dojo.require("dojo.fx"); // load dojo/fx.js
  dojo.require("dojox.widget.Toaster"); // load dojox/widget/Toaster.js

The general rule-of-thumb is: if you are calling a function or class like: dojo.some.randomFunction(), you will need to load the ``dojo.some`` module. If you don't, your scripts will throw a "dojo.some not defined" or "dojo.some.randomFunction not defined. There are a few exceptions to this rule, all of which are covered later in this guide. 

It may seem painful to require all modules, but Dojo rewards by:

* Loading any dependent scripts for you.  If dijit.Dialog requires dojo.math, you still need only require dijit.Dialog.
* Preventing loading dojo packages twice.  dojo.require will simply return if the package is already loaded.
* Allowing you to build streamlined versions of Dojo.  If you use dijit.Dialog a lot, you can build a custom version of dojo that loads dijit.Dialog quickly.  ``dojo.require`` knows whether the function is already loaded, and so you don't have to change any of your code.  

dojo.addOnLoad
--------------

This registers a function to be run when the document (and all `required </dojo/require>`_ dependencies) are ready. Simply pass it a function:

.. code-block :: javascript
  
  dojo.addOnLoad(function(){
     console.log("document ready!"); 
  });

That example passes an anonymous function. You can pass named functions as well:

.. code-block :: javascript
  
  var init = function(){
     console.log("document ready!");
  }
  dojo.addOnLoad(init);

Notice we didn't call ``dojo.addOnLoad(init());`` ... The additional () causes the named-function to execute immediately, and ``dojo.addOnLoad`` expects a function.

dojo.byId
---------

This is more or less an alias to ``document.getElementsById``. Simple pass ``dojo.byId`` a string, and the domNode with that id is returned. Notice how we wrap the byId call in an ``addOnLoad`` function -- You cannot use or manipulate the DOM before onLoad has fired, as a general rule.

.. code-block :: javascript

   dojo.addOnLoad(function(){
       var node = dojo.byId("someNode");
       node.innerHTML = "found me!";
   });

``.innerHTML`` is a basic property of DOM Elements. Here, we're setting the content of the node with ``id="someNode"`` to say "found me!"

Note: in some cases (in *lesser* browsers), ``document.getElementsById`` doesn't actually return the Node you desire. ``dojo.byId`` normalizes this, and is the recommended way of accessing nodes byId. ``dojo.byId`` is similar to Prototype's ``$("someId")``, and jQuery's ``$("#someId")`` syntax, though Dojo uses a safely-namespaced function for it's query engine: ```dojo.query("#someId")`` </dojo/query>`_, to avoid conflicts.

dijit.byId 
----------

``dojo.byId`` works exclusively on Dom Elements. 
