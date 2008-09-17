## page was renamed from 1.2/dijit/ColorPalette
## page was renamed from dijit/ColorPalette
#format dojo_rst

dijit.ColorPalette
==================

dijit.ColorPalette is a great little tool which provides a color picker for you to use in your application.

Examples
--------

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

Small color palette, created declaratively:

.. cv-compound::

  .. cv:: javascript

      <script type="text/javascript">
        dojo.require("dijit.ColorPalette");
      </script>

  .. cv:: html

     <div dojoType="dijit.ColorPalette" onChange="alert(this.value);" palette="3x4"></div>
