.. _dojox/mobile/Switch:

===================
dojox.mobile.Switch
===================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.5

.. contents ::
    :depth: 2

Switch is a toggle switch with a sliding knob. You can either tap or slide the knob to toggle the switch. The onStateChanged handler is called when the switch is manipulated.

.. image :: Switch.png

Constructor Parameters
======================

+--------------+----------+-------------------+-------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default            |Description                                                                                      |
+--------------+----------+-------------------+-------------------------------------------------------------------------------------------------+
|value         |String    |"on"               |The initial state of the switch. "on" or "off". The default value is "on".                       |
+--------------+----------+-------------------+-------------------------------------------------------------------------------------------------+
|name          |String    |""                 |A name for a hidden input field, which holds the current value.                                  |
+--------------+----------+-------------------+-------------------------------------------------------------------------------------------------+
|leftLabel     |String    |"ON"               |The left-side label of the switch.                                                               |
+--------------+----------+-------------------+-------------------------------------------------------------------------------------------------+
|rightLabel    |String    |"OFF"              |The right-side label of the switch.                                                              |
+--------------+----------+-------------------+-------------------------------------------------------------------------------------------------+
|shape         |String    |"mblSwDefaultShape"|The shape of the switch. "mblSwDefaultShape", "mblSwSquareShape", "mblSwRoundShape1",            |
|              |          |                   |"mblSwRoundShape2", "mblSwArcShape1" or "mblSwArcShape2".                                        |
+--------------+----------+-------------------+-------------------------------------------------------------------------------------------------+

Examples
========

Declarative example 1
---------------------

.. html ::

  <div id="sw" data-dojo-type="dojox.mobile.Switch" value="off"></div>

.. image :: Switch-example1.png

Declarative example 2
---------------------

.. html ::

  <div data-dojo-type="dojox.mobile.Switch" value="on" leftLabel="Start" rightLabel="Stop"></div>

.. image :: Switch-example2.png

Square Shape
------------

.. html ::

  <div class="mblSwSquareShape" data-dojo-type="dojox.mobile.Switch"></div>

.. image :: Switch-SquareShape.png

Round Shape 1
-------------

.. html ::

  <div class="mblSwRoundShape1" data-dojo-type="dojox.mobile.Switch"></div>

.. image :: Switch-RoundShape1.png

Round Shape 2
-------------

.. html ::

  <div class="mblSwRoundShape2" data-dojo-type="dojox.mobile.Switch"></div>

.. image :: Switch-RoundShape2.png

Arc Shape 1
-----------

.. html ::

  <div class="mblSwArcShape1" data-dojo-type="dojox.mobile.Switch"></div>

.. image :: Switch-ArcShape1.png

Arc Shape 2
-----------

.. html ::

  <div class="mblSwArcShape2" data-dojo-type="dojox.mobile.Switch"></div>

.. image :: Switch-ArcShape2.png

Custom Color
------------

.. css ::

  .color1 .mblSwitchBgLeft {
    background: -webkit-gradient(linear, left top, left bottom,
                                 from(#28B159), to(#75FBAC),
                                 color-stop(0.5, #3FEB84),
                                 color-stop(0.5, #4CEE8E));
  }
  .color1 .mblSwitchBgRight {
    background: -webkit-gradient(linear, left top, left bottom,
                                 from(#CECECE), to(#FDFDFD),
                                 color-stop(0.5, #EEEEEE),
                                 color-stop(0.5, #F8F8F8));
  }
  .color1 .mblSwitchKnob {
    background: -webkit-gradient(linear, left top, left bottom,
                                 from(#999999), to(#FAFAFA),
                                 color-stop(0.5, #BBBBBB),
                                 color-stop(0.5, #CACACA));
  }
.. html ::

  <div class="mblSwRoundShape1 color1" data-dojo-type="dojox.mobile.Switch"></div>

.. image :: Switch-CustomColor.png

Listening to onStateChanged
---------------------------

To listen to the changes of switch states, you can connect to the onStateChanged handler, which is called every time the state has been changed. Or you may want to create a subclass of Switch and override the onStateChanged handler.

.. js ::

  dojo.connect(dijit.byId("sw"), "onStateChanged", function(newState){
      alert("newState = "+newState); // newState is "on" or "off"
  });

A setter for "value"
--------------------

To change the state of the switch programmatically, you can use a setter method for "value" as below.

.. js ::

  var widget = dijit.byId("sw");
  widget.set("value", "on"); // "on" or "off" can be set
