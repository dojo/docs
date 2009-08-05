#format dojo_rst

dojo.contentBox
===============

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since 1.0

.. contents::
   :depth: 2

Getter/setter for the content-box of node.


======================
Introduction and Usage
======================

See the `CSS spec <http://www.w3.org/TR/CSS2/box.html>`_ for details on box model and what margin-box means.

This method will either return the content-box size of a node:

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   var contentBox = dojo.contentBox(domNode);
 </script>

... or set the node's width/height such that it's content-box size becomes as specified:

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
    // 300px x 150px
    dojo.contentBox(domNode, {w: 300, h: 400});
 </script>

In either usage it returns an object in the expected format of box. The object might look like:

{ l: 50, t: 200, w: 300: h: 150 }

for a node offset from its parent 50px to the left, 200px from the top with a content-width of 300px and a content-height of 150px.


========
Examples
========

Example 1: Getting the content box
----------------------------------

This example displays the return values of dojo.contentBox on a node. 

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.Button"); // only for the beauty :)

      function getContentBox(){
        var contentBox = dojo.contentBox("nodeOne");

        var info = dojo.byId("boxInfo");
        while(info.firstChild){
          info.removeChild(info.firstChild);  
        }
        info.appendChild(document.createTextNode("Top: "+contentBox.t));
        info.appendChild(document.createElement("br"));
        info.appendChild(document.createTextNode("Left: "+contentBox.l));
        info.appendChild(document.createElement("br"));
        info.appendChild(document.createTextNode("Width: "+contentBox.w));
        info.appendChild(document.createElement("br"));
        info.appendChild(document.createTextNode("Height: "+contentBox.h));
        info.appendChild(document.createElement("br"));
      };
    </script>

  .. cv:: html

    <button dojoType="dijit.form.Button" onClick="getContentBox()">Get content box</button>
    <div id="nodeOne" style="margin: 10px; border: 10px solid black; padding: 10px; width: 100px; height: 30px;">Hi!</div>

    <div id="boxInfo">
    </div>

Example 2: Setting content box
------------------------------

This example is showcasing the usage of dojo.contentBox as a setter, take a look at the JavaScript code to see what the code does.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.Button"); // only for the beauty :)
      dojo.addOnLoad(function(){
        dojo.connect(dijit.byId("cButton"), "onClick", function(){
          var contentBox = dojo.marginBox(dojo.byId("node2"), {t: 20, l: 30, h: 300, w: 300});
        });
      });
    </script>

  .. cv:: html

    <button id="cButton" dojoType="dijit.form.Button">Click to alter the content box of 'node 2'</button>
    <br>
    <div>
      Hi I am nested
      <div id="node2">Hi!</div>
    </div>

  .. cv:: css

    <style type="text/css">
      #node2 {
        padding: 10px;
        margin: 10px;
        border: 1px solid #ccc;
      }
    </style>

Comparison of various DOM node position/size methods
----------------------------------------------------

`Link: Comparison of various DOM node position/size methods. <dojo/position#example-2-comparison-of-various-dom-node-position-size-methods>`_


========
See also
========

* `dojo.marginBox <dojo/marginBox>`_
