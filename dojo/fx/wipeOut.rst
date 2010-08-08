#format dojo_rst

dojo.fx.wipeOut
===============

:Status: Draft
:Version: 1.0
:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann, Jared Jurkiewicz
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, sjmiles
:Available: since V1.0

.. contents::
    :depth: 2

This function is a helper function that wraps the `dojo.animateProperty <dojo/animateProperty>`_ function to provide an easy interface to wiping a node out of view on the page.  While this can be done with the *dojo.animateProperty* function, this function is simpler to use and will handle 99% of the cases a wipe-out is desired.

**NOTE:** The wipe end wipes from a height of 0px to the full height of the target dom node.

==========
Parameters
==========

The *dojo.fx.wipeOut* takes an object as its parameter.  This object defines what dom node to act on, how long the wipe out should take (in milliseconds, and an optional easing function.  All standard `dojo.Animation <dojo/Animation>`_ events and parameters apply, with no custom additions for this function.

============
Return value
============

The *dojo.fx.wipeOut* function returns an instance of dojo._Animation.  To execute the wipeOut, call the *play()* function on the animation.  This object can be used with other dojo animation functions, such as `dojo.fx.chain <dojo/fx/chain>`_ and `dojo.fx.combine <dojo/fx/combine>`_ to link it with other effects to perform complex animations.

========
Examples
========

Example 1:  Wipe out a dom node
-------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx");
      function basicWipeinSetup(){
         //Function linked to the button to trigger the wipe.
         function wipeIt() {
			dojo.style("basicWipeNode", "height", "");
			dojo.style("basicWipeNode", "display", "block");
            var wipeArgs = {
              node: "basicWipeNode"
            };
            dojo.fx.wipeOut(wipeArgs).play();
         }
         dojo.connect(dijit.byId("basicWipeButton"), "onClick", wipeIt);
      }
      dojo.addOnLoad(basicWipeinSetup);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicWipeButton">Wipe It Out!</button>
    <div id="basicWipeNode" style="width: 200px; background-color: red;">
      <b>This is a container of random content to wipe out!</b>
    </div>


Example 2:  Wipe out a dom node with a custom duration
------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx");
      function basicWipeinSetup1(){
         //Function linked to the button to trigger the wipe.
         function wipeIt() {
			 dojo.style("basicWipeNode1", "height", "");
			 dojo.style("basicWipeNode1", "display", "block");
            var wipeArgs = {
              node: "basicWipeNode1",
              duration: 5000
            };
            dojo.fx.wipeOut(wipeArgs).play();
         }
         dojo.connect(dijit.byId("basicWipeButton1"), "onClick", wipeIt);
      }
      dojo.addOnLoad(basicWipeinSetup1);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicWipeButton1">Wipe It Out!</button>
    <div id="basicWipeNode1" style="width: 200px; background-color: red;">
      <b>This is a container of random content to wipe out slowly!</b>
    </div>



Example 3:  Wipe out a dom node with an easing function
-------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx");
      dojo.require("dojo.fx.easing");
      function basicWipeinSetup2(){
         //Function linked to the button to trigger the wipe.
         function wipeIt() {
			 dojo.style("basicWipeNode2", "height", "");
			 dojo.style("basicWipeNode2", "display", "block");
            var wipeArgs = {
              node: "basicWipeNode2",
              duration: 5000,
              easing: dojo.fx.easing.expoOut
            };
            dojo.fx.wipeOut(wipeArgs).play();
         }
         dojo.connect(dijit.byId("basicWipeButton2"), "onClick", wipeIt);
      }
      dojo.addOnLoad(basicWipeinSetup2);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicWipeButton2">Wipe It Out!</button>
    <div id="basicWipeNode2" style="width: 200px; background-color: red;">
      <b>This is a container of random content to wipe out slowly with the expoOut easing!</b>
    </div>

========
See Also
========

* `dojo.fx.wipeIn <dojo/fx/wipeIn>`_
* `dojo.animateProperty <dojo/animateProperty>`_
* `Animation Quickstart <quickstart/Animation>`_
