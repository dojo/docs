#format dojo_rst

dojo.getAttr
============

:Available: since V1.2

.. contents::
   :depth: 2

Gets an attribute on an HTML element.


============
Introduction
============

``dojo.getAttr()`` is a companion function for `dojo.attr <dojo/attr>`_. It handles normalized getting of attributes on DOM Nodes and return the value of the requested attribute or null if that attribute does not have a specified or default value.

Since 1.7 it will be replaced by attr.get in dojo/dom-attr.


=====
Usage
=====

.. code-block :: javascript
 :linenos:

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
In dojo 1.7, dojo.getAttr has been moved to dojo/_base/html.

.. code-block :: javascript

  require("dojo/_base/html", function(dojo){   
      // get the current value of the "foo" attribute on a node
      dojo.getAttr(dojo.byId("nodeId"), "foo");

      // or we can just pass the id:
      dojo.getAttr("nodeId", "foo");
  });

It's recommend to use attr.get in dojo 1.7.

.. code-block :: javascript

  require("dojo/dom-attr", function(attr){   
      // get the current value of the "foo" attribute on a node
      attr.get(dojo.byId("nodeId"), "foo");

      // or we can just pass the id:
      attr.get("nodeId", "foo");
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
