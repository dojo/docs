.. _dojo/Stateful:

=============
dojo/Stateful
=============

:Authors: Kris Zyp, Marcus Reimann, Kitson Kelly, Jan Dockx
:Project owner: Kris Zyp
:since: V1.5

.. contents ::
   :depth: 2

A generic interface and base class for getting, setting, and watching for property changes (with getters and
setters) in a consistent manner. Classes in your model, viewmodel, or view, that have state (i.e., the object
is mutable) should implement this interface.

Introduction
============

``dojo/Stateful`` provides the ability to get and set named properties, including using custom accessors, in conjunction
with the ability to monitor these properties for changes. ``dojo.Stateful`` is intended to be a base class that can be
extended by other components that wish to support watchable properties. This can be very useful for creating live
bindings that utilize current property states and must react to any changes in properties. It also allows a developer to
customize the behavior of accessing the property by providing auto-magic getters and setters (accessors). Furthermore,
``dojo/Stateful`` makes it possible to create instances using `object initialization`.

Usage
=====

You can create an instance of ``dojo/Stateful`` directly, but creating a subclass is recommended:

.. js ::

  require(["dojo/Stateful", "dojo/_base/declare"], function(Stateful, declare){
    // Subclass dojo/Stateful:
    var MyClass = declare([Stateful], {
      foo: null,
      _fooGetter: function(){
        return this.foo;
      },
      _fooSetter: function(value){
        this.foo = value;
      }
    });

    // Create an instance and initialize some property values:
    myObj = new MyClass({
      foo: "baz"
    });

    // Watch changes on a property:
    myObj.watch("foo", function(name, oldValue, value){
      // Do something based on the change
    });

    // Get the value of a property:
    myObj.get("foo");

    // Set the value of a property:
    myObj.set("foo", "bar");
  });

When calling the constructor, you can pass an optional Object argument. This Object will be used
to initialize the object `after` the constructors in the inheritance chain have executed.

get()
-----

Gets the value of a property. If a custom getter is defined for the property, the custom getter will be called instead.
The function takes a single argument:

======== ====== ===============================
Argument Type   Description
======== ====== ===============================
name     String The name of the property to get
======== ====== ===============================

set()
-----

Sets the value of a property. If a custom setter is defined for the property, the custom setter will be used instead.
The function takes up to two arguments:

======== ============= ==============================================================================================
Argument Type          Description
======== ============= ==============================================================================================
name     String|Object The name of the property to set, or a hash of key/value pairs of several properties to set.
value    Any?          *Optional* The value of the property to set, or if ``name`` is a hash, this argument should be
                       omitted.
======== ============= ==============================================================================================

If no custom setter is defined on an object, performing a set() will result in the property value being set directly on the object. This can be convenient, as the property can be accessed directly through standard JS syntax (object.property). But, be aware that setting arbitrary property names could lead to overriding the object's methods (like set(), get(), etc.), which may be undesirable. If you are setting arbitrary property names, you may wish to guard against reserved method names, or prefix property names to avoid collision.

watch()
-------

Sets a callback to be called when the property changes.  The function takes up to two arguments:

======== ======== =================================================================================================
Argument Type     Description
======== ======== =================================================================================================
name     String?  *Optional* The name of the property to watch.  If omitted, all properties will be watched and the
                  callback will be called.
callback Function The callback function that should be called when the property changes.
======== ======== =================================================================================================

``watch()`` returns a handle that allows disconnection of the watch at some point in the future.  For example:

.. js ::

  var handle = myObj.watch("foo", function(name, oldValue, value){
    console.log(name, oldValue, value);
  });
  
  handle.unwatch();

The callback function will be passed three arguments:

======== ====== ============================================
Argument Type   Description
======== ====== ============================================
name     String The name of the property that changed.
oldValue Any    The value of the property before the change.
value    Any    The value of the property after the change.
======== ====== ============================================

_changeAttrValue()
------------------

This is a helper function to be used in custom setters that is used in scenarios where calling ``.set()`` is not
appropriate, but the value of the property needs to be changed and any watches called. The typical scenario is when
there are interlinked values, where changing one value affects another value, and therefore can avoid an infinite loop
of one property changing the value of the other property. The function takes two arguments:

======== ====== ====================================
Argument Type   Description
======== ====== ====================================
name     String The name of the property to change.
value    Any    The value to change the property to.
======== ====== ====================================

Custom Accessors
----------------

