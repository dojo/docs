.. _dojo/prop:

===============
dojo.prop
===============

.. contents ::
   :depth: 2

Gets or sets a property on an HTML element.


Introduction
============
Handles normalized getting and setting of properties on DOM Nodes. If 2 arguments are passed, and the second argument is a string, acts as a getter. If a third argument is passed, or if the second argument is a map of attributes, acts as a setter.
When passing functions as values, note that they will not be directly assigned to slots on the node, but rather the default behavior will be removed and the new behavior will be added using `dojo.connect()`, meaning that event handler properties will be normalized and that some caveats with regards to non-standard behaviors for onsubmit apply. Namely that you should cancel form submission using `dojo.stopEvent()` on the passed event object instead of returning a boolean value from the handler itself.

Since Dojo 1.7, ``dojo.prop`` is exposed via the ``get`` and ``set`` methods of the ``dojo/dom-prop`` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

.. js ::
  
 // Dojo 1.7+ (AMD)
 require(["dom-prop"], function(domProp){
   domProp.get(node, name);
   domProp.set(node, name, value);
 });
 
 // Dojo < 1.7
 dojo.prop(node, name, value);

node
  id or reference to the element to get or set the property on

name
  the name of the property to get or set.

value
  The value to set for the property

When used as a getter, returns the value of the requested property or null if that attribute does not have a specified or default value; when used as a setter, returns the DOM node.

Dojo 1.7+ (AMD)
---------------

When using AMD format in a fully baseless application, ``get`` and ``set`` are accessed from the ``dojo/dom-prop`` module.

.. js ::
 
  require(["dojo/dom-prop"], function(domProp){
    // Get the property of a node
    domProp.get("nodeId", "foo");

    // Set node property
    domProp.set("nodeId", "tabIndex", 3);
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.prop`` in the ``define`` or ``require`` callback:

.. js ::
 
  require(["dojo"], function(dojo){
    // Get the property of a node
    dojo.prop("nodeId", "foo");

    // Set node property
    dojo.prop("nodeId", "tabIndex", 3);
  });

Dojo < 1.7
----------

.. js ::
 
  // Get the property of a node
  dojo.prop("nodeId", "foo");

  // Set node property
  dojo.prop("nodeId", "tabIndex", 3);

Examples
========

Get property on a node
----------------------

.. js ::
 
  // Dojo 1.7+ (AMD), granular dependencies (recommended)
  require(["dojo/dom-prop", "dojo/dom"], function(domProp, dom){
    // get the current value of the "foo" property on a node
    domProp.get(dom.byId("nodeId"), "foo");
    // or we can just pass the id:
    domProp.get("nodeId", "foo");
  });

  // Dojo 1.7+ (AMD), loading Dojo base
  require(["dojo"], function(dojo){
    // get the current value of the "foo" property on a node
    dojo.prop(dojo.byId("nodeId"), "foo");
    // or we can just pass the id:
    dojo.prop("nodeId", "foo");
  });

  // Dojo < 1.7

  // get the current value of the "foo" property on a node
  dojo.prop(dojo.byId("nodeId"), "foo");
  // or we can just pass the id:
  dojo.prop("nodeId", "foo");

Set the tab index
-----------------

.. js ::
 
  // Dojo 1.7+ (AMD), granular dependencies (recommended)
  require(["dojo/dom-prop"], function(domProp){
    domProp.set("nodeId", "tabIndex", 3);
  });

  // Dojo 1.7+ (AMD), loading Dojo base
  require(["dojo"], function(dojo){
    dojo.prop("nodeId", "tabIndex", 3);
  });

  // Dojo < 1.7

  dojo.prop("nodeId", "tabIndex", 3);


Set multiple values at once
---------------------------

.. js ::
 
  // Dojo 1.7+ (AMD), granular dependencies (recommended)
  require(["dojo/dom-prop"], function(domProp){
    domProp.set("formId", {
      "foo": "bar",
      "tabIndex": -1,
      "method": "POST",
      "onsubmit": function(e){
        dojo.stopEvent(e);
        dojo.xhrPost({ form: "formId" });
      }
    });
  });

  // Dojo 1.7+ (AMD), loading Dojo base
  require(["dojo"], function(dojo){
    dojo.prop("formId", {
      "foo": "bar",
      "tabIndex": -1,
      "method": "POST",
      "onsubmit": function(e){
        dojo.stopEvent(e);
        dojo.xhrPost({ form: "formId" });
      }
    });
  });

  // Dojo < 1.7
  dojo.prop("formId", {
    "foo": "bar",
    "tabIndex": -1,
    "method": "POST",
    "onsubmit": function(e){
      dojo.stopEvent(e);
      dojo.xhrPost({ form: "formId" });
    }
  });

Style special case
------------------

.. js ::
 
  // Dojo 1.7+ (AMD), granular dependencies (recommended)
  require(["dojo/dom-prop"], function(domProp){
    domProp.set("someNode", {
      id:"bar",
      style:{
        width:"200px", height:"100px", color:"#000"
      }
    });
  });

  // Dojo 1.7+ (AMD), loading Dojo base
  require(["dojo"], function(dojo){
    dojo.prop("someNode", {
      id:"bar",
      style:{
        width:"200px", height:"100px", color:"#000"
      }
    });
  });

  // Dojo < 1.7
  dojo.prop("someNode", {
    id:"bar",
    style:{
      width:"200px", height:"100px", color:"#000"
    }
  });


Set style as an object hash of styles
-------------------------------------

.. js ::
 
  // Dojo 1.7+ (AMD), granular dependencies (recommended)
  require(["dojo/dom-prop", "dojo/dom-style"], function(domProp, domStyle){
     var obj = { color:"#fff", backgroundColor:"#000" };
     domProp.set("someNode", "style", obj);
     domStyle.set("someNode", obj);
  });

  // Dojo 1.7+ (AMD), loading Dojo base
  require(["dojo"], function(dojo){
     var obj = { color:"#fff", backgroundColor:"#000" };
     dojo.prop("someNode", "style", obj);
     dojo.style("someNode", obj);
  });

  // Dojo < 1.7
  var obj = { color:"#fff", backgroundColor:"#000" };
  dojo.prop("someNode", "style", obj);
  dojo.style("someNode", obj);

See also
========

* :ref:`dojo.getProp <dojo/getProp>`
* :ref:`dojo.setProp <dojo/setProp>`
