.. _dojo/marginBox:

===============
dojo.marginBox
===============

:since: 1.0

.. contents ::
   :depth: 2

Getter/setter for the margin-box of node.


Introduction
============

See the `CSS spec <http://www.w3.org/TR/CSS2/box.html>`_ for details on box model and what margin-box means.

This method will either return the margin-box size of a node or set the node's width/height such that it's margin-box size becomes as specified.

In either usage it returns an object in the expected format of box. The object might look like:

{ l: 50, t: 200, w: 300: h: 150 }

for a node offset from its parent 50px to the left, 200px from the top with a margin width of 300px and a margin-height of 150px.

Since Dojo 1.7, ``dojo.marginBox`` is exposed via the ``getMarginBox`` and ``setMarginBox`` methods of the ``dojo/dom-geometry`` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

Dojo 1.7+ (AMD)
---------------

When using AMD format in a fully baseless application, ``getMarginBox`` and ``setMarginBox`` are accessed from the ``dojo/dom-geometry`` module.

.. js ::
 
  require(["dojo/dom-geometry"], function(domGeom){
    // Get the margin-box size of a node
    var marginBox = domGeom.getMarginBox(domNode);

    // Set domNode margin-box to 300px x 150px
    domGeom.setMarginBox(domNode, {w: 300, h: 150});
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.marginBox`` in the ``define`` or ``require`` callback:

.. js ::
 
  require(["dojo"], function(dojo){
    // Get the margin-box size of a node
    var marginBox = dojo.marginBox(domNode);

    // Set domNode margin-box to 300px x 150px
    dojo.marginBox(domNode, {w: 300, h: 150});
    
    // You can also use dojo.getMarginBox and dojo.setMarginBox individually:
    var marginBox = dojo.getMarginBox(domNode);
    dojo.setMarginBox(domNode, {w: 300, h: 150});
  });

Dojo < 1.7
----------

.. js ::
 
   // Get the margin-box size of a node
   var marginBox = dojo.marginBox(domNode);

   // Set domNode margin-box to 300px x 150px
   dojo.marginBox(domNode, {w: 300, h: 150});
   
   // You can also use dojo.getMarginBox and dojo.setMarginBox individually:
   var marginBox = dojo.getMarginBox(domNode);
   dojo.setMarginBox(domNode, {w: 300, h: 150});

Examples
========

Getting margin box I.
---------------------

This example displays the return values of dojo.marginBox on a node.

.. code-example ::

  .. js ::

      dojo.require("dijit.form.Button"); // only for the beauty :)

      getMarginBoxOne = function(){
        var marginBox = dojo.marginBox(dojo.byId("marginNodeOne"));

        console.log("Top: "+marginBox.t);
        console.log("Left: "+marginBox.l);
        console.log("Width: "+marginBox.w);
        console.log("Height: "+marginBox.h);
      };

  .. html ::

    <button data-dojo-type="dijit.form.Button" data-dojo-props="onClick:getMarginBoxOne">Get margin box</button>

    <div id="marginNodeOne">Hi, I am a marginNode, really!</div>
    
  .. css ::

      #marginNodeOne {
        width: 200px;
        height: 200px;
        padding: 10px;
        margin: 10px;
        border: 1px solid #ccc;
      }

Getting margin box II.
----------------------

This example displays the return values of dojo.marginBox on a nested node.

.. code-example ::

  .. js ::

      dojo.require("dijit.form.Button"); // only for the beauty :)

      getMarginBoxTwo = function(){
        var marginBox = dojo.marginBox(dojo.byId("marginNodeTwo"));

        console.log("Top: "+marginBox.t);
        console.log("Left: "+marginBox.l);
        console.log("Width: "+marginBox.w);
        console.log("Height: "+marginBox.h);
      };

  .. html ::

    <button data-dojo-type="dijit.form.Button" data-dojo-props="onClick:getMarginBoxTwo">Get margin box</button>

    <div>
      Hi I am nested
      <div id="marginNodeTwo">Hi, I am a marginNode, really!</div>
    </div>
    
  .. css ::

      #marginNodeTwo {
        width: 300px;
        height: 200px;
        padding: 10px;
        margin: 10px;
        border: 1px solid #ccc;
      }

Setting margin box I.
---------------------

This example is showcasing the usage of dojo.marginBox as a setter, take a look at the JavaScript code to see what the code does.

.. code-example ::

  .. js ::

      dojo.ready(function(){
        var marginBox = dojo.marginBox(dojo.byId("marginNodeThree"), {t: 20, l: 30, h: 300, w: 300});
      });

  .. html ::

    <div>
      Hi I am nested
      <div id="marginNodeThree">Hi, I am a marginNode, really!</div>
    </div>

  .. css ::

      #marginNodeThree {
        padding: 10px;
        margin: 10px;
        border: 1px solid #ccc;
      }


Comparison of various DOM node position/size methods
----------------------------------------------------

:ref:`Link: Comparison of various DOM node position/size methods. <dojo/position>`

See also
========

* :ref:`dojo.contentBox <dojo/contentBox>`
* :ref:`dojo.getMarginBox <dojo/getMarginBox>`
* :ref:`dojo.setMarginBox <dojo/setMarginBox>`
