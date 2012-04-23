.. _dojo/dom-class:

==============
dojo/dom-class
==============

:Project owner:	Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 2

This module defines the core dojo DOM class API.  The standard return variable for this module is ``domClass``.

Features
========

AMD Features
------------

* :ref:`domClass.contains <dojo/hasClass>`

  Returns whether or not the specified classes are a portion of the class list currently applied to the node.

* :ref:`domClass.add <dojo/addClass>`

  Adds the specified classes to the end of the class list on the passed node. Will not re-apply duplicate classes.

* :ref:`domClass.remove <dojo/removeClass>`

  Removes the specified classes from node. No ``domClass.contains`` check is required.

* :ref:`domClass.replace <dojo/replaceClass>`

  Replaces one or more classes on a node if not present. Operates more quickly than calling ``domClass.remove`` and
  ``domClass.add``

* :ref:`domClass.toggle <dojo/toggleClass>`

  Adds a class to node if not present, or removes if present. Pass a boolean condition if you want to explicitly add or
  remove. Returns the condition that was specified directly or indirectly.

Legacy features are set in :ref:`dojo/_base/html <dojo/_base/html>`.

Examples
========

Here is an example of using ``domClass.contains`` to determine if a DOM node contains a particular class.

.. js ::

  require(["dojo/dom-class"], function(domClass){
    if (domClass.contains("someNode", "aSillyClassName")){
      console.log("someNode contains aSillyClassName");
    }else{
      console.log("someNode does not contain aSillyClassName");
    }
  });

See also
========

* :ref:`dojo/dom <dojo/dom>` - Core DOM API

* :ref:`dojo/dom-attr <dojo/dom-attr>` - Dojo DOM Attribute API

* :ref:`dojo/dom-prop <dojo/dom-prop>` - DOM Property API

* :ref:`dojo/dom-style <dojo/dom-style>` - DOM Style API

* :ref:`dojo/_base/html <dojo/_base/html>` - Legacy API aliases

.. api-link :: dojo.dom-class
