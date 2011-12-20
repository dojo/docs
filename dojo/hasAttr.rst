.. _dojo/hasAttr:

============
dojo.hasAttr
============

:since: V1.2

.. contents ::
   :depth: 2

Checks a node for the presence of an attribute.


Introduction
============

``dojo.hasAttr()`` is a companion function for :ref:`dojo.attr <dojo/attr>`. It checks if an attribute is present on a DOM node, and returns the truthy value if it is there, and falsy value otherwise.

Since 1.4 it will return true for standard properties that can't have a corresponding attribute, e.g., ``innerHTML`` or ``class``.

Since Dojo 1.7, ``dojo.hasAttr`` is exposed via the ``has`` method of the ``dojo/dom-attr`` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

.. js ::
 
 // Dojo 1.7+ (AMD)
 require(["dojo/dom-attr"], function(domAttr){
   result = domAttr.has(node, attr);
 });
 
 // Dojo < 1.7
 result = dojo.hasAttr(node, attr);

node
  id or reference of the DOM node to get/set style for

attr
  the attribute property name.

result
  truthy, if the attribute is present, falsy otherwise


Examples
========

Dojo 1.7+ (AMD)
---------------

When using AMD format in a fully baseless application, ``has`` is accessed from the ``dojo/dom-attr`` module.

.. js ::

  require(["dojo/dom-attr"], function(domAttr){
    domAttr.has("nodeId", "foo");
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.hasAttr`` in the ``define`` or ``require`` callback:

.. js ::

  require(["dojo"], function(dojo){
    dojo.hasAttr("nodeId", "foo");
  });

Dojo < 1.7
----------

.. js ::

    dojo.hasAttr("nodeId", "foo");

Testing for attributes
----------------------

The following example will check for several attributes.

.. code-example ::

  .. js ::

      function checkAttributes(){
        showAttribute("id");
        showAttribute("type");
        showAttribute("name");
        showAttribute("innerHTML");
        showAttribute("foo");
        showAttribute("baz");
      }
      function showAttribute(name){
        var result = dojo.hasAttr("model", name);
        // I don't use dojo.create() here because it was not available in 1.2
        var wrapper = dojo.doc.createElement("div");
        dojo.place(wrapper, "out");
        wrapper.innerHTML = "<input type='checkbox' disabled='disabled' " +
          (result ? "checked='checked'" : "") + "> has " + name;
      }

  .. html ::

    <p><input id="model" name="model" baz="foo"> &mdash; our model node</p>
    <p><button onclick="checkAttributes();">Check attributes</button></p>
    <p id="out"></p>

See also
========

DOM operations:

* :ref:`dojo.attr <dojo/attr>`
* :ref:`dojo.getNodeProp <dojo/getNodeProp>`
* :ref:`dojo.getAttr <dojo/getAttr>`
* :ref:`dojo.setAttr <dojo/setAttr>`
* :ref:`dojo.removeAttr <dojo/removeAttr>`
* :ref:`dojo.style <dojo/style>`

NodeList:

* :ref:`dojo.NodeList <dojo/NodeList>`
* :ref:`dojo.NodeList.attr <dojo/NodeList/attr>`
* :ref:`dojo.NodeList.removeAttr <dojo/NodeList/removeAttr>`

External links:

* `DOM Attributes and The Dojo Toolkit 1.2 <http://www.sitepen.com/blog/2008/10/23/dom-attributes-and-the-dojo-toolkit-12/>`_
