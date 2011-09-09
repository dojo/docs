#format dojo_rst

dojo._base.html
===============

:Status: Draft
:Version: 1.0
:Available: since V?

.. contents::
    :depth: 2


**dojo._base.html** contains basic DOM handling functions.

As with all dojo._base components, these functions are included within Dojo Base. This module is basically an alias of other modules (like "dojo/dom", "dojo/attr"...), it's just for compatibility. For Dojo 1.7 (AMD), You get this functionality by coding "require(['dojo/_base/html'], function() { ... });". For Dojo < 1.7, You get this functionality by just including dojo.js or dojo.xd.js in your page.


========
Features
========

* `dojo.byId <dojo/byId>`_

  Returns the DOM node with the matching 'id. It's an alias of dom.byId in dojo/dom.

* `dojo.isDescendant <dojo/isDescendant>`_

  It's an alias of dom.isDescendant in dojo/dom.

* `dojo.setSelectable <dojo/setSelectable>`_

  It's an alias of dom.setSelectable in dojo/dom.

* `dojo.getAttr <dojo/getAttr>`_

  Gets an attribute on an HTML element. It's an alias of attr.get in dojo/dom-attr.

* `dojo.setAttr <dojo/setAttr>`_

  Sets an attribute on an HTML element. It's an alias of attr.set in dojo/dom-attr.

* `dojo.hasAttr <dojo/hasAttr>`_

  Returns true if the requested attribute is specified on the given element, and false otherwise. It's an alias of attr.has in dojo/dom-attr.

* `dojo.removeAttr <dojo/removeAttr>`_

  Removes an attribute from an HTML element. It's an alias of attr.remove in dojo/dom-attr.

* `dojo.getPropNode <dojo/getPropNode>`_

  Returns an effective value of a property or an attribute. It's an alias of attr.getNodeProp in dojo/dom-attr.

* `dojo.attr <dojo/attr>`_

  Gets or sets an attribute on an HTML element.

* `dojo.hasClass <dojo/hasClass>`_

  Returns whether or not the specified classes are a portion of the class list currently applied to the node. It's an alias of cls.contains in dojo/dom-class.

* `dojo.addClass <dojo/addClass>`_

  Adds the specified classes to the end of the class list on the passed node. Will not re-apply duplicate classes. It's an alias of cls.add in dojo/dom-class.

* `dojo.removeClass <dojo/removeClass>`_

  Removes the specified classes from node. No `dojo.hasClass` check is required. It's an alias of cls.remove in dojo/dom-class.

* `dojo.toggleClass <dojo/toggleClass>`_

  Adds a class to node if not present, or removes if present. Pass a boolean condition if you want to explicitly add or remove. Returns the condition that was specified directly or indirectly. It's an alias of cls.toggle in dojo/dom-class.

* `dojo.replaceClass <dojo/replaceClass>`_

  Replaces one or more classes on a node if not present. Operates more quickly than calling dojo.removeClass and dojo.addClass It's an alias of cls.replace in dojo/dom-class.

* `dojo.toDom <dojo/toDom>`_

  Instantiates an HTML fragment returning the corresponding DOM. It's an alias of ctr.toDom in dojo/dom-construct.

* `dojo.place <dojo/place>`_

  Attempt to insert node into the DOM, choosing from various positioning options. Returns the first argument resolved to a DOM node. It's an alias of ctr.place in dojo/dom-construct.

* `dojo.create <dojo/create>`_

  Create an element, allowing for optional attribute decoration and placement. It's an alias of ctr.create in dojo/dom-construct.

* `dojo.empty <dojo/empty>`_

  Safely removes all children of the node. It's an alias of ctr.empty in dojo/dom-construct.

* `dojo.destroy <dojo/destroy>`_

  Removes a node from its parent, clobbering it and all of its children. It's an alias of ctr.destroy in dojo/dom-construct.

* `dojo.getPadExtents <dojo/getPadExtents>`_

  Returns object with special values specifically useful for node fitting. It's an alias of geom.getPadExtents in dojo/dom-geometry.

* `dojo.getBorderExtents <dojo/getBorderExtents>`_

  Returns an object with properties useful for noting the border dimensions. It's an alias of geom.getBorderExtents in dojo/dom-geometry.

* `dojo.getPadBorderExtents <dojo/getPadBorderExtents>`_

  Returns object with properties useful for box fitting with regards to padding. It's an alias of geom.getPadBorderExtents in dojo/dom-geometry.

