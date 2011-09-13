#format dojo_rst

dojo.setAttr
============

.. contents::
   :depth: 2

Sets an attribute on an HTML element.


============
Introduction
============

``dojo.setAttr()`` is a companion function for `dojo.attr <dojo/attr>`_. It handles normalized setting of attributes on DOM Nodes. When passing functions as values, note that they will not be directly assigned to slots on the node, but rather the default behavior will be removed and the new behavior will be added
using `dojo.connect()`, meaning that event handler properties will be normalized and that some caveats with regards to non-standard behaviors for onsubmit apply. Namely that you should cancel form submission using `dojo.stopEvent()` on the passed event object instead of returning a boolean value from the handler itself. It returns the DOM node.

Since dojo 1.7, dojo.setAttr has been kept in dojo/_base/html as a compatibility of dojo version before, it is an alias of attr.set in dojo/dom-attr.

=====
Usage
=====

.. code-block :: javascript
 :linenos:

  dojo.setAttr(node, name, value);

node
  id or reference to the element to set the attribute on.

name
  the name of the attribute to set, or a hash of key-value pairs to set.

value
  the value to set for the attribute, if the name is a string.


========
Examples
========

Dojo 1.7 (AMD)
--------------

.. code-block :: javascript

  require(["dojo/_base/html"], function(dojo){   
      // use setAttr() to set the tab index
      dojo.setAttr("nodeId", "tabIndex", 3);

      // Again, only set style as an object hash of styles:
      var obj = { color:"#fff", backgroundColor:"#000" };
      dojo.setAttr("someNode", "style", obj);
  });

It's recommended to use attr.set in dojo 1.7.

.. code-block :: javascript

  require(["dojo/dom-attr"], function(attr){   
      // use setAttr() to set the tab index
      attr.set("nodeId", "tabIndex", 3);

      // Again, only set style as an object hash of styles:
      var obj = { color:"#fff", backgroundColor:"#000" };
      attr.set("someNode", "style", obj);
  });

Dojo < 1.7
----------

.. code-block :: javascript

    // use setAttr() to set the tab index
    dojo.setAttr("nodeId", "tabIndex", 3);

    // Again, only set style as an object hash of styles:
    var obj = { color:"#fff", backgroundColor:"#000" };
    dojo.setAttr("someNode", "style", obj);

========
See also
========

DOM operations:

* `dojo.attr <dojo/attr>`_
* `dojo.getNodeProp <dojo/getNodeProp>`_
* `dojo.getAttr <dojo/getAttr>`_
* `dojo.hasAttr <dojo/hasAttr>`_
* `dojo.removeAttr <dojo/removeAttr>`_
* `dojo.style <dojo/style>`_

NodeList:

* `dojo.NodeList <dojo/NodeList>`_
* `dojo.NodeList.attr <dojo/NodeList/attr>`_
* `dojo.NodeList.removeAttr <dojo/NodeList/removeAttr>`_

External links:

* `DOM Attributes and The Dojo Toolkit 1.2 <http://www.sitepen.com/blog/2008/10/23/dom-attributes-and-the-dojo-toolkit-12/>`_
