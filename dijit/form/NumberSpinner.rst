#format dojo_rst

dijit.form.NumberSpinner
=============================

:Status: Draft
:Version: 1.0
:Author: CraigRiecke

The Number Spinner, a familiar widget in GUI interfaces, makes integer entry easier when small adjustments are required. The down and up arrow buttons "spin" the number up and down.  Furthermore, when you hold down the buttons, the spinning accelerates to make coarser adjustments easier.

The Basic Version
-----------------

This number spinner starts at 1000, and holds a number from 9 to 1550.  Each up or down button click adjusts the number by 10.  Note here the constraints attribute.  The options available in `dojo.number <dojo/number>`_ are available here as well.


.. cv-compound::

  .. cv:: javascript

      <script type="text/javascript">
        dojo.require("dijit.form.NumberSpinner");
      </script>

  .. cv:: html

   <input dojoType="dijit.form.NumberSpinner"
        value="1000"
        smallDelta="10"
        constraints="{min:9,max:1550,places:0}"
        id="integerspinner2"/>


Sizing the Box
--------------

The default NumberSpinner looks a bit large for numbers 9-1550.  You can set the size of the enclosing box by setting the style attribute, like most Dijit form controls can.  Here, we'll use a programatically-created NumberSpinner:

.. cv-compound::

  .. cv:: javascript

      <script type="text/javascript">
        dojo.require("dijit.form.NumberSpinner");
        dojo.addOnLoad(function() {
           var mySpinner = new dijit.form.NumberSpinner({
              value: 1000,
              smallDelta: 10,
              constraints: { min:9, max:1550, places:0 }
              id: "integerspinner2",
              style: "width:100px"
           }, "spinnerId" );
        });
      </script>

  .. cv:: html

      <div id="spinnerId"></div>

**Note:** Safari 3 appears to render the NumberSpinner as 177px, no matter what.  You can workaround this by surrounding the NumberSpinner with a <div> of size 100px.  

Change Events
-------------

Like regular <input> boxes, the onChange event fires only when the box loses focus.  Just clicking on an up or down button changes the value, but the changes doesn't "stick" until you leave the box.  

If you'd like to hook into TODO
