.. _dojo/_base/window:

=================
dojo/_base/window
=================

.. contents ::
    :depth: 2

**dojo/_base/window** serves two purposes:

   - It provides methods/variables to access the current document and the ``<body>`` element of the current document
     These should be used along with :ref:`dojo/_base/kernel::global <dojo/_base/kernel#global>` as an abstraction
     in application code.

   - It provides functions to switch the "current document", i.e. the document accessed by the methods/variables
     mentioned above.


Accessing the Current Document
==============================


body()
------

This is a shorthand `method` for accessing the ``<body>`` element within the document. Not only is it shorter, it returns the `current` body of the current context. It also allows Dojo to use the call in non-browser environments by overloading the function to return an appropriate element.


The most important item to remember is ``body()`` is a function, and needs to be executed to get the value:

.. js ::

  require(["dojo/_base/window"], function(win){
    console.log( win.body() );
  });

This is shorter and safer to write than:

.. js ::

  var b = document.getElementsByTagName("body")[0];
  console.log(b);

Using the ``<body>`` element is an exercise left to the developer.
There are several utility functions in Dojo to do common tasks on DOMNodes, and ``<body>`` is just another DOMNode:

.. js ::

    require(["dojo/_base/window", "dojo/dom-style", "dojo/dom-construct"], function(win, style, ctr){
        // set the background color:
        style.set(win.body(), "backgroundColor", "green");
        // place a node with id="foo" as the last-child of body:
        ctr.place("foo", win.body());
        // place id="foo" as a first-child of body:
        ctr.place("foo", win.body(), "first");
    });



doc
---

Alias for the current document.  This is normally the value of window["document"];


The purpose of this attribute is twofold.  First, it provides a shorter reference to get the current document.  Second, all references that make use of it can have their document scope altered temporarily by changes to the ``doc`` variable.  In other words, ``doc`` is altered by ``withDoc()`` and ``setContext()``.


Use this variable in place of window.document.

.. js ::

   require(["dojo/_base/window"], function(win){
      var currentBody = win.body();
      var newText = win.doc.createTextNode("Some text");
      currentBody.appendChild(newText);
   });


Changing the Current Document
=============================

setContext()
------------

``setContext()`` allows many of Dojo's core functions to easily switch context (e.g. from the current window to an iframe) with a single function call:

.. js ::

  require(["dojo/_base/window"], function(win){
    win.setContext(window, window.document);
    // or
    win.setContext(myIframe.contentWindow, myIframe.contentWindow.document);
    ...
  });


However, most code will want to use ``withDoc()`` or ``withGlobal()`` rather than calling ``setContext()`` directly.

``setContext()`` works by modifying the values of ``doc``, ``body()``, and :ref:`dojo/_base/kernel::global <dojo/_base/kernel#global>`

Example
~~~~~~~

Here is a simple example that counts the links in the current page as well as the links in an embedded iframe, via ``setContext()``.

.. js ::

  require(["dojo/dom", "dojo/query", "dojo/_base/window"], function(dom, query, win){
    var countLinks = function(){
      var these = dom.byId('these_links');
      var those = dom.byId('those_links');
      var iframe = dom.byId('iframe').contentWindow;

      // Count the number of links in *this* page
      these.value = query('a').length;

      // Change context from current window to iframe
      win.setContext(iframe.window, iframe.window.document);

      // Count the number of links in the *iframe*
      those.value = query('a').length;
    };
  });


withDoc()
---------

Use this function to replace ``doc`` for the duration of a specific function call. Only during that specific function execution is ``doc`` assigned the document you specify, and then it's restored to it's previous value.

The example below demonstrates how to use it against an iframe document to query into the iframe and make updates:

.. code-example ::

  .. js ::


   require(["dojo/_base/array", "dojo/dom", "dojo/_base/window", "dojo/query", "dojo/dom-style"],
   function(array, dom, win, query, style){
       changeStyles = function(){
           // Apply styles to the document contained by the iframe
           var frameDoc = dom.byId("simpleFrame").contentWindow.document;
           win.withDoc(frameDoc, function(){
               var tds= query("td");
               array.forEach(tds, function(cell){
                   style.set(cell, "color", "red");
               });
           });
       };
   });

  .. html ::

    <button id="changeStyles" onclick="changeStyles();">Change Text Color in iFrame</button>
    <br><br>
    <iframe id="simpleFrame" name="simpleFrame" src="{{dataUrl}}dojox/data/tests/stores/books.html" style="width: 500px; height: 500px;">
    </iframe>

withGlobal()
------------

This function provides a quick way to alter both ``dojo/_base/kernel::global`` (the global scope)
and the ``dojo/_base/window::doc`` (the current document) for the duration of a callback execution.
You pass in a global scope (window object) and if it contains a "document" property, it is used in place of the default dojo/_base/window::doc.

Example usage:

.. js ::

   require(["dojo/dom", "dojo/_base/window"], function(dom, win){
     var ifr = dom.byId("someIframe");
     var newGlobal = ifr.contentWindow; // get the global scope object from the frame

     // Call a callback with different 'global' values and context.
     win.withGlobal(newGlobal,  function(){
       console.log("The current win.global is: ", win.global);
       console.log("The current win.doc is: ", win.doc);
       console.log("The current scope is: ", this);
     }, this);
   });
