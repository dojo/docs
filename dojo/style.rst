#format dojo_rst

dojo.style
==========

:Authors: James Burke, Peter Higgins, Eugene Lazutkin, Marcus Reimann
:Available: since V1.0

.. contents::
   :depth: 2

A getter/setter for styles on a DOM node.


============
Introduction
============

Accesses styles on a node. If 2 arguments are passed and the second argument is a string acts as a getter. If 2 arguments are passed, and the second is an Object, recursively acts as a setter for the key/value paris. If 3 arguments are passed, acts as a setter for a single property.

See the Tips section below for caveats on getting style information, like when using a compound style value (like background or border), and getting node dimensions.


=====
Usage
=====

.. code-block :: javascript
 :linenos:

 dojo.style(node, style, value);

node
  id or reference of the DOM node to get/set style for

style
  the style property to set in DOM-accessor format ("borderWidth", not "border-width") or an object with key/value pairs suitable for setting each property.

value
  If passed, sets value on the node for style, handling cross-browser concerns. When setting a pixel value, be sure to include "px" in the value. For instance, top: "200px". Otherwise, in some cases, some browsers will not apply the style.


========
Examples
========

Get the style of a DOM node
---------------------------

Passing only an ID or node returns the computed style object of the node:

.. cv-compound::

  .. cv:: css

     <style type="text/css">
         .style1 { color: red; padding: 10px; border: 1px red solid; }
         #poorboy_styles li { display:inline; }
         #poorboy_styles li .prop { color: blue; }
     </style>

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.Button");
    </script>

  .. cv:: html

    <div id="poorboy" class="style1">Don't look at me - I'm just a poor DOM node.</div>
    <ul id="poorboy_styles"></ul>

    <div dojoType="dijit.form.Button">
        get the current style
        <script type="dojo/method" event="onClick" args="evt">
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

.. cv-compound::

  .. cv:: css

     <style type="text/css">
         .style2 { color: blue; padding: 10px; border: 1px blue solid; }
     </style>

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.Button");
    </script>

  .. cv:: html

    <div id="poorboy2" class="style2">I will tell you anything...</div>

    <div dojoType="dijit.form.Button">
        give me the color
        <script type="dojo/method" event="onClick" args="evt">
            // Get the color property from DOM node "poorboy2":
            alert(dojo.style("poorboy2", "color"));
        </script>
    </div>

Set a style property
--------------------

Passing a node, a style property, and a value changes the current display of the node and returns the new computed value:

.. cv-compound::

  .. cv:: css

     <style type="text/css">
         .style3 { color: green; padding: 10px; border: 1px green solid; }
     </style>

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.Button");
    </script>

  .. cv:: html

    <div id="poorboy3" class="style3">I don't like this green</div>

    <div dojoType="dijit.form.Button">
        give me another color
        <script type="dojo/method" event="onClick" args="evt">
            // Set the color 'red' to DOM node "poorboy3":
            dojo.style("poorboy3", "color", "red");
        </script>
    </div>


Set multiple style properties at once
-------------------------------------

Passing a node, an object-style style property sets each of the values in turn and returns the computed style object of the node:

.. cv-compound::

  .. cv:: css

     <style type="text/css">
         .style4 { color: black; padding: 10px; border: 1px black solid; }
         .nib { font-size: 4.2em; }
     </style>

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.Button");
    </script>

  .. cv:: html

    <div id="poorboy4" class="style4"><span class="nib">NIB</span><br/>NODE IN BLACK</div>

    <div dojoType="dijit.form.Button">
        set multiple style properties
        <script type="dojo/method" event="onClick" args="evt">
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

.. cv-compound::

  .. cv:: css

     <style type="text/css">
         .style5 { color: black; padding: 10px; border: 1px black solid; }
         .sweet { color: #FF8C8C; }
     </style>

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.Button");
    </script>

  .. cv:: html

    <div id="poorboy5" class="style5">
        <p>The different faces of dojo.style():</p>
        <ul>
            <li class="sweet">dojo.style(node);</li>
            <li class="sweet">dojo.style(node, property);</li>
            <li class="sweet">dojo.style(node, property, value);</li>
            <li class="sweet">dojo.style(node, object);</li>
        </ul>
    </div>

    <div dojoType="dijit.form.Button">
        change the style for each point
        <script type="dojo/method" event="onClick" args="evt">
            // Set the backgroundColor, color and opacity
            // for each node found by dojo.query:
            dojo.query(".sweet").style({
                "backgroundColor": "#B822B0",
                "color": "#FFFF00",
                "opacity": 0.5
            });
        </script>
    </div>


====
Tips
====

* If the CSS style property is hyphenated, the JavaScript property is camelCased.

  for example: "font-size" becomes "fontSize", and so on

* You will get a "TypeError: n is null", if you call dojo.style() on a non existent DOM node. It's more safe to use dojo.query("#a").style("b","c");

* dojo.style uses getComputedStyle to get the style value, so the value will be a calculated value, not just the immediate node.style value.

* Getting the value for a compound style value (like background or border): you need to ask for specific properties, like bottomBorderWidth. Getting the "background" compound value is not reflected in the way you might think when using getComputedStyle.

* For getting a node's dimensions, use `dojo.marginBox <dojo/marginBox>`_ or `dojo.contentBox <dojo/contentBox>`_: the .width and .style properties are not accurate from getComputedStyle.


========
See also
========

* `Dojo’s got style <http://dojocampus.org/content/2008/04/01/dojos-got-style/>`_

  dojo.style() tutorial from Peter Higgins

* `dojo.addClass <dojo/addClass>`_
* `dojo.hasClass <dojo/hasClass>`_
* `dojo.removeClass <dojo/removeClass>`_
* `dojo.toggleClass <dojo/toggleClass>`_
* `dojo.query <dojo/query>`_
* `dojo.NodeList <dojo/NodeList>`_
