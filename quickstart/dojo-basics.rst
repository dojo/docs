#format dojo_rst

Functions used Everywhere
=========================

.. contents::
  :depth: 2

It would be near impossible to explain any one aspect of the Dojo Toolkit without first explaining a few simple functions that appear literally *everywhere* within the codebase.  These are dojo-fundamentals, and should be memorized if possible. 

============
dojo.require
============

This is the core of the Dojo package system, and loads functionality not provided for in the Base dojo.js. Simply pass it a string:

.. code-block :: javascript

  dojo.require("dojo.fx"); // load dojo/fx.js
  dojo.require("dojox.widget.Toaster"); // load dojox/widget/Toaster.js

The general rule-of-thumb is: if you are calling a function or class like: dojo.some.randomFunction(), you will need to load the ``dojo.some`` module. If you don't, your scripts will throw a "dojo.some not defined" or "dojo.some.randomFunction not defined. There are a few exceptions to this rule, all of which are covered later in this guide. 

It may seem painful to require all modules, but Dojo rewards by:

* Loading any dependent scripts for you.  If dijit.Dialog requires dojo.math, you still need only require dijit.Dialog.
* Preventing loading dojo packages twice.  dojo.require will simply return if the package is already loaded.
* Allowing you to build streamlined versions of Dojo.  If you use dijit.Dialog a lot, you can build a custom version of dojo that loads dijit.Dialog quickly.  ``dojo.require`` knows whether the function is already loaded, and so you don't have to change any of your code.  

==============
dojo.addOnLoad
==============

This registers a function to be run when the document (and all `required <dojo/require>`_ dependencies) are ready. Simply pass it a function:

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


=========
dojo.byId
=========

This is more or less an alias to ``document.getElementsById``. Simply pass ``dojo.byId`` a string, and the domNode with that id is returned. Notice how we wrap the byId call in an ``addOnLoad`` function -- You should not use or manipulate the DOM before onLoad has fired, as a general rule.

.. code-block :: javascript

   dojo.addOnLoad(function(){
       var node = dojo.byId("someNode");
       node.innerHTML = "found me!";
   });

``.innerHTML`` is a basic property of DOM Elements. Here, we're setting the content of the node with ``id="someNode"`` to say "found me!"

Note: in some cases (in *lesser* browsers), ``document.getElementsById`` doesn't actually return the Node you desire. ``dojo.byId`` normalizes this, and is the recommended way of accessing nodes byId. ``dojo.byId`` is similar to Prototype's ``$("someId")``, and jQuery's ``$("#someId")`` syntax, though Dojo uses a safely-namespaced function for it's query engine: ``dojo.query("#someId")`` (see: `dojo.query </dojo/query>`_) to avoid conflicts.


==========
dojo.query
==========

``dojo.query()`` returns a list of DOM nodes based on a CSS selector. Users of other libraries will find the syntax very familiar:

.. code-block :: javascript

  dojo.addOnLoad(function(){
    // every element in the page with the class "blueButton" assigned
    dojo.query(".blueButton").forEach(function(node, index, arr){
        console.debug(node.innerHTML);
    });
  });

The returned object of a ``dojo.query()`` call is an instance of `dojo.NodeList </dojo/NodeList>`_, a subclass of Array with many convenience methods added for making DOM manipulation and event handling easier. Custom extensions of the ``dojo.NodeList`` class are supported and encouraged.

==========
dijit.byId 
==========

``dojo.byId`` works exclusively on Dom Elements. Dijit is Dojo's widgeting system, and builds on Core Dojo functionality. Every widget generated in a page has a unique ID, just as native Dom Elements should, though with one *huge* difference: Dijit's are objects. An excellent article articulating this difference can be found at `DojoCampus <http://dojocampus.org/content/2008/05/06/jsid-dijitbyid-and-dojobyid/>`_, but the basics are: 

* If you are using just a normal domNode, use dojo.byId
* If you are working with a Dijit, use dijit.byId
* If you need access to the Dijit's domNode, it is stored in the the ``.domNode`` property of the Dijit reference:

.. code-block :: javascript

  var dialog = dijit.byId("myDialog");
  // the top-level node containing the dialog is:
  // dialog.domNode
  if(dialog){
     dialog.show();
  }

``dijit.byId`` returns an reference to that particular Dijit instance, and allows you to call methods and set properties. Each Dijit has several fundamental methods and properties defined by `dijit._Widget </dijit/_Widget>`_, and adds in additional specific methods depending on the type of Dijit. 

============
dojo.forEach
============

JavaScript 1.6 has a forEach loop, where you can apply a certain function to each element of an array.  Unfortunately at the time of this writing, only Firefox 2 has support for JS 1.6.  But never fear!  Dojo has defined one you can use in any Dojo-supported browser.  

Foreach is syntactic sugar for a regular ol' for loop.  So for example:

.. code-block :: javascript

  for(var i in queueEntries){
     console.debug(queueEntries[i]);
  }

