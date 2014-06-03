.. _dojo/_base/NodeList:

===================
dojo/_base/NodeList
===================

.. contents ::
    :depth: 2

``dojo/_base/NodeList`` extends ``NodeList`` with legacy API's for backwards compatability.

Those features are: ``connect()``, ``coords()``, ``blur()``, ``focus()``, ``change()``, ``click()``, ``error()``, ``keydown()``, ``keypress()``, ``keyup()``, ``load()``, ``mousedown()``, ``mouseenter()``, ``mouseleave()``, ``mousemove()``, ``mouseout()``, ``mouseover()``, ``mouseup()``, and ``submit()`` methods.

Usage
=====

As with the rest of ``dojo/_base`` modules, if you are running the Dojo loader in legacy mode (``async: false``) this 
module is automatically loaded.  Even if it is automatically loaded, you should require it in to have access to its 
features:

.. js ::

  require(["dojo/_base/NodeList"], function(){
    // Instances of NodeList will contain legacy features
  });

As stated above, these are legacy features and generally shouldn't be used for new development.
Utilising :ref:`dojo/query <dojo/query>` and the ``NodeList`` extension modules are more appropriate.  See:

* :ref:`NodeList <dojo/NodeList>` - The base NodeList supplied by ``dojo/query``.

* :ref:`dojo/NodeList-data <dojo/NodeList-data>` - Allows the association of arbitrary data with items of a ``NodeList``.

* :ref:`dojo/NodeList-dom <dojo/NodeList-dom>` - DOM related functions that are similar functionality to the ``dojo/dom-*`` related modules.

* :ref:`dojo/NodeList-fx <dojo/NodeList-fx>` - Adds base and core FX support to ``NodeList``.

* :ref:`dojo/NodeList-html <dojo/NodeList-html>` - Adds advanced content setting functionality.

* :ref:`dojo/NodeList-manipulate <dojo/NodeList-manipulate>` - Functions that allow for manipulation of DOM nodes in similar way to jQuery.

* :ref:`dojo/NodeList-traverse <dojo/NodeList-traverse>` - Advanced node traversal functions.
