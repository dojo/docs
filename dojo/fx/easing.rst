## page was renamed from 1.2/dojo/fx
#format dojo_rst

dojo.fx.easing
==============

:Status: Draft
:Version: 1.0
:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, sjmiles
:Available: since V1.0

.. contents::
    :depth: 2

Have you ever wanted a fade out, fade in, wipe in, and so forth to apply the effect in a non-linear way?  For example, wouldn't it be cool to have a fade in accelerate the rate at which the node appears the further along in the animation duration it is?  This is handled through the 'easing' property of the arguments passed to the animation creation functions.  

Instead of having to write the easing function yourself, dojo provides a collection of easing functions to use as this parameter to get a variety of effects.

================
Easing Functions
================

All functions follow a simple naming convention of "ease type" + "when".  If the name of the function ends in Out, the easing described appears 	towards the end of the animation. "In" means during the beginning, and InOut means both ranges of the Animation will applied, both beginning and end. 


+---------------------------------------+------------------------------------------------------------------------------------------------------+
|**Function**                           |**Description**                                                                                       |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.linear                 | The most basic easing function (and the default for animations), apply the effect linearly over time.|
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.quadIn                 | A function to apply the rate of the effect by a power of 2 over time at the beginning.               |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.quadOut                | A function to apply the rate of the effect by a power of 2 over time at the end.                     |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.quadInOut              | A function to apply the quad function at the beginning and end of the duration.                      |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.cubicIn                | A function to apply the rate of the effect by a power of 3 over time at the beginning.               |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.cubicOut               | A function to apply the rate of the effect by a power of 3 over time at the end.                     |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.cubicInOut             | A function to apply the cubic function at the beginning and end of the duration.                     |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.quartIn                | A function to apply the rate of the effect by a power of 4 over time at the beginning.               |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.quartOut               | A function to apply the rate of the effect by a power of 4 over time at the end.                     |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.quartInOut             | A function to apply the quart function at the beginning and end of the duration.                     |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.quintIn                | A function to apply the rate of the effect by a power of 5 over time at the beginning.               |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.quintOut               | A function to apply the rate of the effect by a power of 5 over time at the end.                     |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.quintInOut             | A function to apply the quint function at the beginning and end of the duration.                     |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.sineIn                 | A function to apply the rate of the effect by a sine function over time at the beginning.            |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.sineOut                | A function to apply the rate of the effect by a sine function over time at the end.                  |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.sineInOut              | A function to apply the sine function at the beginning and end of the duration.                      |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.expoIn                 | A function to apply the rate of the effect exponentially over time at the beginning.                 |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.expoOut                | A function to apply the rate of the effect exponentially over time at the end.                       |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.expoInOut              | A function to apply the exponential function at the beginning and end of the duration.               |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.circIn                 | A function to apply the rate of the effect circularly over time at the beginning.                    |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.circOut                | A function to apply the rate of the effect circularly over time at the end.                          |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.circInOut              | A function to apply the circular function at the beginning and end of the duration.                  |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.backIn                 | A function where the rate of change starts away from the target, but quickly accelerates towards it. | 
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.backOut                | A function where the end value actually goes past the end, then pops back to the end value|          |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.backInOut              | A function that applies both backIn and backOut to the animation behavior.                           |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.elasticIn              | A function where the rate of change snaps elastically from the start value                           | 
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.elasticIn              | A function where the rate of change snaps elastically around the end value.                          | 
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.elasticInOut           | A function that elastically snaps around the value, near the beginning and end of the Animation.     |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.bounceIn               | A function where the rate of change 'bounces' near the beginning value                               | 
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.bounceIn               | A function where the rate of change 'bounces' near the ending value                                  | 
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.bounceInOut            | A function that 'bounces' near the beginning and end of the animation                                |
+---------------------------------------+------------------------------------------------------------------------------------------------------+

========
Examples
========

Example 1:  Linearly change the margin-left of a div
----------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.linear,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton">Move the div!</button>
    <div id="basicNode" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>


