#format dojo_rst

dijit.form.NumberSpinner
=============================

:Status: Contributed, Draft
:Version: 1.0

The Number Spinner, a familiar widget in GUI interfaces, makes integer entry easier when small adjustments are required. The down and up arrow buttons "spin" the number up and down.  Furthermore, when you hold down the buttons, the spinning accelerates to make coarser adjustments easier.

Examples
--------

This number spinner starts at 1000, and holds a number from 9 to 1550.  Each up or down button click adjusts the number by 10. 


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
        maxlength="4"
        id="integerspinner2"/>
