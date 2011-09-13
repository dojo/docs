## page was renamed from 1.2/dojo/byId
#format dojo_rst

dojo.byId
=========

:Available: since V0.3

.. contents::
    :depth: 2

This is a simple alias to ''document.getElementById'', which not only is shorter to write, but fortunately works in all browsers. It turns a domNode reference to some Node byId, or the same node reference if passed a domNode. 

Since dojo 1.7, dojo.byId has been kept in dojo/_base/html as a compatibility of dojo version before, it is an alias of dom.byId in dojo/dom.

=====
Usage
=====

Dojo 1.7 (AMD)
--------------

.. code-block :: javascript

  require(["dojo/_base/html"], function(dojo){  // Note, dom or any other variable name can be used     
      // fetch a node by id="someNode"
      var node = dojo.byId("someNode");
  });

It's recommended to use dom.byId to replace dojo.byId.

.. code-block :: javascript

  require(["dojo/dom"], function(dom){  // Note, dom or any other variable name can be used     
      // fetch a node by id="someNode"
      var node = dom.byId("someNode");
  });


Dojo < 1.7
----------

.. code-block :: javascript

  // fetch a node by id="someNode"
  var node = dojo.byId("someNode");


The node variable is just a native domNode, with properties you can manipulate. The most common, ''innerHTML'':

.. code-block :: javascript
  :linenos:
  
  // set some node to say "Hello World"
  // dojo 1.7 (AMD)
  require(["dojo/dom"], function(dom){
      dom.byId("someNode").innerHTML = "Hello World";
  });

  // dojo < 1.7
  dojo.byId("someNode").innerHTML = "Hello World";

If you pass byId a domNode reference, the same node is returned:

.. code-block :: javascript
  :linenos:

  // dojo 1.7 (AMD)
  require(["dojo/dom"], function(dom){
      var node = dom.byId("someNode");
      var other = dom.byId(node);
      console.log(node == other);
  });

  //dojo < 1.7
  var node = dojo.byId("someNode");
  var other = dojo.byId(node);
  console.log(node == other);

  // output
  >>> true

If you pass dojo.byId a string, and no domNode is found to match, ''undefined'' or the null object is returned (depending on the browser), which is adequate truthiness to use conditionally:

.. code-block :: javascript
  :linenos:

  // dojo 1.7 (AMD)
  require(["dojo/dom"], function(dom){
    var node = dom.byId("fooBar");
    if(node){
      node.innerHTML = "I was found!";
    }else{
      console.log("no node with id='fooBar' found!");
    }
  });

  //dojo < 1.7
  var node = dojo.byId("fooBar");
  if(node){
    node.innerHTML = "I was found!";
  }else{
    console.log("no node with id='fooBar' found!");
  }

Most (if not all) functions in Dojo accept either a string or DomNode as a parameter. If passed a string, the function typically calls dojo.byId(), ensuring a domNode is always the object. For instance:

.. code-block :: javascript
  :linenos:

  // dojo 1.7 (AMD)
  require(["dojo/dom", "dojo/dom-style"], function(dom, style){
    style.set(dom.byId("foo"), "opacity", 0.5);
    // is identical to:
    style.set("foo", "opacity", 0.5);
  });
  

  //dojo < 1.7
  dojo.style(dojo.byId("foo"), "opacity", 0.5);
  // is identical to:
  dojo.style("foo", "opacity", 0.5);

The latter is preferred, as the call to dojo.byId is made in both cases. The passing of a string ID is consistent throughout the Dojo Toolkit.

JavaScript has a fun convention for conditionals inline. Imagine wanting a domNode reference, and if not present, default to some other node:

.. code-block :: javascript
  :linenos:

  var othernode = dojo.byId("fallbackNode");
  var node = dojo.byId("missingNode") || othernode;
  node.innerHTML = "Which one?";

Above, if the node id="missingNode" is in fact missing, the logical OR will continue, and use othernode as the value of node.


========
Examples
========

Fade-out a node
---------------

The following example lets a node by id dissapear from the screen

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button");

    dojo.addOnLoad(function(){
      var node = dojo.byId("findMe");
      dojo.connect(dijit.byId("buttonOne"), "onClick", function(){
        dojo.fadeOut({node: node, duration: 300}).play();
      });
      dojo.connect(dijit.byId("buttonTwo"), "onClick", function(){
        dojo.fadeIn({node: node, duration: 300}).play();
      })
    });
    </script>

  .. cv:: html

    <button data-dojo-type="dijit.form.Button" id="buttonOne">Hide Me!</button> <button data-dojo-type="dijit.form.Button" id="buttonTwo">Show Me!</button>
    <div id="findMe">Hiya!</div>

  .. cv:: css

    <style type="text/css">
      #findMe {
        width: 200px;
        height: 100px; 
        background: #f3f3f3;
        border: 1px dotted #ccc;
        color: #444;
        padding: 10px;
        margin: 10px;
      }
    </style>

See Also
--------
- `dijit.byId <dijit/byId>`_ - Accessing a Dijit widget by id.

References
----------
- `DOM <http://www.w3.org/DOM/DOMTR>`_ - Official documentation on the Document Object Model.