Example 2:  quadIn change the margin-left of a div
--------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup1(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode1", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode1",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.quadIn,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton1"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup1);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton1">Move the div!</button>
    <div id="basicNode1" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 3:  quadOut change the margin-left of a div
---------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup2(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode2", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode2",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.quadOut,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton2"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup2);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton2">Move the div!</button>
    <div id="basicNode2" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 4:  quadInOut change the margin-left of a div
-----------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup3(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode3", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode3",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.quadInOut,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton3"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup3);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton3">Move the div!</button>
    <div id="basicNode3" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 5:  cubicIn change the margin-left of a div
---------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup4(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode4", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode4",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.cubicIn,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton4"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup4);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton4">Move the div!</button>
    <div id="basicNode4" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 6:  cubicOut change the margin-left of a div
----------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup5(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode5", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode5",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.cubicOut,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton5"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup5);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton5">Move the div!</button>
    <div id="basicNode5" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 7:  cubicInOut change the margin-left of a div
------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup6(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode6", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode6",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.cubicInOut,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton6"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup6);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton6">Move the div!</button>
    <div id="basicNode6" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>


Example 8:  quartIn change the margin-left of a div
---------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup7(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode7", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode7",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.quartIn,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton7"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup7);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton7">Move the div!</button>
    <div id="basicNode7" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 9:  quartOut change the margin-left of a div
----------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup8(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode8", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode8",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.quartOut,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton8"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup8);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton8">Move the div!</button>
    <div id="basicNode8" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 10:  quartInOut change the margin-left of a div
-------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup9(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode9", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode9",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.quartInOut,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton9"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup9);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton9">Move the div!</button>
    <div id="basicNode9" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>


Example 11:  quintIn change the margin-left of a div
----------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup10(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode10", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode10",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.quintIn,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton10"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup10);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton10">Move the div!</button>
    <div id="basicNode10" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 12:  quintOut change the margin-left of a div
-----------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup11(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode11", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode11",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.quintOut,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton11"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup11);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton11">Move the div!</button>
    <div id="basicNode11" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 13:  quintInOut change the margin-left of a div
-------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup12(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode12", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode12",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.quintInOut,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton12"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup12);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton12">Move the div!</button>
    <div id="basicNode12" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 14:  sineIn change the margin-left of a div
---------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup13(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode13", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode13",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.sineIn,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton13"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup13);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton13">Move the div!</button>
    <div id="basicNode13" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 15:  sineOut change the margin-left of a div
----------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup14(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode14", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode14",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.sineOut,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton14"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup14);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton14">Move the div!</button>
    <div id="basicNode14" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 16:  sineInOut change the margin-left of a div
-------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup15(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode15", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode15",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.sineInOut,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton15"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup15);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton15">Move the div!</button>
    <div id="basicNode15" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 17:  expoIn change the margin-left of a div
---------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup16(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode16", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode16",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.expoIn,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton16"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup16);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton16">Move the div!</button>
    <div id="basicNode16" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 18:  expoOut change the margin-left of a div
----------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup17(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode17", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode17",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.expoOut,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton17"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup17);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton17">Move the div!</button>
    <div id="basicNode17" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 19:  expoInOut change the margin-left of a div
------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup18(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode18", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode18",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.expoInOut,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton18"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup18);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton18">Move the div!</button>
    <div id="basicNode18" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 20:  circIn change the margin-left of a div
---------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup19(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode19", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode19",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.circIn,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton19"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup19);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton19">Move the div!</button>
    <div id="basicNode19" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 21:  circOut change the margin-left of a div
----------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup20(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode20", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode20",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.circOut,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton20"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup20);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton20">Move the div!</button>
    <div id="basicNode20" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 22:  circInOut change the margin-left of a div
------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup21(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode21", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode21",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.circInOut,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton21"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup21);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton21">Move the div!</button>
    <div id="basicNode21" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>


Example 23:  backIn change the margin-left of a div
---------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup22(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode22", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode22",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.circIn,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton22"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup22);
    </script>			   

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton22">Move the div!</button>
    <div id="basicNode22" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 24:  backOut change the margin-left of a div
----------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup23(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode23", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode23",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.circOut,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton23"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup23);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton23">Move the div!</button>
    <div id="basicNode23" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 25:  backInOut change the margin-left of a div
------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup24(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode24", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode24",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.backInOut,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton24"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup24);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton24">Move the div!</button>
    <div id="basicNode24" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 26:  elasticIn change the margin-left of a div
------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup25(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode25", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode25",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.elasticIn,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton25"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup25);
    </script>			   

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton25">Move the div!</button>
    <div id="basicNode25" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 27:  elasticOut change the margin-left of a div
-------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup26(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode26", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode26",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.elasticOut,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton26"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup26);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton26">Move the div!</button>
    <div id="basicNode26" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 28:  elasticInOut change the margin-left of a div
---------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup27(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode27", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode27",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.elasticInOut,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton27"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup27);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton27">Move the div!</button>
    <div id="basicNode27" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>


Example 29:  bounceIn change the margin-left of a div
-----------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup28(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode28", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode28",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.bounceIn,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton28"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup28);
    </script>			   

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton28">Move the div!</button>
    <div id="basicNode28" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 30:  bnounceOut change the margin-left of a div
-------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup29(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode29", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode29",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.bounceOut,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton29"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup29);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton29">Move the div!</button>
    <div id="basicNode29" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

Example 31:  bounceInOut change the margin-left of a div
--------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function setup30(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
            dojo.style("basicNode30", "marginLeft", "0px");
            var moveArgs = {
              node: "basicNode30",
              properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
              easing: dojo.fx.easing.bounceInOut,
              duration: 5000
            };
            dojo.animateProperty(moveArgs).play();
         }
         dojo.connect(dijit.byId("basicMoveButton30"), "onClick", moveIt);
      }
      dojo.addOnLoad(setup27);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicMoveButton30">Move the div!</button>
    <div id="basicNode30" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>


========
See Also
========

* `dojox.fadeIn <dojox/fadeIn>`_ - Examples show using the expoOut easing.

* `dojox.fadeOut <dojox/fadeOut>`_ - Examples show using the expoOut easing.
