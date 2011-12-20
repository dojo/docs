.. _dojo/setAttr:

============
dojo.setAttr
============

.. contents ::
   :depth: 2

Sets an attribute on an HTML element.


Introduction
============

``dojo.setAttr()`` is a companion function for :ref:`dojo.attr <dojo/attr>`. It handles normalized setting of attributes on DOM Nodes. When passing functions as values, note that they will not be directly assigned to slots on the node, but rather the default behavior will be removed and the new behavior will be added
using `dojo.connect()`, meaning that event handler properties will be normalized and that some caveats with regards to non-standard behaviors for onsubmit apply. Namely that you should cancel form submission using `dojo.stopEvent()` on the passed event object instead of returning a boolean value from the handler itself. It returns the DOM node.

Since Dojo 1.7, ``dojo.setAttr`` is exposed via the ``set`` method of the ``dojo/dom-attr`` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

.. js ::
   
  // Dojo 1.7+ (AMD)
  require(["dojo/dom-attr"], function(domAttr){
    domAttr.set(node, name, value);
  });
  
  // Dojo < 1.7
  dojo.setAttr(node, name, value);

node
  id or reference to the element to set the attribute on.

name
  the name of the attribute to set, or a hash of key-value pairs to set.

value
  the value to set for the attribute, if the name is a string.


Examples
========

Dojo 1.7 (AMD)
--------------

When using AMD format in a fully baseless application, ``set`` is accessed from the ``dojo/dom-attr`` module.

.. js ::

  require(["dojo/dom-attr"], function(domAttr){
      // use setAttr() to set the tab index
      domAttr.set("nodeId", "tabIndex", 3);

      // Again, only set style as an object hash of styles:
      var obj = { color:"#fff", backgroundColor:"#000" };
      domAttr.set("someNode", "style", obj);
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.setAttr`` in the ``define`` or ``require`` callback:

.. js ::

  require(["dojo"], function(dojo){
      // use setAttr() to set the tab index
      dojo.setAttr("nodeId", "tabIndex", 3);

      // Again, only set style as an object hash of styles:
      var obj = { color:"#fff", backgroundColor:"#000" };
      dojo.setAttr("someNode", "style", obj);
  });
  
Dojo < 1.7
----------

.. js ::

    // use setAttr() to set the tab index
    dojo.setAttr("nodeId", "tabIndex", 3);

    // Again, only set style as an object hash of styles:
    var obj = { color:"#fff", backgroundColor:"#000" };
    dojo.setAttr("someNode", "style", obj);

See also
========

DOM operations:

* :ref:`dojo.attr <dojo/attr>`
* :ref:`dojo.getNodeProp <dojo/getNodeProp>`
* :ref:`dojo.getAttr <dojo/getAttr>`
* :ref:`dojo.hasAttr <dojo/hasAttr>`
* :ref:`dojo.removeAttr <dojo/removeAttr>`
* :ref:`dojo.style <dojo/style>`

NodeList:

* :ref:`dojo.NodeList <dojo/NodeList>`
* :ref:`dojo.NodeList.attr <dojo/NodeList/attr>`
* :ref:`dojo.NodeList.removeAttr <dojo/NodeList/removeAttr>`

External links:

* `DOM Attributes and The Dojo Toolkit 1.2 <http://www.sitepen.com/blog/2008/10/23/dom-attributes-and-the-dojo-toolkit-12/>`_
