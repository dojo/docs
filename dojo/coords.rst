#format dojo_rst

dojo.marginBox
===============

:Status: Draft
:Version: 1.0
:Available: since 1.0

.. contents::
   :depth: 2

Getter for the complete coordinates of a dom node.


============
Introduction
============

The dojo coords function is used to obtain a plethora of coordinate information about a dom node.  The type of information it returns is relative positin to its parent in the form of 'left' and 'top' values, the width and height of the dom node, and absolute position in the form of page x and y coordinates.  Effectively, it is a combination of margin box values <dojo/marginMox>_ and absolute coordinates.  The return object looks like:

{ l: 50, t: 200, w: 300: h: 150, x: 700, y: 900, }

for a node offset from its parent 50px to the left, 200px from the top with a margin width of 300px and a margin-height of 150px, with page absolute coordinates of 700 pixels on the x axis and 900 pixels on the y axis.
