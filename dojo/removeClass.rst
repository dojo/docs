#format dojo_rst

dojo.removeClass
================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2


Removes a class from a Node. 

============
Introduction
============

Follows the same pattern as most Dojo functionality by accepting a string ID of a Node, or a DOM Node reference, removing a passed class from the class="" attribute.


=====
Usage
=====

.. code-block :: javascript
  :linenos:

  dojo.removeClass("someNode","removedClass");
  var node = dojo.byId("someNode").parentNode;
  dojo.removeClass(node, "removedClass");

You can also use removeClass as a dojo.query chain:

.. code-block :: javascript
  :linenos:

  dojo.query(".someSelector").removeClass("someClass");

The example above will remove class="someClass" from all nodes that have class="someSelector", if the node already has the class.


========
Examples
========

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

TODO: example


========
See also
========

* `dojo.addClass <dojo/addClass>`_
* `dojo.hasClass <dojo/hasClass>`_
