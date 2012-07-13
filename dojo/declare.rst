.. _dojo/declare:

=================================
dojo.declare (dojo/_base/declare)
=================================

:since: V0.9

.. contents ::
    :depth: 2

JavaScript uses `prototype-based inheritance`_, not class-based inheritance (which is used by most programming languages). Dojo provides the ability to simulate class-based inheritance using ``dojo.declare``.

Basic Usage
===========

Basic example
-------------

Define a class, "my/Person".

.. js ::

  // in my/Person.js
  define(['dojo/_base/lang', 'dojo/_base/declare'], function(lang, declare){
    return declare(null, {
      constructor: function(name, age, residence){
        this.name = name;
        this.age = age;
        this.residence = residence;
      }
    });
  });

  // elsewhere
  require(['my/Person'], function(Person){
    var folk = new Person("phiggins", 42, "Tennessee");
  });

Using lang.mixin in constructor
-------------------------------

Define a class, "my/Person", using an object for mixing in arguments instead of an argument list.

.. js ::

  // in my/Person.js
  define(['dojo/_base/lang', 'dojo/_base/declare'], function(lang, declare){
    return declare(null, {
      name: "Anonymous",
      age: null,
      residence: "Universe A",

      constructor: function(/*Object*/ kwArgs){
        lang.mixin(this, kwArgs);
      },

      moveTo: function(/*string*/ residence){
        this.residence = residence;
      }
    });
  });

  // elsewhere
  require(['my/Person'], function(Person){
    var anon  = new Person(),
        alice = new Person({ name: "Alice", age: 42, residence: "Universe 1" });

    console.log(anon.name, alice.name); // "Anonymous", "Alice"
    console.log(anon.residence, alice.residence); // "Universe A", "Universe 1"
    alice.moveTo("Universe 420");
    console.log(alice.residence); // "Universe 420"
  });

Arrays and objects as member variables
======================================

If your class contains arrays or other objects, they should be declared in the constructor so that each instance gets its own copy. Simple types (strings, numbers, booleans, null) are fine to declare in the class directly because simple types are assigned by value, whereas objects are assigned by reference (in JS, arrays are also considered objects).

Instance objects
----------------

Define a class, "my/Demo.js", with instance objects.

.. js ::

  // in my/Demo.js
  define(['dojo/_base/declare', 'my/Foo'], function(declare, Foo){
    return declare(null, {
      arr: [ 1, 2, 3, 4 ], // object. shared by all instances!
      num: 5,              // non-object. not shared.
      str: "string",       // non-object. not shared.
      obj: new Foo(),      // object. shared by all instances!

      constructor: function(){
        this.arr = [ 1, 2, 3, 4 ]; // per-instance object.
        this.obj = new Foo();      // per-instance object.
      }
    });
  });


Static objects
--------------

Define a class, "my/Demo.js", with "static" properties.

.. js ::

  define(['dojo/_base/declare'], function(declare){
    var Demo = declare("my.Demo", null, {
      constructor: function(){
        console.debug("this is Demo object #" + Demo.counter++);
      }
    });

    Demo.counter = 0;

    return Demo;
  });

Inheritance
===========

The first argument to the ``declare`` function is used for extending classes by providing a parent class (superclass) to inherit from. (Note that in Dojo 1.6 and earlier, this is actually the *second* argument.)

Single inheritance
------------------

Define a "my/Employee" class that extends the "my/Person" class from the first example.

.. js ::

  // in my/Employee.js
  define(['dojo/_base/declare', 'my/Person'], function(declare, Person){
    return declare(Person, {
      constructor: function(name, age, residence, salary){
        // The "constructor" method is special: the parent class (Person)
        // constructor is called automatically before this one.

        this.salary = salary;
      },

      askForRaise: function(){
        return this.salary * 0.02;
      }
    });
  });

  // in my/Boss.js
  define(['dojo/_base/declare', 'my/Employee'], function(declare, Employee){
    return declare(Employee, {
      askForRaise: function(){
        return this.salary * 0.25;
      }
    });
  });

  // elsewhere
  require(['my/Employee', 'my/Boss'], function(Employee, Boss){
    var kathryn = new Boss("Kathryn", 26, "Minnesota", 9000),
        matt    = new Employee("Matt", 33, "California", 1000);

    console.log(kathryn.askForRaise(), matt.askForRaise()); // 2250, 20
  });

