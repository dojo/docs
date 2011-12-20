.. _dojo/style:

==========
dojo.style
==========

:Authors: James Burke, Peter Higgins, Eugene Lazutkin, Marcus Reimann
:since: V1.0

.. contents ::
   :depth: 2

A getter/setter for styles on a DOM node.


Introduction
============

Accesses styles on a node. If 2 arguments are passed and the second argument is a string acts as a getter. If 2 arguments are passed, and the second is an Object, recursively acts as a setter for the key/value paris. If 3 arguments are passed, acts as a setter for a single property.

See the Tips section below for caveats on getting style information, like when using a compound style value (like background or border), and getting node dimensions.

Since Dojo 1.7, ``dojo.style`` is exposed via the ``get`` and ``set`` methods of the ``dojo/dom-style`` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

.. js ::

 // Dojo 1.7+ (AMD)
 require(["dojo/dom-style"], function(domStyle){
   domStyle.get(node, style);
   domStyle.set(node, style, value);
 });
 
 // Dojo < 1.7
 dojo.style(node, style, value);

node
  id or reference of the DOM node to get/set style for

style
  the style property to set in DOM-accessor format ("borderWidth", not "border-width") or an object with key/value pairs suitable for setting each property.

value
  If passed, sets value on the node for style, handling cross-browser concerns. When setting a pixel value, be sure to include "px" in the value. For instance, top: "200px". Otherwise, in some cases, some browsers will not apply the style.


Dojo 1.7+ (AMD)
---------------

When using AMD format in a fully baseless application, ``get`` and ``set`` are accessed from the ``dojo/dom-style`` module.

