#format dojo_rst

dojo.touch
==========

:Project owner: Evan Huang
:Available: since V.1.7

.. contents::
   :depth: 2

============
Introduction
============

This module provides an unified set of touch events - press|move|release|cancel, which can run well across a wide range of devices(including desktops). 

The rationale is very simple - press|move|release|cancel are:

- Mapped to touchstart|touchmove|touchend|touchcancel on touch devices(`W3C Touch Events Specification <http://www.w3.org/TR/touch-events/>`_)


- Mapped to mousedown|mousemove|mouseup|mouseleave on desktops. 

So by using dojo/touch, we don't need to worry about changing to appropriate native events when switching devices.


======
Usages
======

dojo/touch is based on `dojo/on <dojo/on>`_ and provides press|move|release|cancel as 4 event handles. Following below are detail usage samples:


1. Used with dojo/on

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
      define(["dojo/on", "dojo/touch"], function(on, touch){
        on(node, touch.press, function(e){});
        on(node, touch.move, function(e){});
        on(node, touch.release, function(e){});
        on(node, touch.cancel, function(e){});
      }
  </style>


2. Used with dojo/touch directly

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
      define(["dojo/touch"], function(touch){
        touch.press(node, function(e){});
        touch.move(node, function(e){});
        touch.release(node, function(e){});
        touch.cancel(node, function(e){});
      }
  </style>

3. Or used with the traditional dojo/connect

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
        dojo.connect(node, dojo.touch.press, function(e){});
        dojo.connect(node, dojo.touch.move, function(e){});
        dojo.connect(node, dojo.touch.release, function(e){});
        dojo.connect(node, dojo.touch.cancel, function(e){});
  </style>



==============================
Relationship with dojo/gesture
==============================

dojo/touch is the underneath basis for `dojox/gesture <dojox/gesture>`_


============
Known Issues
============

If a device (like blackberry phones or some high end desktop computers) has both mouse and touch, dojo.touch will only monitor touch events, ideally it should be monitoring both. See also See the `#13048 <http://bugs.dojotoolkit.org/ticket/13048>`_.
