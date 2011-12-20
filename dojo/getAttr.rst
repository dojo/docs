.. _dojo/getAttr:

============
dojo.getAttr
============

.. contents ::
   :depth: 2

Gets an attribute on an HTML element.


Introduction
============

``dojo.getAttr()`` is a companion function for :ref:`dojo.attr <dojo/attr>`. It handles normalized getting of attributes on DOM Nodes and return the value of the requested attribute or null if that attribute does not have a specified or default value.

Since Dojo 1.7, ``dojo.getAttr`` is exposed via the ``get`` method of the ``dojo/dom-attr`` module.  An alias is kept in dojo/_base/html for backward-compatibility.

Usage
=====

.. js ::
 
  // Dojo 1.7+ (AMD)
  require(["dojo/dom-attr"], function(domAttr){
    domAttr.get(node, attr);
  });

  // Dojo < 1.7
  dojo.getAttr(node, attr);

node
  id or reference to the element to get the attribute on.

attr
  the name of the attribute to get.


Examples
========

Dojo 1.7 (AMD)
--------------

When using AMD format in a fully baseless application, ``get`` is accessed from the ``dojo/dom-attr`` module.

.. js ::

  require(["dojo/dom-attr", "dojo/dom"], function(domAttr, dom){
      // get the current value of the "foo" attribute on a node
      domAttr.get(dom.byId("nodeId"), "foo");

      // or we can just pass the id:
      domAttr.get("nodeId", "foo");
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.getAttr`` in the ``define`` or ``require`` callback:

.. js ::

  require(["dojo"], function(dojo){
      // get the current value of the "foo" attribute on a node
      dojo.getAttr(dojo.byId("nodeId"), "foo");

      // or we can just pass the id:
      dojo.getAttr("nodeId", "foo");
  });


Dojo < 1.7
----------

.. js ::

    // get the current value of the "foo" attribute on a node
    dojo.getAttr(dojo.byId("nodeId"), "foo");

    // or we can just pass the id:
    dojo.getAttr("nodeId", "foo");

See also
========

DOM operations:

* :ref:`dojo.attr <dojo/attr>`
* :ref:`dojo.getNodeProp <dojo/getNodeProp>`
* :ref:`dojo.setAttr <dojo/setAttr>`
* :ref:`dojo.hasAttr <dojo/hasAttr>`
* :ref:`dojo.removeAttr <dojo/removeAttr>`
* :ref:`dojo.style <dojo/style>`

NodeList:

* :ref:`dojo.NodeList <dojo/NodeList>`
* :ref:`dojo.NodeList.attr <dojo/NodeList/attr>`
* :ref:`dojo.NodeList.removeAttr <dojo/NodeList/removeAttr>`

External links:

* `DOM Attributes and The Dojo Toolkit 1.2 <http://www.sitepen.com/blog/2008/10/23/dom-attributes-and-the-dojo-toolkit-12/>`_