Calling superclass methods
--------------------------

Superclass constructors are *always* called automatically, and *always* before the subclass constructor. This convention reduces boilerplate in 90% of cases. If it doesn’t fit your needs see `Manual constructor chaining`_ below. For all other methods, use ``this.inherited(arguments)`` to call the superclass method of the same name.

.. js ::

  // in my/Boss.js
  define(['dojo/_base/declare', 'my/Employee'], function(declare, Employee){
    return declare(Employee, {
      // override the askForRaise function from the Employee class
      askForRaise: function(){
        return this.inherited(arguments) * 20; // boss multiplier!
      }
    });
  });

  // elsewhere
  require(['my/Employee', 'my/Boss'], function(Employee, Boss){
    var kathryn = new Boss("Kathryn", 26, "Minnesota", 9000),
        matt    = new Employee("Matt", 33, "California", 1000);

    console.log(kathryn.askForRaise(), matt.askForRaise()); // 3600, 20
  });

Note that the first argument to ``this.inherited()`` is always literally ``arguments``, a special JavaScript array-like pseudo-variable which holds all the arguments (like argv in C). If you want to override the arguments passed to the superclass, pass them in an array as a second argument:

.. js ::

  this.inherited(arguments, [ customArg1, customArg2 ]);

See `inherited()`_ for more details.

Multiple inheritance
--------------------

Just as Dojo adds class-based inheritance to JavaScript, so it adds support for *multiple inheritance* using `C3 superclass linearization`_. This algorithm is what Python and some other languages use for its implementation of multiple inheritance. You can learn more details in the `Python 2.3 Method Resolution Order documentation`_.

In static languages like Java, you must use typecasts to make an object "act like" its mixed-in class (in Java, this is through interfaces). In Dojo, you can use the mixed-in properties directly.

Define a "my/Blizzard" class using the base class "VanillaSoftServe" and mixins "OreoMixin" and "CookieDoughMixin":

.. js ::

  // in my/ingredients.js
  define(['dojo/_base/declare'], function(declare){
    return {
      VanillaSoftServe: declare(null, {
        constructor: function(){
          console.debug ("adding soft serve");
        }
      }),

      OreoMixin: declare(null, {
        constructor: function(){
          console.debug("mixing in oreos");
        },
        kind: "plain"
      }),

      CookieDoughMixin: declare(null, {
        constructor: function(){
          console.debug("mixing in cookie dough");
        },
        chunkSize: "medium"
      });
    };
  });

  // in my/Blizzard.js
  define(['dojo/_base/declare', 'my/ingredients'], function(declare, ingredients){
    return declare([ ingredients.VanillaSoftServe, ingredients.OreoMixin, ingredients.CookieDoughMixin ], {
      constructor: function(){
        console.debug("A blizzard with " +
          this.kind + " oreos and " +
          this.chunkSize + "-sized chunks of cookie dough."
        );
      }
    });
  });

  // elsewhere
  require(['my/Blizzard'], function(Blizzard){
    // This will print to console:
    // "adding soft serve",
    // "mixing in oreos",
    // "mixing in cookie dough",
    // "A blizzard with plain oreos and medium-sized chunks of cookie dough."
    var yummyTreat = new Blizzard();
  });


Only the first class passed for multiple inheritance is a true superclass. The rest are *mixins*, and are mixed into the child class to produce the inheritance chain we need. On a practical level, this means that the ``instanceof`` operator cannot be used for mixins, only for base classes. Instead, use the `isInstanceOf()`_ function.

Technical information
=====================

This information describes the major revision of ``dojo.declare`` made in 1.4.

Inheritance Info
----------------

Since 1.4 ``dojo.declare`` uses `C3 superclass linearization`_ to convert multiple inheritance to a linear list of superclasses. While it solves most thorny problems of inheritance, some configurations are impossible:

.. js ::

  require(['dojo/_base/declare'], function(declare){
    var A = declare(null);
    var B = declare(null);
    var C = declare([A, B]);
    var D = declare([B, A]);
    var E = declare([C, D]);
  });

As you can see ``D`` requires that ``B`` should go before ``A``, and ``C`` requires that ``A`` go before ``B``. It makes an inheritance chain for ``E`` impossible because these contradictory requirements cannot be satisfied. Obviously any other circular dependencies cannot be satisfied either. But any `DAG`_ inheritance will be linearized correctly including the famous `Diamond problem`_.

