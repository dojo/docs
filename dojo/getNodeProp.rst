#format dojo_rst

dojo.getNodeProp
================

:Available: since V1.4

.. contents::
   :depth: 2

Returns a property value falling back to an attribute, if property is not available.


============
Introduction
============

``dojo.getNodeProp`` is a companion function for `dojo.attr <dojo/attr>`_. Unlike the latter it favors properties falling back on attributes, if a property was not present.

It is useful when you don't care if somebody set an attribute on a node in HTML, or not, but you want to read a default/current value, which is used by a browser. For example, if user didn't specify ``type`` attribute on ``input`` element, it is default value is ``"text"``. You don't need to know all defaults, or how browser interprets missing attributes exactly, just use ``dojo.getNodeProp``.

There is no corresponding ``dojo.setNodeProp``. If you want to set a property value, use straight assignment.

=====
Usage
=====

.. code-block :: javascript
 :linenos:

 dojo.getNodeProp(node, attr);

node
  id or reference of the DOM node to get/set style for

attr
  the attribute property name.


========
Examples
========

Dojo 1.7 (AMD)
--------------
In dojo 1.7, dojo.getNodeProp has been kept in dojo/_base/html as a compatibility of dojo version before, it is an alias of attr.getNodeProp in dojo/dom-attr.

.. code-block :: javascript

  require(["dojo/_base/html"], function(dojo){   
      dojo.getNodeProp("model", name);
  });

It's recommend to use attr.getNodeProp in dojo 1.7.

.. code-block :: javascript

  require(["dojo/dom-attr"], function(attr){   
      attr.getNodeProp("model", name);
  });

Dojo < 1.7
----------

.. code-block :: javascript

    dojo.getNodeProp("model", name);

Reading current values
----------------------

The following example reads effective values from the ``input`` node.

.. cv-compound::

  .. cv:: css

     <style type="text/css">
         
     </style>

  .. cv:: javascript

    <script type="text/javascript">
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
    </script>

  .. cv:: html

    <p><input id="model" name="model" baz="foo"> &mdash; our model node</p>
    <p><button onclick="checkAttributes();">Check attributes</button></p>
    <p id="out"></p>


========
See also
========

DOM operations:

* `dojo.attr <dojo/attr>`_
* `dojo.getAttr <dojo/getAttr>`_
* `dojo.setAttr <dojo/setAttr>`_
* `dojo.hasAttr <dojo/hasAttr>`_
* `dojo.removeAttr <dojo/attr>`_
* `dojo.style <dojo/style>`_

NodeList:

* `dojo.NodeList <dojo/NodeList>`_
* `dojo.NodeList.attr <dojo/NodeList/attr>`_
* `dojo.NodeList.removeAttr <dojo/NodeList/removeAttr>`_

External links:

* `DOM Attributes and The Dojo Toolkit 1.2 <http://www.sitepen.com/blog/2008/10/23/dom-attributes-and-the-dojo-toolkit-12/>`_
