.. _dojo/fx/slideTo:

===============
dojo.fx.slideTo
===============

:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann, Jared Jurkiewicz
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, sjmiles
:since: V1.0

.. contents ::
    :depth: 2

This function is a helper function that wraps the :ref:`dojo.animateProperty <dojo/animateProperty>` function to provide an easy interface to sliding a node from its current position to a new position on the page.  While this can be done with the *dojo.animateProperty* function, this function is simpler to use and will handle 99% of the cases a slide of a node is desired.

**NOTE:** This function works best on absolutely positioned nodes.

Parameters
==========

The *dojo.fx.slideTo* function takes an object as its parameter.  This object defines what dom node to act on, how long the slide to should take (in milliseconds, and an optional easing function. All standard :ref:`dojo.Animation <dojo/Animation>` properties apply with the addition of two special properties for only *slideTo*:

:top:  The position to move the top corner of the node to in absolute pixels
:left:  The position to move the left corner for the node to, in absolute pixels.


Return value
============

The *dojo.fx.slideTo* function returns an instance of dojo._Animation.  To execute the slideTo, call the *play()* function on the animation.  This object can be used with other dojo animation functions, such as :ref:`dojo.fx.chain <dojo/fx/chain>` and :ref:`dojo.fx.combine <dojo/fx/combine>` to link it with other effects to perform complex animations.

Examples
========

Example 1:  Slide a dom node right 200 pixels.
----------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.Button");
      dojo.require("dojo.fx");
      function basicSlideToSetup(){
         // Function linked to the button to trigger the slide.
         function slideIt(amt){
            var slideArgs = {
              node: "basicNode",
              top: (dojo.marginBox("basicNode").t).toString(),
              left: (dojo.marginBox("basicNode").l + amt).toString(),
              unit: "px"
            };
            dojo.fx.slideTo(slideArgs).play();
         }
         dojo.connect(dijit.byId("slideRightButton"), "onClick", dojo.partial(slideIt, 200));
         dojo.connect(dijit.byId("slideLeftButton"), "onClick", dojo.partial(slideIt, -200));
      }
      dojo.ready(basicSlideToSetup);

  .. html ::

    <button data-dojo-type="dijit.form.Button" id="slideLeftButton">Slide It Left!</button><button data-dojo-type="dijit.form.Button" id="slideRightButton">Slide It Right!</button>
    <br>
    <br>
    <div style="width: 100%; height: 120px;">
      <div id="basicNode" style="width: 100px; height: 100px; background-color: red; position: absolute;"></div>
    </div>


See Also
========

* :ref:`dojo.fadeIn <dojo/fadeIn>`
* :ref:`dojo.fadeOut <dojo/fadeOut>`
* :ref:`dojo.fx.wipeIn <dojo/fx/wipeIn>`
* :ref:`dojo.fx.wipeOut <dojo/fx/wipeOut>`
* :ref:`dojo.fx.chain <dojo/fx/chain>`
* :ref:`dojo.fx.combine <dojo/fx/combine>`
* :ref:`Semi-complex chaining and combining of effects <dojo/fx/chainCombineExamples>`
* :ref:`dojo.animateProperty <dojo/animateProperty>`
* :ref:`Animation Quickstart <quickstart/Animation>`
