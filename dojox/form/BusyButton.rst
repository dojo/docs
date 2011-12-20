.. _dojox/form/BusyButton:

=====================
dojox.form.BusyButton
=====================

:Project owner: Nikolai Onken
:since: V?

.. contents ::
   :depth: 2

BusyButton is a simple widget which provides implementing more user friendly form submission.

Introduction
============

When a form gets submitted by a user, many time it is recommended to disable the submit buttons to prevent double submission.
BusyButton provides a simple set of features for this purpose

Examples
========

Programmatic example
--------------------

The first example shows you how to create a nifty button programmatically

.. code-example ::

  .. js ::

    dojo.require("dojox.form.BusyButton");

    dojo.ready(function(){
      var button = new dojox.form.BusyButton({
                 id: "submit",
                 busyLabel: "Sending mail...",
                 label: "Send mail",
                 timeout: 5000
      }, "placeHolder");
    });

  .. html ::

    <div id="placeHolder"></div>

  .. css ::

      @import url({{baseUrl}}dojox/form/resources/BusyButton.css);

Declarative example
-------------------

This example show how to use the busy button without internal timeout. Once you receive a server response from the server (than can include a timeout from the server) you can and should change the status of the button.

.. code-example ::

  .. js ::

    dojo.require("dojox.form.BusyButton");

  .. html ::

    <button data-dojo-type="dojox.form.BusyButton" data-dojo-props="busyLabel:'Sending data...'">Send data</button>

  .. css ::

      @import url({{baseUrl}}dojox/form/resources/BusyButton.css);

Using the built-in timeout
--------------------------

The following example has a built-in timeout.

.. code-example ::

  .. js ::

    dojo.require("dojox.form.BusyButton");

  .. html ::

   <button data-dojo-type="dojox.form.BusyButton" data-dojo-props="busyLabel:'For 10 seconds', timeout:10000">Hold your breath</button>

  .. css ::

      @import url({{baseUrl}}dojox/form/resources/BusyButton.css);

Set a new label
---------------

In this example we will set a new label by clicking on a button (this can be a server response as well). The first state will not have a timeout, the second state will have a timeout of 2 seconds

.. code-example ::

  .. js ::

    dojo.require("dojox.form.BusyButton");
    dojo.ready(function(){
      dojo.connect(dijit.byId("buttonChangeState"), "onClick", function(){
        dijit.byId("buttonChargeback").setLabel("Chargeback failed...", 2000);
      });
    });

  .. html ::

    <button data-dojo-type="dojox.form.BusyButton" id="buttonChargeback" data-dojo-props="busyLabel:'Canceling payment...'">Cancel payment</button>
    <button data-dojo-type="dijit.form.Button" id="buttonChangeState">Change state</button>

  .. css ::

      @import url({{baseUrl}}dojox/form/resources/BusyButton.css);

Disabled BusyButton
-------------------

The last example uses a little bit of trickery to create a button which is disabled initially and enabled after the timeout. This sort of button is very hand for license agreements or times when you want to be sure the user can't submit a form (usually forcing a user to read the license agreement doesn't work, but its worth a try). The chance is high that the button already is not disabled anymore - just reload the page and scroll to this example real quick.

.. code-example ::

  .. js ::

    dojo.require("dojox.form.BusyButton");
    dojo.ready(function(){
      dojo.connect(dijit.byId("buttonLicense"), "_onClick", function(){
        dijit.byId("buttonLicense").setLabel("Creating account...");
        dijit.byId("buttonLicense").resetTimeout();
      });
    });

  .. html ::

   <button data-dojo-type="dojox.form.BusyButton" id="buttonLicense" data-dojo-props="isBusy:true, busyLabel:'Please read the agreement...', timeout:10000">I Agree</button>

  .. css ::

      @import url({{baseUrl}}dojox/form/resources/BusyButton.css);


Known Problems
==============

* This Widget doesn't work using Internet Explorer 8. The error is well known and reported as bug `#9075 <http://bugs.dojotoolkit.org/ticket/9075>`_
