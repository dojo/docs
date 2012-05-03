.. _dojox/mobile/TimePicker:

=======================
dojox.mobile.TimePicker
=======================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

dojox.mobile.TimePicker is a wrapper widget around :ref:`dojox.mobile.SpinWheelTimePicker <dojox/mobile/SpinWheelTimePicker>` or :ref:`dojox.mobile.ValuePickerTimePicker <dojox/mobile/ValuePickerTimePicker>`. If you use :ref:`dojox.mobile.deviceTheme <dojox/mobile/deviceTheme>` and the current theme is 'android', it returns ValuePickerTimePicker. For the other themes, it returns SpinWheelTimePicker.

Constructor Parameters
======================

See :ref:`dojox.mobile.ValuePickerTimePicker <dojox/mobile/ValuePickerTimePicker>`.

Examples
========

Declarative example
-------------------

.. js ::

  require([
      "dojox/mobile/parser",
      "dojox/mobile/TimePicker"
  ]);

.. html ::

  <div id="picker1" data-dojo-type="dojox.mobile.TimePicker"></div>

Programmatic example
--------------------

.. js ::

  require([
      "dojo/_base/window",
      "dojo/ready",
      "dojox/mobile/TimePicker",
      "dojox/mobile/parser"
  ], function(win, ready, registry, TimePicker){
      ready(function(){
        var widget = new TimePicker({id:"picker1"});
        win.body().appendChild(widget.domNode);
        widget.startup();
      });
  });

See also :ref:`dojox.mobile.SpinWheelTimePicker <dojox/mobile/SpinWheelTimePicker>` or :ref:`dojox.mobile.ValuePickerTimePicker <dojox/mobile/ValuePickerTimePicker>`.