In same rare cases it is possible to build a linear chain, which cannot reuse the base class:

.. js ::

  require(['dojo/_base/declare'], function(declare){
    // the first batch
    var A = declare(null);
    var B = declare(A);
    var C = declare(B);

    // the second batch
    var D = declare(null);
    var E = declare([D, B]);

    // the quirky case
    var F = declare([C, E]);
  });

Let's look at ``C`` and ``E`` inheritance chains:

.. html ::

  C -> B -> A
  E -> B -> D

As you can see in one case ``B`` follows after ``A`` and in the other case it follows ``D``. How does ``F`` look like?

.. html ::

  F -> C -> B -> D -> A

As you can see all dependency rules are satisfied, yet the chain's tail doesn't match ``C`` as we are accustomed to see. Obviously ``instanceof`` would be useless in this case, but `isInstanceOf()`_ will work just fine. So when in doubt use `isInstanceOf()`_.

Chaining
--------

New in 1.4.

By default only constructors are chained automatically. In some cases user may want to chain other methods too, e.g., life-cycle methods, which govern how instances are created, modified, and destroy, or methods called for various events. Good example is ``destroy()`` method, which destroys external objects and references and can be used by all super classes of an object.

While ``this.inherited()`` takes care of all scenarios, chaining has following benefits:

* It is much faster than using ``this.inherited()``. On some browsers the difference can be more than an order of magnitude for simple methods.
* It is automatic. User cannot forget to call a superclass method.
* Less code to write, less code to worry about.

Chained methods should not return values: all returned values are going to be ignored. They all be called with the same arguments. A good practice is to avoid modifications to the arguments. It will ensure that your classes play nice with others when used as superclasses.

There are two ways to chain methods: **after** and **before** (`AOP`_ terminology is used). **after** means that a method is called after its superclass' method. **before** means that a method is called before calling its superclass method. All chains are described in a special property named ``-chains-``:

.. js ::

  require(['dojo/_base/declare', 'dojo/dom-construct'], function(declare, domConstruct){
    var A = declare(null, {
      "-chains-": {
        init:    "after",
        destroy: "before"
      },
      init: function(token){
        this.initialized = true;
        this.token = token;
        this.node = dojo.create("div", null, dojo.body());
        console.log("A.init");
      },
      destroy: function(){
        domConstruct.destroy(this.node);
        this.node = null;
        console.log("A.destroy");
      }
    });
    var B = declare(A, {
      init: function(token){
        console.log("B.init");
        // more code
      },
      destroy: function(){
        console.log("B.destroy");
        // more code
      }
    });

    var x = new B();
    x.init(42);
    x.destroy();
  });

  // prints:
  // A.init
  // B.init
  // B.destroy
  // A.destroy

Chain declarations are inherited. Chaining for individual methods can be overridden in child classes, but not advised.

There is a special case: chain declaration for ``constructor``. This method supports two chaining directives: **after**, and **manual**. See more details in Constructors_.

Constructors
------------

Constructor invocations are governed by Chaining_.

Default constructor chaining
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

By default all constructors are chained using **after** algorithm (using `AOP`_ terminology). It means that after the linearization for any given class its constructor is going to be called *after* its superclass constructors:

.. js ::

  require(['dojo/_base/declare'], function(declare){
    var A = declare(null, {
      constructor: function(){ console.log("A"); }
    });
    var B = declare(A, {
      constructor: function(){ console.log("B"); }
    });
    var C = declare(B, {
      constructor: function(){ console.log("C"); }
    });
    new C();
  });

  // prints:
  // A
  // B
  // C

The exact algorithm of an instance initialization for chained constructors:


Notes:

* A good practice for constructors is to avoid modifications of its arguments. It ensures that other classes can access original values, and allows to play nice when the class is used as a building block for other classes.
* If you do need to modify arguments of superclass constructors consider `Manual constructor chaining`_ as a better alternative to ``preamble()``.
* If a class doesn't use ``preamble()`` it switches the initialization to the fast path making an instantiation substantially faster.
* For historical reasons ``preamble()`` is called for classes without a constructor and even for the last class in the superclass list, which doesn't have a superclass.

Manual constructor chaining
~~~~~~~~~~~~~~~~~~~~~~~~~~~

New in 1.4.

