.. _dojo/setStyle:

=============
dojo.setStyle
=============

.. contents ::
   :depth: 2

Sets styles on a node.


Introduction
============

``dojo.setStyle()`` is a companion function for :ref:`dojo.style <dojo/style>`. It sets styles on a node.

Since Dojo 1.7, ``dojo.setStyle`` is exposed via the ``set`` method of the ``dojo/dom-style`` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

.. js ::

  // Dojo 1.7+ (AMD)
  require(["dojo/dom-style"], function(domStyle){
    domStyle.set(node, name, value);
  });
  
  // Dojo < 1.7
  dojo.setStyle(node, name, value);

node
  id or reference to node to set style for.

name
  the style property to set in DOM-accessor format or an object with key/value pairs suitable for setting each property.

value
  If passed, sets value on the node for style, handling cross-browser concerns.  When setting a pixel value, be sure to include &quot;px&quot; in the value. For instance, top: 200px. Otherwise, in some cases, some browsers will not apply the style.


Examples
========

Dojo 1.7+ (AMD)
---------------

When using AMD format in a fully baseless application, ``set`` is accessed from the ``dojo/dom-style`` module.

.. js ::
  
  require(["dojo/dom-style", "dojo/query", "dojo/NodeList-dom"], function(domStyle, query){
    // Passing a node, a style property, and a value changes the current display of the node and returns the new computed value
    domStyle.set("thinger", "opacity", 0.5); // == 0.5

    // Passing a node, an object-style style property sets each of the values in turn and returns the computed style object of the node:
    domStyle.set("thinger", {
      "opacity": 0.5,
      "border": "3px solid black",
      "height": "300px"
    });

    // When the CSS style property is hyphenated, the JavaScript property is camelCased.
    // font-size becomes fontSize, and so on.
    domStyle.set("thinger", {
      fontSize:"14pt",
      letterSpacing:"1.2em"
    });

    // dojo.NodeList implements .style() using the same syntax, omitting the "node" parameter,
    // calling dojo.style() on every element of the list. See: dojo.query() and dojo.NodeList
    query(".someClassName").style("visibility", "hidden");
    // or
    query("#baz > div").style({
      opacity:0.75,
      fontSize:"13pt"
    });
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.setStyle`` in the ``define`` or ``require`` callback:

.. js ::
  
  require(["dojo"], function(dojo){
    // Passing a node, a style property, and a value changes the current display of the node and returns the new computed value
    dojo.setStyle("thinger", "opacity", 0.5); // == 0.5

    // Passing a node, an object-style style property sets each of the values in turn and returns the computed style object of the node:
    dojo.setStyle("thinger", {
      "opacity": 0.5,
      "border": "3px solid black",
      "height": "300px"
    });

    // When the CSS style property is hyphenated, the JavaScript property is camelCased.
    // font-size becomes fontSize, and so on.
    dojo.setStyle("thinger", {
      fontSize:"14pt",
      letterSpacing:"1.2em"
    });

    // dojo.NodeList implements .style() using the same syntax, omitting the "node" parameter,
    // calling dojo.style() on every element of the list. See: dojo.query() and dojo.NodeList
    dojo.query(".someClassName").style("visibility", "hidden");
    // or
    dojo.query("#baz > div").style({
      opacity:0.75,
      fontSize:"13pt"
    });
  });

Dojo < 1.7
----------

.. js ::
  
  // Passing a node, a style property, and a value changes the current display of the node and returns the new computed value
  dojo.setStyle("thinger", "opacity", 0.5); // == 0.5

  // Passing a node, an object-style style property sets each of the values in turn and returns the computed style object of the node:
  dojo.setStyle("thinger", {
    "opacity": 0.5,
    "border": "3px solid black",
    "height": "300px"
  });

  // When the CSS style property is hyphenated, the JavaScript property is camelCased.
  // font-size becomes fontSize, and so on.
  dojo.setStyle("thinger", {
    fontSize:"14pt",
    letterSpacing:"1.2em"
  });

  // dojo.NodeList implements .style() using the same syntax, omitting the "node" parameter,
  // calling dojo.style() on every element of the list. See: dojo.query() and dojo.NodeList
  dojo.query(".someClassName").style("visibility", "hidden");
  // or
  dojo.query("#baz > div").style({
    opacity:0.75,
    fontSize:"13pt"
  });

See also
========

DOM operations:

* :ref:`dojo.style <dojo/style>`
* :ref:`dojo.getComputedStyle <dojo/getComputedStyle>`
* :ref:`dojo.getStyle <dojo/getStyle>`
* :ref:`dojo.attr <dojo/attr>`

External links:

* `DOM Attributes and The Dojo Toolkit 1.2 <http://www.sitepen.com/blog/2008/10/23/dom-attributes-and-the-dojo-toolkit-12/>`_
