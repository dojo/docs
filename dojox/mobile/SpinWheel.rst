.. _dojox/mobile/SpinWheel:

======================
dojox.mobile.SpinWheel
======================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.7

.. contents ::
    :depth: 2

Introduction
============

SpinWheel is a value picker component. It is a sectioned wheel that can be used to pick up some values from the wheel slots by spinning them.

.. image :: SpinWheel-custom.png

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
      "dojox/mobile/SpinWheel"
  ]);

.. html ::

  <div id="view1" data-dojo-type="dojox.mobile.View">
      <h1 data-dojo-type="dojox.mobile.Heading">Custom SpinWheel</h1>
      <div id="spin1" data-dojo-type="dojox.mobile.SpinWheel">
       <div data-dojo-type="dojox.mobile.SpinWheelSlot"
           labels="['A','B','C','D','E','F','G','H','I','J','K']"
           style="text-align:center;width:40px;"></div>
       <div data-dojo-type="dojox.mobile.SpinWheelSlot"
           labelFrom="3000" labelTo="3100"
           style="width:70px;"></div>
       <div id="pt" class="mblSpinWheelSlot"></div>
       <div id="txt" class="mblSpinWheelSlot">.</div>
       <div data-dojo-type="dojox.mobile.SpinWheelSlot"
           labelFrom="0" labelTo="9"
           style="width:30px;"></div>
       <div data-dojo-type="dojox.mobile.SpinWheelSlot"
           labels="['pt','px','cm']"
           style="width:50px;"></div>
       <div data-dojo-type="dojox.mobile.SpinWheelSlot"
           labels="[
               '<img src=images/i-icon-1.png>',
               '<img src=images/i-icon-2.png>',
               '<img src=images/i-icon-3.png>',
               '<img src=images/i-icon-4.png>',
               '<img src=images/i-icon-5.png>'
           ]"
           style="width:70px;text-align:center;"></div>
      </div>
  </div>

Programmatic example
--------------------

.. js ::

  require([
      "dojo/dom-construct",
      "dojo/ready",
      "dijit/registry",
      "dojox/mobile/SpinWheel",
      "dojox/mobile/SpinWheelSlot",
      "dojox/mobile/parser"
  ], function(domConst, ready, registry, SpinWheel, SpinWheelSlot){
    ready(function(){
      var view = registry.byId("view1");
      var widget = new SpinWheel({id:"spin1"});
      widget.placeAt(view.containerNode);
      widget.startup();
      var slot1 = new SpinWheelSlot({
        labels:['A','B','C','D','E','F','G','H','I','J','K','L','M',
                'N','O','P','Q','R','S','T','U','V','W','X','Y','Z'],
        style:{textAlign:"center", width:"40px"}});
      widget.addChild(slot1);

      var slot2 = new SpinWheelSlot({labelFrom:3000, labelTo:3100, style:{width:"70px"}});
      widget.addChild(slot2);

      domConst.create("div", {className: "mblSpinWheelSlot", id:"pt"}, widget.containerNode);
      domConst.create("div", {className: "mblSpinWheelSlot", id:"txt", innerHTML:"."},
                      widget.containerNode);

      var slot3 = new SpinWheelSlot({labelFrom:0, labelTo:9, style:{width:"30px"}});
      widget.addChild(slot3);

      var slot4 = new SpinWheelSlot({labels:['pt','px','cm'], style:{width:"50px"}});
      widget.addChild(slot4);

      var slot5 = new SpinWheelSlot({
        labels:[
          '<img src=images/i-icon-1.png>',
          '<img src=images/i-icon-2.png>',
          '<img src=images/i-icon-3.png>',
          '<img src=images/i-icon-4.png>',
          '<img src=images/i-icon-5.png>',
          '<img src=images/i-icon-6.png>',
          '<img src=images/i-icon-7.png>',
          '<img src=images/i-icon-8.png>',
          '<img src=images/i-icon-9.png>',
          '<img src=images/i-icon-10.png>'
        ],
        style:{width:"70px", textAlign:"center"}
      });
      widget.addChild(slot5);

      //widget.reset();
    });
  });
