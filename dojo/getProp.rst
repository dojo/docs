.. _dojo/getProp:

=============
dojo.getProp
=============

.. contents ::
   :depth: 2

Gets a property on an HTML element.

Introduction
============

Handles normalized getting of properties on DOM nodes.

Since Dojo 1.7, ``dojo.getProp`` is exposed via the ``get`` method of the ``dojo/dom-prop`` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

.. js ::
 
  // Dojo 1.7+ (AMD)
  require(["dojo/dom-prop"], function(domProp){
    domProp.get(node, name);
  });
  
  // Dojo < 1.7
  dojo.getProp(node, name);

node
  id or reference to the element to get the property on

name
  the name of the property to get.


Examples
========

Dojo 1.7+ (AMD)
---------------

When using AMD format in a fully baseless application, ``get`` is accessed from the ``dojo/dom-prop`` module.

.. js ::

  require(["dojo/dom-prop", "dojo/dom"], function(domProp, dom){
      // get the current value of the "foo" property on a node
      domProp.get(dom.byId("nodeId"), "foo");

      // or we can just pass the id:
      domProp.get("nodeId", "foo");
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.getProp`` in the ``define`` or ``require`` callback:

.. js ::

  require(["dojo"], function(dojo){
      // get the current value of the "foo" property on a node
      dojo.getProp(dojo.byId("nodeId"), "foo");

      // or we can just pass the id:
      dojo.getProp("nodeId", "foo");
  });

Dojo < 1.7
----------

.. js ::

    // get the current value of the "foo" property on a node
    dojo.getProp(dojo.byId("nodeId"), "foo");

    // or we can just pass the id:
    dojo.getProp("nodeId", "foo");

See also
========

DOM operations:

* :ref:`dojo.prop <dojo/prop>`
* :ref:`dojo.setProp <dojo/setProp>`
