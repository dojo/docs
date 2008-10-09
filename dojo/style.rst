#format dojo_rst

dojo.style
==========

:Status: Draft
:Version: 1.0
:Available: since V?

.. contents::
   :depth: 2

A getter/setter for styles on a DOM node.


============
Introduction
============

Accesses styles on a node. If 2 arguments are passed, acts as a getter. If 3 arguments are passed, acts as a setter.


=====
Usage
=====

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   dojo.style = function( node, style, value)
 </script>

node
  id or reference of the DOM node to get/set style for

style
  the style property to set in DOM-accessor format ("borderWidth", not "border-width") or an object with key/value pairs suitable for setting each property.

value
  If passed, sets value on the node for style, handling cross-browser concerns.







========
Examples
========

Programmatic example
--------------------

TODO: example
example:
  Passing only an ID or node returns the computed style object of
  the node:
|	dojo.style("thinger");
example:
  Passing a node and a style property returns the current
  normalized, computed value for that property:
|	dojo.style("thinger", "opacity"); // 1 by default
    //
example:
  Passing a node, a style property, and a value changes the
  current display of the node and returns the new computed value
|	dojo.style("thinger", "opacity", 0.5); // == 0.5
    //
example:
  Passing a node, an object-style style property sets each of the values in turn and returns the computed style object of the node:
|	dojo.style("thinger", {
|		"opacity": 0.5,
|		"border": "3px solid black",
|		"height": 300
|	});
    //
    // 	example:
  When the CSS style property is hyphenated, the JavaScript property is camelCased.
  font-size becomes fontSize, and so on.
|	dojo.style("thinger",{
|		fontSize:"14pt",
|		letterSpacing:"1.2em"
|	});
    //
example:
  dojo.NodeList implements .style() using the same syntax, omitting the "node" parameter, calling
  dojo.style() on every element of the list. See: dojo.query and dojo.NodeList
|	dojo.query(".someClassName").style("visibility","hidden");
|	// or
|	dojo.query("#baz > div").style({
|		opacity:0.75,
|		fontSize:"13pt"
|	});




Declarative example
-------------------

TODO: example


========
See also
========

* TODO: links to other related articles