In some cases users may want to redefine how initialization works. In this case the chaining should be turned off so ``this.inherited()`` can be used instead.

.. js ::

  require(['dojo/_base/declare'], function(declare){
    var A = declare(null, {
      constructor: function(){
        console.log("A");
      }
    });
    var B = declare(A, {
      "-chains-": {
        constructor: "manual"
      },
      constructor: function(){
        console.log("B");
      }
    });
    var C = declare(B, {
      constructor: function(){
        console.log("C - 1");
        this.inherited(arguments);
        console.log("C - 2");
      }
    });
    var x = new C();
  });

  // prints:
  // C - 1
  // B
  // C - 2

The example above doesn't call the constructor of ``A`` at all, and runs some code before and after calling the constructor of ``B``.

The exact algorithm of an instance initialization for manual constructors:


Notes:

* Prefer manual constructors to deprecated ``preamble()``.
* As soon as you switch to manual constructors **all** constructors in your hierarchy should be called manually. Make sure that all constructors are wired for that.
* Chaining works faster than simulating it with ``this.inherited()``. Know when to use it.

Constructor methods
-------------------

Every constructor created by ``dojo.declare`` defines some convenience methods.

extend
~~~~~~

This constructor method adds new properties to the constructor's prototype the same way as :ref:`dojo.extend <dojo/extend>` works. The difference is that it annotates function properties the same way ``dojo.declare`` does. These changes will be propagated to all classes and object where this class constructor was a superclass.

The method has one argument: an object to mix in. It returns the constructor itself, which can be used for chained calls.

Example:

.. js ::

  require(['dojo/_base/declare'], function(declare){
    var A = declare(null, {
      m1: function(){
        // ...
      }
    });

    A.extend({
      m1: function(){
        // this method will replace the original method
        // ...
      },
      m2: function(){
        // ...
      }
    });

    var x = new A();
    a.m1();
    a.m2();
  });

Internally this method uses :ref:`dojo.safeMixin <dojo/safeMixin>`.

**Important note:** Do not forget that ``dojo.declare`` uses mixins to build a constructor from several bases. Remember that only the first base is inherited, the rest is mixed in by copying properties. It means that if you ``extend`` a constructor's prototype that was already used as a mixin and its methods became top methods in the chain of inheritance, these top methods would not be replaced because they are already copied.

Example:

.. js ::

  require(['dojo/_base/declare'], function(declare){
    var A = declare(null, {
      m1: function(){ console.log("A org"); },
      m2: function(){ console.log("A org"); }
    });

    var B = declare(null, {
      m2: function(){ this.inherited(arguments); console.log("B org"); },
      m3: function(){ this.inherited(arguments); console.log("B org"); }
    });

    var C = declare(null, {
      m3: function(){ this.inherited(arguments); console.log("C org"); },
      m4: function(){ this.inherited(arguments); console.log("C org"); }
    });

    var ABC = declare([A, B, C], {});

    // now A is the true base, B and C are mixed in

    var abc = new ABC();

    abc instanceof A; // true
    abc instanceof B; // false
    abc instanceof C; // false

    // use isInstanceOf() to check if you include
    // proper mixins

    // let's list top methods:
    // m1 comes from A (inherited)
    // m2 comes from B (copied)
    // m3 comes from C (copied)
    // m4 comes from D (copied)

    abc.m1(); // A org
    abc.m2(); // A org, B org
    abc.m3(); // B org, C org
    abc.m4(); // C org

    // let's extend() all prototypes

    A.extend({
      m1: function(){ console.log("A new"); },
      m2: function(){ console.log("A new"); }
    });

    B.extend({
      m2: function(){ this.inherited(arguments); console.log("B new"); },
      m3: function(){ this.inherited(arguments); console.log("B new"); }
    });

    C.extend({
      m3: function(){ this.inherited(arguments); console.log("C new"); },
      m4: function(){ this.inherited(arguments); console.log("C new"); }
    });

    // observe that top copied methods are not changed

    abc.m1(); // A new
    abc.m2(); // A new, B org
    abc.m3(); // B new, C org
    abc.m4(); // C org
  });

You can see that copied methods were not replaced in ``ABC`` and ``abc``.


Class methods
-------------

Every prototype produced by ``dojo.declare`` contains some convenience methods.

inherited()
~~~~~~~~~~~

The method is used to call a superclass method. It accepts up to three arguments:

