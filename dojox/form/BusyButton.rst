#format dojo_rst

dojox.form.BusyButton
=====================

Status: Draft
Version: Beta
Author: Nikolai Onken

BusyButton is a simple widget which provides implementing more user friendly form submission.
When a form gets submitted bu a user, many time it is recommended to disable the submit buttons to prevent double submittion.
BusyButton provides a simple set of features for this purpose

Examples
--------

This example show how to use the busy button without internal timeout. Once you receive a server response from the server (than can include a timeout from the server) you can and should change the status of the button.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dojox.form.BusyButton")
    </script>

  .. cv:: html

    <button dojoType="dojox.form.BusyButton" busyLabel="Sending data...">Send data</button>

  .. cv:: css

    <style type="text/css">
    @import: url(/moin_static163/js/dojo/trunk/dojox/form/resources/BusyButton.css);
    </style>

The following example has a build-in timeout.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dojox.form.BusyButton")
    </script>

  .. cv:: html

   <button dojoType="dojox.form.BusyButton" busyLabel="For 10 seconds" timeout="10000">Hold your breath</button>

  .. cv:: css

    <style type="text/css">
    @import: url(/moin_static163/js/dojo/trunk/dojox/form/resources/BusyButton.css);
    </style>
