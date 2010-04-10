#format dojo_rst

dojox.form.BusyButton
=====================

:Status: Draft
:Version: Beta
:Project owner: Nikolai Onken
:Available: since V?

.. contents::
   :depth: 2

BusyButton is a simple widget which provides implementing more user friendly form submission.

============
Introduction
============

When a form gets submitted by a user, many time it is recommended to disable the submit buttons to prevent double submittion.
BusyButton provides a simple set of features for this purpose

========
Examples
========

Programmatic example
--------------------

The first example shows you how to create a nifty button programatically

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dojox.form.BusyButton");

    dojo.addOnLoad(function(){
      var button = new dojox.form.BusyButton({
                 id: "submit",
                 busyLabel: "Sending mail...",
                 label: "Send mail",
                 timeout: 5000
      }, "placeHolder");
    });
    </script>

  .. cv:: html

    <div id="placeHolder"></div>

  .. cv:: css

    <style type="text/css">
      @import url(/moin_static163/js/dojo/trunk/dojox/form/resources/BusyButton.css);
    </style>

Declarative example
-------------------

This example show how to use the busy button without internal timeout. Once you receive a server response from the server (than can include a timeout from the server) you can and should change the status of the button.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dojox.form.BusyButton");
    </script>

  .. cv:: html

    <button dojoType="dojox.form.BusyButton" busyLabel="Sending data...">Send data</button>

  .. cv:: css

    <style type="text/css">
      @import url(/moin_static163/js/dojo/trunk/dojox/form/resources/BusyButton.css);
    </style>

Using the built-in timeout
--------------------------

The following example has a built-in timeout.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dojox.form.BusyButton");
    </script>

  .. cv:: html

   <button dojoType="dojox.form.BusyButton" busyLabel="For 10 seconds" timeout="10000">Hold your breath</button>

  .. cv:: css

    <style type="text/css">
      @import url(/moin_static163/js/dojo/trunk/dojox/form/resources/BusyButton.css);
    </style>

Set a new label
---------------

In this example we will set a new label by clicking on a button (this can be a server response as well). The first state will not have a timeout, the second state will have a timeout of 2 seconds

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dojox.form.BusyButton");
    dojo.addOnLoad(function(){
      dojo.connect(dijit.byId("buttonChangeState"), "onClick", function(){
        dijit.byId("buttonChargeback").setLabel("Chargeback failed...", 2000);
      });
    });
    </script>

  .. cv:: html

   <button dojoType="dojox.form.BusyButton" id="buttonChargeback" busyLabel="Canceling payment...">Cancel payment</button> <button dojoType="dijit.form.Button" id="buttonChangeState">Change state</button>

  .. cv:: css

    <style type="text/css">
      @import url(/moin_static163/js/dojo/trunk/dojox/form/resources/BusyButton.css);
    </style>

Disabled BusyButton
-------------------

The last example uses a little bit of trickery to create a button which is disabled initially and enabled after the timeout. This sort of button is very hand for license agreements or times when you want to be sure the user can't submit a form (usually forcing a user to read the license agreement doesn't work, but its worth a try). The chance is high that the button already is not disabled anymore - just reload the page and scroll to this example real quick.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dojox.form.BusyButton");
    dojo.addOnLoad(function(){
      dojo.connect(dijit.byId("buttonLicense"), "_onClick", function(){
        dijit.byId("buttonLicense").setLabel("Creating account...");
        dijit.byId("buttonLicense").resetTimeout();
      });
    });
    </script>

  .. cv:: html

   <button dojoType="dojox.form.BusyButton" id="buttonLicense" isBusy="true" busyLabel="Please read the agreement..." timeout="10000">I Agree</button>

  .. cv:: css

    <style type="text/css">
      @import url(/moin_static163/js/dojo/trunk/dojox/form/resources/BusyButton.css);
    </style>


==============
Known Problems
==============

* This Widget doesn't work using Internet Explorer 8. The error is well known and reported as bug `#9075 <http://bugs.dojotoolkit.org/ticket/9075>`_
