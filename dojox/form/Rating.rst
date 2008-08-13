#format dojo_rst

dojox.widget.Rating
===================

:Status: Contributed, Draft
:Version: 1.2

This widget allows users to rate items. By default it shows five stars, that are provided by dojox. 
This is a form widget, which means that you can simply embed it inside a dojo form, which submits the value automatically too.

Basics
-------

.. codeviewer::
  
  <style type="text/css">
    @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/form/resources/Rating.css"; 
  </style>
  <script type="text/javascript">
    dojo.require("dojox.form.Rating");
  </script>

  <div dojoType="dojox.form.Rating"></div>
