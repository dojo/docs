.. _dojox/mvc/sync:

==============
dojox/mvc/sync
==============

:Authors: Akira Sudoh, Ed Chatelain
:Developers: Akira Sudoh, Ed Chatelain
:since: V1.8

.. contents ::
  :depth: 2

==================
dojox/mvc/sync API
==================

The module's value is a sync function that can be directly called to synchronize two dojo.Stateful properties.
The sync function is in below form:

.. js ::

  sync(source, sourceProp, target, targetProp, options);

The following parameters should be provided to the sync function:

* source - This is the dojo.Stateful to get one of its properties, or its all properties, to be in sync.
* sourceProp - This is the dojo.Stateful property name in source, or "*". Using "*" means to get all properties in sync. (See `Wildcard syntax`_ section fore more details)
* target - This is the dojo.Stateful to get one of its properties, or its all properties, to be in sync.
* targetProp - This is the dojo.Stateful property name in target, or "*". Using "*" means to get all properties in sync. (See `Wildcard syntax`_ section fore more details)
* options - The optional list of options. (See `Data binding direction`_ section and `Data converter`_ section for more details)

The basic usage looks like below, where target.foo will become "fooValue" as it synchronizes with source.foo:

.. js ::

  require(["dojo/Stateful", "dojox/mvc/sync"], function(Stateful, sync){
    var source = new Stateful({foo: "fooValue"}),
     target = new Stateful();
    sync(source, "foo", target, "foo");
  });

---------------
Wildcard syntax
---------------

When sourceProp and targetProp are "*", sync function tries to synchronize all properties in source/target. The list of properties are determined by the following way:

* If target.get("properties") is there, use it. Otherwise sync function enumerates properties in target, except _watchCallbacks function.
* If target.get("excludes") is there, sync function removes the property names in it, from above list.
* If source.get("properties") is there, sync function removes the property names that are not in it, from above list.

----------------------
Data binding direction
----------------------

By default, sync function watches for changes both at target.targetProp and source.sourceProp and reflects one change to another. sync function allows to specify the direction via options.bindDirection, which are:

* sync.from - Only reflect changes in source.sourceProp to target.targetProp
* sync.to - Only reflect changes in target.targetProp to source.sourceProp
* sync.both - Reflect changes in each other (Default)

--------------
Data converter
--------------

sync function allows source.sourceProp and target.targetProp to have different format as they are synchronized, for example, source.soureProp to have String "2" and target.targetProp to have Number 2. It's done by specifying options.converter, which has some interface compatibility with dojo.number, dojo.date.locale, etc., so that those libraries can be used directly as the converter, by having the following properties:

* format - A function that converts source.sourceProp to target.targetProp. When an error is thrown here, target.targetProp won't be set.
* parse - A function that converts target.targetProp to source.sourceProp. When an error is thrown here, source.sourceProp won't be set.

The basic usage of options.converter is like below:

.. js ::

  sync(source, sourceProp, target, targetProp, {
    converter: {
      format: function(value){
        return "" + value; // Simple conversion from number to string
      },
      parse: function(value){
        return value - 0; // Simple conversion from string to number
      }
    }
  });
