.. _dojox/fx:

========
dojox.fx
========

:Authors: Peter Higgins, Jonathan Bond-Caron, Shane O'Sullivan, Bryan Forbes

.. contents ::
    :depth: 2

dojox.fx provides a class of animation effects to use, and other animation and Effects additions to :ref:`Dojo FX <dojo/fx>`.

Base dojox.fx Animations
========================

These are the animations provided by calling ``dojo.require("dojox.fx");``

* :ref:`dojox.fx.wipeTo <dojox/fx/wipeTo>` - allows you to wipe a node to a specific height or width
* dojox.fx.sizeTo - animates a node about it's center to a defined width and height
* dojox.fx.slideBy - slide a node by a defined offset
* dojox.fx.crossFade - conveniently fade two nodes simultaneously
* dojox.fx.highlight - highlights a node for a short timespan
* dojox.fx.fadeTo - fade a node to a defined opacity

Additionally, dojox.fx includes the Dojo Core :ref:`animations <dojo/fx>`, and creates aliases to them in the dojox.fx namespace. For instance:

.. js ::

  dojox.fx.fadeIn == dojo.fadeIn
  dojox.fx.chain == dojo.fx.chain

Additional FX Modules
=====================

The ``dojox.fx`` project also contains additional modules, providing even more animation functions:

* dojox.fx.scroll - Provides window and node scrolling animation: dojox.fx.smoothScroll
* dojox.fx.Shadow - An experimental cross-browser drop-shadow
* :ref:`dojox.fx.style <dojox/fx/style>` - **experimental** API to animate the effects of adding, toggling, and removing class names from nodes.
 
  * dojox.fx.addClass
  * dojox.fx.removeClass
  * dojox.fx.toggleClass

* dojox.fx.flip - An experimental simulated 3d effect API
* dojox.fx.split - A series of animations for breaking nodes into parts, and transitioning them
* dojox.fx.text - An extension of fx.split, which works exclusively on text nodes.
* :ref:`dojox.fx.Timeline <dojox/fx/Timeline>` - An advanced *dojo._Line* replacement

NodeList Plugins
================

A cross-namespace module which mixes all the `base dojox.fx animations`_ into :ref:`dojo.NodeList <dojo/NodeList>` is available with the module ``dojox/fx/ext-dojo/NodeList``

.. js ::

    require(["dojo/query", "dojox/fx/ext-dojo/NodeList"], function(query){
        // ...
    })

This allows you to use :ref:`dojo.query <dojo/query>` to select groups of nodes and create animation instances from them. If you *only* want stock Dojo Core animations in your ``dojo.query`` lists, check out :ref:`dojo.NodeList-fx <dojo/NodeList-fx>`


Additionally, a module in dojox.fx also provides the :ref:`dojox.fx.style <dojox/fx/style>` APIs to :ref:`dojo.query <dojo/query>` as well:

.. js ::
 
  require(["dojox/fx/ext-dojo/NodeList-style"], function(){ });

Read more about CSS morphing at :ref:`dojox.fx.style docs <dojox/fx/style>`

Base Dojo Extensions
====================

A few modules mix into the :ref:`dojo <dojo/index>` namespace, as denoted by their module names:

* :ref:`dojox.fx.ext-dojo.complex <dojox/fx/ext-dojo/complex>`
* :ref:`dojox.fx.ext-dojo.reverse <dojox/fx/ext-dojo/reverse>`


See Also
========

* :ref:`Beginning dojo Animations <quickstart/Animation>`
