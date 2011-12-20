.. _dojo/fx/wipeIn:

==============
dojo.fx.wipeIn
==============

:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann, Jared Jurkiewicz
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, sjmiles
:since: V1.0

.. contents ::
    :depth: 2

This function is a helper function that wraps the :ref:`dojo.animateProperty <dojo/animateProperty>` function to provide an easy interface to wiping a node into view on the page.  While this can be done with the *dojo.animateProperty* function, this function is simpler to use and will handle 99% of the cases a wipe-in is desired.

**NOTE:** The wipe end wipes from a height of 0px to the full height of the target dom node.

Parameters
==========

The *dojo.fx.wipeIn* function takes an object as its parameter.  This object defines what dom node to act on, how long the wipe in should take (in milliseconds, and an optional easing function. All standard :ref:`dojo.Animation <dojo/Animation>` parameters and events apply to this function, with no additional properties included.

Return value
============

The *dojo.fx.wipeIn* function returns an instance of dojo._Animation.  To execute the wipeIn, call the *play()* function on the animation.  This object can be used with other dojo animation functions, such as :ref:`dojo.fx.chain <dojo/fx/chain>` and :ref:`dojo.fx.combine <dojo/fx/combine>` to link it with other effects to perform complex animations.

Examples
========

Example 1:  Wipe in a dom node
------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx");
      function basicWipeinSetup(){
         // Function linked to the button to trigger the wipe.
         function wipeIt(){
            dojo.style("basicWipeNode", "display", "none");
            var wipeArgs = {
              node: "basicWipeNode"
            };
            dojo.fx.wipeIn(wipeArgs).play();
         }
         dojo.connect(dijit.byId("basicWipeButton"), "onClick", wipeIt);
      }
      dojo.ready(basicWipeinSetup);

  .. html ::

    <button data-dojo-type="dijit.form.Button" id="basicWipeButton">Wipe It In!</button>
    <div id="basicWipeNode" style="width: 200px; background-color: red; display: none;">
      <b>This is a container of random content to wipe in!</b>
    </div>


Example 2:  Wipe in a dom node with a custom duration
-----------------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx");
      function basicWipeinSetup1(){
         // Function linked to the button to trigger the wipe.
         function wipeIt(){
            dojo.style("basicWipeNode1", "display", "none");
            var wipeArgs = {
              node: "basicWipeNode1",
              duration: 5000
            };
            dojo.fx.wipeIn(wipeArgs).play();
         }
         dojo.connect(dijit.byId("basicWipeButton1"), "onClick", wipeIt);
      }
      dojo.ready(basicWipeinSetup1);

  .. html ::

    <button data-dojo-type="dijit.form.Button" id="basicWipeButton1">Wipe It In!</button>
    <div id="basicWipeNode1" style="width: 200px; background-color: red; display: none;">
      <b>This is a container of random content to wipe in slowly!</b>
    </div>



Example 3:  Wipe in a dom node with an easing function
------------------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx");
      dojo.require("dojo.fx.easing");
      function basicWipeinSetup2(){
         // Function linked to the button to trigger the wipe.
         function wipeIt(){
            dojo.style("basicWipeNode2", "display", "none");
            var wipeArgs = {
              node: "basicWipeNode2",
              duration: 5000,
              easing: dojo.fx.easing.expoOut
            };
            dojo.fx.wipeIn(wipeArgs).play();
         }
         dojo.connect(dijit.byId("basicWipeButton2"), "onClick", wipeIt);
      }
      dojo.ready(basicWipeinSetup2);

  .. html ::

    <button data-dojo-type="dijit.form.Button" id="basicWipeButton2">Wipe It In!</button>
    <div id="basicWipeNode2" style="width: 200px; background-color: red; display: none;">
      <b>This is a container of random content to wipe in slowly with the expoOut easing!</b>
    </div>

See Also
========

* :ref:`dojo.fx.wipeOut <dojo/fx/wipeOut>`
* :ref:`dojo.animateProperty <dojo/animateProperty>`
* :ref:`Animation Quickstart <quickstart/Animation>`
