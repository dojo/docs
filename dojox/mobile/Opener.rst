.. _dojox/mobile/Opener:

===================
dojox/mobile/Opener
===================

:Authors: Doug Hays
:Developers: Doug Hays
:since: V1.7

.. contents ::
    :depth: 2

Opener is a utility widget that behaves either as a Overlay on small screen devices or as a Tooltip otherwise.

Interface
=========

.show()
-------
Causes the content to shown (popup Tooltip or sliding Overlay).

+--------------+----------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Description                                                                                                |
+--------------+----------+-----------------------------------------------------------------------------------------------------------+
|aroundNode    |DOM node  |The DOM node that should be pointed to by the small arrow.                                                 |
+--------------+----------+-----------------------------------------------------------------------------------------------------------+
|positions     |Array     |The relative positions to the aroundNode in which to try and place the Tooltip content for best fit.       |
|              |          |before: places drop down before the aroundNode                                                             |
|              |          |after: places drop down after the aroundNode                                                               |
|              |          |above-centered: drop down goes above aroundNode                                                            |
|              |          |below-centered: drop down goes below aroundNode                                                            |
+--------------+----------+-----------------------------------------------------------------------------------------------------------+

.hide()
-------
Hides the Opener content.


Example
=======

.. html ::

  <button onclick="dijit.registry.byId('customPicker').show()">slide up</button>
  <div id="customPicker" data-dojo-type="dojox/mobile/Opener">
        <h1 data-dojo-type="dojox/mobile/Heading" label="Custom Picker">
                <div data-dojo-type="dojox/mobile/ToolBarButton" label="Done" class="mblColorBlue" style="width:45px;float:right;" onClick="dijit.registry.byId('customPicker').hide()"></div>
        </h1>
        <div id="spin1" data-dojo-type="dojox/mobile/SpinWheelDatePicker"></div>
  </div>

Small screen Overlay
--------------------

.. image :: MobileOpenerOverlay.png

Large screen Tooltip
--------------------

.. image :: MobileOpenerTooltip.png
