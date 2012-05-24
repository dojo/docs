.. _dojo/fx/slideTo:

==================
dojo/fx::slideTo()
==================

:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann, Jared Jurkiewicz
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, 
             sjmiles
:since: V1.0

.. contents ::
    :depth: 2

This function is a helper function that wraps the :ref:`dojo/_base/fx::animateProperty() <dojo/_base/fx#animateproperty>` function to provide an easy interface to sliding a node from its current position to a
new position on the page. While this can be done with the ``animateProperty()`` function, this function is simpler to
use and will handle 99% of the cases a wipe-out is desired.

**NOTE:** This function works best on absolutely positioned nodes.

Usage
=====

Basic usage requires the node being moved, the ``top`` and ``left`` coordinates and the ``unit``\s:

.. js ::

  require(["dojo/fx"], function(coreFx){
    coreFx.slideTo({
      node: "someNode",
      top: "40",
      left: "50",
      units: "px"
    }).play();
  });

The function configuration hash can take the other properties of `dojo/_base/fx::animateProperty() <dojo/_base/fx#animateproperty>`.

The ``slideTo()`` function returns an instance of :ref:`dojo/_base/fx::Animation <dojo/_base/fx#animation>`. To start
the slide, call the ``.play()`` function on the Animation. This object can be used with other Dojo animation
functions, such as :ref:`dojo/fx::chain() <dojo/fx/chain>` and :ref:`dojo/fx::combine() <dojo/fx/combine>` to link it
with other effects to perform complex animations.

Examples
========

.. code-example ::

  This example allows you to slide a node to the left or the right by 200 pixels.
  
  .. js ::
  
    require(["dojo/fx", "dojo/dom", "dojo/dom-geometry", "dojo/on", "dojo/domReady!"],
    function(coreFx, dom, domGeom, on){
      
      function slideIt(amt){
        coreFx.slideTo({
          node: "basicNode",
          top: domGeom.getMarginBox("basicNode").t.toString(),
          left: (domGeom.getMarginBox("basicNode").l + amt).toString(),
          unit: "px"
        }).play();
      }
    
      on(dom.byId("slideRightButton"), "click", function(){
        slideIt(200);
      });
      on(dom.byId("slideLeftButton"), "click", function(){
        slideIt(-200);
      });
    });

  .. html ::

    <button type="button" id="slideLeftButton">Slide It Left!</button>
    <button type="button" id="slideRightButton">Slide It Right!</button>
    <br />
    <br />
    <div style="width: 100%; height: 120px;">
      <div id="basicNode" style="width: 100px; height: 100px; background-color: red; position: absolute;"></div>
    </div>

See Also
========

* :ref:`dojo/fx <dojo/fx>` - Overview of the core Dojo FX API

* :ref:`dojo/_base/fx::animateProperty() <dojo/_base/fx#animateproperty>` - Details around the other options possible

* `Animation Tutorial <http://dojotoolkit.org/documentation/tutorials/1.7/animation/>`_ - The tutorial to find out about
  Dojo's FX API

