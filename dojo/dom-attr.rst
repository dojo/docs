.. _dojo/dom-attr:

=============
dojo/dom-attr
=============

:Project owner:	Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 2

This module defines the core Dojo DOM attributes API. This module will eventually be retired and wholly superseded by
the :ref:`dojo/dom-prop <dojo/dom-prop>` module in the future. The standard return variable for this module is
``domAttr``.

Features
========

AMD Features
------------

* :ref:`domAttr.has <dojo/hasAttr>`

  Returns true if the requested attribute is specified on the given element, and false otherwise.

* :ref:`domAttr.get <dojo/getAttr>`

  Gets an attribute on an HTML element.

* :ref:`domAttr.set <dojo/setAttr>`

  Sets an attribute on an HTML element.

* :ref:`domAttr.remove <dojo/removeAttr>`

  Removes an attribute from an HTML element.

* :ref:`domAttr.getNodeProp <dojo/getNodeProp>`

  Returns an effective value of a property or an attribute.

Legacy features are set in :ref:`dojo/_base/html <dojo/_base/html>`.

Examples
========

.. js::

  require(["dojo/dom-attr"], function(domAttr){
    if domAttr.has("nodeId", "foo"){
      console.log("nodeId has attribute foo = " + domAttr.get("nodeId", "foo"));
    }else{
      console.log("nodeId doesn't have attribute foo");
    }
  });

See also
========

* :ref:`dojo/dom <dojo/dom>` - Core DOM API

* :ref:`dojo/dom-class <dojo/dom-class>` - Dojo DOM Class API

* :ref:`dojo/dom-prop <dojo/dom-prop>` - DOM Property API

* :ref:`dojo/dom-style <dojo/dom-style>` - DOM Style API

* :ref:`dojo/_base/html <dojo/_base/html>` - Legacy API aliases

.. api-link :: dojo.dom-attr
