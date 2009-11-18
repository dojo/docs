#format dojo_rst

dojo.removeClass
================

:Status: Final
:Version: 1.0
:Project owner: Eugene Lazutkin
:Available: since 0.9

.. contents::
   :depth: 2

Removes a class or a list of classes from a DOM node.

============
Introduction
============

Follows the same pattern as most Dojo functionality by accepting a string ID of a Node, or a DOM Node reference, removing a passed class from the class="" attribute.

=====
Usage
=====

The function takes up to two arguments:

1. A DOM node or its node id (as a string).
2. Optional. A string, which can list classes separated by spaces, or an array of CSS classes as strings. In the latter case array elements cannot contain spaces.

If the second argument is not specified or ``undefined``, all classes will be removed.

Space-separated classes, arrays, and optional removing of all classes are supported since 1.4.

.. code-block :: javascript
  :linenos:

  dojo.removeClass("someNode","removedClass");

  var node = dojo.byId("someNode").parentNode;
  dojo.removeClass(node, "someClass");

  dojo.removeClass(node, "someClass2 someClass3");
  dojo.removeClass(node, ["someClass4", "someClass5"]);
  dojo.removeClass(node);


You can also use removeClass as a dojo.query chain:

.. code-block :: javascript
  :linenos:

  dojo.query(".someSelector").removeClass("someClass");

The example above will remove ``class="someClass"`` from all nodes that have ``class="someSelector"``, if the node already has the class.


========
See also
========

* `dojo.addClass <dojo/addClass>`_
* `dojo.hasClass <dojo/hasClass>`_
* `dojo.toggleClass <dojo/toggleClass>`_
