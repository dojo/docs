#format dojo_rst

dojox.fx.style
==============

:Status: Draft
:Version: 1.4
:Project owner: Peter Higgins
:Available: since v1.2

.. contents::
   :depth: 2

This module provides Animated CSS class transisitons for nodes, or in other words: will animate the effects of adding, removing, or toggling a class name on a node.

=====
Usage
=====

These API's are identical to their plain Dojo counterparts: `dojo.addClass <dojo/addClass>`_, `dojo.removeClass <dojo/removeClass>`_, dojo.toggleClass <dojo/toggleClass>`_ , though they return an instance of a dojo.Animation, and require you to call .play()

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   dojo.require("dojox.fx.style");
   dojo.addOnLoad(function(){

       // remove class="bar" from node id="foo"
       dojox.fx.removeClass("foo", "bar").play();

       // add the class="bar" to node id="baz"
       dojox.fx.addClass("baz", "bar").play();

       // toggle the class "bar" on id="bamm"
       dojox.fx.toggleClass("bamm", "bar").play();

   });
 </script>

Additionally, you can pass in an animation "magic arg", defining additional properties for the animation (such as duration: easing: rate: ... ). This is passed as the third parameter to removeClass and addClass:

.. code-block :: javascript
  :linenos:

    dojox.fx.addClass("baz", "bar", {
        duration:5000, onEnd: function(node){ console.log("we're done with", node) }
    }).play();

The only variation here is toggleClass, whose third parameter can be used to force adding or removing (just as `dojo.toggleClass <dojo/toggleClass>`_ does). In this case, you need to pass undefined value in third position, and the animation arg object in the fourth:

.. code-block :: javascript
  :linenos:

    dojox.fx.toggleClass("bar", "baz", undefined, {
        duration:1500, easing: dojo.fx.easing.backOut
    }).play();

The returns of these functions can be applied to a `dojo.fx.combine <dojo/fx/combine>`_ or `chain <dojo/fx/chain>`_ call.

=================
NodeList Morphing
=================

An ext-dojo module exists for these functions as well. They can be included into `dojo.NodeList <dojo/NodeList>`_ by requiring the appropriate module:

.. code-block :: javascript 
  :linenos:

  dojo.require("dojox.fx.ext-dojo.NodeList-style");

This allows you to use these functions automatically with `dojo.query <dojo/query>`_, though to not conflict with dojo.query's own .addClass, .removeClass, and .toggleClass, these functions are suffixed with "Fx": .addClassFx, .removeClassFx, and .toggleClassFx respectively.

.. code-block :: javascript
  :linenos:

  dojo.query("li.bar").addClassFx("baz").play();
  dojo.query("a.featured").removeClassFx("featured").play();
  dojo.query("a.bizam").toggleClassFx("aClass").play();

The node is assumed, and omitted from the parameters. An Animation "magic arg" can be mixed in after the classname in these functions as well.
