.. _dojo/_base/html:

===============
dojo/_base/html
===============

:since: V?

.. contents ::
    :depth: 2


The **dojo/_base/html** module defines aliases to basic DOM & HTML handling functions for backwards-compatibility.  As with all dojo/_base components, these functions are included within Dojo Base, which you get simply by loading ``dojo.js``  (except when loading baseless with ``async: true`` in Dojo 1.7+).

As of Dojo 1.7, the recommended practice going forward (with ``async: true``) is to require just the individual dependencies you need, instead of ``dojo/_base/html``.  The new locations of its functions are indicated in the list below.


Features
========

* :ref:`dojo.byId <dojo/byId>`

  Returns the DOM node with the matching 'id.  Alias of ``dom.byId`` in ``dojo/dom``.

* dojo.isDescendant

  Determines whether a node is a descendant of another.  Alias of ``dom.isDescendant`` in ``dojo/dom``.

* dojo.setSelectable

  Enables or disables selection on a node.  Alias of ``dom.setSelectable`` in ``dojo/dom``.

* :ref:`dojo.getAttr <dojo/getAttr>`

  Gets an attribute on an HTML element. Alias of ``domAttr.get`` in ``dojo/dom-attr``.

* :ref:`dojo.setAttr <dojo/setAttr>`

  Sets an attribute on an HTML element. Alias of ``domAttr.set`` in ``dojo/dom-attr``.

* :ref:`dojo.hasAttr <dojo/hasAttr>`

  Returns true if the requested attribute is specified on the given element, false otherwise. Alias of ``domAttr.has`` in ``dojo/dom-attr``.

* :ref:`dojo.removeAttr <dojo/removeAttr>`

  Removes an attribute from an HTML element.  Alias of ``domAttr.remove`` in ``dojo/dom-attr``.

* :ref:`dojo.getNodeProp <dojo/getNodeProp>`

  Returns an effective value of a property or an attribute.  Alias of ``domAttr.getNodeProp`` in ``dojo/dom-attr``.

* :ref:`dojo.attr <dojo/attr>`

  Gets or sets an attribute on an HTML element.

* :ref:`dojo.hasClass <dojo/hasClass>`

  Returns whether or not the specified classes are a portion of the class list currently applied to the node.  Alias of ``domClass.contains`` in ``dojo/dom-class``.

* :ref:`dojo.addClass <dojo/addClass>`

  Adds the specified classes to the end of the class list on the passed node. Will not re-apply duplicate classes. Alias of ``domClass.add`` in ``dojo/dom-class``.

* :ref:`dojo.removeClass <dojo/removeClass>`

  Removes the specified classes from node. No ``dojo.hasClass`` check is required.  Alias of ``domClass.remove`` in ``dojo/dom-class``.

* :ref:`dojo.toggleClass <dojo/toggleClass>`

  Adds a class to node if not present, or removes if present. Pass a boolean condition if you want to explicitly add or remove. Returns the condition that was specified directly or indirectly.  Alias of ``domClass.toggle`` in ``dojo/dom-class``.

* :ref:`dojo.replaceClass <dojo/replaceClass>`

  Replaces one or more classes on a node if not present. Operates more quickly than calling ``dojo.removeClass`` and ``dojo.addClass``.  Alias of ``domClass.replace`` in ``dojo/dom-class``.

* :ref:`dojo.toDom <dojo/toDom>`

  Instantiates an HTML fragment returning the corresponding DOM.  Alias of ``domConstruct.toDom`` in ``dojo/dom-construct``.

* :ref:`dojo.place <dojo/place>`

  Attempt to insert node into the DOM, choosing from various positioning options. Returns the first argument resolved to a DOM node.  Alias of ``domConstruct.place`` in ``dojo/dom-construct``.

* :ref:`dojo.create <dojo/create>`

  Create an element, allowing for optional attribute decoration and placement.  Alias of ``domConstruct.create`` in ``dojo/dom-construct``.

* :ref:`dojo.empty <dojo/empty>`

  Safely removes all children of the node.  Alias of ``domConstruct.empty`` in ``dojo/dom-construct``.

* :ref:`dojo.destroy <dojo/destroy>`

  Removes a node from its parent, clobbering it and all of its children.  Alias of ``domConstruct.destroy`` in ``dojo/dom-construct``.

* dojo.getPadExtents

  Returns object with special values specifically useful for node fitting.  Alias of ``domGeom.getPadExtents`` in ``dojo/dom-geometry``.

* dojo.getBorderExtents

  Returns an object with properties useful for noting the border dimensions.  Alias of ``domGeom.getBorderExtents`` in ``dojo/dom-geometry``.

