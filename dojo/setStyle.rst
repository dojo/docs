#format dojo_rst

dojo.setStyle
=============

:Available: since V1.2

.. contents::
   :depth: 2

Sets styles on a node.


============
Introduction
============

``dojo.setStyle()`` is a companion function for `dojo.style <dojo/style>`_. It sets styles on a node.

Since 1.7 it will be replaced by style.set in dojo/dom-style.


=====
Usage
=====

.. code-block :: javascript
 :linenos:

  dojo.setStyle(node, name, value);

node
  id or reference to node to set style for.

name
  the style property to set in DOM-accessor format or an object with key/value pairs suitable for setting each property.

value
  If passed, sets value on the node for style, handling cross-browser concerns.  When setting a pixel value, be sure to include &quot;px&quot; in the value. For instance, top: 200px. Otherwise, in some cases, some browsers will not apply the style.


========
Examples
========

Dojo 1.7 (AMD)
--------------
In dojo 1.7, dojo.getStyle has been moved to dojo/_base/html.

.. code-block :: javascript

  require(["dojo/_base/html", "dojo/query"], function(dojo, query){   
      // Passing a node, a style property, and a value changes the current display of the node and returns the new computed value
      dojo.setStyle("thinger", "opacity", 0.5); // == 0.5

      // Passing a node, an object-style style property sets each of the values in turn and returns the computed style object of the node:
      dojo.setStyle("thinger", {
	 "opacity": 0.5,
	 "border": "3px solid black",
	 "height": "300px"
      });

      // When the CSS style property is hyphenated, the JavaScript property is camelCased.font-size becomes fontSize, and so on.
      dojo.setStyle("thinger",{
	 fontSize:"14pt",
	 letterSpacing:"1.2em"
      });

      // dojo.NodeList implements .style() using the same syntax, omitting the "node" parameter, calling dojo.style() on every element of the list. See: dojo.query()` and `dojo.NodeList()`
      query(".someClassName").style("visibility","hidden");
      // or
      query("#baz > div").style({
		opacity:0.75,
		fontSize:"13pt"
      });
  });

It's recommend to use style.get in dojo 1.7.

.. code-block :: javascript

  require(["dojo/dom-style", "dojo/query"], function(style, query){   
      // Passing a node, a style property, and a value changes the current display of the node and returns the new computed value
      style.set("thinger", "opacity", 0.5); // == 0.5

      // Passing a node, an object-style style property sets each of the values in turn and returns the computed style object of the node:
      style.set("thinger", {
	 "opacity": 0.5,
	 "border": "3px solid black",
	 "height": "300px"
      });

      // When the CSS style property is hyphenated, the JavaScript property is camelCased.font-size becomes fontSize, and so on.
      style.set("thinger",{
	 fontSize:"14pt",
	 letterSpacing:"1.2em"
      });

      // dojo.NodeList implements .style() using the same syntax, omitting the "node" parameter, calling dojo.style() on every element of the list. See: dojo.query()` and `dojo.NodeList()`
      query(".someClassName").style("visibility","hidden");
      // or
      query("#baz > div").style({
		opacity:0.75,
		fontSize:"13pt"
      });
  });

Dojo < 1.7
----------

.. code-block :: javascript

      // Passing a node, a style property, and a value changes the current display of the node and returns the new computed value
      dojo.setStyle("thinger", "opacity", 0.5); // == 0.5

      // Passing a node, an object-style style property sets each of the values in turn and returns the computed style object of the node:
      dojo.setStyle("thinger", {
	 "opacity": 0.5,
	 "border": "3px solid black",
	 "height": "300px"
      });

      // When the CSS style property is hyphenated, the JavaScript property is camelCased.font-size becomes fontSize, and so on.
      dojo.setStyle("thinger",{
	 fontSize:"14pt",
	 letterSpacing:"1.2em"
      });

      // dojo.NodeList implements .style() using the same syntax, omitting the "node" parameter, calling dojo.style() on every element of the list. See: dojo.query()` and `dojo.NodeList()`
      dojo.query(".someClassName").style("visibility","hidden");
      // or
      dojo.query("#baz > div").style({
		opacity:0.75,
		fontSize:"13pt"
      });

========
See also
========

DOM operations:

* `dojo.style <dojo/style>`_
* `dojo.getComputedStyle <dojo/getComputedStyle>`_
* `dojo.getStyle <dojo/getStyle>`_
* `dojo.attr <dojo/attr>`_

External links:

* `DOM Attributes and The Dojo Toolkit 1.2 <http://www.sitepen.com/blog/2008/10/23/dom-attributes-and-the-dojo-toolkit-12/>`_
