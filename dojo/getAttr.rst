#format dojo_rst

dojo.getAttr
============

.. contents::
   :depth: 2

Gets an attribute on an HTML element.


============
Introduction
============

``dojo.getAttr()`` is a companion function for `dojo.attr <dojo/attr>`_. It handles normalized getting of attributes on DOM Nodes and return the value of the requested attribute or null if that attribute does not have a specified or default value.

Since Dojo 1.7, ``dojo.getAttr`` is exposed via the ``get`` method of the ``dojo/dom-attr`` module.  An alias is kept in dojo/_base/html for backward-compatibility.

=====
Usage
=====

.. code-block :: javascript
 :linenos:

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


========
Examples
========

Dojo 1.7 (AMD)
--------------

When using AMD format in a fully baseless application, ``get`` is accessed from the ``dojo/dom-attr`` module.

.. code-block :: javascript

  require(["dojo/dom-attr", "dojo/dom"], function(domAttr, dom){   
      // get the current value of the "foo" attribute on a node
      domAttr.get(dom.byId("nodeId"), "foo");

      // or we can just pass the id:
      domAttr.get("nodeId", "foo");
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.getAttr`` in the ``define`` or ``require`` callback:

.. code-block :: javascript

  require(["dojo"], function(dojo){   
      // get the current value of the "foo" attribute on a node
      dojo.getAttr(dojo.byId("nodeId"), "foo");

      // or we can just pass the id:
      dojo.getAttr("nodeId", "foo");
  });


Dojo < 1.7
----------

.. code-block :: javascript

    // get the current value of the "foo" attribute on a node
    dojo.getAttr(dojo.byId("nodeId"), "foo");

    // or we can just pass the id:
    dojo.getAttr("nodeId", "foo");

========
See also
========

DOM operations:

* `dojo.attr <dojo/attr>`_
* `dojo.getNodeProp <dojo/getNodeProp>`_
* `dojo.setAttr <dojo/setAttr>`_
* `dojo.hasAttr <dojo/hasAttr>`_
* `dojo.removeAttr <dojo/removeAttr>`_
* `dojo.style <dojo/style>`_

NodeList:

* `dojo.NodeList <dojo/NodeList>`_
* `dojo.NodeList.attr <dojo/NodeList/attr>`_
* `dojo.NodeList.removeAttr <dojo/NodeList/removeAttr>`_

External links:

* `DOM Attributes and The Dojo Toolkit 1.2 <http://www.sitepen.com/blog/2008/10/23/dom-attributes-and-the-dojo-toolkit-12/>`_
