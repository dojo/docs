#format dojo_rst

dojo.Stateful
=============

:Authors: Kris Zyp, Marcus Reimann
:Project owner: Kris Zyp
:Available: since V1.5

.. contents::
   :depth: 2

A new generic interface and base class for getting, setting, and watching for property changes (with getters and setters) in a consistent manner.


============
Introduction
============

TODO: introduce the component/class/method

=====
Usage
=====

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // create a new Stateful object:
   var myObj = new dojo.Stateful();
   // watch changes of property 'foo':
   myObj.watch("foo", function(){
       console.log("foo changed to " + this.get("foo"));
   });
   // test: change obj.foo:
   myObj.set("foo","bar");
 </script>


=================
Available Methods
=================

* `stateful.get <dojo/Stateful#get>`_

  Get a property on a Stateful instance. **new in 1.5**

* `stateful.set <dojo/Stateful#set>`_

  Set a property on a Stateful instance. **new in 1.5**


get
---

Get a property on a Stateful instance. **new in 1.5**

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // create a new Stateful object with foo = 3:
   var myObj = new dojo.Stateful({foo: 3});
   // call the getter for property 'foo':
   myObj.get('foo');  // returns 3
   // alternative syntax:
   myObj.foo;         // returns 3
 </script>


set
---

Set a property on a Stateful instance. **new in 1.5**


watch
-----


========
Examples
========

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

TODO: example


========
See also
========

* `dijit.get <dijit/get>`_ a getter for properties of Dijits
* `dijit.set <dijit/set>`_ a setter for properties of Dijits
