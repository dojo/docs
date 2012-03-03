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

Legacy Features
---------------

* :ref:`dojo.hasClass <dojo/hasClass>`

* :ref:`dojo.addClass <dojo/addClass>`

* :ref:`dojo.removeClass <dojo/removeClass>`

* :ref:`dojo.replaceClass <dojo/replaceClass>`

* :ref:`dojo.toggleClass <dojo/toggleClass>`

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

.. api-link :: dojo.dom-class
