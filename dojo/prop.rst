#format dojo_rst

dojo.prop
===============

:Status: Draft
:Version: 1.0
:Available: since 1.0

.. contents::
   :depth: 2

Gets or sets a property on an HTML element.


============
Introduction
============
  Handles normalized getting and setting of properties on DOM Nodes. If 2 arguments are passed, and a the second argument is a string, acts as a getter. If a third argument is passed, or if the second argument is a map of attributes, acts as a setter.
  When passing functions as values, note that they will not be directly assigned to slots on the node, but rather the default behavior will be removed and the new behavior will be added using `dojo.connect()`, meaning that event handler properties will be normalized and that some caveats with regards to non-standard behaviors for onsubmit apply. Namely that you should cancel form submission using `dojo.stopEvent()` on the passed event object instead of returning a boolean value from the handler itself.

=====
Usage
=====

.. code-block :: javascript
 :linenos:

 dojo.prop(node, name, value);

node
  id or reference to the element to get or set the property on

name
  the name of the property to get or set.

value
  The value to set for the property

when used as a getter, the value of the requested property or null if that attribute does not have a specified or default value; when used as a setter, return the DOM node

Dojo 1.7 (AMD)
--------------

In dojo 1.7, this API has been moved to dojo/_base/html.

.. code-block :: javascript
 :linenos:

  require(["dojo/_base/html"], function(dojo){   
     // Get the property of a node
     dojo.prop("nodeId", "foo");

     // Set node property
     dojo.prop("nodeId", "tabIndex", 3);
  });

It's recommend to use prop.get and prop.set in dojo 1.7.

.. code-block :: javascript
 :linenos:

  require(["dojo/dom-prop"], function(prop){   
     // Get the property of a node
     prop.get("nodeId", "foo");

     // Set node property
     prop.set("nodeId", "tabIndex", 3);
  });

Dojo < 1.7
----------

.. code-block :: javascript
 :linenos:

     // Get the property of a node
     dojo.prop("nodeId", "foo");

     // Set node property
     dojo.prop("nodeId", "tabIndex", 3);

========
Examples
========

Get property on a node
----------------------

.. code-block :: javascript
 :linenos:

  // dojo 1.7 (AMD)
  require(["dojo/_base/html", "dojo/dom"], function(dojo, dom){   
     dojo.prop(dom.byId("nodeId"), "foo");
     // or we can just pass the id:
     dojo.prop("nodeId", "foo");
  });

  // recommend in dojo 1.7
  require(["dojo/dom-prop", "dojo/dom"], function(prop, dom){   
     prop.get(dom.byId("nodeId"), "foo");
     // or we can just pass the id:
     prop.get("nodeId", "foo");
  });

  // dojo < 1.7

  // get the current value of the "foo" property on a node
  dojo.prop(dojo.byId("nodeId"), "foo");
  // or we can just pass the id:
  dojo.prop("nodeId", "foo");

Set the tab index
-----------------

.. code-block :: javascript
 :linenos:

  // dojo 1.7 (AMD)
  require(["dojo/_base/html"], function(dojo){   
     dojo.prop("nodeId", "tabIndex", 3);
  });

  // recommend in dojo 1.7
  require(["dojo/dom-prop"], function(prop){   
     prop.set("nodeId", "tabIndex", 3);
  });

  // dojo < 1.7

  dojo.prop("nodeId", "tabIndex", 3);


Set multiple values at once
---------------------------

.. code-block :: javascript
 :linenos:

  // dojo 1.7 (AMD)
  require(["dojo/_base/html"], function(dojo){   
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

  // recommend in dojo 1.7
  require(["dojo/dom-prop"], function(prop){   
     prop.set("formId", {
       "foo": "bar",
       "tabIndex": -1,
       "method": "POST",
       "onsubmit": function(e){
            dojo.stopEvent(e);
            dojo.xhrPost({ form: "formId" });
       }
     });
  });

  // dojo < 1.7
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

.. code-block :: javascript
 :linenos:

  // dojo 1.7 (AMD)
  require(["dojo/_base/html"], function(dojo){   
     dojo.prop("someNode",{
       id:"bar",
       style:{
         width:"200px", height:"100px", color:"#000"
       }
     });
  });

  // recommend in dojo 1.7
  require(["dojo/dom-prop"], function(prop){   
     prop.set("someNode",{
       id:"bar",
       style:{
         width:"200px", height:"100px", color:"#000"
       }
     });
  });

  // dojo < 1.7
  dojo.prop("someNode",{
       id:"bar",
       style:{
         width:"200px", height:"100px", color:"#000"
       }
  });


Set style as an object hash of styles
-------------------------------------

.. code-block :: javascript
 :linenos:

  // dojo 1.7 (AMD)
  require(["dojo/_base/html"], function(dojo){   
     var obj = { color:"#fff", backgroundColor:"#000" };
     dojo.prop("someNode", "style", obj);
     dojo.style("someNode", obj);
  });

  // recommend in dojo 1.7
  require(["dojo/dom-prop", "dojo/dom-style"], function(prop, style){   
     var obj = { color:"#fff", backgroundColor:"#000" };
     prop.set("someNode", "style", obj);
     style.set("someNode", obj);
  });

  // dojo < 1.7
  var obj = { color:"#fff", backgroundColor:"#000" };
  dojo.prop("someNode", "style", obj);
  dojo.style("someNode", obj);

========
See also
========

* `dojo.getProp <dojo/getProp>`_
* `dojo.setProp <dojo.setProp>`_
