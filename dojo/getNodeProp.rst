.. _dojo/getNodeProp:

================
dojo.getNodeProp
================

:since: V1.4

.. contents ::
   :depth: 2

Returns a property value falling back to an attribute, if property is not available.


Introduction
============

``dojo.getNodeProp`` is a companion function for :ref:`dojo.attr <dojo/attr>`. Unlike the latter it favors properties falling back on attributes, if a property was not present.

It is useful when you don't care if somebody set an attribute on a node in HTML, or not, but you want to read a default/current value, which is used by a browser. For example, if user didn't specify ``type`` attribute on ``input`` element, it is default value is ``"text"``. You don't need to know all defaults, or how browser interprets missing attributes exactly, just use ``dojo.getNodeProp``.

There is no corresponding ``dojo.setNodeProp``. If you want to set a property value, use straight assignment.

Since Dojo 1.7, ``dojo.getNodeProp`` is exposed via the ``getNodeProp`` method of the ``dojo/dom-attr`` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

.. js ::
 
 // Dojo 1.7+ (AMD)
 require(["dojo/dom-attr"], function(domAttr){
   domAttr.getNodeProp(node, attr);
 });
 
 // Dojo < 1.7
 dojo.getNodeProp(node, attr);

node
  id or reference of the DOM node to get/set style for

attr
  the attribute property name.


Examples
========

Dojo 1.7+ (AMD)
---------------

When using AMD format in a fully baseless application, ``getNodeProp`` is accessed from the ``dojo/dom-attr`` module.

.. js ::

  require(["dojo/dom-attr"], function(domAttr){
    domAttr.getNodeProp("model", name);
  });

Dojo < 1.7
----------

.. js ::

    dojo.getNodeProp("model", name);

Reading current values
----------------------

The following example reads effective values from the ``input`` node.

.. code-example ::

  .. css ::



  .. js ::

      function checkAttributes(){
        showAttribute("id");
        showAttribute("type");
        showAttribute("name");
        showAttribute("value");
        showAttribute("innerHTML");
        showAttribute("foo");
        showAttribute("baz");
      }
      function showAttribute(name){
        var result = dojo.getNodeProp("model", name);
        // I don't use dojo.create() here because it was not available in 1.2
        var wrapper = dojo.doc.createElement("div");
        dojo.place(wrapper, "out");
        wrapper.innerHTML = name + " is '" + result + "'";
      }

  .. html ::

    <p><input id="model" name="model" baz="foo"> &mdash; our model node</p>
    <p><button onclick="checkAttributes();">Check attributes</button></p>
    <p id="out"></p>


See also
========

DOM operations:

* :ref:`dojo.attr <dojo/attr>`
* :ref:`dojo.getAttr <dojo/getAttr>`
* :ref:`dojo.setAttr <dojo/setAttr>`
* :ref:`dojo.hasAttr <dojo/hasAttr>`
* :ref:`dojo.removeAttr <dojo/attr>`
* :ref:`dojo.style <dojo/style>`

NodeList:

* :ref:`dojo.NodeList <dojo/NodeList>`
* :ref:`dojo.NodeList.attr <dojo/NodeList/attr>`
* :ref:`dojo.NodeList.removeAttr <dojo/NodeList/removeAttr>`

External links:

* `DOM Attributes and The Dojo Toolkit 1.2 <http://www.sitepen.com/blog/2008/10/23/dom-attributes-and-the-dojo-toolkit-12/>`_