* Optional name of the method to call. Generally it should be specified when calling ``this.inherited()`` from an un-annotated method, otherwise it will be deduced from the method itself.
* ``arguments`` - literally ``arguments`` pseudo-variable, which is used for introspection.
* Optional array of arguments, which will be used to call a superclass method. If it is not specified ``arguments`` are used. If this argument is a literal constant ``true``, then the found super method is not executed but returned as a value (see `getInherited()`_).

It returns whatever value was returned by a superclass method that was called. If it turned out that there is no superclass method to call, `inherited()`_ doesn't do anything and returns ``undefined``.


Examples:

.. js ::

  require(['dojo/_base/lang', 'dojo/_base/declare'], function(lang, declare){
    var A = declare(null, {
      m1: function(){
        // ...
      },
      m2: function(){
        // ...
      },
      m3: function(){
        // ...
      },
      m4: function(){
        // ...
      },
      m5: function(){
        // ...
      }
    });

    var B = declare(A, {
      m1: function(){
        // simple super call with the same arguments
        this.inherited(arguments);
        // super call with new arguments
        this.inherited(arguments, [1, 2, 3]);
      }
    });

    // extend B using extend()
    B.extend({
      m2: function(){
        // this method is going to be properly annotated =>
        // we can use the same form of this.inherited() as
        // normal methods:
        // simple super call with the same arguments
        this.inherited(arguments);
        // super call with new arguments
        this.inherited(arguments, ["a"]);
      }
    });

    // extend B using lang.extend()
    lang.extend(B, {
      m3: function(){
        // this method is not annotated =>
        // we should supply its name when calling
        // a superclass:
        // simple super call with the same arguments
        this.inherited("m3", arguments);
        // super call with new arguments
        this.inherited("m3", arguments, ["a"]);
      }
    });

    // let's create an instance
    var x = new B();
    x.m1();
    x.m2();
    x.m3();
    x.m4(); // A.m4() is called
    x.m5(); // A.m5() is called

    // add a method on the fly using declare.safeMixin()
    declare.safeMixin(x, {
      m4: function(){
        // this method is going to be properly annotated =>
        // we can use the same form of this.inherited() as
        // normal methods:
        // simple super call with the same arguments
        this.inherited(arguments);
        // super call with new arguments
        this.inherited(arguments, ["a"]);
      }
    });

    // add a method on the fly
    x.m5 = function(){
      // this method is not annotated =>
      // we should supply its name when calling
      // a superclass:
      // simple super call with the same arguments
      this.inherited("m5", arguments);
      // super call with new arguments
      this.inherited("m5", arguments, ["a"]);
    };

    x.m4(); // our instance-specific method is called
    x.m5(); // our instance-specific method is called
  });

getInherited()
~~~~~~~~~~~~~~

This is a companion method to `inherited()`_. The difference is that it doesn't execute the found method, but returns it. It is up to the user to call it with proper arguments.

The method accepts up to two arguments:

* Optional name of the method to call. If it is specified it must match the name of the caller. Generally it should be specified when calling this method from an un-annotated method (the same rule as for `inherited()`_).
* ``arguments`` - literally ``arguments`` pseudo-variable, which is used for introspection.

The result is a superclass method or ``undefined``, if it was not found. You can use the result as you wish. The most useful case is to pass it to some other function, which cannot use `inherited()`_ directly for some reasons.

Examples:

.. js ::

  require(['dojo/_base/declare'], function(declare){
    var A = declare(null, {
      m1: function(){
        // ...
      },
      m2: function(){
        // ...
      }
    });

    var B = declare(A, {
      logAndCall: function(name, method, args){
        console.log("Calling " + name + "...");
        method.apply(this, args);
        console.log("...done");
      },
      m1: function(){
        var supermethod = this.getInherited(arguments);
        this.logAndCall("A.m1", supermethod, [1, 2]);
      }
    });

    var x = new B();
    x.m2 = function(){
      // we need to use a name here because
      // this method was not properly annotated:
      var supermethod = this.getInherited("m2", arguments);
      this.logAndCall("A.m2", supermethod, [1, 2]);
    };
  });

Internally this method is a helper, which calls `inherited()`_ with ``true`` as the last argument.

isInstanceOf()
~~~~~~~~~~~~~~

This method checks if an instance is derived from a given class. It is modeled on ``instanceof`` operator. It is most useful when you have classes built with the multiple inheritance somewhere in your hierarchy.

