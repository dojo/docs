.. _dojo/dom-prop:

=============
dojo/dom-prop
=============

:Project owner:	Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 2

This module defines the core dojo DOM properties API. The convention for the return variable for this module is
``domProp``.

Features
========

AMD Features
------------

* :ref:`domProp.get <dojo/getProp>`

  Gets a property on an HTML element.

* :ref:`domProp.set <dojo/setProp>`

  Sets a property on an HTML element.

Legacy features are set in :ref:`dojo/_base/html <dojo/_base/html>`.

Examples
========

The following is an example of how to retrieve the ``foo`` property of a DOM node.

.. js::

  require(["dojo/dom-prop"], function(domProp){
    var propValue = domProp.get("myNode", "foo");
  });

See also
========

* :ref:`dojo/dom <dojo/dom>` - Core DOM API

* :ref:`dojo/dom-attr <dojo/dom-attr>` - DOM Attribute API

* :ref:`dojo/dom-class <dojo/dom-class>` - Dojo DOM Class API

* :ref:`dojo/dom-style <dojo/dom-style>` - DOM Style API

* :ref:`dojo/_base/html <dojo/_base/html>` - Legacy API aliases

.. api-link :: dojo.dom-prop

