.. _dijit/_base/place:

=================
dijit/_base/place
=================

:Project owner: Bill Keese
:since: V1.7

.. contents ::
   :depth: 2

Introduction
============

dijit/place is used to place one DOMNode relative to another DOMNode, or specified rectangle.
It is mainly used internally by dijit,
by the :ref:`dijit.popup <dijit/popup>` code and by :ref:`dijit.Menu <dijit/Menu>` for displaying context menus.

Around
======

Place.around() positions one node relative to another.

Here’s an example that tries to put a popup tooltip either to the right, or as a fallback (if there is no room on the right), then on the left, of a textbox:

.. js ::
 
     require(["dijit/place"], function(place){
         place.around(tooltip, textbox, ["after", "before"], true);
     });


Note that the third argument should normally be true, unless the page is in RTL (Arabic or Hebrew), in which case it should be false.

The possible values for the position parameters (inside the array of the second argument) are:

* before: places drop down to the left of the anchor node/widget, or to the right in the case of RTL scripts like Hebrew and Arabic
* after: places drop down to the right of the anchor node/widget, or to the left in the case of RTL scripts like Hebrew and Arabic
* above-centered: drop down is centered above anchor node
* above: drop down goes above anchor node, left sides aligned
* above-alt: drop down goes above anchor node, right sides aligned
* below-centered: drop down is centered above anchor node
* below: drop down goes below anchor node
* below-alt: drop down goes below anchor node, right sides aligned

At
==

Place.at() positions a node with one corner at a specified position.

Here's an example of showing a context menu aligning one of the corners with the mouse position.
It picks a corner such that the menu can be displayed fully within the viewport:

.. js ::
 
     require(["dijit/place"], function(place){
         place.at(menu, {x: mouse.x, y: mouse.y}, ["TL", "BL", "TR", "BR"]);
     });

The possible values for the position parameter, which specifies the corner of the popup node, are:

* "BL" - bottom left
* "BR" - bottom right
* "TL" - top left
* "TR" - top right
