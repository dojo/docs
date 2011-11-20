.. _dojox/mobile/Overlay:

dojox.mobile.Overlay
====================

:Status: Draft
:Version: 1.0
:Authors: Doug Hays
:Developers: Doug Hays
:Available: since V1.7

.. contents::
    :depth: 2

Overlay is a simple widget that slides its content (specified via innerHTML) up from the bottom when shown and slides down out of view when hidden.  It is most often used on small screen devices to allow the user to select values with touch events.

=========
Interface
=========

.show()
-------
Causes the Overlay content to slide up from the bottom.

+--------------+----------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Description                                                                                                |
+--------------+----------+-----------------------------------------------------------------------------------------------------------+
|aroundNode    |DOM node  |Optional parameter associated with the Overlay content.                                                    |
+--------------+----------+-----------------------------------------------------------------------------------------------------------+

.hide()
-------
Hides the Overlay content.


=======
Example
=======

.. code-block :: html

  <button onclick="dijit.registry.byId('customPicker').show()">slide up</button>
  <div id="customPicker" dojoType="dojox.mobile.Overlay">
        <h1 dojoType="dojox.mobile.Heading" label="Custom Picker">
                <div dojoType="dojox.mobile.ToolBarButton" label="Done" class="mblColorBlue" style="width:45px;float:right;" onClick="dijit.registry.byId('customPicker').hide()"></div>
        </h1>
        <div id="spin1" dojoType="dojox.mobile.SpinWheelDatePicker"></div>
  </div>

.. image:: SimpleMobileOverlay.png
