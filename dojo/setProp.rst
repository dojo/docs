#format dojo_rst

dojo.setProp
=============

:Available: since V1.2

.. contents::
   :depth: 2

Sets a property on an HTML element. 

============
Introduction
============

Handles normalized setting of properties on DOM nodes. 

When passing functions as values, note that they will not be directly assigned to slots on the node, but rather the default behavior will be removed and the new behavior will be added using `dojo.connect()`, meaning that event handler properties will be normalized and that some caveats with regards to non-standard behaviors for onsubmit apply. Namely that you should cancel form submission using `dojo.stopEvent()` on the passed event object instead of returning a boolean value from the handler itself. 

Since 1.7 it will be replaced by prop.set in dojo/dom-prop.

=====
Usage
=====

.. code-block :: javascript
 :linenos:

  dojo.setProp(node, name, value);

node
  id or reference to the element to set the property on 

name
  the name of the property to set, or a hash object to set multiple properties at once. 

value
  The value to set for the property 

This API will return the DOM node.

========
Examples
========

In dojo 1.7, dojo.getProp has been moved to dojo/_base/html.

Dojo 1.7 (AMD)
--------------

.. code-block :: javascript

  require(["dojo/_base/html"], function(dojo){   
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
      dojo.setProp("someNode",{ 
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

It's recommend to use prop.set in dojo 1.7.

.. code-block :: javascript

  require(["dojo/dom-prop", "dojo/dom-style"], function(prop, style){   
      // Set the tab index 
      prop.set("nodeId", "tabIndex", 3); 

      // Set multiple values at once, including event handlers: 
      prop.set("formId", { 
          "foo": "bar", 
          "tabIndex": -1, 
          "method": "POST", 
          "onsubmit": function(e){ 
              dojo.stopEvent(e); 
              dojo.xhrPost({ form: "formId" }); 
          } 
      });

      // Style is a special case: Only set with an object hash of styles 
      prop.set("someNode",{ 
          id:"bar", 
          style:{ 
              width:"200px", height:"100px", color:"#000" 
          } 
      }); 

      // Again, only set style as an object hash of styles: 
      var obj = { color:"#fff", backgroundColor:"#000" }; 
      prop.set("someNode", "style", obj); 
      style.set("someNode", obj); 
  });

Dojo < 1.7
----------

.. code-block :: javascript

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
      dojo.setProp("someNode",{ 
          id:"bar", 
          style:{ 
              width:"200px", height:"100px", color:"#000" 
          } 
      }); 

      // Again, only set style as an object hash of styles: 
      var obj = { color:"#fff", backgroundColor:"#000" }; 
      dojo.setProp("someNode", "style", obj); 
      dojo.style("someNode", obj); 

========
See also
========

DOM operations:

* `dojo.prop <dojo/prop>`_
* `dojo.getProp <dojo/getProp>`_
