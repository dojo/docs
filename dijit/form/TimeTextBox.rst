#format dojo_rst

dijit.form.TimeTextBox
======================

:Status: Draft
:Version: 1.2

Examples
--------

The following example demonstrates how to create a date textbox programatically:

.. cv-compound::

  .. cv:: javascript

     <script type="text/javascript">
     dojo.require("dijit.form.DateTextBox");

     dojo.addOnLoad(function(){
       var dateBox = new dijit.form.DateTextBox({}, "date");
     });
     </script>

  .. cv:: html

     <input type="text" id="date" />

Lets create a date textbox declaratively

.. cv-compound::

  .. cv:: javascript

     <script type="text/javascript">
     dojo.require("dijit.form.DateTextBox");
     </script>

  .. cv:: html

     <input type="text" dojoType="dijit.form.DateTextBox" />
