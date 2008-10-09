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

Get the style of a DOM node
---------------------------

Passing only an ID or node returns the computed style object of the node:

.. cv-compound::

  .. cv:: css

     <style type="text/css">
         .style1 { color: red }
     </style>

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.Button");
    </script>

  .. cv:: html

    <div id="poorboy" class="style1">Don't look at me - I'm just a poor DOM node.</div>

    <div dojoType="dijit.form.Button">
        get the current style
        <script type="dojo/method" event="onClick" args="evt">
            // Get the style from DOM node "poorboy":
            alert(dojo.style("poorboy"));
        </script>
    </div>


Get a single style property of a DOM node
-----------------------------------------

Passing a node and a style property returns the current normalized, computed value for that property:

.. cv-compound::

  .. cv:: css

     <style type="text/css">
         .style2 { color: blue }
     </style>

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.Button");
    </script>

  .. cv:: html

    <div id="poorboy2" class="style12">I will tell you anything...</div>

    <div dojoType="dijit.form.Button">
        give me the color
        <script type="dojo/method" event="onClick" args="evt">
            // Get the color property from DOM node "poorboy2":
            alert(dojo.style("poorboy", "color"));
        </script>
    </div>

Set a style property
--------------------

Passing a node, a style property, and a value changes the current display of the node and returns the new computed value:

.. cv-compound::

  .. cv:: css

     <style type="text/css">
         .style3 { color: green }
     </style>

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.Button");
    </script>

  .. cv:: html

    <div id="poorboy3" class="style13">I don't like this green</div>

    <div dojoType="dijit.form.Button">
        give me another color
        <script type="dojo/method" event="onClick" args="evt">
            // Set the color 'grey' to DOM node "poorboy3":
            dojo.style("poorboy3", "color", "grey");
        </script>
    </div>


TODO
----

Passing a node, an object-style style property sets each of the values in turn and returns the computed style object of the node:
dojo.style("thinger", {
    "opacity": 0.5,
    "border": "3px solid black",
    "height": 300
});


TODO
----

When the CSS style property is hyphenated, the JavaScript property is camelCased. font-size becomes fontSize, and so on.

dojo.style("thinger",{
    fontSize:"14pt",
    letterSpacing:"1.2em"
});

TODO
----

dojo.NodeList implements .style() using the same syntax, omitting the "node" parameter, calling dojo.style() on every element of the list. See: dojo.query and dojo.NodeList

dojo.query(".someClassName").style("visibility","hidden");

or

dojo.query("#baz > div").style({
    opacity:0.75,
    fontSize:"13pt"
});


========
See also
========

* TODO: links to other related articles
