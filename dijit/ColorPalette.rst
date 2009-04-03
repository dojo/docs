## page was renamed from 1.2/dijit/ColorPalette
## page was renamed from dijit/ColorPalette
#format dojo_rst

dijit.ColorPalette
==================

:Status: Draft
:Version: 1.0
:Authors: Bill Keese, Nikolai Onken
:Developers: Declan Fahey, Bill Keese, Adam Peller, Becky Gibson, Pete Higgins
:Available: since V?

.. contents::
    :depth: 2

dijit.ColorPalette is a great little tool which provides a color picker for you to use in your application.  The color palette size is definable.  In addition, the color palette is accessible through screen readers as well as keyboard.

==============================
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


========
Examples
========

Default color palette
---------------------

Default color palette, created programatically:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
       dojo.require("dijit.ColorPalette");
       dojo.addOnLoad(function(){
         var myPalette = new dijit.ColorPalette({
           palette: "7x10",
           onChange: function(val){ alert(val); }
         }, "placeHolder" );
       });
    </script>

  .. cv:: html

    <span id="placeHolder">this will be replaced</span>

Small color palette
-------------------

Small color palette, created declaratively:

.. cv-compound::

  .. cv:: javascript

      <script type="text/javascript">
        dojo.require("dijit.ColorPalette");
      </script>

  .. cv:: html

     <div dojoType="dijit.ColorPalette" onChange="alert(this.value);" palette="3x4"></div>


=============
Accessibility
=============

Keyboard
--------

===============   ===================
Action            Key
===============   ===================
Navigate colors	  Arrow keys
Pick a color      Spacebar or enter
===============   ===================

Screen Reader
-------------

Screen readers will read the name of each color as it is highlighted. For example, "white", "seashell", "cornsilk", and so on.
