.. _dojo/dom:

========
dojo/dom
========

:Project owner:	Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 2

This module defines the core Dojo DOM API.  The standard return variable for this module is ``dom``.

Features
========

AMD Features
------------

* :ref:`dom.byId <dojo/byId>`

  Returns DOM node with matching ``id`` attribute or ``null`` if not found. If ``id`` is a DomNode, this function is a
  no-op.

* dom.isDescendant

  Returns true if node is a descendant of ancestor

* dom.setSelectable

  Enable or disable selection on a node

Legacy features are set in :ref:`dojo/_base/html <dojo/_base/html>`.

Examples
========

.. js::

  require(["dojo/dom"], function(dom){
    var myNode = dom.byId("myNode");
  });

See also
========

* :ref:`dojo/dom-attr <dojo/dom-attr>` - DOM attribute API

* :ref:`dojo/dom-class <dojo/dom-class>` - Dojo DOM Class API

* :ref:`dojo/dom-prop <dojo/dom-prop>` - DOM Property API

* :ref:`dojo/dom-style <dojo/dom-style>` - DOM Style API

* :ref:`dojo/_base/html <dojo/_base/html>` - Legacy API aliases

.. api-link :: dojo.dom