``dojo/Stateful`` supports the ability to define custom accessors (getters and setters) that allow control over how values of properties are set and retrieved.  When a custom accessors is defined, a call to ``.get()`` or ``.set()`` will auto-magically use the custom accessor instead of accessing the property directly.

A custom getter is defined in the format of ``_xxxGetter`` and a custom setter is defined in the format of ``_xxxSetter`` where the name of the property is ``xxx``.  The name of the property is not mutated in any way.  For example, the following demonstrates several different examples of how custom accessors would be defined:

.. js ::

  require(["dojo/Stateful", "dojo/_base/declare"], function(Stateful, declare){
    var MyClass = declare([Stateful], {
      foo: null,
      _fooGetter: function(){
        return this.foo;
      },
      _fooSetter: function(value){
        this.foo = value;
      },
      
      fooBar: null,
      _fooBarGetter: function(){
        return this.fooBar;
      },
      _fooBarSetter: function(value){
        this.fooBar = value;
      },
      
      foo_bar: null,
      _foo_barGetter: function(){
        return this.fooBar; 
      },
      _foo_barSetter: function(value){
        this.foo_bar = value;
      }
      
      _foo: null,
      __fooGetter: function(){
        return this._foo;
      },
      __fooSetter: function(value){
        this._foo = value;
      }
    });
  });

In addition, ``.set()`` has the ability to detect promise returns from a custom setter. This can be used in situations
where the customer setter will not be immediately setting the value of the attribute. For example, if a custom setter
needs to validate or post a value to a back end service via XHR before actually setting the value of the attribute. The
custom setter can return a Deferred or promise value and any watch callbacks will not be called until the promise is
resolved. If the promise is rejected, the watch will not be called. For example:

.. js ::

  require(["dojo/Stateful", "dojo/Deferred", "dojo/_base/declare"], 
  function(Stateful, Deferred, declare){
    var MyClass = declare([Stateful], {
      foo: null,
      _fooSetter: function(value){
        var d = new Deferred();
        
        // do something async and then
        this.foo = value;
        d.resolve(true);
        
        return d;
      }
    });
  });

Constructor and object initialization
-------------------------------------

Classes you ``declare`` with :ref:`dojo/_base/declare <dojo/_base/declare>` can have a `postscript` method that is
executed immediately after all the chained constructors in the inheritance chain have finished. In ``Stateful``,
this method is used to do `object initialization` if an instance is constructed with an Object argument:

.. js ::

    // Create an instance and initialize some property values:
    var person = new Person({
      firstName: "John",
      lastName: "Doe",
      company: "Acme"
    });

Your subclass can extend this method, but should not override it:

