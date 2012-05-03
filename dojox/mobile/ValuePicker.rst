.. _dojox/mobile/ValuePicker:

========================
dojox.mobile.ValuePicker
========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

ValuePicker is a widget for selecting some values. The values can be selected by using the Plus or Minus buttons, or you can type the value directly in the input field. This type of value pickers are typically seen on Android devices.

.. image :: ValuePicker.png

Constructor Parameters
======================

None.

Examples
========

Declarative example
-------------------

.. js ::

  require([
      "dojox/mobile/parser",
      "dojox/mobile/ValuePicker"
  ]);

.. html ::

  <div id="view1" data-dojo-type="dojox.mobile.View" selected="true">
      <h1 data-dojo-type="dojox.mobile.Heading">Custom ValuePicker</h1>
      <div id="spin1" data-dojo-type="dojox.mobile.ValuePicker">
       <div data-dojo-type="dojox.mobile.ValuePickerSlot"
           labels="['A','B','C','D','E','F','G','H','I','J','K']"
           style="text-align:center;width:40px;"></div>
       <div data-dojo-type="dojox.mobile.ValuePickerSlot"
           labelFrom="3000" labelTo="3100"
           style="width:70px;"></div>
       <div data-dojo-type="dojox.mobile.ValuePickerSlot"
           labelFrom="0" labelTo="9"
           style="width:50px;"></div>
       <div data-dojo-type="dojox.mobile.ValuePickerSlot"
           labels="['pt','px','cm']"
           style="width:50px;"></div>
      </div>
  </div>

Programmatic example
--------------------

.. js ::

  require([
      "dojo/ready",
      "dijit/registry",
      "dojox/mobile/ValuePicker",
      "dojox/mobile/ValuePickerSlot",
      "dojox/mobile/parser"
  ], function(ready, registry, ValuePicker, ValuePickerSlot){
    ready(function(){
      var view = registry.byId("view1");
      var widget = new ValuePicker({id:"spin1"});
      widget.placeAt(view.containerNode);
      widget.startup();
      var slot1 = new ValuePickerSlot({
        labels:['A','B','C','D','E','F','G','H','I','J','K','L','M',
                'N','O','P','Q','R','S','T','U','V','W','X','Y','Z'],
        style:{textAlign:"center", width:"40px"}});
      widget.addChild(slot1);

      var slot2 = new ValuePickerSlot({labelFrom:3000, labelTo:3100, style:{width:"70px"}});
      widget.addChild(slot2);

      var slot3 = new ValuePickerSlot({labelFrom:0, labelTo:9, style:{width:"30px"}});
      widget.addChild(slot3);

      var slot4 = new ValuePickerSlot({labels:['pt','px','cm'], style:{width:"50px"}});
      widget.addChild(slot4);
    });
  });
