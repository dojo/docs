.. _dojo/dom-style:

==============
dojo/dom-style
==============

:Project owner:	Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 2

This module defines the core dojo DOM style API. The convention for the return variable for this module is ``domStyle``.

Features
========

AMD Features
------------

* :ref:`domStyle.getComputedStyle <dojo/getComputedStyle>`

  Returns a "computed style" object.

* *domStyle.toPixelValue*

  Converts style value to pixels on IE or return a numeric value.

* :ref:`domStyle.get <dojo/getStyle>`

  Accesses styles on a node.

* :ref:`domStyle.set <dojo/setStyle>`

  Sets styles on a node.

Legacy features are set in :ref:`dojo/_base/html <dojo/_base/html>`.

Examples
========

Here is an example of how to set the style of ``display: none;`` on a DOM node:

.. js::

  require(["dojo/dom", "dojo/dom-style"], function(dom, domStyle){
    var myNode = dom.byId("myNode");
    domStyle.set(myNode, "display", "none");
  });

See also
========

* :ref:`dojo/dom <dojo/dom>` - Core DOM API

* :ref:`dojo/dom-attr <dojo/dom-attr>` - DOM Attribute API

* :ref:`dojo/dom-class <dojo/dom-class>` - Dojo DOM Class API

* :ref:`dojo/dom-prop <dojo/dom-prop>` - DOM Property API

* :ref:`dojo/_base/html <dojo/_base/html>` - Legacy API aliases
