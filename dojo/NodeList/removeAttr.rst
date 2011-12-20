.. _dojo/NodeList/removeAttr:

========================
dojo.NodeList.removeAttr
========================

:since: V1.4
:Removed: in V1.7

.. contents ::
   :depth: 2

Removes an attribute from a list f DOM nodes.


Introduction
============

``NodeList.removeAttr`` adapts :ref:`dojo.removeAttr <dojo/removeAttr>` for use with node lists by applying it to every node in the list.

See :ref:`dojo.removeAttr <dojo/removeAttr>` for more details.


Usage
=====

.. js ::
 
 dojo.query(sel).removeAttr(attr);

attr
  the attribute property name.


Examples
========

Removing an attribute
---------------------------------

The following example removes ``disabled`` from nodes.

.. code-example ::
  :version: local

  .. js ::

      function remAttr(){
        dojo.query("input").removeAttr("disabled");
      }

  .. html ::

    <p><input name="one" disabled="disabled" value="some text"></p>
    <p><label><input name="two" type="checkbox" disabled="disabled" checked="checked" value="two">&nbsp;a checkbox</label></p>
    <p><button onclick="remAttr();">Remove "disabled"</button></p>


See also
========

DOM operations:

* :ref:`dojo.removeAttr <dojo/removeAttr>`
* :ref:`dojo.attr <dojo/attr>`
* :ref:`dojo.hasAttr <dojo/hasAttr>`
* :ref:`dojo.getNodeProp <dojo/getNodeProp>`
* :ref:`dojo.style <dojo/style>`

NodeList:

* :ref:`dojo.NodeList <dojo/NodeList>`
* :ref:`dojo.NodeList.attr <dojo/NodeList/attr>`

External links:

* `DOM Attributes and The Dojo Toolkit 1.2 <http://www.sitepen.com/blog/2008/10/23/dom-attributes-and-the-dojo-toolkit-12/>`_