The method accepts one argument: class (constructor). It returns ``true``/``false``.

Examples:

.. js ::

  require(['dojo/_base/declare'], function(declare){
    var A = declare(null);
    var B = declare(null);
    var C = declare(null);

    var D = declare([A, B]);

    var x = new D();

    console.log(x instanceof A);     // true
    console.log(x.isInstanceOf(A));  // true

    console.log(x instanceof B);     // false
    console.log(x.isInstanceOf(B));  // true

    console.log(x instanceof C);     // false
    console.log(x.isInstanceOf(C));  // false

    console.log(x instanceof D);     // true
    console.log(x.isInstanceOf(D));  // true
  });

Using "raw" classes with dojo.declare()
---------------------------------------

``dojo.declare`` allows to use "raw" classes created by other means as a superclass. Such classes are considered to be monolithic (because their structure cannot be introspected) and they cannot use advanced features like `inherited()`_. But their methods will be called by `inherited()`_ and all their methods can be chained (see Chaining_) including constructors.

Examples:

.. js ::

  require(['dojo/_base/lang', 'dojo/_base/declare'], function(lang, declare){
    // plain vanilla constructor
    var A = function(){
      this.a = 42;
    };
    A.prototype.m1 = function(){
      // ...
    };

    // another plain vanilla constructor
    var B = function(){
      this.b = "abc";
    };
    lang.extend(B, {
      m2: function(){
        // ...
      }
    });

    var C = declare([A, B], {
      m1: function(){
        return this.inherited(arguments);
      },
      m2: function(){
        return this.inherited(arguments);
      }
    });

    var x = new C();
    // both A and B will be called at this point

    console.log(x.isInstanceOf(A)); // true
    console.log(x.isInstanceOf(B)); // true

    x.m1(); // A.m1 will be called via this.inherited()
    x.m2(); // B.m2 will be called via this.inherited()
  });

Meta-information
----------------

All meta-information is a subject to change and should not be used in the course of normal coding. If you use it, be ready to update your code, when it changes.

Every constructor produced with ``dojo.declare`` carries a meta-information required for internal plumbing and for introspection. It is implemented as a property called :ref:``meta`` on a constructor. :ref:``meta`` has following properties:

bases
  List of all superclasses produced by the C3 linearization algorithm (see Inheritance_ for more details). The very first item in the list is the class itself.

hidden
  Copy of all own properties and methods of the class. It is the third argument (or the second argument, if class name was omitted) of ``dojo.declare``.

chains
  List of chains (see Chaining_ for more details) augmented by all inherited chains.

parents
 List of immediate parents. It is the second argument (or the first argument, if class name was omitted) of ``dojo.declare``.

Additionally a prototype has a special property named ``declaredClass``, if the class was named when created by ``dojo.declare``. If it was an anonymous class, this property can be missing, or it can be a auto-generated name in the form of ``uniqName_NNN``, where ``NNN`` is some unique number. This property is used internally to distinguish between different classes. It is not meant for end users, but it can be useful for debugging.

Every instance created by ``dojo.declare``'d class has a special property called ``inherited``, which is used to speed up `inherited()`_ calls. Please don't touch it.

Every method mixed in by ``dojo.declare`` or :ref:`dojo.safeMixin <dojo/safeMixin>` is annotated: a special property called ``nom`` is added. It contains a name of the method in question and used by `inherited()`_ and `getInherited()`_ to deduce the name of a superclass method. See :ref:`dojo.safeMixin <dojo/safeMixin>` for more details.

See Also
========

* `Classy JavaScript with dojo.declare`_

.. _`prototype-based inheritance`: http://en.wikipedia.org/wiki/Prototype-based_programming
.. _`C3 superclass linearization`: http://en.wikipedia.org/wiki/C3_linearization
.. _`Python 2.3 Method Resolution Order documentation`: http://www.python.org/download/releases/2.3/mro
.. _`DAG`: http://en.wikipedia.org/wiki/Directed_acyclic_graph
.. _`Diamond problem`: http://en.wikipedia.org/wiki/Diamond_problem
.. _`AOP`: http://en.wikipedia.org/wiki/Aspect-oriented_programming
.. _`Classy JavaScript with dojo.declare`: http://dojotoolkit.org/documentation/tutorials/1.6/declare/
