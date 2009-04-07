#format dojo_rst

dojo.fx.slideTo
===============

:Status: Draft
:Version: 1.0
:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann, Jared Jurkiewicz
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, sjmiles
:Available: since V1.0

.. contents::
    :depth: 2

This function is a helper function that wraps the `dojo.animateProperty <dojo/animateProperty>`_ function to provide an easy interface to sliding a node from its current position to a new position on the page.  While this can be done with the *dojo.animateProperty* function, this function is simpler to use and will handle 99% of the cases a slide of a node is desired.

**NOTE:** This function works best on absolutlely positioned nodes.

==========
Parameters
==========

The *dojo.fx.wipeIn* takes an object as its parameter.  This object defines what dom node to act on, how long the wipe in should take (in milliseconds, and an optional easing function.  As with all dojo apis, refer to the API docs for the most up to date information on parameters.  These are listed for convenience.

+-------------------------------+--------------------------------------------------------------------------------------------+
+**Parameter**                  |**Description**                                                                             |
+-------------------------------+--------------------------------------------------------------------------------------------+
| node                          |The domNode or node id to wipe in.                                                          |
|                               |                                                                                            |
|                               |**required**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+
| top                           |The position to move the top corner of the node to in absolute pixels                       |
|                               |                                                                                            |
|                               |**optional**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+
| left                          |The position to move the left corner of the node to, in absolute pixels.                    |
|                               |                                                                                            |
|                               |**optional**                                                                                |
+-------------------------------+--------------------------------------------------------------------------------------------+
| duration                      |How long, in milliseconds, should the wipe take.  The default is 350 milliseconds           |
|                               |(.3 seconds).                                                                               |
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

The *dojo.fx.slideTo* function returns an instance of dojo._Animation.  To execute the slideTo, call the *play()* function on the animation.  This object can be used with other dojo animation functions, such as `dojo.fx.chain <dojo/fx/chain>`_ and `dojo.fx.combine <dojo/fx/combine>`_ to link it with other effects to perform complex animations.

========
Examples
========

Example 1:  Slide a dom node right 200 pixels.
----------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx");
      function basicSlideToSetup(){
         //Function linked to the button to trigger the wipe.
         function slideIt() {
            var slideArgs = {
              node: "basicNode",
              top: (dojo.coords("basicNode").t).toString(),
              left: (dojo.coords("basicNode").l + 200).toString(),
              unit: "px"
            };
            console.debug(slideArgs);
            dojo.fx.slideTo(slideArgs).play();
         }
         dojo.connect(dijit.byId("basicSlideButton"), "onClick", slideIt);
      }
      dojo.addOnLoad(basicSlideToSetup);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="basicSlideButton">Slide It Right!</button>
    <div style="width: 100%; height: 120px;">
      <div id="basicNode" style="width: 100px; height: 100px; background-color: red; position: absolute;"></div>
    </div>


========
See Also
========

* `dojo.fadeIn <dojo/fadeIn>`_
* `dojo.fadeOut <dojo/fadeOut>`_
* `dojo.fx.wipeIn <dojo/fx/wipeIn>`_
* `dojo.fx.wipeOut <dojo/fx/wipeOut>`_
* `dojo.fx.chain <dojo/fx/chain>`_
* `dojo.fx.combine <dojo/fx/combine>`_
* `dojo.animateProperty <dojo/animateProperty>`_
* `Animation Quickstart <quickstart/Animation>`_
