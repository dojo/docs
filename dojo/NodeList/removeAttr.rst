#format dojo_rst

dojo.NodeList.removeAttr
========================

:Status: Final
:Version: 1.0
:Available: since 1.4

.. contents::
   :depth: 2

Removes an attribute from a list f DOM nodes.


============
Introduction
============

``NodeList.removeAttr`` adapts `dojo.removeAttr <dojo/removeAttr>`_ for use with node lists by applying it to every node in the list.

See `dojo.removeAttr <dojo/removeAttr>`_ for more details.


=====
Usage
=====

.. code-block :: javascript
 :linenos:

 dojo.query(sel).removeAttr(attr);

attr
  the attribute property name.


========
Examples
========

Removing an attribute
---------------------------------

The following example removes ``disabled`` from nodes.

.. cv-compound::
  :version: local

  .. cv:: javascript

    <script type="text/javascript">
      function remAttr(){
        dojo.query("input").removeAttr("disabled");
      }
    </script>

  .. cv:: html

    <p><input name="one" disabled="disabled" value="some text"></p>
    <p><input name="two" type="checkbox" disabled="disabled" checked="checked" value="two"></p>
    <p><button onclick="remAttr();">Remove "disabled"</button></p>


========
See also
========

DOM operations:

* `dojo.removeAttr <dojo/removeAttr>`_
* `dojo.attr <dojo/attr>`_
* `dojo.hasAttr <dojo/hasAttr>`_
* `dojo.getNodeProp <dojo/getNodeProp>`_
* `dojo.style <dojo/style>`_

NodeList:

* `dojo.NodeList <dojo/NodeList>`_
* `dojo.NodeList.attr <dojo/NodeList/attr>`_

External links:

* `DOM Attributes and The Dojo Toolkit 1.2 <http://www.sitepen.com/blog/2008/10/23/dom-attributes-and-the-dojo-toolkit-12/>`_
