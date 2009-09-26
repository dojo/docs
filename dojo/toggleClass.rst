#format dojo_rst

dojo.toggleClass
================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

Simply toggles a className (or now in 1.4 an array of classNames).

============
Introduction
============

dojo.toggleClass adds a class to node if not present, or removes if present.


=====
Usage
=====

Pass a boolean condition if you want to explicitly add or remove.

Parameters:

node
  The node which should changed.

classStr
  name of the class

condition
  true|false Optional. true means to add the class, false means to remove.

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   var foo=dojo.toggleClass(node: DomNode|String, classStr: String, condition: Boolean?);
 </script>


========
Examples
========

Programmatic example
--------------------

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   dojo.toggleClass("someNode", "hovered");

   // Forcefully add a class:
   dojo.toggleClass("someNode", "hovered", true);

   // Available in `dojo.NodeList` for multiple toggles:
   dojo.query(".toggleMe").toggleClass("toggleMe");
 </script>

========
See also
========

* `dojo.addClass <dojo/addClass>`_
* `dojo.hasClass <dojo/hasClass>`_
* `dojo.removeClass <dojo/removeClass>`_
* `dojo.style <dojo/style>`_
