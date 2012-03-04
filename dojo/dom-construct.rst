.. _dojo/dom-construct:

==================
dojo/dom-construct
==================

:Project owner:	Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 2

This module defines the core dojo DOM construction API. The convention for the return variable for this module is
``domConstruct``.

Features
========

AMD Features
------------

* :ref:`domConstruct.toDom <dojo/toDom>`

  Instantiates an HTML fragment returning the corresponding DOM.

* :ref:`domConstruct.place <dojo/place>`

  Places a DOM node relative to an other.

* :ref:`domConstruct.create <dojo/create>`

  Creates a DOM node with optional values and placement.

* :ref:`domConstruct.empty <dojo/empty>`

  Empty the contents of a DOM node.

* :ref:`domConstruct.destroy <dojo/destroy>`

  Destroy a DOM node.

Legacy features are set in :ref:`dojo/_base/html <dojo/_base/html>`.

Examples
========

.. js::

  require(["dojo/dom", "dojo/dom-construct"], function(dom, domConstruct){
    // create a div node
    var node = domConstruct.create("div");
    
    // get a reference to another node
    var refNode = dom.byId("refNode");
    
    // place the constructed node at the referenced node
    domConstruct.place(node, refNode);
  });

See also
========

* :ref:`dojo/dom <dojo/dom>` - Core DOM API

* :ref:`dojo/_base/html <dojo/_base/html>` - Legacy API aliases

.. api-link :: dojo.dom-construct

