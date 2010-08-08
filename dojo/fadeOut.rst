#format dojo_rst

dojo.fadeOut
============

:Status: Draft
:Version: 1.0
:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann, Jared Jurkiewicz
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, sjmiles
:Available: since v1.0.0

.. contents::
    :depth: 2

This function is a helper function that wraps the `dojo.animateProperty <dojo/animateProperty>`_ function to provide an easy interface to fading a node out of view on the page.  While this can be done with the *dojo.animateProperty* function, this function is simpler to use and will handle 99% of the cases a fade-out is desired.

==========
Parameters
==========

The *dojo.fadeOut* takes an object as its parameter.  This object defines what dom node to act on, how long the fade out should take (in milliseconds, and an optional easing function.  

All standard `dojo.Animation <dojo/Animation>`_ events and parameters apply, though *properties:{}* is explicitly set to control opacity, so should be omitted.

============
Return value
============

The *dojo.fadeOut* function returns an instance of `dojo.Animation <dojo/Animation>`_.  To execute the fadeOut, call the *play()* function on the animation.  This object can be used with other dojo animation functions, such as `dojo.fx.chain <dojo/fx/chain>`_ and `dojo.fx.combine <dojo/fx/combine>`_ to link it with other effects to perform complex animations.

========
Examples
========

Example 1:  Fade out a dom node
-------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      function basicFadeoutSetup(){
         //Function linked to the button to trigger the fade.
         function fadeIt() {
            dojo.style("basicFadeNode", "opacity", "1");
            var fadeArgs = {
              node: "basicFadeNode"
            };
            dojo.fadeOut(fadeArgs).play();
         }
         dojo.connect(dijit.byId("basicFadeButton"), "onClick", fadeIt);
      }
      dojo.addOnLoad(basicFadeoutSetup);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicFadeButton">Fade It Out!</button>
    <div id="basicFadeNode" style="width: 100px; height: 100px; background-color: red;"></div>


Example 2:  Fade in a dom node with a custom duration
-----------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      function basicFadeoutSetup2(){
         //Function linked to the button to trigger the fade.
         function fadeIt() {
            dojo.style("basicFadeNode2", "opacity", "1");
            var fadeArgs = {
              node: "basicFadeNode2",
              duration: 5000,
            };
            dojo.fadeOut(fadeArgs).play();
         }
         dojo.connect(dijit.byId("basicFadeButton2"), "onClick", fadeIt);
      }
      dojo.addOnLoad(basicFadeoutSetup2);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicFadeButton2">Fade It Out Slow!</button>
    <div id="basicFadeNode2" style="width: 100px; height: 100px; background-color: red;"></div>



Example 3:  Fade in a dom node with an easing function
------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function basicFadeoutSetup3(){
         //Function linked to the button to trigger the fade.
         function fadeIt() {
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
      dojo.addOnLoad(basicFadeoutSetup3);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicFadeButton3">Fade It Out Slow with Expo Easing!</button>
    <div id="basicFadeNode3" style="width: 100px; height: 100px; background-color: red;"></div>

========
See Also
========

* `dojo/fadeIn <dojo/fadeIn>`_
* `Animation Quickstart <quickstart/Animation>`_
