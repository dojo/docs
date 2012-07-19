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

The module's value is a ``sync`` function that can be directly called to synchronize two :ref:`dojo/Stateful <dojo/Stateful>` properties.
The ``sync`` function is in below form:

.. js ::

  sync(source, sourceProp, target, targetProp, options);

The following parameters should be provided to the ``sync`` function:

* ``source`` - This is the :ref:`dojo/Stateful <dojo/Stateful>` to get one of its properties, or its all properties, to be in sync.
* ``sourceProp`` - This is the :ref:`dojo/Stateful <dojo/Stateful>` property name in ``source``, or ``*``. Using ``*`` means to get all properties in sync. (See `Wildcard syntax`_ section fore more details)
* ``target`` - This is the :ref:`dojo/Stateful <dojo/Stateful>` to get one of its properties, or its all properties, to be in sync.
* ``targetProp`` - This is the :ref:`dojo/Stateful <dojo/Stateful>` property name in ``target``, or ``*``. Using ``*`` means to get all properties in sync. (See `Wildcard syntax`_ section fore more details)
* ``options`` - The optional list of options. (See `Data binding direction`_ section and `Data converter`_ section for more details)

The basic usage looks like below, where ``target.foo`` will become "fooValue0" as soon as ``sync`` function is called (as it's copied from ``source.foo``), and ``source.foo`` will become "fooValue1" as soon as "fooValue1" is set to ``target.foo``:

.. code-example::
  :djConfig: parseOnLoad: false, async: true, mvc: {debugBindings: true}
  :toolbar: versions, themes
  :version: 1.8-2.0
  :width: 480
  :height: 80

  .. js ::

    require(["dojo/Stateful", "dojox/mvc/sync"], function(Stateful, sync){
      var source = new Stateful({foo: "fooValue0"}),
       target = new Stateful();
      sync(source, "foo", target, "foo"); // Start synchronization between source.foo and target.foo
      alert(target.get("foo"));
      target.set("foo", "fooValue1"); // This change is reflected to source.foo, too, as source.foo is in sync with target.foo by sync function
      alert(source.get("foo"));
    });

``sync`` function returns a handle that allows stopping synchronization at some point in the future. For example:

.. code-example::
  :djConfig: parseOnLoad: false, async: true, mvc: {debugBindings: true}
  :toolbar: versions, themes
  :version: 1.8-2.0
  :width: 480
  :height: 80

  .. js ::

    require(["dojo/Stateful", "dojox/mvc/sync"], function(Stateful, sync){
      var source = new Stateful({foo: "fooValue0"}),
       target = new Stateful();
      var handle = sync(source, "foo", target, "foo"); // Start synchronization between source.foo and target.foo
      alert(target.get("foo"));
      handle.remove(); // Stop synchronization between source.foo and target.foo
      target.set("foo", "fooValue1");
      alert(source.get("foo")); // Still "fooValue0" as synchronization had been stopped before "fooValue1" is set to target.foo
    });

---------------
Wildcard syntax
---------------

When ``sourceProp`` and ``targetProp`` are ``*``, ``sync`` function tries to synchronize all properties in ``source``/``target``. The list of properties are determined by the following way:

* If ``target.get("properties")`` is there, use it. Otherwise ``sync`` function enumerates properties in ``target``, except ``_watchCallbacks`` function.
* If ``target.get("excludes")`` is there, ``sync`` function removes the property names in it, from above list.
* If ``source.get("properties")`` is there, ``sync`` function removes the property names that are not in it, from above list.

----------------------
Data binding direction
----------------------

By default, ``sync`` function watches for changes both at ``target.targetProp`` and ``source.sourceProp`` and reflects one change to another. ``sync`` function allows to specify the direction via ``options.bindDirection``, which are:

* ``sync.from`` - Only reflect changes in ``source.sourceProp`` to ``target.targetProp``
* ``sync.to`` - Only reflect changes in ``target.targetProp`` to ``source.sourceProp``
* ``sync.both`` - Reflect changes in each other (Default)

The basic usage of data binding direction looks like below, where change in ``source.foo`` is reflected to ``target.foo``, but not the way around:

.. code-example::
  :djConfig: parseOnLoad: false, async: true, mvc: {debugBindings: true}
  :toolbar: versions, themes
  :version: 1.8-2.0
  :width: 480
  :height: 80

  .. js ::

    require(["dojo/Stateful", "dojox/mvc/sync"], function(Stateful, sync){
      var source = new Stateful({foo: "fooValue0"}),
       target = new Stateful();
      sync(source, "foo", target, "foo", {bindDirection: sync.from}); // Start one-way synchronization from source.foo to target.foo
      alert(target.get("foo"));
      source.set("foo", "fooValue1"); // This change is reflected to target.foo, too, as target.foo reflects the change in source.foo by sync function
      alert(target.get("foo"));
      target.set("foo", "fooValue2"); // This change won't be reflect to source.foo, as the data binding is only from source.foo to target.foo, not the other way around
      alert(source.get("foo")); // source.foo still is "fooValue1"
    });

--------------
Data converter
--------------

``sync`` function allows ``source.sourceProp`` and ``target.targetProp`` to have different format as they are synchronized, for example, ``source.soureProp`` to have String ``"2"`` and ``target.targetProp`` to have Number ``2``. It's done by specifying ``options.converter``, which has some interface compatibility with ``dojo/number``, ``dojo/date/locale``, etc., so that those libraries can be used directly as the converter, by having the following properties:

* ``format`` - A function that converts ``source.sourceProp`` to ``target.targetProp``. When an error is thrown here, ``target.targetProp`` won't be set. It has optional 2nd parameter (``options``), which is passed in if ``constraints`` property exists in ``source`` or ``target`` passed into ``sync`` function.
* ``parse`` - A function that converts ``target.targetProp`` to ``source.sourceProp``. When an error is thrown here, ``source.sourceProp`` won't be set. It has optional 2nd parameter (``options``), which is passed in if ``constraints`` property exists in ``source`` or ``target`` passed into ``sync`` function.

The basic usage of ``options.converter`` is like below:

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

An example of using ``dojo/date/locale`` as data converter is like below:

.. code-example::
  :djConfig: parseOnLoad: false, async: true, mvc: {debugBindings: true}
  :toolbar: versions, themes
  :version: 1.8-2.0
  :width: 480
  :height: 80

  .. js ::

    require(["dojo/Stateful", "dojo/date/locale", "dojox/mvc/sync"], function(Stateful, dateLocale, sync){
      var source = new Stateful({date: new Date(1970, 0, 1, 0, 0, 0, 0)}),
       target = new Stateful();
      sync(source, "date", target, "date", {converter: dateLocale}); // Start synchronization between source.date and target.date
      alert(target.get("date")); // target shows formatted date
      source.set("date", new Date()); // This change is reflected to target.date, target.date will be formatted version of newer date
      alert(target.get("date"));
    });
