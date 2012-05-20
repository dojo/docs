.. _dojo/fx/easing:

==============
dojo/fx/easing
==============

:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann, Jared Jurkiewicz
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, 
             sjmiles
:since: V1.2

.. contents ::
    :depth: 2

Have you ever wanted a fade-out, fade-in, wipe-in, etc. effect to play in a a non-linear way? For example, wouldn't it
be cool to have a fade in accelerate the rate at which the node appears the further along in the animation duration it
is? This is handled through the ``easing`` property of the arguments passed to the animation creation functions.

Instead of having to write the easing function yourself, Dojo provides a collection of easing functions to use as this
parameter to get a variety of effects.

Usage
=====

The module returns an objection that contains the various easing functions, that then can be used in an animation:

.. js ::

  require(["dojo/fx/easing", "dojo/_base/fx"], function(easing, baseFx){
    baseFx.animateProperty({
      node: "someNode",
      properties: {
        width: 300
      },
      easing: easing.linear
    }).play();
  });

Easing Functions
----------------

All functions follow a simple naming convention of "ease type" plus "when". If the name of the function ends in Out, the
easing described appears towards the end of the animation. "In" means during the beginning, and InOut means both ranges
of the Animation will applied, both beginning and end.

============ ===========================================================================================================
Function     Description
============ ===========================================================================================================
linear       The most basic easing function (and the default for animations), apply the effect linearly over time.
quadIn       A function to apply the rate of the effect by a power of 2 over time at the beginning.

             *Starts slow and gets faster.*
quadOut      A function to apply the rate of the effect by a power of 2 over time at the end.

             *Starts fast and gets slower.*
quadInOut    A function to apply the rate of the effect by a power of 2 over time at the beginning and end.

             *Starts slow, gets faster and then slows again.*
cubicIn      A function to apply the rate of the effect by a power of 3 over time at the beginning.

             *Starts slow and gets faster.*
cubicOut     A function to apply the rate of the effect by a power of 3 over time at the end.

             *Starts fast and gets slower.*
cubicInOut   A function to apply the rate of the effect by a power of 3 over time at the beginning and end.

             *Starts slow, gets faster and then slows again.*
quartIn      A function to apply the rate of the effect by a power of 4 over time at the beginning.

             *Starts slow and gets faster.*
quartOut     A function to apply the rate of the effect by a power of 4 over time at the end.

             *Starts fast and gets slower.*
quartInOut   A function to apply the rate of the effect by a power of 4 over time at the beginning and end.

             *Starts slow, gets faster and then slows again.*
quintIn      A function to apply the rate of the effect by a power of 5 over time at the beginning.

             *Starts slow and gets faster.*
quintOut     A function to apply the rate of the effect by a power of 5 over time at the end.

             *Starts fast and gets slower.*
quintInOut   A function to apply the rate of the effect by a power of 5 over time at the beginning and end.

             *Starts slow, gets faster and then slows again.*
sineIn       A function to apply the rate of the effect by the sine function over time at the beginning.

             *Starts slow and gets faster.*
sineOut      A function to apply the rate of the effect by the sine function over time at the end.

             *Starts fast and gets slower.*
sineInOut    A function to apply the rate of the effect by the sine function over time at the beginning and end.

             *Starts slow, gets faster and then slows again.*
expoIn       A function to apply the rate of the effect exponentially over time at the beginning.

             *Starts slow and gets faster.*
expoOut      A function to apply the rate of the effect exponentially over time at the end.

             *Starts fast and gets slower.*
expoInOut    A function to apply the rate of the effect exponentially over time at the beginning and end.

             *Starts slow, gets faster and then slows again.*
circIn       A function to apply the rate of the effect circularly over time at the beginning.

             *Starts slow and gets faster.*
circOut      A function to apply the rate of the effect circularly over time at the end.

             *Starts fast and gets slower.*
circInOut    A function to apply the rate of the effect circularly over time at the beginning and the end.

             *Starts slow, gets faster and then slows again.*
backIn       A function where the rate of change starts away from the target, but quickly accelerates towards it.
backOut      A function where the end value actually goes past the end, then pops back to the end value.
backInOut    A function that applies both backIn and backOut to the animation behavior.
elasticIn    A function where the rate of change snaps elastically from the start value.
elasticOut   A function where the rate of change snaps elastically around the end value.
elasticInOut A function that elastically snaps around the value, near the beginning and end of the Animation.
bounceIn     A function where the rate of change "bounces" near the beginning value
bounceOut    A function where the rate of change "bounces" near the ending value
bounceInOut  A function that "bounces" near the beginning and end of the animation
============ ===========================================================================================================

Examples
========


Example: Playing with Easing
----------------------------

.. code-example ::

  Select the desired easing function from the dropdown and press 'move the div'

  .. js ::

    require(["dojo/_base/fx", "dojo/fx/easing", "dojo/on", "dojo/dom", "dojo/dom-prop", "dojo/dom-style", 
        "dojo/domReady!"],
    function(baseFx, easing, on, dom, domProp, style){
      on(dom.byId("moveButton"), "click", function(){
        style.set("moveableNode", "marginLeft", "0px");
        var easeType = domProp.get("easingSelector", "value"),
            ef = easing[easeType];
        if(ef){
          baseFx.animateProperty({
            node: "moveableNode",
            properties: {
              marginLeft: {
                start: 0,
                end: 400,
                unit: "px"
              }
            },
            easing: ef,
            duration: 5000
          }).play();
        }
      });
    });

  .. html ::

    <select id="easingSelector">
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
    <button type="button" id="moveButton">Move the div!</button>
    <div id="moveableNode" style="width: 100px; height: 100px; background-color: red; margin-left: 0px;"></div>

See Also
========

* :ref:`dojo/_base/fx::fadeIn() <dojo/_base/fx#fadein>` - Examples show using the ``expoOut`` easing.

* :ref:`dojo/_base/fx::fadeOut() <dojo/_base/fx#fadeout>` - Examples show using the ``expoOut`` easing.
