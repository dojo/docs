#format dojo_rst

dojox.mobile.Switch
===================

:Status: Draft
:Version: 1.0
:Authors: Jared Jurkiewicz, Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama, Jared Jurkiewicz
:Available: since V1.5

.. contents::
    :depth: 2

Switch is a toggle switch with a sliding knob. You can either tap or slide the knob to toggle the switch. The onStateChanged handler is called when the switch is manipulated.

.. image:: Switch.png

======================
Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|value 	       |String 	  |on       |The initial state of the switch. "on" or "off". The default value is "on".                                 |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|leftLabel     |String    |ON       |The left-side label of the switch. The default value is "ON".                                              |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|rightLabel    |String    |OFF      |The right-side label of the switch. The default value is "OFF".                                            |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

========
Examples
========

Declarative example 1
---------------------

.. code-block :: html

  <div id="sw" dojoType="dojox.mobile.Switch" value="off"></div>

.. image:: Switch-example1.png

Declarative example 2
---------------------

.. code-block :: html

  <div dojoType="dojox.mobile.Switch" value="on" leftLabel="Start" rightLabel="Stop"></div>

.. image:: Switch-example2.png

Listening to onStateChanged
---------------------------

To listen to the changes of switch states, you can connect to the onStateChanged handler, which is called every time the state has been changed. Or you may want to create a subclass of Switch and override the onStateChanged handler.

.. code-block :: javascript

  dojo.connect(dijit.byId("sw"), "onStateChanged", function(newState){
      alert("newState = "+newState); // newState is "on" or "off"
  });
