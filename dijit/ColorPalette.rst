## page was renamed from 1.2/dijit/ColorPalette
## page was renamed from dijit/ColorPalette
#format dojo_rst

dijit.ColorPalette
==================

:Status: Contributed, Draft
:Version: beta
:Authors: ?--

.. contents::
    :depth: 2

dijit.ColorPalette is a great little tool which provides a color picker for you to use in your application.


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
