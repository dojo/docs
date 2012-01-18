.. _dijit/ColorPalette:

==================
dijit.ColorPalette
==================

:Authors: Bill Keese, Nikolai Onken, Jared Jurkiewicz
:Developers: Declan Fahey, Bill Keese, Adam Peller, Becky Gibson, Pete Higgins
:since: V1.0

.. contents ::
    :depth: 2

dijit.ColorPalette is a great little tool which provides a color picker for you to use in your application.
The color palette size is definable.
In addition, the color palette is accessible through screen readers as well as keyboard.
The widget also supports the 'standard' dijit function *onChange*, which signals when a new selection was made from the palette.

Widget Construction Parameters
==============================

+--------------------------------------+---------------------------------------------------------------------------------------------+
|**Parameter**                         |**Description**                                                                              |
+--------------------------------------+---------------------------------------------------------------------------------------------+
| palette                              |A string defining the size of the palette.  Can only take one of two values, 7x10 or 3x4.    |
|                                      |The default value is 7x10.                                                                   |
|                                      |                                                                                             |
|                                      |**optional**                                                                                 |
+--------------------------------------+---------------------------------------------------------------------------------------------+

Return Values
=============

As with all dijit widgets, the selected value can be obtained through the widget *get("value")* function.
The return type is an instance of :ref:`dojo.Color <dojo/_base/Color>`.

Examples
========

Default color palette
---------------------

Default color palette, created programmatically:

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dijit/ColorPalette"], function(ColorPalette){
        var myPalette = new ColorPalette({
            palette: "7x10",
            onChange: function(val){ alert(val); }
        }, "placeHolder");
    });

  .. html ::

    <span id="placeHolder">this will be replaced</span>

Small color palette
-------------------

Small color palette, created declaratively:

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/ColorPalette"]);

  .. html ::

     <div data-dojo-type="dijit/ColorPalette" data-dojo-props="onChange:function(){alert(this.value);}, palette:'3x4'"></div>


Accessibility
=============

Keyboard
--------

===============   ===================
Action            Key
===============   ===================
Navigate colors   Arrow keys
Pick a color      Spacebar or enter
===============   ===================

Screen Reader
-------------

Screen readers will read the name of each color as it is highlighted.
For example, "white", "seashell", "cornsilk", and so on.
