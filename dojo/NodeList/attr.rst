.. _dojo/NodeList/attr:

==================
dojo.NodeList.attr
==================

:since: V1.2
:Removed: in V1.7

.. contents ::
   :depth: 2

A getter and setter for DOM attributes, events and CSS styles adapted to work with node lists.


Introduction
============

``NodeList.attr`` adapts :ref:`dojo.attr <dojo/attr>` for use with node lists by applying it to every node in the list.

See :ref:`dojo.attr <dojo/attr>` for more details.


Usage
=====

.. js ::
 
 dojo.query(sel).attr(attr, value);

attr
  the attribute property name or an object with key/value pairs suitable for setting each property.

value
  If passed, sets value on the node for an attribute, handling cross-browser concerns.


Examples
========

Setting different node attributes
---------------------------------

The following example will set several attributes such as the ``value`` and ``disabled``.

.. code-example ::

  .. js ::

      function enable(){
        dojo.query("input").attr("disabled", false);
      }
      function disableAndSet(){
        dojo.query("input").attr({
          disabled: true,
          value:    "cool, eh?"
        });
      }

  .. html ::

    <p><input name="one"></p>
    <p><input name="two"></p>
    <p><input name="three"></p>
    <p><button onclick="enable();">Enable</button></p>
    <p><button onclick="disableAndSet();">Disable &amp; Set</button></p>


See also
========

DOM operations:

* :ref:`dojo.attr <dojo/attr>`
* :ref:`dojo.getNodeProp <dojo/getNodeProp>`
* :ref:`dojo.hasAttr <dojo/hasAttr>`
* :ref:`dojo.removeAttr <dojo/attr>`
* :ref:`dojo.style <dojo/style>`

NodeList:

* :ref:`dojo.NodeList <dojo/NodeList>`
* :ref:`dojo.NodeList.removeAttr <dojo/NodeList/removeAttr>`

External links:

* `DOM Attributes and The Dojo Toolkit 1.2 <http://www.sitepen.com/blog/2008/10/23/dom-attributes-and-the-dojo-toolkit-12/>`_
