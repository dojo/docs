.. _dojo/dom-style:

==============
dojo/dom-style
==============

:Project owner:	Eugene Lazutkin
:Authors: James Burke, Peter Higgins, Eugene Lazutkin, Marcus Reimann
:since: V1.7

.. contents ::
    :depth: 2

This module defines the core dojo DOM style API. The convention for the return variable for this module is ``domStyle``
or ``style``.

Legacy features are set in :ref:`dojo/_base/html <dojo/_base/html>`.

Features
========

.. _dojo/dom-style#getcomputedstyle:

getComputedStyle()
------------------

``getComputedStyle()`` is a companion function for :ref:`get() <dojo/dom-style#get>` and :ref:`set() <dojo/dom-style#set>`. It gets a "computed style" object which can be used to gather information about the current state of the rendered node.

*Note* This may behave differently on different browsers. Values may have different formats and value encodings across browsers.

*Note* This method is expensive.  Wherever possible, reuse the returned object.

Use :ref:`get() <dojo/dom-style#get>` for more consistent (pixelized) return values.

Usage
~~~~~

.. js ::

  require(["dojo/dom-style", "dojo/dom"], function(domStyle, dom){
    var node = dom.byId("myNode");
    var computedStyle = domStyle.getComputedStyle(node);
  });

Attributes
~~~~~~~~~~

======== ======= ======================================================================================
Argument Type    Description
======== ======= ======================================================================================
node     DomNode A reference to a DOM node. Does **NOT** support taking an ID string for speed reasons.
======== ======= ======================================================================================

Examples
~~~~~~~~

The following example computes the style for a node and outputs some of its values.

.. code-example::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/dom-style", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(style, dom, on){
      on(dom.byId("command"), "click", function(){
        var node = dom.byId("example");
        var computedStyle = style.getComputedStyle(node);
        var output = "computedStyle.width: " + computedStyle.width + "<br/>";
        output += "computedStyle.height: " + computedStyle.height + "<br/>";
        output += "computedStyle.backgroundColor: " + computedStyle.backgroundColor + "<br/>";
        dom.byId("output").innerHTML = output;
      });
    });

  .. html ::

    <button id="command" type="button">getComputedStyle()</button>
    <div class="example" id="example">Some example node</div>
    <p><strong>Output:</strong></p>
    <div id="output"></div>

  .. css ::

    .example{
      margin: 1em;
      text-align: center;
      padding: 1em;
      border: 2px solid black;
      color: white;
      background-color: blue;
      width: 200px;
      height: 100px;
    }

.. _dojo/dom-style#get:

get()
-----

``get()`` gets the style value and uses the computed style for the node, so the value will be a calculated value, not
just the immediate ``node.style`` value. Also when getting values, use the specific style names, like
``borderBottomWidth`` instead of ``border`` since compound values like ``border`` are not necessarily returned as
expected. If you want to get node dimensions, use the :ref:`dojo/dom-geometry <dojo/dom-geometry>` module functions.

Usage
~~~~~

.. js ::

  require(["dojo/dom-style"], function(domStyle){
    var width = domStyle.get("someNode", "width");
  });

Using ``get()`` with just supplying a node and node attribute is syntactically equivalent to using
``getComputedStyle()``. For example:

.. js ::

  require(["dojo/dom-style", "dojo/dom"], function(domStyle, dom){
    var node = dom.byId("someNode");
    var getStyle = domStyle.get(node);
    var computedStyle = domStyle.getComputedStyle(node);
    // getStyle == computedStyle
  });

Attributes
~~~~~~~~~~

========= ============== ======================================================================================
Arguments Type           Description
========= ============== ======================================================================================
node      String|DomNode ID or reference to node to get style for
name      String?        The style property to get.  If omitted, then returns the whole computed style object.
========= ============== ======================================================================================

Examples
~~~~~~~~

.. code-example::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/dom-style", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(style, dom, on){
      on(dom.byId("command"), "click", function(){
        var backgroundColor = style.get("example", "backgroundColor");
        dom.byId("output").innerHTML = "example.backgroundColor: " + backgroundColor;
      });
    });

  .. html ::

    <button id="command" type="button">style.get()</button>
    <div class="example" id="example">Some example node</div>
    <p><strong>Output:</strong></p>
    <div id="output"></div>

  .. css ::

    .example{
      margin: 1em;
      text-align: center;
      padding: 1em;
      border: 2px solid black;
      color: white;
      background-color: blue;
      width: 200px;
      height: 100px;
    }

.. _dojo/dom-style#set:

set()
-----

Sets the styles on a DOM node.

Usage
~~~~~

Setting a style is done like:

.. js ::

  require(["dojo/dom-style"], function(domStyle){
    domStyle.set("someNode", "width", "100px");
  });

