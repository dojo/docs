#format dojo_rst

dojo/_base/html
===============

:Status: Draft
:Version: 1.0
:Available: since V?

.. contents::
    :depth: 2


The **dojo/_base/html** module defines aliases to basic DOM & HTML handling functions for backwards-compatibility.  As with all dojo/_base components, these functions are included within Dojo Base, which you get simply by loading dojo.js or dojo.xd.js (except when loading baseless with ``async: true`` in Dojo 1.7+).

As of Dojo 1.7, the recommended practice going forward (with ``async: true``) is to require just the individual dependencies you need, instead of ``dojo/_base/html``.  The new locations of its functions are indicated in the list below.


========
Features
========

* `dojo.byId <dojo/byId>`_

  Returns the DOM node with the matching 'id.  Alias of ``dom.byId`` in ``dojo/dom``.

* `dojo.isDescendant <dojo/isDescendant>`_

  Determines whether a node is a descendant of another.  Alias of ``dom.isDescendant`` in ``dojo/dom``.

* `dojo.setSelectable <dojo/setSelectable>`_

  Enables or disables selection on a node.  Alias of ``dom.setSelectable`` in ``dojo/dom``.

* `dojo.getAttr <dojo/getAttr>`_

  Gets an attribute on an HTML element. Alias of ``domAttr.get`` in ``dojo/dom-attr``.

* `dojo.setAttr <dojo/setAttr>`_

  Sets an attribute on an HTML element. Alias of ``domAttr.set`` in ``dojo/dom-attr``.

* `dojo.hasAttr <dojo/hasAttr>`_

  Returns true if the requested attribute is specified on the given element, false otherwise. Alias of ``domAttr.has`` in ``dojo/dom-attr``.

* `dojo.removeAttr <dojo/removeAttr>`_

  Removes an attribute from an HTML element.  Alias of ``domAttr.remove`` in ``dojo/dom-attr``.

* `dojo.getPropNode <dojo/getPropNode>`_

  Returns an effective value of a property or an attribute.  Alias of ``domAttr.getNodeProp`` in ``dojo/dom-attr``.

* `dojo.attr <dojo/attr>`_

  Gets or sets an attribute on an HTML element.

* `dojo.hasClass <dojo/hasClass>`_

  Returns whether or not the specified classes are a portion of the class list currently applied to the node.  Alias of ``domClass.contains`` in ``dojo/dom-class``.

* `dojo.addClass <dojo/addClass>`_

  Adds the specified classes to the end of the class list on the passed node. Will not re-apply duplicate classes. Alias of ``domClass.add`` in ``dojo/dom-class``.

* `dojo.removeClass <dojo/removeClass>`_

  Removes the specified classes from node. No ``dojo.hasClass`` check is required.  Alias of ``domClass.remove`` in ``dojo/dom-class``.

* `dojo.toggleClass <dojo/toggleClass>`_

  Adds a class to node if not present, or removes if present. Pass a boolean condition if you want to explicitly add or remove. Returns the condition that was specified directly or indirectly.  Alias of ``domClass.toggle`` in ``dojo/dom-class``.

* `dojo.replaceClass <dojo/replaceClass>`_

  Replaces one or more classes on a node if not present. Operates more quickly than calling ``dojo.removeClass`` and ``dojo.addClass``.  Alias of ``domClass.replace`` in ``dojo/dom-class``.

* `dojo.toDom <dojo/toDom>`_

  Instantiates an HTML fragment returning the corresponding DOM.  Alias of ``domConstruct.toDom`` in ``dojo/dom-construct``.

* `dojo.place <dojo/place>`_

  Attempt to insert node into the DOM, choosing from various positioning options. Returns the first argument resolved to a DOM node.  Alias of ``domConstruct.place`` in ``dojo/dom-construct``.

* `dojo.create <dojo/create>`_

  Create an element, allowing for optional attribute decoration and placement.  Alias of ``domConstruct.create`` in ``dojo/dom-construct``.

* `dojo.empty <dojo/empty>`_

  Safely removes all children of the node.  Alias of ``domConstruct.empty`` in ``dojo/dom-construct``.

* `dojo.destroy <dojo/destroy>`_

  Removes a node from its parent, clobbering it and all of its children.  Alias of ``domConstruct.destroy`` in ``dojo/dom-construct``.

* `dojo.getPadExtents <dojo/getPadExtents>`_

  Returns object with special values specifically useful for node fitting.  Alias of ``domGeom.getPadExtents`` in ``dojo/dom-geometry``.

* `dojo.getBorderExtents <dojo/getBorderExtents>`_

  Returns an object with properties useful for noting the border dimensions.  Alias of ``domGeom.getBorderExtents`` in ``dojo/dom-geometry``.

