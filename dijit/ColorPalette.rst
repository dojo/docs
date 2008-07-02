#format dojo_rst

dijit.ColorPalette
==================

dijit.ColorPalette is a great little tool which provides a color picker for you to use in your application.

Attributes
----------

========= ==========
Parameter Value
========= ==========
palette   7x10 | 3x4
value     value of selected color
========= ==========

Examples
--------

Default color palette

.. codeviewer::

   <script type="text/javascript">
      dojo.require("dijit.ColorPalette");
   </script>

   <div dojoType="dijit.ColorPalette" onChange="alert(this.value);"></div>

Small color palette

.. codeviewer::

   <script type="text/javascript">
      dojo.require("dijit.ColorPalette");
   </script>

   <div dojoType="dijit.ColorPalette" onChange="alert(this.value);" palette="3x4"></div>
