.. _dojo/dom-prop:

=============
dojo/dom-prop
=============

:Project owner:	Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 2

This module defines the core dojo DOM properties API. The convention for the return variable for this module is
``domProp``.

The *deprecated* legacy features are set in :ref:`dojo/_base/html <dojo/_base/html>`.

Features
========

get()
-----

Handles normalized getting of properties on DOM nodes.

Usage
~~~~~

.. js ::
 
  require(["dojo/dom-prop"], function(domProp){
    domProp.get("myNode", "innerHTML");
  });


Attributes
~~~~~~~~~~

======== ============== =====================================================
Argument Type           Description
======== ============== =====================================================
node     String|DomNode ID or reference to the element to get the property on
name     String         The name of the property to get
======== ============== =====================================================

Examples
~~~~~~~~

The following code gets the ``innerHTML`` property of a DOM node.

.. code-example::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/dom-prop", "dojo/dom", "dojo/on", "dojo/domReady!"], 
    function(domProp, dom, on){
      on(dom.byId("execute"), "click", function(){
        var output = domProp.get("example", "innerHTML");
        dom.byId("output").innerHTML = "Node example.innerHTML='" + output + "'";
      });
    });

  .. html ::

    <button id="execute" type="button">domProp.get()</button>
    <div id="example">Hello World!</div>
    <pre id="output"></pre>

set()
-----

Handles normalized setting of properties on DOM nodes.

When passing functions as values, note that they will not be directly assigned to slots on the node, but rather the
default behavior will be removed and the new behavior will be added using ``dojo/_base/connect::connect()``, meaning
that event handler properties will be normalized and that some caveats with regards to non-standard behaviors for
onsubmit apply. Namely that you should cancel form submission using ``dojo/_base/event::stop()`` on the passed event
object instead of returning a boolean value from the handler itself.

Attributes
~~~~~~~~~~

======== ============== ========================================================
Argument Type           Description
======== ============== ========================================================
node     String|DomNode ID or reference to the element to get the property on
name     String|Object  The name of the property to get or a hash of name/values
value    String?        The value to be set
======== ============== ========================================================

Examples
~~~~~~~~

Using ``set()`` to set the value of ``innerHTML`` on a node:

.. code-example::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/dom-prop", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(domProp, dom, on){
      on(dom.byId("execute"), "click", function(){
        domProp.set("example", "innerHTML", "Hello World!");
      });
    });

  .. html ::

    <button id="execute" type="button">domProp.set()</button>
    <div id="example">I'm going to change!</div>

Using ``set()`` to set multiple values in the same call:

.. code-example::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/dom-prop", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(domProp, dom, on){
      on(dom.byId("execute"), "click", function(){
        domProp.set("example", {
          innerHTML: "Hello World!",
          class: "example"
        });
      });
    });

  .. html ::

    <button id="execute" type="button">domProp.set()</button>
    <div id="example">I'm going to change!</div>

  .. css ::

    .example { margin: 1em; padding: 1em; width: 300px; text-align: center; background: blue; color: white; font-weight: bold; }

See also
========

* :ref:`dojo/dom <dojo/dom>` - Core DOM API

* :ref:`dojo/dom-attr <dojo/dom-attr>` - DOM Attribute API

* :ref:`dojo/dom-class <dojo/dom-class>` - Dojo DOM Class API

* :ref:`dojo/dom-style <dojo/dom-style>` - DOM Style API

* :ref:`dojo/_base/html <dojo/_base/html>` - Legacy API aliases
