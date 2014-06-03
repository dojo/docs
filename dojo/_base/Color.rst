.. _dojo/_base/Color:

================
dojo/_base/Color
================

:Authors: Marcus Reimann, Bill Keese, JJ Kress
:Developers: Eugene Lazutkin, Adam Peller, Alex Russell

.. contents ::
    :depth: 2


**dojo._base.Color** contains functions for setting Colors.

The Color object provides a unified way to store colors, which holds the color in rgba form. This simplifies dealing 
with the different ways to define colors as everyone can use the format they are most comfortable with. Color objects 
can be used directly as a value to the various color attributes.

Usage
=====

As with the rest of ``dojo/_base`` modules, if you are running the Dojo loader in legacy mode (``async: false``) this 
module is automatically loaded.  Even if it is automatically loaded, you should require it in to have access to its 
features:

.. js ::

  require(["dojo/_base/Color"], function(Color){
    // Color contains functions
  });


Examples
========

Creating with the Constructor
-----------------------------

A new color object is either created by using the constructor or any of the utility functions.  Next are some examples 
of using the constructor with different arguments:

.. js ::

  require(["dojo/_base/Color"], function(Color){ // AMD allows us to use the color functions under the alias name 
  "Color"

    // Creates an empty color object for later use
    var emptyColor = new Color();

    // Constructor accepts named colors
    var namedColor = new Color("purple");
  
    // Hex Strings work also
    var hexColor = new Color("#cdefa0");
  
    // One can also pass arrays containing 3 or 4 values
    var a3Color = new Color([123, 123, 234]);
    var a4Color = new Color([123, 123, 234, 0.6]);
  
    // Finally, objects with r,g,b and a values work as well
    var objColor = new Color({ r:23, g:45, b:67, a:0.7 });
  });

Using the from Utility Functions
--------------------------------

All these expressions result in the same value, a ``dojo/_base/Color`` object representing red with no transparency (
full opacity):

.. js ::

  require(["dojo/_base/Color"],function(Color){
    Color.fromHex("#FF0000");
    Color.fromHex("#F00");
    Color.fromArray([255, 0, 0]);
    Color.fromArray([255, 0, 0, 1]);
    Color.fromRgb("rgb(255, 0, 0)");
    Color.fromRgb("rgba(255, 0, 0, 1)");
    Color.fromString("red");
    // as mentioned above, you could also pass a hex string or an rgb(a) string
  });


Blending Colors
---------------

``dojo/_base/Color`` supports a blend function that can blend two Color instances together with a weighting, to 
produce a new color.

.. js ::

  require(["dojo/_base/Color"], function(Color){
    Color.blendColors(start, end, weight, color);
  });

Return a Specific Format
------------------------

The Color object also provides some methods to return the color in a desired format: ``toRgb()``, ``toRgba()``, 
``toHex()``, ``toCss()`` and ``toString()``.

.. js ::

  require(["dojo/_base/Color"], function(Color){
    // First create a color object, containing red
    var myColor = Color.colorFromString("red");
    
    // Now return the color with the object methods
    myColor.toRgb();  // returns the Array [255,0,0]
    myColor.toRgba(); // returns the Array [255,0,0,1]
    myColor.toHex(); // returns the String "#ff0000"
    myColor.toCss(false); // returns the String "rgb(255,0,0)"
    myColor.toCss(true); // returns the String "rgba(255,0,0,1)"
    myColor.toString(); // returns the String "rgba(255,0,0,1)"
  });
  
Although the last two lines are equivalent, you should use the method that fits to the context to maintain readability.

Using the Color Object as a Value
---------------------------------

The last example shows how one can use the Color object directly to change the properties of an element:

.. js ::

  require(["dojo/_base/Color", "dojo/dom-style"], function(Color, style){
    var myColor = Color.fromString("red");
    style.set("someId", "backgroundColor", myColor);
    // This changes the background-color of the element "someId" to the color specified in myColor
  });

See Also
========

* :ref:`dojo/colors <dojo/colors>` - Additional color features.

* :ref:`dojox/color <dojox/color>` - Even more color features.
