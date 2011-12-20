.. _dojo/setProp:

=============
dojo.setProp
=============

.. contents ::
   :depth: 2

Sets a property on an HTML element.

Introduction
============

Handles normalized setting of properties on DOM nodes.

When passing functions as values, note that they will not be directly assigned to slots on the node, but rather the default behavior will be removed and the new behavior will be added using `dojo.connect()`, meaning that event handler properties will be normalized and that some caveats with regards to non-standard behaviors for onsubmit apply. Namely that you should cancel form submission using `dojo.stopEvent()` on the passed event object instead of returning a boolean value from the handler itself.

Since Dojo 1.7, ``dojo.setProp`` is exposed via the ``set`` method of the ``dojo/dom-prop`` module.  An alias is kept in ``dojo/_base/html`` for backward-compatibility.

Usage
=====

.. js ::
 
  // Dojo 1.7+ (AMD)
  require(["dojo/dom-prop"], function(domProp){
    domProp.set(node, name, value);
  });
  
  // Dojo < 1.7
  dojo.setProp(node, name, value);

node
  id or reference to the element to set the property on

name
  the name of the property to set, or a hash object to set multiple properties at once.

value
  The value to set for the property

This API will return the DOM node.

Examples
========

Dojo 1.7+ (AMD)
---------------

When using AMD format in a fully baseless application, ``set`` is accessed from the ``dojo/dom-prop`` module.

.. js ::

  require(["dojo/dom-prop", "dojo/dom-style"], function(domProp, domStyle){
      // Set the tab index
      domProp.set("nodeId", "tabIndex", 3);

      // Set multiple values at once, including event handlers:
      domProp.set("formId", {
          "foo": "bar",
          "tabIndex": -1,
          "method": "POST",
          "onsubmit": function(e){
              dojo.stopEvent(e);
              dojo.xhrPost({ form: "formId" });
          }
      });

      // Style is a special case: Only set with an object hash of styles
      domProp.set("someNode", {
          id:"bar",
          style:{
              width:"200px", height:"100px", color:"#000"
          }
      });

      // Again, only set style as an object hash of styles:
      var obj = { color:"#fff", backgroundColor:"#000" };
      domProp.set("someNode", "style", obj);
      domStyle.set("someNode", obj);
  });

Alternatively, you can load dojo base in AMD style and continue using ``dojo.setProp`` in the ``define`` or ``require`` callback:

.. js ::

  require(["dojo"], function(dojo){
      // Set the tab index
      dojo.setProp("nodeId", "tabIndex", 3);

      // Set multiple values at once, including event handlers:
      dojo.setProp("formId", {
          "foo": "bar",
          "tabIndex": -1,
          "method": "POST",
          "onsubmit": function(e){
              dojo.stopEvent(e);
              dojo.xhrPost({ form: "formId" });
          }
      });

      // Style is a special case: Only set with an object hash of styles
      dojo.setProp("someNode", {
          id:"bar",
          style:{
              width:"200px", height:"100px", color:"#000"
          }
      });

      // Again, only set style as an object hash of styles:
      var obj = { color:"#fff", backgroundColor:"#000" };
      dojo.setProp("someNode", "style", obj);
      dojo.style("someNode", obj);
  });

Dojo < 1.7
----------

.. js ::

  // Set the tab index
  dojo.setProp("nodeId", "tabIndex", 3);

  // Set multiple values at once, including event handlers:
  dojo.setProp("formId", {
      "foo": "bar",
      "tabIndex": -1,
      "method": "POST",
      "onsubmit": function(e){
          dojo.stopEvent(e);
          dojo.xhrPost({ form: "formId" });
      }
  });

  // Style is a special case: Only set with an object hash of styles
  dojo.setProp("someNode", {
      id:"bar",
      style:{
          width:"200px", height:"100px", color:"#000"
      }
  });

  // Again, only set style as an object hash of styles:
  var obj = { color:"#fff", backgroundColor:"#000" };
  dojo.setProp("someNode", "style", obj);
  dojo.style("someNode", obj);

See also
========

DOM operations:

* :ref:`dojo.prop <dojo/prop>`
* :ref:`dojo.getProp <dojo/getProp>`
