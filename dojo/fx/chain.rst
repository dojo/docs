.. _dojo/fx/chain:

================
dojo/fx::chain()
================

:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann, Jared Jurkiewicz
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, 
             sjmiles
:since: v1.0

.. contents ::
    :depth: 2

**dojo/fx::chain()** is a helper function that can take a list of :ref:`dojo/_base/fx::Animation <dojo/_base/fx#animation>` objects and combine them so that their effects run sequentially. With this function
animations that affect multiple nodes can be generated and executed with a single call.

Usage
=====

To use ``dojo/fx::chain()`` pass it an array of ``dojo/_base/fx::Animation`` objects:

.. js ::

  require(["dojo/fx"], function(coreFx){
    var animA = coreFx.wipeIn({
      node: "someNode"
    });
    var animB = coreFx.wipeOut({
      node: "someNode"
    });
    
    coreFx.chain([animA, animB]).play();
  });

``.chain()`` returns another instance of Animation that can be used to control the chained Animation.

Examples
========

.. code-example ::

  This example fades and wipes in two DOM nodes sequentially.

  .. js ::

    require(["dojo/fx", "dojo/_base/fx", "dojo/dom", "dojo/dom-style", "dojo/on", "dojo/domReady!"],
    function(coreFx, baseFx, dom, style, on){
      style.set("basicNode1", "opacity", "0");
      style.set("basicNode2", "height", "0px");
      
      on(dom.byId("basicButton"), "click", function(){
        style.set("basicNode1", "opacity", "0");
        style.set("basicNode2", "height", "0px");
        style.set("basicNode2", "display", "none");
        coreFx.chain([
          baseFx.fadeIn({
            node: "basicNode1",
            duration: 2000
          }),
          coreFx.wipeIn({
            node: "basicNode2",
            duration: 2000
          })
        ]).play();
      });
    });

  .. html ::

    <button type="button" id="basicButton">Fade and Wipe in Nodes!!</button>
    <div id="basicNode1" style="width: 100px; height: 100px; background-color: red;"></div>
    <br />
    <div id="basicNode2" style="width: 100px; background-color: green; display: none;">
      <b>Some random text in a node to wipe in.</b>
    </div>

See Also
========

* :ref:`dojo/fx <dojo/fx>` - Overview of the core Dojo FX API

* :ref:`dojo/fx::combine() <dojo/fx/combine>` - A helper function that combines animations.

* :ref:`dojo/_base/fx::animateProperty() <dojo/_base/fx#animateproperty>` - Details around the other options possible

* `Animation Tutorial <http://dojotoolkit.org/documentation/tutorials/1.7/animation/>`_ - The tutorial to find out about
  Dojo's FX API
