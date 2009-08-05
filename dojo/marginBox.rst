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

This method will either return the margin-box size of a node:

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   var marginBox = dojo.marginBox(domNode);
 </script>

... or set the node's width/height such that it's margin-box size becomes as specified:

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
    // 300px x 150px
    dojo.marginBox(domNode, {w: 300, h: 400});
 </script>

In either usage it returns an object in the expected format of box. The object might look like:

{ l: 50, t: 200, w: 300: h: 150 }

for a node offset from its parent 50px to the left, 200px from the top with a margin width of 300px and a margin-height of 150px.


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

    <button dojoType="dijit.form.Button" onClick="getMarginBoxOne()">Get margin box</button>

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

    <button dojoType="dijit.form.Button" onClick="getMarginBoxTwo()">Get margin box</button>

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
