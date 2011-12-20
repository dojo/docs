.. _dojo/byId:

=========
dojo.byId
=========

:since: V0.3

.. contents ::
    :depth: 2

This is a simple alias to ''document.getElementById'', which not only is shorter to write, but fortunately works in all browsers. It turns a domNode reference to some Node byId, or the same node reference if passed a domNode.

Since dojo 1.7, dojo.byId is defined in the ``dojo/dom`` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

Dojo 1.7 (AMD)
--------------

When using AMD in a fully baseless application, ``byId`` is accessed from the ``dojo/dom`` module.

.. js ::

  require(["dojo/dom"], function(dom){
      // fetch a node by id="someNode"
      var node = dom.byId("someNode");
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.byId`` in the ``define`` or ``require`` callback:

.. js ::

  require(["dojo"], function(dojo){
      // fetch a node by id="someNode"
      var node = dojo.byId("someNode");
  });


Dojo < 1.7
----------

.. js ::

  // fetch a node by id="someNode"
  var node = dojo.byId("someNode");


The node variable is just a native domNode, with properties you can manipulate. The most common, ''innerHTML'':

.. js ::
    
  // set some node to say "Hello World"
  // dojo 1.7 (AMD)
  require(["dojo/dom"], function(dom){
      dom.byId("someNode").innerHTML = "Hello World";
  });

  // dojo < 1.7
  dojo.byId("someNode").innerHTML = "Hello World";

If you pass byId a domNode reference, the same node is returned:

.. js ::
  
  // dojo 1.7 (AMD)
  require(["dojo/dom"], function(dom){
      var node = dom.byId("someNode");
      var other = dom.byId(node);
      console.log(node == other);
  });

  // dojo < 1.7
  var node = dojo.byId("someNode");
  var other = dojo.byId(node);
  console.log(node == other);

  // output
  >>> true

If you pass dojo.byId a string, and no domNode is found to match, ''undefined'' or the null object is returned (depending on the browser), which is adequate truthiness to use conditionally:

.. js ::
  
  // dojo 1.7 (AMD)
  require(["dojo/dom"], function(dom){
    var node = dom.byId("fooBar");
    if(node){
      node.innerHTML = "I was found!";
    }else{
      console.log("no node with id='fooBar' found!");
    }
  });

  // dojo < 1.7
  var node = dojo.byId("fooBar");
  if(node){
    node.innerHTML = "I was found!";
  }else{
    console.log("no node with id='fooBar' found!");
  }

Most (if not all) functions in Dojo accept either a string or DomNode as a parameter. If passed a string, the function typically calls dojo.byId(), ensuring a domNode is always the object. For instance:

.. js ::
  
  // dojo 1.7 (AMD)
  require(["dojo/dom", "dojo/dom-style"], function(dom, domStyle){
    domStyle.set(dom.byId("foo"), "opacity", 0.5);
    // is identical to:
    domStyle.set("foo", "opacity", 0.5);
  });
  

  // dojo < 1.7
  dojo.style(dojo.byId("foo"), "opacity", 0.5);
  // is identical to:
  dojo.style("foo", "opacity", 0.5);

The latter is preferred, as the call to dojo.byId is made in both cases. The passing of a string ID is consistent throughout the Dojo Toolkit.

JavaScript has a fun convention for conditionals inline. Imagine wanting a domNode reference, and if not present, default to some other node:

.. js ::
  
  var othernode = dojo.byId("fallbackNode");
  var node = dojo.byId("missingNode") || othernode;
  node.innerHTML = "Which one?";

Above, if the node id="missingNode" is in fact missing, the logical OR will continue, and use othernode as the value of node.


Examples
========

Fade-out a node
---------------

The following example lets a node by id disappear from the screen

.. code-example ::

  .. js ::

    dojo.require("dijit.form.Button");

    dojo.ready(function(){
      var node = dojo.byId("findMe");
      dojo.connect(dijit.byId("buttonOne"), "onClick", function(){
        dojo.fadeOut({node: node, duration: 300}).play();
      });
      dojo.connect(dijit.byId("buttonTwo"), "onClick", function(){
        dojo.fadeIn({node: node, duration: 300}).play();
      })
    });

  .. html ::

    <button data-dojo-type="dijit.form.Button" id="buttonOne">Hide Me!</button> <button data-dojo-type="dijit.form.Button" id="buttonTwo">Show Me!</button>
    <div id="findMe">Hiya!</div>

  .. css ::

      #findMe {
        width: 200px;
        height: 100px;
        background: #f3f3f3;
        border: 1px dotted #ccc;
        color: #444;
        padding: 10px;
        margin: 10px;
      }

See Also
--------
- :ref:`dijit.byId <dijit/byId>` - Accessing a Dijit widget by id.

References
----------
- `DOM <http://www.w3.org/DOM/DOMTR>`_ - Official documentation on the Document Object Model.
