.. _dojo/coords:

===========
dojo.coords
===========

:since: 1.0
:Deprecated: since 1.4

.. contents ::
   :depth: 2

Getter for the complete coordinates of a DOM node.

*Deprecated* use :ref:`dojo/dom-geometry::position() <dojo/dom-geometry/position>` and :ref:`dojo/dom-geometry::getMarginBox() <dojo/dom-geometry/getMarginBox>` instead.

Introduction
============

The dojo coords function is used to obtain a plethora of coordinate information about a dom node.  The type of information it returns is relative position to its parent in the form of 'left' and 'top' values, the width and height of the dom node, and absolute position in the form of page x and y coordinates.  Effectively, it is a combination of margin box values :ref:`dojo/dom-geometry::getMarginBox() <dojo/dom-geometry/getMarginBox>` and :ref:`dojo/dom-geometry::position() <dojo/dom-geometry/position>`.  Because of this redundancy and because the return attributes use differing box-types, this method is *deprecated* but is being kept available for backward compatibility.  The return object looks like:

{ l: 50, t: 200, w: 300: h: 150, x: 700, y: 900, }

for a node offset from its parent 50px to the left, 200px from the top with a margin width of 300px and a margin-height of 150px, with page absolute coordinates (border-box) of 700px on the x axis and 900px on the y axis.

Since dojo 1.7, ``dojo.coords`` is available in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

.. js ::
 
  require(["dojo/_base/html"], function(html){
     var coords = html.coords(node);
  });

Notes
=====
* For DOM nodes with border styles, on Internet Explorer the absolute coordinates (x and y axis), do not include the border position, so you may have to adjust for that depending on what your indented usage of the information is.
* Remember that page coordinates start as the top leftmost of the page is 0px, 0px
