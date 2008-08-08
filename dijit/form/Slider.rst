#format dojo_rst

dijit.form.Slider
=================

:Status: Draft
:Version: 1.2

A slider is a scale with a handle you can drag up/down or left/right to select a value. Calling dojo.require("dijit.form.Slider") provides dijit.form.HorizontalSlider, dijit.form.VerticalSlider and all the rule and label classes.

Examples
--------

One way you could show the user the value of your Slider is to create a textbox that the Slider fills when the user moves the Slider. The following code fills in a simple textbox called horizontalSliderValue.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.Slider");
      dojo.addOnLoad(function(){
        var slider = new dijit.form.HorizontalSlider({
          id: "slider",
          value: 5,
          minimum: -10,
          maximum: 10,
          intermediateChanges: true,
          onChange: function(value){
            dojo.byId("sliderValue").value = value;
          }
        }, "slider");
      });
    </script>

  .. cv:: html

    <div id="slider"></div>
    <p><input type="text" id="sliderValue" /></p>
