#format dojo_rst

dojox.mobile.Button
===================

:Status: Draft
:Version: 1.0
:Authors: Yoshiroh Kamiyama, Jared Jurkiewicz, Doug Hays
:Developers: Yoshiroh Kamiyama, Doug Hays
:Available: since V1.5

.. contents::
    :depth: 2

Button is a very simple button widget.  When pressed, it generates an onClick event and changes CSS classes temporarily to emulate a native HTML BUTTON element press-and-release.

.. image:: Button.png

======================
Constructor Parameters
======================

+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default       |Description                                                                                                |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|baseClass     |String 	  |mblButton     |Default CSS class name used to render the button.                                                          |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|class         |String 	  |              |Additional CSS class names to add to baseClass                                                             |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|duration      |Number    |1000          |Duration of the selected CSS change in milliseconds.                                                       |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|label         |String    |              |A label of the button. If the label is not specified, innerHTML is used as a label.                        |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+
|onClick       |Function  |              |An event handler used for press notifications.                                                             |
+--------------+----------+--------------+-----------------------------------------------------------------------------------------------------------+

========
Examples
========

Default Button
--------------

.. code-block :: html

  <button dojoType="dojox.mobile.Button" style="width:120px">Default Button</button>

.. image:: Button-example1.png

Custom Button
-------------

You can define your own style for Button and specify it with the btnClass parameter.

.. code-block :: html

  <style>
  .redButton {
    border-color: #cc3333;
    background-image: url(images/red-button-bg.png);
    background: -webkit-gradient(linear, left top, left bottom, from(#D3656D), to(#BC1320), color-stop(0.5, #C9404B), color-stop(0.5, #BC1421));
  }
  .redButtonSelected {
    background-image: url(images/red-button-sel-bg.png);
    background: -webkit-gradient(linear, left top, left bottom, from(#AF333C), to(#880E17), color-stop(0.5, #952B33), color-stop(0.5, #870F18));
  }
  </style>

.. code-block :: html

  <button dojoType="dojox.mobile.Button" class="redButton" style="width:120px">Custom Button</button>

.. image:: Button-example2.png

onClick handler
---------------

.. code-block :: html

  <div data-dojo-type="dojox.mobile.Button" data-dojo-props='label:"Click me!", onClick:function(e){ alert("button clicked"); }'></div>
