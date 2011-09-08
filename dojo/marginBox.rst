#format dojo_rst

dojo.marginBox
===============

:Status: Draft
:Version: 1.0
:Available: since 1.0

.. contents::
   :depth: 2

Getter/setter for the margin-box of node.


======================
Introduction and Usage
======================

See the `CSS spec <http://www.w3.org/TR/CSS2/box.html>`_ for details on box model and what margin-box means.

This method will either return the margin-box size of a node or set the node's width/height such that it's margin-box size becomes as specified.

In either usage it returns an object in the expected format of box. The object might look like:

{ l: 50, t: 200, w: 300: h: 150 }

for a node offset from its parent 50px to the left, 200px from the top with a margin width of 300px and a margin-height of 150px.

=====
Usage
=====

Dojo 1.7 (AMD)
--------------

In dojo 1.7, this API has been moved to dojo/_base/html.

.. code-block :: javascript
 :linenos:

  require(["dojo/_base/html"], function(dojo){   
     // Get the margin-box size of a node
     var marginBox = dojo.marginBox(domNode);

     // Set domNode margin-box to 300px x 150px
     dojo.marginBox(domNode, {w: 300, h: 400});
  });

It is also can use `dojo.getMarginBox <dojo.getMarginBox>`_ and `dojo.setMarginBox <dojo.setMarginBox>`_ to do this operation.

.. code-block :: javascript
 :linenos:

  require(["dojo/_base/html"], function(dojo){   
     // Get the margin-box size of a node
     var marginBox = dojo.getMarginBox(domNode);

     // Set domNode margin-box to 300px x 150px
     dojo.setMarginBox(domNode, {w: 300, h: 400});
  });

It's recommend to use geom.getMarginBox and geom.setMarginBox in dojo 1.7.

.. code-block :: javascript
 :linenos:

  require(["dojo/dom-geometry"], function(geom){   
     // Get the margin-box size of a node
     var marginBox = geom.getMarginBox(domNode);

     // Set domNode margin-box to 300px x 150px
     geom.setMarginBox(domNode, {w: 300, h: 400});
  });

Dojo < 1.7
----------

.. code-block :: javascript
 :linenos:

   // Get the margin-box size of a node
   var marginBox = dojo.marginBox(domNode);

   // Set domNode margin-box to 300px x 150px
   dojo.marginBox(domNode, {w: 300, h: 400});

========
Examples
========

Getting margin box I.
---------------------

This example displays the return values of dojo.marginBox on a node. 

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.Button"); // only for the beauty :)

      getMarginBoxOne = function(){
        var marginBox = dojo.marginBox(dojo.byId("marginNodeOne"));

        console.log("Top: "+marginBox.t);
        console.log("Left: "+marginBox.l);
        console.log("Width: "+marginBox.w);
        console.log("Height: "+marginBox.h);
      };
    </script>

  .. cv:: html

    <button data-dojo-type="dijit.form.Button" data-dojo-props="onClick:getMarginBoxOne">Get margin box</button>

    <div id="marginNodeOne">Hi, I am a marginNode, really!</div>
    
  .. cv:: css

    <style type="text/css">
      #marginNodeOne {
        width: 200px;
        height: 200px;
        padding: 10px;
        margin: 10px;
        border: 1px solid #ccc;
      }
    </style>

Getting margin box II.
----------------------

This example displays the return values of dojo.marginBox on a nested node. 

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.Button"); // only for the beauty :)

      getMarginBoxTwo = function(){
        var marginBox = dojo.marginBox(dojo.byId("marginNodeTwo"));

        console.log("Top: "+marginBox.t);
        console.log("Left: "+marginBox.l);
        console.log("Width: "+marginBox.w);
        console.log("Height: "+marginBox.h);
      };
    </script>

  .. cv:: html

    <button data-dojo-type="dijit.form.Button" data-dojo-props="onClick:getMarginBoxTwo">Get margin box</button>

    <div>
      Hi I am nested
      <div id="marginNodeTwo">Hi, I am a marginNode, really!</div>
    </div>
    
  .. cv:: css

    <style type="text/css">
      #marginNodeTwo {
        width: 300px;
        height: 200px;
        padding: 10px;
        margin: 10px;
        border: 1px solid #ccc;
      }
    </style>

Setting margin box I.
---------------------

This example is showcasing the usage of dojo.marginBox as a setter, take a look at the JavaScript code to see what the code does.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.addOnLoad(function(){
        var marginBox = dojo.marginBox(dojo.byId("marginNodeThree"), {t: 20, l: 30, h: 300, w: 300});
      });
    </script>

  .. cv:: html

    <div>
      Hi I am nested
      <div id="marginNodeThree">Hi, I am a marginNode, really!</div>
    </div>

  .. cv:: css

    <style type="text/css">
      #marginNodeThree {
        padding: 10px;
        margin: 10px;
        border: 1px solid #ccc;
      }
    </style>


Comparison of various DOM node position/size methods
----------------------------------------------------

`Link: Comparison of various DOM node position/size methods. <dojo/position#comparison-of-various-dom-node-position-size-methods>`_

========
See also
========

* `dojo.contentBox <dojo/contentBox>`_
* `dojo.getMarginBox <dojo.getMarginBox>`_
* `dojo.setMarginBox <dojo.setMarginBox>`_ 
