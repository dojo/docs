#format dojo_rst

dojo.addClass
=============

:Status: Final
:Version: 1.0
:Project owner: Eugene Lazutkin
:Available: since 0.9

.. contents::
   :depth: 2

Safely adds a CSS class or a set of classes to a node avoiding duplications.

=====
Usage
=====

The function takes two arguments:

1. A DOM node or its node id (as a string).
2. A string, which can list classes separated by spaces, or an array of CSS classes as strings. In the latter case array elements cannot contain spaces.

.. code-block :: javascript
  :linenos:

  dojo.addClass("someNode", "someClass");
  dojo.addClass("someNode", "someClass class1 class2");

  var node = dojo.byId("someNode").parentNode;
  dojo.addClass(node, "someClass");
  dojo.addClass(node, "someClass2 someClass3");
  dojo.addClass(node, ["someClass4", "someClass5"]);  // Adding classes using array is new in 1.4

When using ``addClass`` with `dojo.query <dojo/query>`_, the node parameter is omitted:

.. code-block :: javascript
  :linenos:

  dojo.query(".randomClass").addClass("anotherClass");

will find all the nodes with `class="randomClass"` and add "anotherClass" to the class attribute.

========
See also
========

* `dojo.hasClass <dojo/hasClass>`_
* `dojo.removeClass <dojo/removeClass>`_
* `dojo.toggleClass <dojo/toggleClass>`_
