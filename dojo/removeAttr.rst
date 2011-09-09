#format dojo_rst

dojo.removeAttr
===============

:Available: since V1.2

.. contents::
   :depth: 2

Removes an attribute.


============
Introduction
============

``dojo.removeAttr()`` removes an attribute. It is modeled after DOM's `removeAttribute <https://developer.mozilla.org/En/DOM/Element.removeAttribute>`_, but unlike the latter it normalizes standard attribute names to smooth over differences between browsers, or to provide convenient aliases, e.g., ``className`` is aliased to ``class``, and so on. The same algorithm is used by `dojo.attr <dojo/attr>`_.


=====
Usage
=====

.. code-block :: javascript
 :linenos:

 dojo.removeAttr(node, attr);

node
  id or reference of the DOM node to get/set style for

attr
  the attribute property name.


========
Examples
========

Dojo 1.7 (AMD)
--------------
In dojo 1.7, dojo.removeAttr has been kept in dojo/_base/html as a compatibility of dojo version before, it is a alias of attr.remove in dojo/dom-attr.

.. code-block :: javascript

  require(["dojo/_base/html"], function(dojo){   
      dojo.removeAttr("model", "disabled");
  });

It's recommended to use attr.remove in dojo 1.7.

.. code-block :: javascript

  require(["dojo/dom-attr"], function(attr){   
      attr.remove("model", "disabled");
  });

Dojo < 1.7
----------

.. code-block :: javascript

    dojo.removeAttr("model", "disabled");

Removing an attribute
---------------------

The following example will remove ``disabled`` from the ``input`` node.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      function remAttr(){
        dojo.removeAttr("model", "disabled");
      }
    </script>

  .. cv:: html

    <p><input id="model" name="model" disabled="disabled" value="some text"> &mdash; our model node</p>
    <p><button onclick="remAttr();">Remove "disabled"</button></p>

========
See also
========

DOM operations:

* `dojo.attr <dojo/attr>`_
* `dojo.getAttr <dojo/getAttr>`_
* `dojo.setAttr <dojo/setAttr>`_
* `dojo.hasAttr <dojo/hasAttr>`_
* `dojo.getNodeProp <dojo/getNodeProp>`_
* `dojo.style <dojo/style>`_

NodeList:

* `dojo.NodeList <dojo/NodeList>`_
* `dojo.NodeList.removeAttr <dojo/NodeList/removeAttr>`_
* `dojo.NodeList.attr <dojo/NodeList/attr>`_

External links:

* `DOM Attributes and The Dojo Toolkit 1.2 <http://www.sitepen.com/blog/2008/10/23/dom-attributes-and-the-dojo-toolkit-12/>`_