* dojo.getPadBorderExtents

  Returns object with properties useful for box fitting with regards to padding.  Alias of ``domGeom.getPadBorderExtents`` in ``dojo/dom-geometry``.

* dojo.getMarginExtents

  Returns object with properties useful for box fitting with regards to box margins (i.e., the outer-box).  Alias of ``domGeom.getMarginExtents`` in ``dojo/dom-geometry``.

* dojo.getMarginSize

  Returns an object that encodes the width and height of the node's margin box.  Alias of ``domGeom.getMarginSize`` in ``dojo/dom-geometry``.

* :ref:`dojo.getMarginBox <dojo/getMarginBox>`

  Returns an object that encodes the width, height, left and top positions of the node's margin box.  Alias of ``domGeom.getMarginBox`` in ``dojo/dom-geometry``.

* :ref:`dojo.setMarginBox <dojo/setMarginBox>`

  Set the size of the node's margin box and placement (left/top), irrespective of box model. Think of it as a passthrough to setBox that handles box-model vagaries for you.  Alias of ``domGeom.setMarginBox`` in ``dojo/dom-geometry``.

* :ref:`dojo.getContentBox <dojo/getContentBox>`

  Returns an object that encodes the width, height, left and top positions of the node's content box, irrespective of the current box model.  Alias of ``domGeom.getContentBox`` in ``dojo/dom-geometry``.

* :ref:`dojo.setContentSize <dojo/setContentSize>`

  Sets the size of the node's contents, irrespective of margins, padding, or borders.  Alias of ``domGeom.setContentSize`` in ``dojo/dom-geometry``.

* dojo.isBodyLtr

  Returns true if the current language is left-to-right, and false otherwise.  Alias of ``domGeom.isBodyLtr`` in ``dojo/dom-geometry``.

* dojo.docScroll

  Returns an object with {node, x, y} with corresponding offsets.  Alias of ``domGeom.docScroll`` in ``dojo/dom-geometry``.

* dojo.getIeDocumentElementOffset

  Returns the offset in x and y from the document body to the visual edge of the page for IE.  Alias of ``domGeom.getIeDocumentElementOffset`` in ``dojo/dom-geometry``.

* dojo.fixIeBiDiScrollLeft

  In RTL direction, scrollLeft should be a negative value, but IE returns a positive one. All codes using documentElement.scrollLeft must call this function to fix this error, otherwise the position will offset to right when there is a horizontal scrollbar.  Alias of ``domGeom.fixIeBiDiScrollLeft`` in ``dojo/dom-geometry``.

* :ref:`dojo.position <dojo/position>`

  Gets the position and size of the passed element relative to the viewport (if includeScroll==false), or relative to the document root (if includeScroll==true).  Alias of ``domGeom.position`` in ``dojo/dom-geometry``.

* :ref:`dojo.marginBox <dojo/marginBox>`

  Getter/setter for the margin-box of node.

* :ref:`dojo.contentBox <dojo/contentBox>`

  Getter/setter for the content-box of node.

* :ref:`dojo.coords <dojo/coords>`

  Deprecated: Use ``position()`` for border-box x/y/w/h or ``marginBox()`` for margin-box w/h/l/t. Returns an object representing a node's size and position.

* :ref:`dojo.getProp <dojo/getProp>`

  Gets a property on an HTML element.  Alias of ``domProp.get`` in ``dojo/dom-prop``.

* :ref:`dojo.setProp <dojo/setProp>`

  Sets a property on an HTML element.  Alias of ``domProp.set`` in ``dojo/dom-prop``.

* :ref:`dojo.prop <dojo/prop>`

  Gets or sets a property on an HTML element.

* :ref:`dojo.getStyle <dojo/getStyle>`

  Accesses styles on a node.  Alias of ``domStyle.get`` in ``dojo/dom-style``.

* :ref:`dojo.setStyle <dojo/setStyle>`

  Sets styles on a node.  Alias of ``domStyle.set`` in ``dojo/dom-style``.

* :ref:`dojo.getComputedStyle <dojo/getComputedStyle>`

  Returns a `computed style` object.  Alias of ``domStyle.getComputedStyle`` in ``dojo/dom-style``.

* dojo.toPixelValue

  Converts style value to pixels on IE or return a numeric value.  Alias of ``domStyle.toPixelValue`` in ``dojo/dom-style``.

* :ref:`dojo.style <dojo/style>`

  Accesses styles on a node. If 2 arguments are passed, acts as a getter. If 3 arguments are passed, acts as a setter.


See also
========

* :ref:`dojo.html <dojo/html>`

  dojo.html.set() inserts (replaces) the given content into the given node

* :ref:`dojox.html <dojox/html>`

  Additional HTML helper functions