* `dojo.getPadBorderExtents <dojo/getPadBorderExtents>`_

  Returns object with properties useful for box fitting with regards to padding.  Alias of ``domGeom.getPadBorderExtents`` in ``dojo/dom-geometry``.

* `dojo.getMarginExtents <dojo/getMarginExtents>`_

  Returns object with properties useful for box fitting with regards to box margins (i.e., the outer-box).  Alias of ``domGeom.getMarginExtents`` in ``dojo/dom-geometry``.

* `dojo.getMarginSize <dojo/getMarginSize>`_

  Returns an object that encodes the width and height of the node's margin box.  Alias of ``domGeom.getMarginSize`` in ``dojo/dom-geometry``.

* `dojo.getMarginBox <dojo/getMarginBox>`_

  Returns an object that encodes the width, height, left and top positions of the node's margin box.  Alias of ``domGeom.getMarginBox`` in ``dojo/dom-geometry``.

* `dojo.setMarginBox <dojo/setMarginBox>`_

  Set the size of the node's margin box and placement (left/top), irrespective of box model. Think of it as a passthrough to setBox that handles box-model vagaries for you.  Alias of ``domGeom.setMarginBox`` in ``dojo/dom-geometry``.

* `dojo.getContentBox <dojo/getContentBox>`_

  Returns an object that encodes the width, height, left and top positions of the node's content box, irrespective of the current box model.  Alias of ``domGeom.getContentBox`` in ``dojo/dom-geometry``.

* `dojo.setContentSize <dojo/setContentSize>`_

  Sets the size of the node's contents, irrespective of margins, padding, or borders.  Alias of ``domGeom.setContentSize`` in ``dojo/dom-geometry``.

* `dojo.isBodyLtr <dojo/isBodyLtr>`_

  Returns true if the current language is left-to-right, and false otherwise.  Alias of ``domGeom.isBodyLtr`` in ``dojo/dom-geometry``.

* `dojo.docScroll <dojo/docScroll>`_

  Returns an object with {node, x, y} with corresponding offsets.  Alias of ``domGeom.docScroll`` in ``dojo/dom-geometry``.

* `dojo.getIeDocumentElementOffset <dojo/getIeDocumentElementOffset>`_

  Returns the offset in x and y from the document body to the visual edge of the page for IE.  Alias of ``domGeom.getIeDocumentElementOffset`` in ``dojo/dom-geometry``.

* `dojo.fixIeBiDiScrollLeft <dojo/fixIeBiDiScrollLeft>`_

  In RTL direction, scrollLeft should be a negative value, but IE returns a positive one. All codes using documentElement.scrollLeft must call this function to fix this error, otherwise the position will offset to right when there is a horizontal scrollbar.  Alias of ``domGeom.fixIeBiDiScrollLeft`` in ``dojo/dom-geometry``.

* `dojo.position <dojo/position>`_

  Gets the position and size of the passed element relative to the viewport (if includeScroll==false), or relative to the document root (if includeScroll==true).  Alias of ``domGeom.position`` in ``dojo/dom-geometry``.

* `dojo.marginBox <dojo/marginBox>`_

  Getter/setter for the margin-box of node.

* `dojo.contentBox <dojo/contentBox>`_

  Getter/setter for the content-box of node.

* `dojo.coords <dojo/coords>`_

  Deprecated: Use ``position()`` for border-box x/y/w/h or ``marginBox()`` for margin-box w/h/l/t. Returns an object representing a node's size and position.

* `dojo.getProp <dojo/getProp>`_

  Gets a property on an HTML element.  Alias of ``domProp.get`` in ``dojo/dom-prop``.

* `dojo.setProp <dojo/setProp>`_

  Sets a property on an HTML element.  Alias of ``domProp.set`` in ``dojo/dom-prop``.

* `dojo.prop <dojo/prop>`_

  Gets or sets a property on an HTML element.

* `dojo.getStyle <dojo/getStyle>`_

  Accesses styles on a node.  Alias of ``domStyle.get`` in ``dojo/dom-style``.

* `dojo.setStyle <dojo/setStyle>`_

  Sets styles on a node.  Alias of ``domStyle.set`` in ``dojo/dom-style``.

* `dojo.getComputedStyle <dojo/getComputedStyle>`_

  Returns a `computed style` object.  Alias of ``domStyle.getComputedStyle`` in ``dojo/dom-style``.

* `dojo.toPixelValue <dojo/toPixelValue>`_

  Converts style value to pixels on IE or return a numeric value.  Alias of ``domStyle.toPixelValue`` in ``dojo/dom-style``.

* `dojo.style <dojo/style>`_

  Accesses styles on a node. If 2 arguments are passed, acts as a getter. If 3 arguments are passed, acts as a setter.


========
See also
========

* `dojo.html <dojo/html>`__

  dojo.html.set() inserts (replaces) the given content into the given node

* `dojox.html <dojox/html>`__

  Additional HTML helper functions
