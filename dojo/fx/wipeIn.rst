#format dojo_rst

dojo.wipeIn
===========

:Status: Draft
:Version: 1.0
:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann, Jared Jurkiewicz
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, sjmiles
:Available: since V1.0

.. contents::
    :depth: 2

This function is a helper function that wraps the `dojo.animateProperty <dojo/animateProperty>`_ function to provide an easy interface to wiping a node into view on the page.  While this can be done with the *dojo.animateProperty* function, this function is simpler to use and will handle 99% of the cases a wipe-in is desired.

==========
Parameters
==========

The *dojo.wipeIn* takes an object as its parameter.  This object defines what dom node to act on, how long the wipe in should take (in milliseconds, and an optional easing function.  As with all dojo apis, refer to the API docs for the most up to date information on parameters.  These are listed for convenience.

+-------------------------------+--------------------------------------------------------------------------------------------+
+**Parameter**                  |**Description**                                                                             |
+-------------------------------+--------------------------------------------------------------------------------------------+
| node                          |The domNode or node id to wipe in.                                                          |
|                               |                                                                                            |
|                               |**required**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+
| duration                      |How long, in milliseconds, should the wipe take.  The default is 2000 milliseconds          |
|                               |(2 seconds).                                                                                |
|                               |                                                                                            |
|                               |**optional**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+
| easing                        |An easing function to apply to the effect, such as exponential wipe in, bouncing wipe in,   |
|                               |etc.  Dojo provides a number of easing functions in module                                  |
|                               |`dojo.fx.easing <dojo/fx/easing>`_                                                          |
|                               |                                                                                            |
|                               |**optional**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+

============
Return value
============

The *dojo.wipeIn* function returns an instance of dojo._Animation.  To execute the wipeIn, call the *play()* function on the animation.  This object can be used with other dojo animation functions, such as `dojo.fx.chain <dojo/fx/chain>`_ and `dojo.fx.combine <dojo/fx/combine>`_ to link it with other effects to perform complex animations.

========
Examples
========

Example 1:  wipe in a dom node
------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      function basicWipeinSetup(){
         //Style the dom node to opacity 0;
         dojo.style("basicWipeNode", "display", "none");

         //Function linked to the button to trigger the fade.
         function wipeIt() {
            dojo.style("basicWipeNode", "display", "none");
            var wipeArgs = {
              node: "basicWipeNode"
            };
            console.log("Calling wipein");
            dojo.wipeIn(wipeArgs).play();
         }
         dojo.connect(dijit.byId("basicWipeButton"), "onClick", wipeIt);
      }
      dojo.addOnLoad(basicWipeinSetup);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicWipeButton">Wipe It In!</button>
    <div id="basicWipeNode" style="width: 100px; background-color: red;">
      This is a container of random content to wipe in!
    </div>


Example 2:  Fade in a dom node with a custom duration
-----------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      function basicFadeinSetup2(){
         //Style the dom node to opacity 0;
         dojo.style("basicFadeNode2", "opacity", "0");

         //Function linked to the button to trigger the fade.
         function fadeIt() {
            dojo.style("basicFadeNode2", "opacity", "0");
            var fadeArgs = {
              node: "basicFadeNode2",
              duration: 10000,
            };
            dojo.fadeIn(fadeArgs).play();
         }
         dojo.connect(dijit.byId("basicFadeButton2"), "onClick", fadeIt);
      }
      dojo.addOnLoad(basicFadeinSetup2);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicFadeButton2">Fade It In Slow!</button>
    <div id="basicFadeNode2" style="width: 100px; height: 100px; background-color: red;"></div>



Example 3:  Fade in a dom node with an easing function
------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx.easing");
      function basicFadeinSetup3(){
         //Style the dom node to opacity 0;
         dojo.style("basicFadeNode3", "opacity", "0");

         //Function linked to the button to trigger the fade.
         function fadeIt() {
            dojo.style("basicFadeNode3", "opacity", "0");
            var fadeArgs = {
              node: "basicFadeNode3",
              duration: 10000,
              easing: dojo.fx.easing.expoOut
            };
            dojo.fadeIn(fadeArgs).play();
         }
         dojo.connect(dijit.byId("basicFadeButton3"), "onClick", fadeIt);
      }
      dojo.addOnLoad(basicFadeinSetup3);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicFadeButton3">Fade It In Slow with Expo Easing!</button>
    <div id="basicFadeNode3" style="width: 100px; height: 100px; background-color: red;"></div>

========
See Also
========

* `dojo/fadeOut <dojo/fadeOut>`_
* `Animation Quickstart <quickstart/Animation>`_
