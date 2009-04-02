## page was renamed from 1.2/dojo/fx
#format dojo_rst

dojo.fx.easing
==============

:Status: Draft
:Version: 1.0
:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann, Jared Jurkiewicz
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
|                                       |                                                                                                      |
|                                       | *Starts slow and gets faster*                                                                        |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.quadOut                | A function to apply the rate of the effect by a power of 2 over time at the end.                     |
|                                       |                                                                                                      |
|                                       | *Starts fast and gets slower*                                                                        |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.quadInOut              | A function to apply the quad function at the beginning and end of the duration.                      |
|                                       |                                                                                                      |
|                                       | *Starts slow and gets faster, then gets slow again*                                                  |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.cubicIn                | A function to apply the rate of the effect by a power of 3 over time at the beginning.               |
|                                       |                                                                                                      |
|                                       | *Starts slow and gets faster*                                                                        |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.cubicOut               | A function to apply the rate of the effect by a power of 3 over time at the end.                     |
|                                       |                                                                                                      |
|                                       | *Starts fast and gets slower*                                                                        |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.cubicInOut             | A function to apply the cubic function at the beginning and end of the duration.                     |
|                                       |                                                                                                      |
|                                       | *Starts slow and gets faster, then gets slow again*                                                  |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.quartIn                | A function to apply the rate of the effect by a power of 4 over time at the beginning.               |
|                                       |                                                                                                      |
|                                       | *Starts slow and gets faster*                                                                        |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.quartOut               | A function to apply the rate of the effect by a power of 4 over time at the end.                     |
|                                       |                                                                                                      |
|                                       | *Starts fast and gets slower*                                                                        |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.quartInOut             | A function to apply the quart function at the beginning and end of the duration.                     |
|                                       |                                                                                                      |
|                                       | *Starts slow and gets faster, then gets slow again*                                                  |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.quintIn                | A function to apply the rate of the effect by a power of 5 over time at the beginning.               |
|                                       |                                                                                                      |
|                                       | *Starts slow and gets faster*                                                                        |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.quintOut               | A function to apply the rate of the effect by a power of 5 over time at the end.                     |
|                                       |                                                                                                      |
|                                       | *Starts fast and gets slower*                                                                        |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.quintInOut             | A function to apply the quint function at the beginning and end of the duration.                     |
|                                       |                                                                                                      |
|                                       | *Starts slow and gets faster, then gets slow again*                                                  |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.sineIn                 | A function to apply the rate of the effect by a sine function over time at the beginning.            |
|                                       |                                                                                                      |
|                                       | *Starts slow and gets faster*                                                                        |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.sineOut                | A function to apply the rate of the effect by a sine function over time at the end.                  |
|                                       |                                                                                                      |
|                                       | *Starts fast and gets slower*                                                                        |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.sineInOut              | A function to apply the sine function at the beginning and end of the duration.                      |
|                                       |                                                                                                      |
|                                       | *Starts slow and gets faster, then gets slow again*                                                  |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.expoIn                 | A function to apply the rate of the effect exponentially over time at the beginning.                 |
|                                       |                                                                                                      |
|                                       | *Starts slow and gets faster*                                                                        |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.expoOut                | A function to apply the rate of the effect exponentially over time at the end.                       |
|                                       |                                                                                                      |
|                                       | *Starts fast and gets slower*                                                                        |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.expoInOut              | A function to apply the exponential function at the beginning and end of the duration.               |
|                                       |                                                                                                      |
|                                       | *Starts slow and gets faster, then gets slow again*                                                  |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.circIn                 | A function to apply the rate of the effect circularly over time at the beginning.                    |
|                                       |                                                                                                      |
|                                       | *Starts slow and gets faster*                                                                        |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.circOut                | A function to apply the rate of the effect circularly over time at the end.                          |
|                                       |                                                                                                      |
|                                       | *Starts fast and gets slower*                                                                        |
+---------------------------------------+------------------------------------------------------------------------------------------------------+
| dojo.fx.easing.circInOut              | A function to apply the circular function at the beginning and end of the duration.                  |
|                                       |                                                                                                      |
|                                       | *Starts slow and gets faster, then gets slow again*                                                  |
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


Examples:  Select the desired easing function from the dropdown and press 'move the div' 
----------------------------------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dijit.form.ComboBox");
      dojo.require("dojo.fx.easing");
      function setupMove(){
         //Function linked to the button to trigger the fade.
         function moveIt() {
			//Set initial state and get the easing from the dropdown
            dojo.style("moveableNode", "marginLeft", "0px");
			var easing = dijit.byId("easingSelector").attr("value");
			var ef = dojo.fx.easing[easing];
			if (ef) {
				var moveArgs = {
				  node: "moveableNode",
				  properties: { marginLeft: {start: 0, end: 400, unit: "px"} },
				  easing: ef,
				  duration: 5000
				};
				dojo.animateProperty(moveArgs).play();
			}
         }
         dojo.connect(dijit.byId("moveButton"), "onClick", moveIt);
      }
      dojo.addOnLoad(setupMove);
    </script>

  .. cv :: html 

	<select dojoType="dijit.form.ComboBox" id="easingSelector">
		<option>linear</option>
		<option>quadIn</option>
		<option>quadOut</option>
		<option>quadInOut</option>
		<option>cubicIn</option>
		<option>cubicOut</option>
		<option>cubicInOut</option>
		<option>quartIn</option>
		<option>quartOut</option>
		<option>quartInOut</option>
		<option>quintIn</option>
		<option>quintOut</option>
		<option>quintInOut</option>
		<option>sineIn</option>
		<option>sineOut</option>
		<option>sineInOut</option>
		<option>expoIn</option>
		<option>expoOut</option>
		<option>expoInOut</option>
		<option>circIn</option>
		<option>circOut</option>
		<option>circInOut</option>
		<option>backIn</option>
		<option>backOut</option>
		<option>backInOut</option>
		<option>elasticIn</option>
		<option>elasticOut</option>
		<option>elasticInOut</option>
		<option>bounceIn</option>
		<option>bounceOut</option>
		<option>bounceInOut</option>
	</select>
    <button dojoType="dijit.form.Button" id="moveButton">Move the div!</button>
    <div id="moveableNode" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>


========
See Also
========

* `dojox.fadeIn <dojox/fadeIn>`_ - Examples show using the expoOut easing.

* `dojox.fadeOut <dojox/fadeOut>`_ - Examples show using the expoOut easing.
