#format dojo_rst

dojo.getProp
=============

.. contents::
   :depth: 2

Gets a property on an HTML element. 

============
Introduction
============

Handles normalized getting of properties on DOM nodes. 

Since dojo 1.7, this API has been kept in dojo/_base/html as a compatibility of dojo version before, it is an alias of prop.get in dojo/dom-prop.

=====
Usage
=====

.. code-block :: javascript
 :linenos:

  dojo.getProp(node, name);

node
  id or reference to the element to get the property on 

name
  the name of the property to get. 


========
Examples
========

Dojo 1.7 (AMD)
--------------

.. code-block :: javascript

  require(["dojo/_base/html", "dojo/dom"], function(dojo, dom){   
      // get the current value of the "foo" property on a node 
      dojo.getProp(dom.byId("nodeId"), "foo"); 

      // or we can just pass the id: 
      dojo.getProp("nodeId", "foo"); 
  });

It's recommended to use prop.get in dojo 1.7.

.. code-block :: javascript

  require(["dojo/dom-prop", "dojo/dom"], function(prop, dom){   
      // get the current value of the "foo" property on a node 
      prop.get(dom.byId("nodeId"), "foo"); 

      // or we can just pass the id: 
      prop.get("nodeId", "foo"); 
  });

Dojo < 1.7
----------

.. code-block :: javascript

    // get the current value of the "foo" property on a node 
    dojo.getProp(dom.byId("nodeId"), "foo"); 

    // or we can just pass the id: 
    dojo.getProp("nodeId", "foo"); 

========
See also
========

DOM operations:

* `dojo.prop <dojo/prop>`_
* `dojo.setProp <dojo/setProp>`_
