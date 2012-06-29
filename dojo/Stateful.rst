.. _dojo/Stateful:

=============
dojo/Stateful
=============

:Authors: Kris Zyp, Marcus Reimann, Kitson Kelly
:Project owner: Kris Zyp
:since: V1.5

.. contents ::
   :depth: 2

A new generic interface and base class for getting, setting, and watching for property changes (with getters and
setters) in a consistent manner.

Introduction
============

``dojo/Stateful`` provides the ability to get and set named properties, including using custom accessors in conjunction
with the ability to monitor these properties for changes. ``dojo.Stateful`` is intended to be a base class that can be
extended by other components that wish to support watchable properties. This can be very useful for creating live
bindings that utilize current property states and must react to any changes in properties. It also allows a developer to
customize the behavior of accessing the property by providing auto-magic getters and setters (accessors).

Usage
=====

Usage of the class can be an instance of the class, although subclassing is recommended.

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
    
    // Create an instance and set some initial property values:
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

The constructor takes an optional argument of an Object which defines any of the initial properties of the instance.
Anything passed will utilise ``.set()`` to set the value.

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
        domConst.place("<br />change: " + name + " from: " + oldValue + " to: " + value, "output");
      }
      
      // Setting watches
      aFoo.watch("foo", watchCallback);
      aFoo.watch("bar", watchCallback);
      
      // Setting "click" event handler
      on(dom.byId("startButton"), "click", function(){
        domConst.place("aFoo.get('foo'): " + aFoo.get("foo"), "output");
        domConst.place("<br />aFoo.get('bar'): " + aFoo.get("bar"), "output");
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
          domConst.place("<code>_fooGetter()</code> called<br />", "output");
          return this.foo;
        },
        _fooSetter: function(value){
          domConst.place("<code>_fooSetter()</code> called<br />", "output");
          this.foo = value;
        }
      });
      
      on(dom.byId("startButton"), "click", function(){
        var aFoo = new FooClass({
          foo: "bar"
        });
        domConst.place("<code>aFoo.get('foo')</code>: " + aFoo.get("foo") + "<br />", "output");
        domConst.place("<code>aFoo.set('foo', 'baz')</code>...<br />", "output");
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
          domConst.place("<code>_fooSetter()</code> called<br />", "output");
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
        domConst.place("<code>" + name + "</code> changed from: " + oldValue + " to: " + value + "<br />", "output");
      });
      
      on(dom.byId("startButton"), "click", function(){
        domConst.place("<code>aFoo.set('foo', 'bar')</code>...<br />", "output");
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
