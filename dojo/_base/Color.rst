#format dojo_rst

dojo._base.Color
================

:Status: Draft
:Version: 1.0
:Authors: Marcus Reimann, Bill Keese, JJ Kress
:Developers: Eugene Lazutkin, Adam Peller, Alex Russell
:Available: since V?

.. contents::
    :depth: 2


**dojo._base.Color** contains functions for setting Colors.

As with all dojo._base components, these functions are included within Dojo Base. You get this functionality by just including dojo.js or dojo.xd.js in your page.

The Color object provides a unified way to store colors, which holds the color in rgba form. This simplifies dealing with the different ways to define colors as everyone can use the format they are most comfortable with. Color objects can be used directly as a value to the various color attributes.


========
Features
========

* **dojo.Color.named**

  An array of named Colors. Those are only the 16 named colors defined by the HTML 4 standard. If you need all named colors from the CSS3 standard you have to require `dojo.colors <dojo/colors>`_

* **dojo.blendColors**

  Blend two colors in a given ration to create a new one. It takes two dojo.Color objects and a ration between 0 and 1, which is interpreted as a weight: if you provide a ration of 0.25, blendColors will take 25% of the first color and 75% of the second color. The calculation is straight forward: each of the rgba values of the first color are multiplied by 0.25, the values of the second color are multiplied by 0.75 and added to the results

* **dojo.colorFromRgb**

  This will create or modify a color object from a string resembling a CSS color definition in the form of rgb() or rgba()

* **dojo.colorFromHex**

  Converts a hex string with a '#' prefix to a color object. Supports 12-bit #rgb shorthand.

* **dojo.colorFromArray**

  Builds a color from 3 or 4 element array. Note that fewer elements in the array will result in broken color objects.

* **dojo.colorFromString**

  Parses a string for a color value. You can pass either one of the 16 named colors, hex strings such as "#23ab45" and "#28a", or rgb(a) strings such as "rgb(200,100,50)" and "rgba(200,100,50,0.5)"

========
Examples
========

Creating color objects with the constructor
-------------------------------------------

A new color object is either created by using the constructor or any of the utility functions. Next are some examples of using the constructor with different arguments:

.. code-block:: javascript

  // Creates an empty color object for later use
  var emptyColor = new dojo.Color();
  
  // Constructor accepts named colors
  var namedColor = new dojo.Color("purple");
  
  // Hex Strings work also
  var hexColor = new dojo.Color("#cdefa0");
  
  // One can also pass arrays containing 3 or 4 values
  var a3Color = new dojo.Color([123,123,234]);
  var a4Color = new dojo.Color([123,123,234,0.6]);
  
  // Finally, objects with r,g,b and a values work as well
  var objColor = new dojo.Color({r:23,g:45,b:67,a:0.7});

Using the colorFrom* utility functions
--------------------------------------

All these expressions result in the same value, a dojo.Color object representing red with no transparency (full opacity):

.. code-block:: javascript

  dojo.colorFromHex("#FF0000")

.. code-block:: javascript

  dojo.colorFromHex("#F00")

.. code-block:: javascript

  dojo.colorFromArray([255, 0, 0])

.. code-block:: javascript

  dojo.colorFromArray([255, 0, 0, 1])

.. code-block:: javascript

  dojo.colorFromRgb("rgb(255, 0, 0)")

.. code-block:: javascript

  dojo.colorFromRgb("rgba(255, 0, 0, 1)")

.. code-block:: javascript

  dojo.colorFromString("red")
  // as mentioned above, you could also pass a hex string or an rgb(a) string

Using the blendColors function
------------------------------

TODO

Returning specific formats with the object methods
--------------------------------------------------

The color object also provides some methods to return the color in a desired format, toRgb(), toRgba(), toHex(), toCss() and toString().

.. code-block:: javascript

  // First create a color object, containing red
  var myColor = dojo.colorFromString("red");
  
  // Now return the color with the object methods
  myColor.toRgb();  // returns the Array [255,0,0]
  myColor.toRgba(); // returns the Array [255,0,0,1]
  myColor.toHex(); // returns the String "#ff0000"
  myColor.toCss(false); // returns the String "rgb(255,0,0)"
  myColor.toCss(true); // returns the String "rgba(255,0,0,1)"
  myColor.toString(); // returns the String "rgba(255,0,0,1)"
  
Although the last two lines are equivalent, you should use the method that fits to the context to maintain readability.

Using the color object as a value
---------------------------------

The last example shows how one can use the color object directly to change the properties of an element:

.. code-block:: javascript

  var myColor = dojo.colorFromString("red");
  dojo.style("someId", "backgroundColor", myColor);
  // This changes the background-color of the element "someId" to the color specified in myColor
