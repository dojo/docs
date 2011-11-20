.. _dojox/fx:

dojox.fx
========

:Status: Draft
:Version: experimental
:Authors: Peter Higgins, Jonathan Bond-Caron, Shane O'Sullivan, Bryan Forbes

.. contents::
    :depth: 3

dojox.fx provides a class of animation effects to use, and other animation and Effects additions to dojo base.

Base Animations
---------------

These are the animations provided by calling ``dojo.require("dojox.fx");``

* :ref:`dojox.fx.wipeTo <dojox/fx/wipeTo>` - allows you to wipe a node to a specific height or width
* dojox.fx.sizeTo - animates a node about it's center to a defined width and height
* dojox.fx.slideBy - slide a node by a defined offset
* dojox.fx.crossFade - conveniently fade two nodes simultaneously
* dojox.fx.highlight - highlights a node for a short timespan
* dojox.fx.fadeTo - fade a node to a defined opacity

Additionally, dojox.fx includes the Dojo Core :ref:`animations <dojo/fx>`, and creates aliases to them in the dojox.fx namespace. For instance:

.. code-block :: javascript

  dojox.fx.fadeIn == dojo.fadeIn
  dojox.fx.chain == dojo.fx.chain

Additional FX
-------------

The DojoX FX project also contains additional functions, group by role.

* dojox.fx.scroll - Provides window and node scrolling animation: dojox.fx.smoothScroll
* dojox.fx.Shadow - An experimental cross-browser drop-shadow
* :ref:`dojox.fx.style <dojox/fx/style>` - An experimental API to animate the effects of adding, toggling, and removing class names from nodes.
 
  * dojox.fx.addClass
  * dojox.fx.removeClass
  * dojox.fx.toggleClass 

* dojox.fx.easing - **deprecated**, module moved to :ref:`dojo.fx.easing <dojo/fx/easing>` in Dojo 1.3
* dojox.fx.flip - An experimental simulated 3d effect API
* dojox.fx.split - A series of animations for breaking nodes into parts, and transitioning them
* dojox.fx.text - An extension of fx.split, which works exclusively on text nodes. 
* :ref:`dojox.fx.Timeline <dojox/fx/Timeline>` - An advanced *dojo._Line* replacement

NodeList Supplements
--------------------

A cross-namespace module which mixes all the Core dojox.fx animations into :ref:`dojo.NodeList <dojo/NodeList>` is available with the module:

.. code-block :: javascript

  dojo.require("dojox.fx.ext-dojo.NodeList");

This allows you to use :ref:`dojo.query <dojo/query>` to select groups of nodes and create animation instances from them.

Additionally, a module in dojox.fx also provides the dojox.fx.style APIs to :ref:`dojo.query <dojo/query>` as well:

.. code-block :: javascript
 
  dojo.require("dojox.fx.ext-dojo.NodeList-style");

Read more about CSS morphing at :ref:`dojox.fx.style docs <dojox/fx/style>`

Base Dojo Extensions
--------------------

A few modules mix into the :ref:`dojo <dojo/index>` namespace, as denoted by their module names:

* :ref:`dojox.fx.ext-dojo.complex <dojox/fx/ext-dojo/complex>`
* :ref:`dojox.fx.ext-dojo.reverse <dojox/fx/ext-dojo/reverse>`