Multiple styles can be done by using a hash as the ``name`` argument:

.. js ::

  require(["dojo/dom-style"], function(domStyle){
    domStyle.set("someNode", {
      width: "100px",
      backgroundColor: "blue"
    });
  });

To remove an inline style, set the value to an empty string(``""``):

.. js ::

  require(["dojo/dom-style"], function(domStyle){
    domStyle.set("someNode", "display", "");
  });

*Note* CSS attributes that contain a dash are lowerCamelCased in JavaScript. Like as above the CSS ``background-color``
becomes ``backgroundColor``.

Attributes
~~~~~~~~~~

========= ============== ===============================================================================================
Arguments Type           Description
========= ============== ===============================================================================================
node      String|DomNode ID or reference to node to get style for
name      String|Object  The style property to set in DOM-accessor format or an object with key/value pairs suitable for
                         setting each property.
value     String?        If passed, sets value on the node for style, handling cross-browser concerns.  When setting a
                         pixel value, be sure to include "px" in the value. For instance, ``top: "200px"``. Otherwise,
                         in some cases, some browsers will not apply the style.
========= ============== ===============================================================================================

Examples
~~~~~~~~

The following example changes the background color of a node and then shows the return value of the ``set()`` to show
the current value:

.. code-example::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/dom-style", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(style, dom, on){
      on(dom.byId("command"), "click", function(){
        var backgroundColor = style.set("example", "backgroundColor", "green");
        dom.byId("output").innerHTML = "example.backgroundColor: " + backgroundColor;
      });
    });

  .. html ::

    <button id="command" type="button">Green Please!</button>
    <div class="example" id="example">Some example node</div>
    <p><strong>Output:</strong></p>
    <div id="output"></div>

  .. css ::

    .example{
      margin: 1em;
      text-align: center;
      padding: 1em;
      border: 2px solid black;
      color: white;
      background-color: blue;
      width: 200px;
      height: 100px;
    }

The following example changes several style properties at once by passing a hash of the values:

.. code-example::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/dom-style", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(style, dom, on){
      on(dom.byId("command"), "click", function(){
        style.set("example", {
          backgroundColor: "green",
          border: "1px dashed black",
          margin: "0.5em",
          textAlign: "right"
        });
      });
    });

  .. html ::

    <button id="command" type="button">Change Please!</button>
    <div class="example" id="example">Some example node</div>

  .. css ::

    .example{
      margin: 1em;
      text-align: center;
      padding: 1em;
      border: 2px solid black;
      color: white;
      background-color: blue;
      width: 200px;
      height: 100px;
    }

The return values of :ref:`dojo/query <dojo/query>` also allow you to access to the CSS styling information in a similar
way. The following turns all the all the red nodes orange.

.. code-example::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/query", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(query, dom, on){
      on(dom.byId("command"), "click", function(){
        query(".red").style("backgroundColor", "orange");
      });
    });

  .. html ::

    <button id="command" type="button">Change Please!</button>
    <div class="red">A Node!</div>
    <div class="green">A Node!</div>
    <div class="red">A Node!</div>
    <div class="green">A Node!</div>
    <div class="red">A Node!</div>
    <div class="green">A Node!</div>

  .. css ::

    .red, .green { margin: 10px; padding 10px; width: 200px; color: white; font-weight: bold; text-align: center; }
    .red { background-color: red; }
    .green { background-color: green; }

Tips
====

* If the CSS style property is hyphenated, the JavaScript property is camelCased.

  For example: ``font-size`` becomes ``fontSize``

* You will get a ``TypeError: n is null``, if you call ``get()`` or ``set()`` on a non existent DOM node. It's more safe
  to use ``query("#a").style("b", "c");``

* ``get()`` uses ``getComputedStyle()`` to get the style value, so the value will be a calculated value, not just the
  immediate ``node.style`` value.

* Getting the value for a compound style value (like background or border): you need to ask for specific properties,
  like ``bottomBorderWidth``. Getting the ``background`` compound value is not reflected in the way you might think when
  using ``getComputedStyle()``.

* For getting a node's dimensions, use :ref:`dojo/dom-geometry <dojo/dom-geometry>` functions: as the ``.width`` and
  ``.style`` properties are not necessarily accurate from ``getComputedStyle()``.

See also
========

* :ref:`dojo/dom-geometry <dojo/dom-geometry>` - Dojo DOM Geometry API

* :ref:`dojo/dom <dojo/dom>` - Core DOM API

* :ref:`dojo/dom-attr <dojo/dom-attr>` - DOM Attribute API

* :ref:`dojo/dom-class <dojo/dom-class>` - Dojo DOM Class API

* :ref:`dojo/dom-prop <dojo/dom-prop>` - DOM Property API

* :ref:`dojo/_base/html <dojo/_base/html>` - Legacy API aliases
