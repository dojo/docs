.. _dojox/mobile/DatePicker:

=======================
dojox.mobile.DatePicker
=======================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

dojox.mobile.DatePicker is a wrapper widget around :ref:`dojox.mobile.SpinWheelDatePicker <dojox/mobile/SpinWheelDatePicker>` or :ref:`dojox.mobile.ValuePickerDatePicker <dojox/mobile/ValuePickerDatePicker>`. If you use :ref:`dojox.mobile.deviceTheme <dojox/mobile/deviceTheme>` and the current theme is 'android', it returns ValuePickerDatePicker. For the other themes, it returns SpinWheelDatePicker.

Constructor Parameters
======================

See :ref:`dojox.mobile.SpinWheelDatePicker <dojox/mobile/SpinWheelDatePicker>` or :ref:`dojox.mobile.ValuePickerDatePicker <dojox/mobile/ValuePickerDatePicker>`.

Examples
========

Declarative example
-------------------

.. js ::

  require([
      "dojox/mobile/parser",
      "dojox/mobile/DatePicker"
  ]);

.. html ::

  <div id="picker1" data-dojo-type="dojox.mobile.DatePicker"></div>

Programmatic example
--------------------

.. js ::

  require([
      "dojo/_base/window",
      "dojo/ready",
      "dojox/mobile/DatePicker",
      "dojox/mobile/parser"
  ], function(win, ready, registry, DatePicker){
      ready(function(){
        var widget = new DatePicker({id:"picker1"});
        win.body().appendChild(widget.domNode);
        widget.startup();
      });
  });

See also :ref:`dojox.mobile.SpinWheelDatePicker <dojox/mobile/SpinWheelDatePicker>` or :ref:`dojox.mobile.ValuePickerDatePicker <dojox/mobile/ValuePickerDatePicker>`.
