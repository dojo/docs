#format dojo_rst

dojo.NodeList.attr
==================

:Status: Final
:Version: 1.0
:Available: since 1.2

.. contents::
   :depth: 2

A getter and setter for DOM attributes, events and CSS styles adapted to work with node lists.


============
Introduction
============

``NodeList.attr`` adapts `dojo.attr <dojo/attr>`_ for use with node lists by applying it to every node in the list.

See `dojo.attr <dojo/attr>`_ for more details.


=====
Usage
=====

.. code-block :: javascript
 :linenos:

 dojo.query(sel).attr(attr, value);

attr
  the attribute property name or an object with key/value pairs suitable for setting each property.

value
  If passed, sets value on the node for an attribute, handling cross-browser concerns.


========
Examples
========

Setting different node attributes
---------------------------------

The following example will set several attributes such as the ``value`` and ``disabled``.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      function enable(){
        dojo.query("input").attr("disabled", false);
      }
      function disableAndSet(){
        dojo.query("input").attr({
          disabled: true,
          value:    "cool, eh?"
        });
      }
    </script>

  .. cv:: html

    <p><input name="one"></p>
    <p><input name="two"></p>
    <p><input name="three"></p>
    <p><button onclick="enable();">Enable</button></p>
    <p><button onclick="disableAndSet();">Disable &amp; Set</button></p>


========
See also
========

* `dojo.attr <dojo/attr>`_
* `dojo.hasAttr <dojo/hasAttr>`_
* `dojo.removeAttr <dojo/removeAttr>`_
* `dojo.getNodeProp <dojo/getNodeProp>`_
* `dojo.style <dojo/style>`_
* `DOM Attributes and The Dojo Toolkit 1.2 <http://www.sitepen.com/blog/2008/10/23/dom-attributes-and-the-dojo-toolkit-12/>`_