.. js ::
  
  require(["dojo/dom-style", "dojo/query", "dojo/NodeList-dom"], function(domStyle, query){
    // Passing only an ID or node returns the computed style object of the node:
    domStyle.get("thinger");

    // Passing a node and a style property returns the current normalized, computed value for that property:
    domStyle.get("thinger", "opacity"); // 1 by default

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

Alternatively, you can load dojo base in AMD style and continue using ``dojo.style`` in the ``define`` or ``require`` callback:

.. js ::
  
  require(["dojo"], function(dojo){
    // Passing only an ID or node returns the computed style object of the node:
    dojo.style("thinger");

    // Passing a node and a style property returns the current normalized, computed value for that property:
    dojo.style("thinger", "opacity"); // 1 by default

    // Passing a node, a style property, and a value changes the current display of the node and returns the new computed value
    dojo.style("thinger", "opacity", 0.5); // == 0.5

    // Passing a node, an object-style style property sets each of the values in turn and returns the computed style object of the node:
    dojo.style("thinger", {
            "opacity": 0.5,
            "border": "3px solid black",
            "height": "300px"
    });

    // When the CSS style property is hyphenated, the JavaScript property is camelCased.
    // font-size becomes fontSize, and so on.
    dojo.style("thinger", {
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
  
  // Passing only an ID or node returns the computed style object of the node:
  dojo.style("thinger");

  // Passing a node and a style property returns the current normalized, computed value for that property:
  dojo.style("thinger", "opacity"); // 1 by default

  // Passing a node, a style property, and a value changes the current display of the node and returns the new computed value
  dojo.style("thinger", "opacity", 0.5); // == 0.5

  // Passing a node, an object-style style property sets each of the values in turn and returns the computed style object of the node:
  dojo.style("thinger", {
          "opacity": 0.5,
          "border": "3px solid black",
          "height": "300px"
  });

  // When the CSS style property is hyphenated, the JavaScript property is camelCased.
  // font-size becomes fontSize, and so on.
  dojo.style("thinger", {
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

Examples
========

Get the style of a DOM node
---------------------------

Passing only an ID or node returns the computed style object of the node:

.. code-example ::

  .. css ::

         .style1 { color: red; padding: 10px; border: 1px red solid; }
         #poorboy_styles li { display:inline; }
         #poorboy_styles li .prop { color: blue; }

  .. js ::

        dojo.require("dijit.form.Button");

  .. html ::

    <div id="poorboy" class="style1">Don't look at me - I'm just a poor DOM node.</div>
    <ul id="poorboy_styles"></ul>

    <div data-dojo-type="dijit.form.Button">
        get the current style
        <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
            // Get the style from DOM node "poorboy":
            var s = dojo.style("poorboy");
            for(var i in s){
                var n = dojo.doc.createElement('li');
                n.innerHTML = i + " = <span class='prop'>" + s[i] + "</span>, ";
                dojo.place(n, "poorboy_styles", "last");
            }
        </script>
    </div>


Get a single style property of a DOM node
-----------------------------------------

Passing a node and a style property returns the current normalized, computed value for that property:

.. code-example ::

  .. css ::

         .style2 { color: blue; padding: 10px; border: 1px blue solid; }

  .. js ::

        dojo.require("dijit.form.Button");

  .. html ::

    <div id="poorboy2" class="style2">I will tell you anything...</div>

    <div data-dojo-type="dijit.form.Button">
        give me the color
        <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
            // Get the color property from DOM node "poorboy2":
            alert(dojo.style("poorboy2", "color"));
        </script>
    </div>

Set a style property
--------------------

Passing a node, a style property, and a value changes the current display of the node and returns the new computed value:

.. code-example ::

  .. css ::

         .style3 { color: green; padding: 10px; border: 1px green solid; }

  .. js ::

        dojo.require("dijit.form.Button");

  .. html ::

    <div id="poorboy3" class="style3">I don't like this green</div>

    <div data-dojo-type="dijit.form.Button">
        give me another color
        <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
            // Set the color 'red' to DOM node "poorboy3":
            dojo.style("poorboy3", "color", "red");
        </script>
    </div>


Set multiple style properties at once
-------------------------------------

Passing a node, an object-style style property sets each of the values in turn and returns the computed style object of the node:

.. code-example ::

  .. css ::

         .style4 { color: black; padding: 10px; border: 1px black solid; }
         .nib { font-size: 4.2em; }

  .. js ::

        dojo.require("dijit.form.Button");

  .. html ::

    <div id="poorboy4" class="style4"><span class="nib">NIB</span><br/>NODE IN BLACK</div>

    <div data-dojo-type="dijit.form.Button">
        set multiple style properties
        <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
            // Set the color to 'white', background-color to "black", padding to "20px" to DOM node "poorboy4":
            dojo.style("poorboy4", {
                "backgroundColor": "black",
                "color": "white",
                "padding": "20px"
            });
        </script>
    </div>


Use dojo.style() with a list of nodes
-------------------------------------

dojo.NodeList implements .style() using the same syntax, omitting the "node" parameter, calling dojo.style() on every element of the list.

.. code-example ::

  .. css ::

         .style5 { color: black; padding: 10px; border: 1px black solid; }
         .sweet { color: #FF8C8C; }

  .. js ::

        dojo.require("dijit.form.Button");

  .. html ::

    <div id="poorboy5" class="style5">
        <p>The different faces of dojo.style():</p>
        <ul>
            <li class="sweet">dojo.style(node);</li>
            <li class="sweet">dojo.style(node, property);</li>
            <li class="sweet">dojo.style(node, property, value);</li>
            <li class="sweet">dojo.style(node, object);</li>
        </ul>
    </div>

    <div data-dojo-type="dijit.form.Button">
        change the style for each point
        <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
            // Set the backgroundColor, color and opacity
            // for each node found by dojo.query:
            dojo.query(".sweet").style({
                "backgroundColor": "#B822B0",
                "color": "#FFFF00",
                "opacity": 0.5
            });
        </script>
    </div>


Tips
====

* If the CSS style property is hyphenated, the JavaScript property is camelCased.

  for example: "font-size" becomes "fontSize", and so on

* You will get a "TypeError: n is null", if you call dojo.style() on a non existent DOM node. It's more safe to use dojo.query("#a").style("b", "c");

* dojo.style uses getComputedStyle to get the style value, so the value will be a calculated value, not just the immediate node.style value.

* Getting the value for a compound style value (like background or border): you need to ask for specific properties, like bottomBorderWidth. Getting the "background" compound value is not reflected in the way you might think when using getComputedStyle.

* For getting a node's dimensions, use :ref:`dojo.marginBox <dojo/marginBox>` or :ref:`dojo.contentBox <dojo/contentBox>`: the .width and .style properties are not accurate from getComputedStyle.


See also
========

* :ref:`dojo.getStyle <dojo/getStyle>`
* :ref:`dojo.setStyle <dojo/setStyle>`
* :ref:`dojo.addClass <dojo/addClass>`
* :ref:`dojo.hasClass <dojo/hasClass>`
* :ref:`dojo.removeClass <dojo/removeClass>`
* :ref:`dojo.toggleClass <dojo/toggleClass>`
* :ref:`dojo.query <dojo/query>`
* :ref:`dojo.NodeList <dojo/NodeList>`
