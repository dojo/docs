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
   dojo.require('dojo.Stateful'); 

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

* `Stateful.get <dojo/Stateful#get>`_

  Get a property on a Stateful instance. ***new in 1.5***

* `Stateful.set <dojo/Stateful#set>`_

  Set a property on a Stateful instance. ***new in 1.5***

* `Stateful.watch <dojo/Stateful#watch>`_

  Watches a property for changes. ***new in 1.5***


========
Examples
========

get
---

Get a property on a Stateful instance. ***new in 1.5***

Get a named property on a Stateful object. The property may
potentially be retrieved via a getter method in subclasses. In the base class
this just retrieves the object's property. 

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

Set a property on a Stateful instance. ***new in 1.5***

Sets named properties on a stateful object and notifies any watchers of 
the property. A programmatic setter may be defined in subclasses.

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // create a new Stateful object:
   var myObj = new dojo.Stateful();
   // watch changes of each property:
   myObj.watch(function(name, oldValue, value){
       // this will be called on the set below
   }
   myObj.set(foo, 5);
 </script>

set() may also be called with a hash of name/value pairs, ex:

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // create a new Stateful object:
   var myObj = new dojo.Stateful();
   // The following is equivalent to calling 
   // set(foo, "Howdy") and set(bar, 3):
   myObj.set({
       foo: "Howdy",
       bar: 3
   })
 </script>

watch
-----

Watches a property for changes. ***new in 1.5***

Parameters:

name:
  Indicates the property to watch. This is optional (the callback may be the only parameter), and if omitted, all the properties will be watched

callback:
  The function to execute when the property changes. This will be called after the property has been changed. The callback will be called with the **this** set to the instance, the first argument as the name of the property, the second argument as the old value and the third argument as the new value.

returns:
  An object handle for the watch. The unwatch method of this object can be used to discontinue watching this property:


.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // create a new Stateful object:
   var myObj = new dojo.Stateful();
   // watch changes of property 'foo':
   var watchHandle = myObj.watch("foo", callback);
   // ...
   // discontinue watching this property:
   watchHandle.unwatch(); // callback won't be called now
 </script>


========
See also
========

* `dijit.get <dijit/get>`_ a getter for properties of Dijits
* `dijit.set <dijit/set>`_ a setter for properties of Dijits
