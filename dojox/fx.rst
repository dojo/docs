#format dojo_rst

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

* `dojox.fx.wipeTo <dojox/fx/wipeTo>`_ - allows you to wipe a node to a specific height or width
* dojox.fx.sizeTo - animates a node about it's center to a defined width and height
* dojox.fx.slideBy - slide a node by a defined offset
* dojox.fx.crossFade - conveniently fade two nodes simultaneously
* dojox.fx.highlight - highlights a node for a short timespan
* dojox.fx.fadeTo - fade a node to a defined opacity

Additionally, dojox.fx requires the Dojo Core `animations <dojo/fx>`_, and creates aliases to them in the dojox.fx namespace. For instance:

.. code-block :: javascript

  dojox.fx.fadeIn == dojo.fadeIn
  dojox.fx.chain == dojo.fx.chain

Additional FX
-------------

The DojoX FX project also contains additional functions, group by role.

* dojox.fx.scroll - Provides window and node scrolling animation: dojox.fx.smoothScroll
* dojox.fx.Shadow - An experimental cross-browser drop-shadow
* dojox.fx.style - An experimental API to animate the effects of adding, toggling, and removing class names from nodes.