.. js ::

  require(["dojo/Stateful", "dojo/_base/declare"], function(Stateful, declare){

    var Person = declare([Stateful], {

      postscript: function(kwargs) {
        this.inherited(arguments);
        // do your postscript stuff
        // ...
      }

    });

The constructor in every subclass in the inheritance chain should do its bit to deliver an "empty" instance with
default values for all properties. The constructor should `not` be used to set initial values for properties.

Calling the constructor with an Object argument is only syntactic sugar.

.. js ::

    var person = new Person({
      firstName: "John",
      lastName: "Doe",
      company: "Acme"
    });

is completely equivalent to

.. js ::

    var person = new Person();
    person.set("firstName", "John");
    person.set("lastName", "Doe");
    person.set("company", "Acme");

Note that this is exactly the same thing as C# `object initializers
<http://msdn.microsoft.com/en-us/library/bb384062.aspx>`_. The C# equivalent of the example would be:

.. js ::

    Person person = new Person {
      firstName = "John",
      lastName = "Doe",
      company = "Acme"
    };

There is a good reason for this. For classes in the model, viewmodel and view, that have state (i.e., are mutable),
the only good programming idiom is to have `only a default, no-arguments constructor`. These are exactly the kinds of
classes that would be `Stateful`.

First of all, you always need a no-arguments constructor, because all kinds of frameworks (e.g., the
:ref:`dojo/parser <dojo/parser>`) require it. General code cannot provide specific arguments for a custom constructor.

Second, for model and viewmodel objects, you almost always need to be able to construct an "empty" object.
Although semantically a ``firstName`` might be mandatory, in a UI you cannot make this an invariant of ``Person``.
Sure, every time you get an existing object from the server, it will have a `firstName`, but most often the end user
should also be able to create a new person in the UI, and for that he needs to be able to start out with an "empty"
form. It makes things very difficult if you cannot bind a (view)model object to that empty form, so the (view)model
object must allow even semantically mandatory fields to be empty. Such an object might not be "valid" for sending to
the server, but it must be able to exist.

In a language like Java or C#, you might then add further overloaded constructor methods, for convenience, but you
quickly learn that you then have to write overloaded methods for all possible combinations, if that is possible at all.
Each of these methods carries a slightly different version of initialisation semantics, needs to have its own unit
tests, and needs to be maintained. The gain in a language like Java is being able to write:

.. js ::

  Person person = new Person ("John", "Doe", "Acme");

instead of

.. js ::

  Person person = new Person();
  person.setFirstName("John");
  person.setLastName("Doe");
  person.setCompany("Acme");

In C#, given the object initializer syntax, the gain is even smaller.

All in all, it only makes sense for these kinds of classes to have only a default, no-arguments constructor,
and ``Stateful`` builds on this.

The constructor method then should only be used to set the state of a new instance to some sensible starting state,
representing an "empty" instance, which most often resorts to doing ``NOP``, certainly in a prototypical language.
In the example, we might choose to represent empty values by ``null`` for all 3 properties (alternatives are
``undefined`` or the empty string ``""``). In a language like Java and C# this would require no work, since ``null``
is the default value. In Dojo, the default is ``undefined``, but you set the default in the prototype, not in the
constructor:

.. js ::

  var Person = declare([Stateful], {

    // firstName: String?
    //   The first name of this person.
    //   Optional. Cannot be `undefined` or the empty string.
    firstName: null,

    // lastName: String?
    //   The last name of this person.
    //   Optional. Cannot be `undefined` or the empty string.
    lastName: null,

    // company: String?
    //   The name of the company this person works at.
    //   Optional. Cannot be `undefined` or the empty string.
    company: null,

    _firstNameSetter: function(/*String?*/ str) {
      this._set("firstName", str ? str.trim() : null);
    },

    _lastNameSetter: function(/*String?*/ str) {
      this._set("lastName", str ? str.trim() : null);
    },

    _companySetter: function(/*String?*/ str) {
      this._set("company", str ? str.trim() : null);
    },

    getFullName: function() {
      var firstName = this.get("firstName");
      var lastName = this.get("lastName");
      return (firstName ? firstName + " " : "") + (lastName || "");
    },

    // ...

  });

This leaves nothing to be done in the constructor as well.

The added benefit of this idiom is that you only need to write any checks or transformations only once,
in the setter, and you do not need to repeat this code in the constructor. The constructor always delivers
an "empty" setting, and any changes will go through the setter code.

In this example, we want to make sure that the "N/A" value is always ``null``. It is confusing if the names
can be ``null``, as well as ``undefined``, as ``""``. This code makes sure that the names are either sensible
strings (trimmed), or ``null``, and nothing else.

The only real need to do something in the constructor using :ref:`dojo/_base/declare <dojo/_base/declare>`
is when you have instance properties that are references, that you don't want to be ``null`` or ``undefined``
in the "empty" state. The best example is a to-many association that you need to maintain.
Suppose our Person has siblings:

.. js ::

  var Person = declare([Stateful], {

    // ...

    // _siblings: Person[]
    _siblings: undefined,

    constructor: function() {
      // summary:
      //   After construction, there are no siblings.

      this._siblings = [];
    },

    // ...

    _siblingsGetter: function() {
      return this._siblings.slice(); // return Person[]
    },

    _siblingsSetter: function() {
      throw new Error("Cannot set the siblings directly. Use addSibling and removeSibling instead.");
    },

    addSibling: function(/*Person*/ sibling) {
      // summary:
      //   `sibling` will be in `this.get("siblings")`.
      //   `sibling` cannot be `null` or `undefined`, and must have the same
      //   `lastName` as `this`.

      if (!sibling) {
        throw new Error("sibling must be effective");
      }
      if (!sibling.isInstanceOf || !sibling.isInstanceOf(Person)) {
        throw new Error("sibling must be a Person");
      }
      if (!sibling.get("lastName") === this.get("lastName")) {
        throw new Error("sibling must have the same last name");
      }

      if (this._siblings.indexOf(sibling) < 0) {
        this._siblings.push(sibling);
      }
    },

    removeSibling: function(sibling) {
      // summary:
      //   `sibling` will not be in `this.get("siblings")`

      var siblingIndex = this._siblings.indexOf(sibling);
      if (siblingIndex >= 0) {
        this._siblings.splice(siblingIndex, 1);
      }
    }

  });

Here you need to create an distinct array in the constructor of each instance. Setting the prototype property to []
wouldn't do the trick, because then all instances would share the one array in the prototype, mixing up the siblings
of all Person instances.

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  And example of basic attribute getting, setting and watching.

  .. js ::

    require(["dojo/Stateful", "dojo/_base/declare", "dojo/dom", "dojo/dom-construct", "dojo/on", "dojo/domReady!"],
    function(Stateful, declare, dom, domConst, on){
      var FooClass = declare([Stateful], {
        foo: null,
        bar: null
      });
      
      // Setting initial values for properties on construction
      var aFoo = new FooClass({
        foo: "baz",
        bar: "qux"
      });
      
      // Creating a watch handler
      function watchCallback(name, oldValue, value){
        domConst.place("<br>change: " + name + " from: " + oldValue + " to: " + value, "output");
      }
      
      // Setting watches
      aFoo.watch("foo", watchCallback);
      aFoo.watch("bar", watchCallback);
      
      // Setting "click" event handler
      on(dom.byId("startButton"), "click", function(){
        domConst.place("<br>aFoo.get('foo'): " + aFoo.get("foo"), "output");
        domConst.place("<br>aFoo.get('bar'): " + aFoo.get("bar"), "output");
        aFoo.set("foo", 1);
        aFoo.set("bar", 2);
      });
      
    });

  .. html ::

    <p><strong>Output:</strong></p>
    <div id="output"></div>
    <button type="button" id="startButton">Start</button>

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  An example that uses custom accessors.

  .. js ::

    require(["dojo/Stateful", "dojo/_base/declare", "dojo/dom", "dojo/dom-construct", "dojo/on", "dojo/domReady!"],
    function(Stateful, declare, dom, domConst, on){
      var FooClass = declare([Stateful], {
        foo: null,
        _fooGetter: function(){
          domConst.place("<code>_fooGetter()</code> called<br>", "output");
          return this.foo;
        },
        _fooSetter: function(value){
          domConst.place("<code>_fooSetter()</code> called<br>", "output");
          this.foo = value;
        }
      });
      
      on(dom.byId("startButton"), "click", function(){
        var aFoo = new FooClass({
          foo: "bar"
        });
        domConst.place("<code>aFoo.get('foo')</code>: " + aFoo.get("foo") + "<br>", "output");
        domConst.place("<code>aFoo.set('foo', 'baz')</code>...<br>", "output");
        aFoo.set("foo", "baz");
      });
      
    });

  .. html ::

    <p><strong>Output:</strong></p>
    <div id="output"></div>
    <button type="button" id="startButton">Start</button>

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  An example of a property that is not set immediately when ``.set()`` is called, but after 500ms, which means the
  ``.watch()`` callback will not be called until the property is actually set.

  .. js ::

    require(["dojo/Stateful", "dojo/Deferred", "dojo/_base/declare", "dojo/dom", "dojo/dom-construct", "dojo/on",
        "dojo/domReady!"],
    function(Stateful, Deferred, declare, dom, domConst, on){
      var FooClass = declare([Stateful], {
        foo: null,
        _fooSetter: function(value){
          domConst.place("<code>_fooSetter()</code> called<br>", "output");
          var d = new Deferred();
          
          var self = this;
          setTimeout(function(){
            self.foo = value;
            d.resolve(true);
          }, 500);
          
          return d;
        }
      });
      
      var aFoo = new FooClass();
      
      aFoo.watch("foo", function(name, oldValue, value){
        domConst.place("<code>" + name + "</code> changed from: " + oldValue + " to: " + value + "<br>", "output");
      });
      
      on(dom.byId("startButton"), "click", function(){
        domConst.place("<code>aFoo.set('foo', 'bar')</code>...<br>", "output");
        aFoo.set("foo", "bar");
      });
    });

  .. html ::

    <p><strong>Output:</strong></p>
    <div id="output"></div>
    <button type="button" id="startButton">Start</button>

See also
========

* :ref:`dijit/_WidgetBase::set/get <dijit/_WidgetBase#custom-setters-getters>` - Custom accessors for widgets that deal
  with both object properties and DOM attributes.

* :ref:`dojo/Evented <dojo/Evented>` - A base class for classes that utilize events.

* Introductory article on dojo.Stateful -
  http://www.sitepen.com/blog/2010/05/04/consistent-interaction-with-stateful-objects-in-dojo/
