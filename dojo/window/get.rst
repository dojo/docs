.. _dojo/window/get:

==================
dojo/window::get()
==================

:since: v1.5

.. contents ::
  :depth: 2

Gets the window object associated with a document.

Usage
=====

.. js ::

  require(["dojo/window"], function(win){
    var w = win.get(doc);
  });

``get()`` takes a parameter of a Document and returns the appropriate window object reference adjusting for browser 
quirks.

Examples
========

Here is some code to trace up from a node to the root of the main document, passing through iframes:

.. js ::

  require(["dojo/window", "dojo/_base/window", "dojo/dom"], function(win, baseWin, dom){
    var node = dom.byId("someNode");
    while(node){
      if(node.tagName && node.tagName.toLowerCase() == "body"){
        // is this the root of the document or just the root of an iframe?
        if(node === baseWin.body()){
          // node is the root of the main document
          break;
        }
        // otherwise, find the iframe this node refers to (can't access it via parentNode,
        // need to do this trick instead). window.frameElement is supported in IE/FF/Webkit
        node = win.get(node.ownerDocument).frameElement;
      }else{
          node = node.parentNode;
      }
    }
  });

See Also
========

* :ref:`dojo/window <dojo/window>`

* :ref:`dojo/_base/window <dojo/_base/window>` - The base window features
