.. _dojox/fx/style:

==============
dojox.fx.style
==============

:Project owner: Peter Higgins
:since: v1.2

.. contents ::
   :depth: 2

This module provides Animated CSS class transitions for nodes, or in other words: will animate the effects of adding, removing, or toggling a class name on a node.

Usage
=====

These API's are identical to their plain Dojo counterparts: :ref:`dojo.addClass <dojo/addClass>`, :ref:`dojo.removeClass <dojo/removeClass>`, :ref:`dojo.toggleClass <dojo/toggleClass>`, though they return an instance of a dojo.Animation, and require you to call .play()

.. js ::

   dojo.require("dojox.fx.style");
   dojo.ready(function(){

       // remove class="bar" from node id="foo"
       dojox.fx.removeClass("foo", "bar").play();

       // add the class="bar" to node id="baz"
       dojox.fx.addClass("baz", "bar").play();

       // toggle the class "bar" on id="bamm"
       dojox.fx.toggleClass("bamm", "bar").play();

   });

Additionally, you can pass in an animation "magic arg", defining additional properties for the animation (such as duration: easing: rate: ... ). This is passed as the third parameter to removeClass and addClass:

.. js ::
  
    dojox.fx.addClass("baz", "bar", {
        duration:5000, onEnd: function(node){ console.log("we're done with", node) }
    }).play();

The only variation here is toggleClass, whose third parameter can be used to force adding or removing (just as :ref:`dojo.toggleClass <dojo/toggleClass>` does). In this case, you need to pass undefined value in third position, and the animation arg object in the fourth:

.. js ::
  
    dojox.fx.toggleClass("bar", "baz", undefined, {
        duration:1500, easing: dojo.fx.easing.backOut
    }).play();

The returns of these functions can be applied to a :ref:`dojo.fx.combine <dojo/fx/combine>` or :ref:`chain <dojo/fx/chain>` call.

NodeList Morphing
=================

An ext-dojo module exists for these functions as well. They can be included into :ref:`dojo.NodeList <dojo/NodeList>` by requiring the appropriate module:

.. js ::
  
  dojo.require("dojox.fx.ext-dojo.NodeList-style");

This allows you to use these functions automatically with :ref:`dojo.query <dojo/query>`, though to not conflict with dojo.query's own .addClass, .removeClass, and .toggleClass, these functions are suffixed with "Fx": .addClassFx, .removeClassFx, and .toggleClassFx respectively.

.. js ::
  
  dojo.query("li.bar").addClassFx("baz").play();
  dojo.query("a.featured").removeClassFx("featured").play();
  dojo.query("a.bizam").toggleClassFx("aClass").play();

The node is assumed, and omitted from the parameters. An Animation "magic arg" can be mixed in after the classname in these functions as well.
