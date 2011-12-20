.. _dojo/contentBox:

===============
dojo.contentBox
===============

:Project owner: ?--
:since: 1.0

.. contents ::
   :depth: 2

Getter/setter for the content-box of node.


Introduction and Usage
======================

See the `CSS spec <http://www.w3.org/TR/CSS2/box.html>`_ for details on box model and what margin-box means.

This method will either return the content-box size of a node or set the node's width/height such that it's content-box size becomes as specified.

In either usage it returns an object in the expected format of box. The object might look like:

{ l: 50, t: 200, w: 300: h: 150 }

for a node offset from its parent 50px to the left, 200px from the top with a content-width of 300px and a content-height of 150px.

Since Dojo 1.7, ``dojo.contentBox`` is exposed via the ``getContentBox`` and ``setContentSize`` methods of the ``dojo/dom-geometry`` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.


Usage
=====

Dojo 1.7+ (AMD)
---------------

When using AMD format in a fully baseless application, ``getContentBox`` and ``setContentSize`` are accessed from the ``dojo/dom-geometry`` module.

.. js ::
 
  require(["dojo/dom-geometry"], function(domGeom){
     // Get the content-box size of a node
     var contentBox = domGeom.getContentBox(domNode);

     // Set domNode content-box to 300px x 150px
     domGeom.setContentSize(domNode, {w: 300, h: 150});
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.contentBox`` in the ``define`` or ``require`` callback:

.. js ::
 
  require(["dojo"], function(dojo){
    // Get the content-box size of a node
    var contentBox = dojo.contentBox(domNode);

    // Set domNode content-box to 300px x 150px
    dojo.contentBox(domNode, {w: 300, h: 150});

    // You can also use dojo.getMarginBox and dojo.setMarginBox individually:
    var contentBox = dojo.getContentBox(domNode);
    dojo.setContentSize(domNode, {w: 300, h: 150});
  });

Dojo < 1.7
----------

.. js ::
 
   // Get the content-box size of a node
   var contentBox = dojo.contentBox(domNode);

   // Set domNode content-box to 300px x 150px
   dojo.contentBox(domNode, {w: 300, h: 150});
   
   // You can also use dojo.getMarginBox and dojo.setMarginBox individually:
   var contentBox = dojo.getContentBox(domNode);
   dojo.setContentSize(domNode, {w: 300, h: 150});


Examples
========

Example 1: Getting the content box
----------------------------------

This example displays the return values of dojo.contentBox on a node.

.. code-example ::

  .. js ::

      dojo.require("dijit.form.Button"); // only for the beauty :)

      getContentBox = function(){
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

  .. html ::

    <button data-dojo-type="dijit.form.Button" data-dojo-props="onClick:getContentBox">Get content box</button>
    <div id="nodeOne" style="margin: 10px; border: 10px solid black; padding: 10px; width: 100px; height: 30px;">Hi!</div>

    <div id="boxInfo">
    </div>

Example 2: Setting content box
------------------------------

This example is showcasing the usage of dojo.contentBox as a setter, take a look at the JavaScript code to see what the code does.

.. code-example ::

  .. js ::

      dojo.require("dijit.form.Button"); // only for the beauty :)
      dojo.ready(function(){
        dojo.connect(dijit.byId("cButton"), "onClick", function(){
          var contentBox = dojo.marginBox(dojo.byId("node2"), {t: 20, l: 30, h: 300, w: 300});
        });
      });

  .. html ::

    <button id="cButton" data-dojo-type="dijit.form.Button">Click to alter the content box of 'node 2'</button>
    <br>
    <div>
      Hi I am nested
      <div id="node2">Hi!</div>
    </div>

  .. css ::

      #node2 {
        padding: 10px;
        margin: 10px;
        border: 1px solid #ccc;
      }

Comparison of various DOM node position/size methods
----------------------------------------------------

:ref:`Link: Comparison of various DOM node position/size methods. <dojo/position>`


See also
========

* :ref:`dojo.marginBox <dojo/marginBox>`
* :ref:`dojo.getContentBox <dojo/getContentBox>`
* :ref:`dojo.setContentSize <dojo/setContentSize>`
