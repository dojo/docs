.. _dojo/fadeOut:

============
dojo.fadeOut
============

:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann, Jared Jurkiewicz
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, sjmiles
:since: v1.0.0

.. contents ::
    :depth: 2

This function is a helper function that wraps the :ref:`dojo.animateProperty <dojo/animateProperty>` function to provide an easy interface to fading a node out of view on the page.  While this can be done with the *dojo.animateProperty* function, this function is simpler to use and will handle 99% of the cases a fade-out is desired.

Parameters
==========

The *dojo.fadeOut* takes an object as its parameter.  This object defines what dom node to act on, how long the fade out should take (in milliseconds, and an optional easing function.

All standard :ref:`dojo.Animation <dojo/Animation>` events and parameters apply, though *properties:{}* is explicitly set to control opacity, so should be omitted.

Return value
============

The *dojo.fadeOut* function returns an instance of :ref:`dojo.Animation <dojo/Animation>`.  To execute the fadeOut, call the *play()* function on the animation.  This object can be used with other dojo animation functions, such as :ref:`dojo.fx.chain <dojo/fx/chain>` and :ref:`dojo.fx.combine <dojo/fx/combine>` to link it with other effects to perform complex animations.

Examples
========

Example 1:  Fade out a dom node
-------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.Button");
      function basicFadeoutSetup(){
         // Function linked to the button to trigger the fade.
         function fadeIt(){
            dojo.style("basicFadeNode", "opacity", "1");
            var fadeArgs = {
              node: "basicFadeNode"
            };
            dojo.fadeOut(fadeArgs).play();
         }
         dojo.connect(dijit.byId("basicFadeButton"), "onClick", fadeIt);
      }
      dojo.ready(basicFadeoutSetup);

  .. html ::

    <button data-dojo-type="dijit.form.Button" id="basicFadeButton">Fade It Out!</button>
    <div id="basicFadeNode" style="width: 100px; height: 100px; background-color: red;"></div>


Example 2:  Fade in a dom node with a custom duration
-----------------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.Button");
      function basicFadeoutSetup2(){
         // Function linked to the button to trigger the fade.
         function fadeIt(){
            dojo.style("basicFadeNode2", "opacity", "1");
            var fadeArgs = {
              node: "basicFadeNode2",
              duration: 5000,
            };
            dojo.fadeOut(fadeArgs).play();
         }
         dojo.connect(dijit.byId("basicFadeButton2"), "onClick", fadeIt);
      }
      dojo.ready(basicFadeoutSetup2);

  .. html ::

    <button data-dojo-type="dijit.form.Button" id="basicFadeButton2">Fade It Out Slow!</button>
    <div id="basicFadeNode2" style="width: 100px; height: 100px; background-color: red;"></div>



Example 3:  Fade in a dom node with an easing function
------------------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function basicFadeoutSetup3(){
         // Function linked to the button to trigger the fade.
         function fadeIt(){
            dojo.style("basicFadeNode3", "opacity", "1");
            var fadeArgs = {
              node: "basicFadeNode3",
              duration: 10000,
              easing: dojo.fx.easing.expoOut
            };
            dojo.fadeOut(fadeArgs).play();
         }
         dojo.connect(dijit.byId("basicFadeButton3"), "onClick", fadeIt);
      }
      dojo.ready(basicFadeoutSetup3);

  .. html ::

    <button data-dojo-type="dijit.form.Button" id="basicFadeButton3">Fade It Out Slow with Expo Easing!</button>
    <div id="basicFadeNode3" style="width: 100px; height: 100px; background-color: red;"></div>

See Also
========

* :ref:`dojo/fadeIn <dojo/fadeIn>`
* :ref:`Animation Quickstart <quickstart/Animation>`
