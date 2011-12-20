.. _dojo/coords:

===========
dojo.coords
===========

:since: 1.0
:Deprecated: since 1.4

.. contents ::
   :depth: 2

Getter for the complete coordinates of a dom node.


Introduction
============

The dojo coords function is used to obtain a plethora of coordinate information about a dom node.  The type of information it returns is relative position to its parent in the form of 'left' and 'top' values, the width and height of the dom node, and absolute position in the form of page x and y coordinates.  Effectively, it is a combination of margin box values :ref:`dojo.marginBox <dojo/marginBox>` and :ref:`dojo.position <dojo/position>`.  Because of this redundancy and because the return attributes use differing box-types, this method is being deprecated beginning with Dojo 1.4 but is being kept active for backward compatibility.  The return object looks like:

{ l: 50, t: 200, w: 300: h: 150, x: 700, y: 900, }

for a node offset from its parent 50px to the left, 200px from the top with a margin width of 300px and a margin-height of 150px, with page absolute coordinates (border-box) of 700px on the x axis and 900px on the y axis.

Since dojo 1.7, ``dojo.coords`` is available in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

Dojo 1.7+ (AMD)
---------------

.. js ::
 
  require(["dojo"], function(dojo){
     var coords = dojo.coords(node);
  });

Dojo < 1.7
----------

.. js ::
 
 var coords = dojo.coords(node);

Examples
========

Example 1:  Look up a positioned DOM node and calculate its coordinates
-----------------------------------------------------------------------

.. code-example ::
  
  .. js ::

      function init(){
        var node = dojo.byId("box");
        var coords = dojo.coords(node);
        var info = dojo.byId("info");

        info.appendChild(document.createTextNode("Width: " + coords.w + "px.   Height: " + coords.h + "px.  Relative top: " + coords.t +
        "px Relative left: " + coords.l + "px.  Absolute top: " + coords.y + "px.  Absolute left: " + coords.x + "px."));
      }
      dojo.ready(init);

  .. html ::

    <div id="box" style="width: 100px; height: 100px; background-color: darkgray;"></div>
    <br>
    <span id="info"></span>


--------------------------------------------------------------------
Example 2:  Look up a positioned dijit and calculate its coordinates
--------------------------------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.TextBox");
      function init(){
        var node = dijit.byId("textbox").domNode;
        var coords = dojo.coords(node);
        var info = dojo.byId("infoSpan");

        info.appendChild(document.createTextNode("Width: " + coords.w + "px.   Height: " + coords.h + "px.  Relative top: " + coords.t +
        "px Relative left: " + coords.l + "px.  Absolute top: " + coords.y + "px.  Absolute left: " + coords.x + "px."));
      }
      dojo.ready(init);

  .. html ::

    <div id="textbox" data-dojo-type="dijit.form.TextBox"></div>
    <br>
    <br>
    <span id="infoSpan"></span>


----------------------------------------------------
Comparison of various DOM node position/size methods
----------------------------------------------------

:ref:`Link: Comparison of various DOM node position/size methods. <dojo/position>`

Notes
=====
* For dom nodes with border styles, on Internet Explorer the absolute coordinates (x and y axis), do not include the border position, so you may have to adjust for that depending on what your indented usage of the information is.
* Remember that page coordinates start as the top leftmost of the page is 0px, 0px
