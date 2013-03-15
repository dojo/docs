.. _dojox/mobile/Tooltip:

====================
dojox/mobile/Tooltip
====================

:Authors: Doug Hays
:Developers: Doug Hays
:since: V1.7

.. contents ::
    :depth: 2

Tooltip is a simple popup widget that encloses its content and displays a small arrow associating the content (specified as innerHTML) with an arbitrary DOM node.  While the widget does not impose any size restrictions on the content, small screen mobile devices may only be able to display short text messages.


Interface
=========

.show()
-------
Displays the Tooltip content (hiding if already displayed somewhere else).

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
Hides the Tooltip content.


Examples
========

Text Only
---------

.. html ::

  <div id="textTooltip" data-dojo-type="dojox/mobile/Tooltip" class="mblTooltipBubble">Enter a value.<br><center>Please!</center></div>
  <button type="button" onclick="dijit.registry.byId('textTooltip').show(this, ['after','below-centered','above-centered'])">right</button>

.. image :: SimpleMobileTooltip.png


Widget content
--------------

.. html ::

  <div id="customPicker" data-dojo-type="dojox/mobile/Tooltip">
        <div id="spin1" data-dojo-type="dojox/mobile/SpinWheelDatePicker"></div>
  </div>
  <button type="button" onclick="dijit.registry.byId('customPicker').show(this, ['above-centered','after','before'])">above</button>

.. image :: ComplexMobileTooltip.png
