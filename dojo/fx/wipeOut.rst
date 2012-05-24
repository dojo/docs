.. _dojo/fx/wipeOut:

==================
dojo/fx::wipeOut()
==================

:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann, Jared Jurkiewicz
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, 
             sjmiles
:since: V1.0

.. contents ::
    :depth: 2

This function is a helper function that wraps the :ref:`dojo/_base/fx::animateProperty() <dojo/_base/fx#animateproperty>` function to provide an easy interface to wiping a node out of view on the page. While 
this can be done with the ``animateProperty()`` function, this function is simpler to use and will handle 99% of the 
cases a wipe-out is desired.

**NOTE:** The wipe end wipes from the full height of the target DOMNode to a height of ``0px``.

Usage
=====

Basic usage requires just the node to be wiped-out to be passed:

.. js ::

  require(["dojo/fx"], function(coreFx){
    coreFx.wipeOut({
      node: "someNode"
    }).play();
  });

The function configuration hash can take the other properties of `dojo/_base/fx::animateProperty() <dojo/_base/fx#animateproperty>`.

The ``wipeOut()`` function returns an instance of :ref:`dojo/_base/fx::Animation <dojo/_base/fx#animation>`. To start
the wipe-out, call the ``play()`` function on the Animation. This object can be used with other Dojo animation
functions, such as :ref:`dojo/fx::chain() <dojo/fx/chain>` and :ref:`dojo/fx::combine() <dojo/fx/combine>` to link it
with other effects to perform complex animations.

Examples
========

.. code-example ::

  This example does a simple wipe-out of a DOMNode.

  .. js ::

    require(["dojo/fx", "dojo/dom", "dojo/dom-style", "dojo/on", "dojo/domReady!"],
    function(coreFx, dom, style, on){
      on(dom.byId("basicWipeButton"), "click", function(){
        style.set("basicWipeNode", {
          height: "",
          display: "block"
        })
        coreFx.wipeOut({
          node: "basicWipeNode"
        }).play();
      });
    });

  .. html ::

    <button type="button" id="basicWipeButton">Wipe It Out!</button>
    <div id="basicWipeNode" style="width: 200px; background-color: red;">
      <b>This is a container of random content to wipe out!</b>
    </div>

.. code-example ::

  This example adds a custom duration to the wipe-out animation
  
  .. js ::

    require(["dojo/fx", "dojo/dom", "dojo/dom-style", "dojo/on", "dojo/domReady!"],
    function(coreFx, dom, style, on){
      on(dom.byId("basicWipeButton1"), "click", function(){
        style.set("basicWipeNode1", {
          height: "",
          display: "block"
        });
        coreFx.wipeOut({
          node: "basicWipeNode1",
          duration: 5000
        }).play();
      });
    });

  .. html ::

    <button type="button" id="basicWipeButton1">Wipe It Out!</button>
    <div id="basicWipeNode1" style="width: 200px; background-color: red;">
      <b>This is a container of random content to wipe out slowly!</b>
    </div>

.. code-example ::

  Wipe-out a node with an :ref:`easing <dojo/fx/easing>` function.

  .. js ::

    require(["dojo/fx", "dojo/fx/easing", "dojo/dom", "dojo/dom-style", "dojo/on", "dojo/domReady!"],
    function(coreFx, easing, dom, style, on){
      on(dom.byId("basicWipeButton2"), "click", function(){
        style.set("basicWipeNode2", {
          height: "",
          display: "block"
        });
        coreFx.wipeOut({
          node: "basicWipeNode2",
          duration: 5000,
          easing: easing.expoOut
        }).play();
      });
    });

  .. html ::

    <button type="button" id="basicWipeButton2">Wipe It Out!</button>
    <div id="basicWipeNode2" style="width: 200px; background-color: red;">
      <b>This is a container of random content to wipe out slowly with the expoOut easing!</b>
    </div>

See Also
========

* :ref:`dojo/fx::wipeIn() <dojo/fx/wipeIn>` - The companion to ``wipeOut()``

* :ref:`dojo/_base/fx::animateProperty() <dojo/_base/fx#animateproperty>` - Details around the other options possible

* `Animation Tutorial <http://dojotoolkit.org/documentation/tutorials/1.7/animation/>`_ - The tutorial to find out about
  Dojo's FX API
