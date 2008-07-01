#format sphinx_rst

dijit.ColorPalette
==================

welcome
-------

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