* `dojo.getMarginExtents <dojo/getMarginExtents>`_

  Returns object with properties useful for box fitting with regards to box margins (i.e., the outer-box). It's an alias of geom.getMarginExtents in dojo/dom-geometry.

* `dojo.getMarginSize <dojo/getMarginSize>`_

  Returns an object that encodes the width and height of the node's margin box. It's an alias of geom.getMarginSize in dojo/dom-geometry.

* `dojo.getMarginBox <dojo/getMarginBox>`_

  Returns an object that encodes the width, height, left and top positions of the node's margin box. It's an alias of geom.getMarginBox in dojo/dom-geometry.

* `dojo.setMarginBox <dojo/setMarginBox>`_

  Set the size of the node's margin box and placement (left/top), irrespective of box model. Think of it as a passthrough to setBox that handles box-model vagaries for you. It's an alias of geom.setMarginBox in dojo/dom-geometry.

* `dojo.getContentBox <dojo/getContentBox>`_

  Returns an object that encodes the width, height, left and top positions of the node's content box, irrespective of the current box model. It's an alias of geom.getContentBox in dojo/dom-geometry.

* `dojo.setContentSize <dojo/setContentSize>`_

  Sets the size of the node's contents, irrespective of margins, padding, or borders. It's an alias of geom.setContentSize in dojo/dom-geometry.

* `dojo.isBodyLtr <dojo/isBodyLtr>`_

  Returns true if the current language is left-to-right, and false otherwise. It's an alias of geom.isBodyLtr in dojo/dom-geometry.

* `dojo.docScroll <dojo/docScroll>`_

  Returns an object with {node, x, y} with corresponding offsets. It's an alias of geom.docScroll in dojo/dom-geometry.

* `dojo.getIeDocumentElementOffset <dojo/getIeDocumentElementOffset>`_

  Returns the offset in x and y from the document body to the visual edge of the page for IE. It's an alias of geom.getIeDocumentElementOffset in dojo/dom-geometry.

* `dojo.fixIeBiDiScrollLeft <dojo/fixIeBiDiScrollLeft>`_

  In RTL direction, scrollLeft should be a negative value, but IE returns a positive one. All codes using documentElement.scrollLeft must call this function to fix this error, otherwise the position will offset to right when there is a horizontal scrollbar. It's an alias of geom.fixIeBiDiScrollLeft in dojo/dom-geometry.

* `dojo.position <dojo/position>`_

  Gets the position and size of the passed element relative to the viewport (if includeScroll==false), or relative to the document root (if includeScroll==true). It's an alias of geom.position in dojo/dom-geometry.

* `dojo.marginBox <dojo/marginBox>`_

  Getter/setter for the margin-box of node.

* `dojo.contentBox <dojo/contentBox>`_

  Getter/setter for the content-box of node.

* `dojo.coords <dojo/coords>`_

  Deprecated: Use position() for border-box x/y/w/h or marginBox() for margin-box w/h/l/t. Returns an object representing a node's size and position.

* `dojo.getProp <dojo/getProp>`_

  Gets a property on an HTML element. It's an alias of prop.get in dojo/dom-prop.

* `dojo.setProp <dojo/setProp>`_

  Sets a property on an HTML element. It's an alias of prop.set in dojo/dom-prop.

* `dojo.prop <dojo/prop>`_

  Gets or sets a property on an HTML element.

* `dojo.getStyle <dojo/getStyle>`_

  Accesses styles on a node. It's an alias of style.get in dojo/dom-style.

* `dojo.setStyle <dojo/setStyle>`_

  Sets styles on a node. It's an alias of style.set in dojo/dom-style.

* `dojo.getComputedStyle <dojo/getComputedStyle>`_

  Returns a `computed style` object. It's an alias of style.getComputedStyle in dojo/dom-style.

* `dojo.toPixelValue <dojo/toPixelValue>`_

  Converts style value to pixels on IE or return a numeric value. It's an alias of style.toPixelValue in dojo/dom-style.

* `dojo.style <dojo/style>`_

  Accesses styles on a node. If 2 arguments are passed, acts as a getter. If 3 arguments are passed, acts as a setter.


========
See also
========

* `dojo.html <dojo/html>`__

  dojo.html.set() to inserts (replaces) the given content into the given node

* `dojox.html <dojox/html>`__

  Additional HTML helper functions