Can be written as:

.. code-block :: javascript

  dojo.forEach(queueEntries, 
      function(oneEntry, index, array) {
          console.debug(oneEntry + " at index " + index);
      }
  );


We used an anonymous function here to define the operation.  This function must accept between one and three arguments. The first argument is the value of each value in the array in turn, the second is the current index or position in the array, and the third argument is the array itself.

For this simple loop, forEach isn't anything exciting.  But combined with other Dojo functions, especially `dojo.query </dojo/query>`_, it becomes remarkably useful.   Consider this snippet, which disables all SELECT tags on the page:

.. code-block :: javascript

  dojo.forEach(
    dojo.query("select", document),
    function(selectTag) {
        selectTag.disabled = true;
    }
  );


There's no monkeying around with DOM functions, no using tedious names or id's, and it continues to work even when you add new SELECT tags. 

Running dojo.forEach on a dojo.query result is so common, that Dojo defines a shortcut.  This snippet:

.. code-block :: javascript 

  dojo.query("select").forEach(
    function(selectTag) {
        selectTag.disabled = true;
    }
  );


does the same thing.  But that's not all!  *New in 1.0*, you can collapse the function down to its body, passed in as a string like so:

.. code-block :: javascript 

  // >= 1.0 only.
  dojo.query("select", document).forEach("item.disabled = true;");


Ay carumba!  That's a lot of functionality in a tiny 1-line package.  Once you get used to the syntax, you'll never want to go back. This only scratches the surface of how useful ``dojo.forEach`` can be. There is an excellent DojoCookie about `forEach <http://dojocampus.org/content/2008/02/19/foreach-goodness/>`_ on DojoCampus.

============
dojo.connect
============

Events in JavaScript or Dojo based applications are essential to making applications work. Connecting an event handler (function) to an element or an object is one of the most common things you will do when developing applications using Dojo. Dojo provides a simple API for connecting events via the ``dojo.connect`` function. One important thing to note here is that events can be mapped to any property or object or element. Using this API you can wire your user interfaces together or allow for your objects to communicate. The ``dojo.connnect`` API does not require that the objects be Dojo based.  In other words, you can use this API with your existing code and interfaces.

Below is the code in the tutorial handling events.  Here we connected the event handler, ``helloPressed``, to the ``onclick`` property of the hello button element.  When the button is clicked the funtion helloPressed will be called.

.. code-block :: javascript

  function helloPressed(){
   alert('You pressed the button');
  }

  function init(){
     button = dojo.byId('helloButton');
     dojo.connect(button, 'onclick', 'helloPressed');
  }

It is also possible to use the Dojo event model to connect simple objects.  To demonstrate, lets define a simple object with a couple of methods:

.. code-block :: javascript

  var exampleObj = {
      counter: 0,
      foo: function(){ 
          alert("foo");
          this.counter++;
      },
      bar: function(){
          alert("bar");
          this.counter++;
      }
  };


So lets say that I want ``exampleObj.bar()`` to get called whenever ``exampleObj.foo()`` is called. We can set this up the same way that we do with DOM events:

.. code-block :: javascript 

  dojo.connect(exampleObj, "foo", exampleObj, "bar");

Now calling ``foo()`` will also call ``bar()``, thereby incrementing the counter twice and alerting "foo" and then "bar". Any caller that was counting on getting the return value from ``foo()`` won't be disappointed. The source method should behave just as it always has. On the other hand, since there's no explicit caller for ``bar()``, it's return value will be lost since there's no
obvious place to put it.

In either case, each time ``dojo.connect`` is called with the same arguments it will result in multiple connections.   Later we will discuss strategies on how to guard against this.  

Notice that ``dojo.connect`` takes a different number of arguments in the examples above.  dojo.connect determines the types of positional arguments based on usage.

The Dojo event system allows you to connect to DOM elements or nodes or plain JavaScript objects.  The API is sophisticated enough that it allows you to connect multiple listeners to a single object so you can have multiple actions as a result of a single event such as a mouse click.   Of course there is an API to disconnect the listeners too.  The <A href='../event-system'>Events</A> section describes the Dojo Event system in more detail.  

*note*: in the above examples, we're connecting to (the lowercase) ``onclick``, which differs from ``onClick``. If you are using ``dojo.connect`` to listen to a Dijit widget function, Dijit uses mixedCases for it's naming convention. The lowercase version is used for DOM events, and the mixedCase version is for Dijit events.

``dojo.connect`` is a *lot* more powerful than can be described on the surface. See the `full rundown </dojo/connect>`_ for more examples and use-cases.

========
See also
========

* SitePen, a major Dojo contributor, has taken the liberty of writing and maintaining a `Dojo QuickStart Guide <http://sitepen.com/labs/guides/?guide=DojoQuickStart>`_. Rather than duplicate that effort, we will simply suggest you read that exceptionally helpful guide.
