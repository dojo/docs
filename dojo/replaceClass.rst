.. _dojo/replaceClass:

=================
dojo.replaceClass
=================

.. contents ::
   :depth: 2

Removes a class or a list of classes from a DOM node.

Introduction
============

Replaces one or more classes on a node if not present. Operates more quickly than calling dojo.removeClass and dojo.addClass.

Since Dojo 1.7, ``dojo.replaceClass`` is exposed via the ``replace()`` method of the :ref:`dojo/dom-class <dojo/dom-class>` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

The function takes up to three arguments:

1. A DOM node or its node id (as a string).
2. A String class name to add, or several space-separated class names, or an array of class names.
3. A String class name to remove, or several space-separated class names, or an array of class names.

Dojo 1.7+ (AMD)
---------------

When using AMD format in a fully baseless application, ``replace`` is accessed from the ``dojo/dom-class`` module.

.. js ::

  require(["dojo/dom-class"], function(domClass){
      domClass.replace("someNode", "add1 add2", "remove1 remove2");
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.replaceClass`` in the ``define`` or ``require`` callback:

.. js ::

  require(["dojo"], function(dojo){
      dojo.replaceClass("someNode", "add1 add2", "remove1 remove2");
  });

Dojo < 1.7
----------

.. js ::

    dojo.replaceClass("someNode", "add1 add2", "remove1 remove2");

Examples
========

Replace all classes
-------------------

The following example replace all classes with addMe :

.. js ::

  // dojo 1.7+ (AMD)
  require(["dojo/dom-class"], function(domClass){
      domClass.replace("someNode", "addMe");
  });

  // dojo < 1.7
  dojo.replaceClass("someNode", "addMe");

Available in `dojo.NodeList()` for multiple toggles
---------------------------------------------------

.. js ::

  // dojo 1.7+ (AMD)
  require(["dojo/query", "dojo/NodeList-dom"], function(query){
      query(".findMe").replaceClass("addMe", "removeMe");
  });

  // dojo < 1.7
  dojo.query(".findMe").replaceClass("addMe", "removeMe");

See also
========

* :ref:`dojo.addClass <dojo/addClass>`
* :ref:`dojo.removeClass <dojo/removeClass>`
* :ref:`dojo.hasClass <dojo/hasClass>`
* :ref:`dojo.toggleClass <dojo/toggleClass>`
