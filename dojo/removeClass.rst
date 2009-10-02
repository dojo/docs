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
  dojo.removeClass(node, "someClass");
  dojo.removeClass(node, "someClass2 someClass3");
  dojo.removeClass(node, ["someClass4", "someClass5"]);  // Removing classes using array is new in 1.4
  dojo.removeClass(node);  // This will remove all classes - new in 1.4


You can also use removeClass as a dojo.query chain:

.. code-block :: javascript
  :linenos:

  dojo.query(".someSelector").removeClass("someClass");

The example above will remove class="someClass" from all nodes that have class="someSelector", if the node already has the class.


========
See also
========

* `dojo.addClass <dojo/addClass>`_
* `dojo.hasClass <dojo/hasClass>`_
* `dojo.toggleClass <dojo/toggleClass>`_
