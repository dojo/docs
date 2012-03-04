.. _dojo/declare:

=================================
dojo.declare (dojo/_base/declare)
=================================

:since: V0.9

.. contents ::
    :depth: 2

Javascript doesn't have a Class system like Java, though Dojo provides functionality to simulate this: dojo.declare. For some background on JavaScript and prototype-based object orientation see works of `Douglas Crockford <http://javascript.crockford.com/>`_:

* `Prototypal Inheritance in JavaScript <http://javascript.crockford.com/prototypal.html>`_.
* `Classical Inheritance in JavaScript <http://javascript.crockford.com/inheritance.html>`_.
* `Private Members in JavaScript <http://javascript.crockford.com/private.html>`_.

If you prefer books, chapter 9 of `David Flanagan's JavaScript: The Definitive Guide, 5th edition <http://www.amazon.com/JavaScript-Definitive-Guide-David-Flanagan/dp/0596101996/ref=sr_1_1?ie=UTF8&s=books&qid=1257280051&sr=8-1>`_ is a good read.

This section has some pretty abstract stuff, and you may wish to skip it on the first read.  Certainly you can do a lot with Dojo without using ``dojo.declare`` or the other object orientation functions.  But a good knowledge of it will help you program faster and smarter.

Basic Usage
===========

Example:

[Dojo 1.7 (AMD)]

.. js ::
    
  require(['dojo/_base/declare'], function(declare){
    declare("my.Thinger", null, {
      constructor: function(/*Object*/ args){
        declare.safeMixin(this, args);
      }
    });
  });

[Dojo < 1.7]

.. js ::
  
  dojo.declare("my.Thinger", null, {
    constructor: function(/*Object*/ args){
      dojo.safeMixin(this, args);
    }
  });

Here, we've declared a simple class named ``my.Thinger``, not based on anything, and finally providing a single property named ``constructor``. The constructor function is run once for each mixed Class. In this example, we've simply mixed the passed arguments into ``this``, or our scoped reference to an instance of my.Thinger. You could then create a Thinger like so:

.. js ::
  
  var thing = new my.Thinger({ count:100 });
  console.log(thing.count);

The :ref:`dojo.mixin <dojo/mixin>` call (in the constructor) then mixes the variable count into the properties of the instance, making it available as a member of the instance. We can supply defaults to use from within ``dojo.declare`` itself.

[Dojo 1.7 (AMD)]

.. js ::
  
  require(['dojo/_base/declare'], function(declare){
    declare("my.Thinger", null, {
      count: 100,
      constructor: function(args){
        declare.safeMixin(this, args);
      }
    });
    var thing1 = new my.Thinger();
    var thing2 = new my.Thinger({ count:200 });
    console.log(thing1.count, thing2.count);
  });

[Dojo < 1.7]

.. js ::
  
  dojo.declare("my.Thinger", null, {
    count: 100,
    constructor: function(args){
      dojo.safeMixin(this, args);
    }
  });
  var thing1 = new my.Thinger();
  var thing2 = new my.Thinger({ count:200 });
  console.log(thing1.count, thing2.count);

Now we have a 'base class', called my.Thinger.

If we don't want a globally accessible class we can easily make it local (since 1.4):

[Dojo 1.7 (AMD)]

.. js ::
  
  require(['dojo/_base/lang','dojo/_base/declare'], function(lang,declare){
    var localThinger = declare(null, {
      count: 100,
      constructor: function(args){
        lang.mixin(this, args);
      }
    });
    var thing1 = new localThinger();
    var thing2 = new localThinger({ count:200 });
    console.log(thing1.count, thing2.count);
  });

[Dojo < 1.7]

.. js ::
  
  var localThinger = dojo.declare(null, {
    count: 100,
    constructor: function(args){
      dojo.mixin(this, args);
    }
  });
  var thing1 = new localThinger();
  var thing2 = new localThinger({ count:200 });
  console.log(thing1.count, thing2.count);

To show how the inheritance chain works, we will create a new class derived from ``my.Thinger``:

[Dojo 1.7 (AMD)]

.. js ::
  
  require(['dojo/_base/declare'], function(declare){
    declare("my.OtherThinger", [my.Thinger], {
      divisor: 5,
      constructor: function(args){
        console.log('OtherThinger constructor called');
        this.total = this.count / this.divisor;
      }
    });
    var thing = new my.OtherThinger({ count:50 });
    console.log(thing.total); // 10
  });

[Dojo < 1.7]

.. js ::
  
  dojo.declare("my.OtherThinger", [my.Thinger], {
    divisor: 5,
    constructor: function(args){
      console.log('OtherThinger constructor called');
      this.total = this.count / this.divisor;
    }
  });
  var thing = new my.OtherThinger({ count:50 });
  console.log(thing.total); // 10

First, the constructor of ``my.Thinger`` is called, mixing in the args parameter. Then, we're using the reserved word ``this`` to access instance properties, creating a new instance property ``total`` based on some simple code.

Above we passed an object hash exclusively as the parameter to our Class instantiation. The constructor is passed whichever arguments are passed during instantiation.

[Dojo 1.7 (AMD)]

.. js ::
  
  require(['dojo/_base/declare'], function(declare){
    declare("Person", null, {
      constructor: function(name, age, currentResidence){
        this.name=name;
        this.age=age;
        this.currentResidence = currentResidence;
      }
    });
    var folk = new Person("phiggins", 42, "Tennessee");
  });

[Dojo < 1.7]

.. js ::
  
  dojo.declare("Person", null, {
    constructor: function(name, age, currentResidence){
      this.name=name;
      this.age=age;
      this.currentResidence = currentResidence;
    }
  });
  var folk = new Person("phiggins", 42, "Tennessee");

Each of the ordered parameters are passed (as seen by the constructor's function signature) and then manually added to ``this`` by direct variable assignment.

Let's add some content to a new class by giving it a name and showing what the constructor can do.
Following is a Person class with a constructor and a ``moveToNewState()`` function:

[Dojo 1.7 (AMD)]

.. js ::
  
  require(['dojo/_base/declare'], function(declare){
    declare("Person", null, {
      constructor: function(name, age, currentResidence){
        this.name = name;
        this.age = age;
        this.currentResidence = currentResidence;
      },
      moveToNewState: function(newState){
        this.currentResidence = newState;
      }
    });
    var folk = new Person("phiggins", 28, "Tennessee");
    console.log(folk.currentResidence);
    folk.moveToNewState("Oregon");
    console.log(folk.currentResidence);
  });

[Dojo < 1.7]

.. js ::
  
  dojo.declare("Person", null, {
    constructor: function(name, age, currentResidence){
      this.name = name;
      this.age = age;
      this.currentResidence = currentResidence;
    },
    moveToNewState: function(newState){
      this.currentResidence = newState;
    }
  });
  var folk = new Person("phiggins", 28, "Tennessee");
  console.log(folk.currentResidence);
  folk.moveToNewState("Oregon");
  console.log(folk.currentResidence);


Note the use of anonymous functions here.  You are passing to ``dojo.declare`` an associative array of anonymous functions.  "That's not an anonymous function", you might say, "their names are constructor and moveToNewState!"  Strictly speaking, no they aren't.  They are anonymous functions with the *keys* ``constructor`` and ``moveToNewState``.

In pure JavaScript, this is handled by a prototype function named after the class - for example, ``Person.prototype``.  Dojo wires in your constructor as a part of the prototype, but then adds extra goodies like calling the superclass constructor and initializing extra properties.

Arrays and Objects as member variables
======================================

If your class contains arrays or other objects, they should be declared in the constructor so that each instance gets its own copy. Simple types (literal strings and numbers) are fine to declare in the class directly.

[Dojo 1.7 (AMD)]

.. js ::
  
  require(['dojo/_base/declare'], function(declare){
    declare("my.classes.bar", my.classes.foo, {
      someData: [1, 2, 3, 4], // doesn't do what I want: ends up being static
      numItem : 5, // one per bar
      strItem : "string", // one per bar

      constructor: function(){
        this.someData = [ ]; // better, each bar has its own array
        this.expensiveResource = new expensiveResource(); // one per bar
      }
    });
  });

[Dojo < 1.7]

.. js ::
  
  dojo.declare("my.classes.bar", my.classes.foo, {
    someData: [1, 2, 3, 4], // doesn't do what I want: ends up being static
    numItem : 5, // one per bar
    strItem : "string", // one per bar

    constructor: function(){
      this.someData = [ ]; // better, each bar has its own array
      this.expensiveResource = new expensiveResource(); // one per bar
    }
  });

On the other hand, if you want an object or array to be static (shared between all instances of *my.classes.bar*), then you should do something like this:

[Dojo 1.7 (AMD)]

.. js ::
  
  require(['dojo/_base/declare'], function(declare){
    declare("my.classes.bar", my.classes.foo, {
      constructor: function(){
        console.debug("this is bar object # " + this.statics.counter++);
      },

      statics: { counter: 0, somethingElse: "hello" }
    });
  });

[Dojo < 1.7]

.. js ::
  
  dojo.declare("my.classes.bar", my.classes.foo, {
    constructor: function(){
      dojo.debug("this is bar object # " + this.statics.counter++);
    },

    statics: { counter: 0, somethingElse: "hello" }
  });


``Statics`` is not a special dojo construct - you can use any name you want, like ``constants``.  In this example, you'd refer to the variable as ``myInstance.statics.counter`` both inside and outside the class definition.

Why is this true for arrays and objects, but not primitives? It's because, like most OOP languages, JavaScript uses object references. For example, given:

.. js ::

  x = { fruit: "apple" };
  y = x;

Now *x* and *y* both refer to the same object. Modifying *x.fruit* will also affect *y.fruit*.

On the other hand, numbers, booleans, and strings are used as values. Any assignment updates a variable, rather than shared object.

Inheritance
===========

A person can only do so much, so let's create an Employee class that extends the Person class.
The second argument in the ``dojo.declare`` function is for extending classes.

[Dojo 1.7 (AMD)]

.. js ::
  
  require(['dojo/_base/declare'], function(declare){
    declare("Employee", Person, {
      constructor: function(name, age, currentResidence, position){
        // Remember, Person constructor is called automatically
        // before this constructor.
        this.password = "";
        this.position = position;
      },

      login: function(){
        if(this.password){
          alert('you have successfully logged in');
        }else{
          alert('please ask the administrator for your password');
        }
      }
    });
  });

[Dojo < 1.7]

.. js ::
  
  dojo.declare("Employee", Person, {
    constructor: function(name, age, currentResidence, position){
      // Remember, Person constructor is called automatically
      // before this constructor.
      this.password = "";
      this.position = position;
    },

    login: function(){
      if(this.password){
        alert('you have successfully logged in');
      }else{
        alert('please ask the administrator for your password');
      }
    }
  });

Dojo handles all of the requirements for setting up the inheritance chain, including calling the superclass constructor automatically. Methods or variables can be overridden by setting the name to the same as it is in the parent class. The Employee class can override the Person class ``moveToNewState()``, perhaps by letting the company pay for moving expenses.

You initialize the subclass the same as the Person class with the new keyword.

.. js ::

  var kathryn = new Employee('Kathryn', 26, 'Minnesota', 'Designer');
  var matt    = new Person('Matt', 33, 'California');

The Employee class passes the arguments down to the Person class (which uses only the first three), and sets the position. Kathryn has access to the ``login()`` function found in the Employee class, and also the ``moveToNewState()`` function by calling ``kathryn.moveToNewState("Texas")``. Matt on the other hand, does not have access to the Employee ``login()`` function.

Adding more arguments at the end of the argument list is a common idiom in Dojo. All arguments are passed to all constructors, but ancestor constructors take only first N arguments they know of ignoring the rest.

Another popular idiom is to pass an object as one of the arguments using it is a property bag. Each class takes from the bag properties they can understand. Below is rewriting of our example to demonstrate this technique:

[Dojo 1.7 (AMD)]

.. js ::
  
  require(['dojo/_base/declare'], function(declare){
    var Person2 = declare(null, {
      constructor: function(args){
        this.name = args.name;
        this.age = args.age;
        this.currentResidence = args.currentResidence;
      }
      // more methods
    });
  
    var Employee2 = declare(Person2, {
      constructor: function(args){
        // Remember, Person constructor is called automatically
        // before this constructor.
        this.password = "";
        this.position = args.position;
      }
      // more methods
    });
  });

[Dojo < 1.7]

.. js ::
  
  var Person2 = dojo.declare(null, {
    constructor: function(args){
      this.name = args.name;
      this.age = args.age;
      this.currentResidence = args.currentResidence;
    }
    // more methods
  });

  var Employee2 = dojo.declare(Person2, {
    constructor: function(args){
      // Remember, Person constructor is called automatically
      // before this constructor.
      this.password = "";
      this.position = args.position;
    }
    // more methods
  });

Programmers familiar with Python will see Python's ``kwargs`` in this technique.

Calling Superclass Methods
--------------------------

Often when you're overriding a method, you want to *add* something to the superclasses method, not totally replace it.  Dojo has helper functions to make this easy.

But you don't have to worry in the constructor. As we said above, superclass constructors are *always* called automatically, and *always* before the subclass constructor. This convention reduces boilerplate in 90% of cases. If it doesn't fit your needs see `Manual constructor chaining`_ below.

For all other methods, you can use ``this.inherited()`` to call the superclass method of the same name.  Take for example:

.. js ::
  
  someMethod: function(){
    // call base class someMethod
    this.inherited(arguments);
    // now do something else
  }

Inherited will climb up the scope chain, from superclass to superclass, until it finds "someMethod", then it will invoke that method.

The argument is always literally ``arguments``, a special Javascript array-like pseudo-variable which holds all the arguments (like argv in C).

You can send custom parameters to the ancestor function.  Just place the extra arguments in array literal notation with brackets:

.. js ::

  this.inherited(arguments, [ customArg1, customArg2 ]);

See `inherited()`_ for more details.


Multiple inheritance
====================

Just as Dojo adds class-based inheritance to JavaScript, so it adds support for *multiple inheritance*. In order to do it ``dojo.declare`` uses C3 superclass linearization. This algorithm is what Python and some other languages use for its implementation of multiple inheritance. You can learn more details in `The Python 2.3 Method Resolution Order <http://www.python.org/download/releases/2.3/mro/>`_. Essentially the algorithm builds a single inheritance chain respecting all dependencies and removing duplicated base classes.

In static languages like Java, you must use typecasts to make an object "act like" its mixed-in class (in Java, this is through interfaces). Not in Dojo. You can use the mixed-in properties directly.

Suppose, for example, you have a class called ``VanillaSoftServe``, and classes ``MandMs`` and ``CookieDough``.  Here's how to make a ``Blizzard``:

[Dojo 1.7 (AMD)]

.. js ::
  
  require(['dojo/_base/declare'], function(declare){
    declare("VanillaSoftServe", null, {
      constructor: function(){ console.debug ("mixing in Vanilla"); }
    });

    declare("MandMs", null, {
      constructor: function(){ console.debug("mixing in MandM's"); },
      kind: "plain"
    });

    declare("CookieDough", null, {
      chunkSize: "medium"
    });

    declare("Blizzard", [VanillaSoftServe, MandMs, CookieDough], {
        constructor: function(){
             console.debug("A blizzard with " +
                 this.kind + " M and Ms and " +
                 this.chunkSize +" chunks of cookie dough."
             );
        }
    });
    // make a Blizzard:
    new Blizzard();
  });

[Dojo < 1.7]

.. js ::
  
  dojo.declare("VanillaSoftServe", null, {
    constructor: function(){ console.debug ("mixing in Vanilla"); }
  });

  dojo.declare("MandMs", null, {
    constructor: function(){ console.debug("mixing in MandM's"); },
    kind: "plain"
  });

  dojo.declare("CookieDough", null, {
    chunkSize: "medium"
  });

  dojo.declare("Blizzard", [VanillaSoftServe, MandMs, CookieDough], {
        constructor: function(){
             console.debug("A blizzard with " +
                 this.kind + " M and Ms and " +
                 this.chunkSize +" chunks of cookie dough."
             );
        }
  });
  // make a Blizzard:
  new Blizzard();


This will first print "mixing in Vanilla" on the debug console because VanillaSoftServe is the superclass of Blizzard. In fact, VanillaSoftServe is the *only* superclass of Blizzard - the first class in the array of dependencies is used as a true super class (there are some exception, see `Inheritance` for more info). Next the constructors of other classes (the mixins) are called, so "mixing in MandMs" will appear.  Then "A blizzard with plain M and Ms and medium chunks of cookie dough." will appear.

Mixins are used a lot in defining Dijit classes, with most classes extending ``dijit._Widget`` and mixing in ``dijit._Templated``.

Inheritance chains
==================

Given:

[Dojo 1.7 (AMD)]

.. js ::
  
  require(['dojo/_base/declare'], function(declare){
    var A = declare(null);
    var B = declare(null);
    var C = declare(null);
    var D = declare([A, B]);
    var E = declare([B, C]);
    var F = declare([A, C]);
    var G = declare([D, E]);
    var H = declare([D, F]);
    var I = declare([D, E, F]);
  });

[Dojo < 1.7]

.. js ::
  
   var A = dojo.declare(null);
   var B = dojo.declare(null);
   var C = dojo.declare(null);
   var D = dojo.declare([A, B]);
   var E = dojo.declare([B, C]);
   var F = dojo.declare([A, C]);
   var G = dojo.declare([D, E]);
   var H = dojo.declare([D, F]);
   var I = dojo.declare([D, E, F]);

Let's explore inheritance chains. First three classes look trivial:

.. html ::
  
  A
  B
  C

Next three classes look like that:

.. html ::
  
  D -> B -> A
  E -> C -> B
  F -> C -> A

Notice that the inheritance chains are the same as the corresponding list of base classes, but reversed.

Another useful bit of information: only the first base (the last in an inheritance chain) is a true superclass. The rest are duplicated to produce the inheritance chain we need. For example, B is not based on A, so we base a copy of it on A. What does it mean for us practically? We cannot use ``instanceof`` operator for mxins, only for base classes:

.. js ::
  
  console.log(D instanceof A); // true
  console.log(D instanceof B); // false

How to get around it? Use `isInstanceOf()`_.

Now on to more complex cases:

.. html ::
  
  G -> C -> D(-> B -> A)
  H -> C -> D(-> B -> A)
  I -> C -> D(-> B -> A)

As you can see the inheritance chain is the same for all three classes. Why? Because new mixins do not add new functionality. For example ``G`` brings ``E``, which is unraveled as ``E -> C -> B``, but we already have ``B`` in our hierarchy, so we can skip it to avoid double initialization, or calling the same methods twice. That is why ``B`` was removed. You can inspect other cases using the same logic to make sure that the inheritance chains are correct.

Note that ``-> B -> A`` are folded into our superclass ``D`` and are not instantiated directly.

Technical information
=====================

This information describes the major revision of ``dojo.declare`` made in 1.4.

Inheritance Info
----------------

Since 1.4 ``dojo.declare`` uses `C3 superclass linearization <http://www.python.org/download/releases/2.3/mro/>`_ to convert multiple inheritance to a linear list of superclasses. While it solves most thorny problems of inheritance, some configurations are impossible:

[Dojo 1.7 (AMD)]

.. js ::
  
  require(['dojo/_base/declare'], function(declare){
    var A = declare(null);
    var B = declare(null);
    var C = declare([A, B]);
    var D = declare([B, A]);
    var E = declare([C, D]);
  });

[Dojo < 1.7]

.. js ::
  
  var A = dojo.declare(null);
  var B = dojo.declare(null);
  var C = dojo.declare([A, B]);
  var D = dojo.declare([B, A]);
  var E = dojo.declare([C, D]);

As you can see ``D`` requires that ``B`` should go before ``A``, and ``C`` requires that ``A`` go before ``B``. It makes an inheritance chain for ``E`` impossible because these contradictory requirements cannot be satisfied. Obviously any other circular dependencies cannot be satisfied either. But any `DAG <http://en.wikipedia.org/wiki/Directed_acyclic_graph>`_ inheritance will be linearized correctly including the famous `Diamond problem <http://en.wikipedia.org/wiki/Diamond_problem>`_.

In same rare cases it is possible to build a linear chain, which cannot reuse the base class:

[Dojo 1.7 (AMD)]

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

[Dojo < 1.7]

.. js ::
  
  // the first batch
  var A = dojo.declare(null);
  var B = dojo.declare(A);
  var C = dojo.declare(B);

  // the second batch
  var D = dojo.declare(null);
  var E = dojo.declare([D, B]);

  // the quirky case
  var F = dojo.declare([C, E]);

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

There are two ways to chain methods: **after** and **before** (`AOP <http://en.wikipedia.org/wiki/Aspect-oriented_programming>`_ terminology is used). **after** means that a method is called after its superclass' method. **before** means that a method is called before calling its superclass method. All chains are described in a special property named ``-chains-``:

[Dojo 1.7 (AMD)]

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

[Dojo < 1.7]

.. js ::
  
  var A = dojo.declare(null, {
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
      dojo.destroy(this.node);
      this.node = null;
      console.log("A.destroy");
    }
  });
  var B = dojo.declare(A, {
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

By default all constructors are chained using **after** algorithm (using `AOP <http://en.wikipedia.org/wiki/Aspect-oriented_programming>`_ terminology). It means that after the linearization for any given class its constructor is going to be called *after* its superclass constructors:

[Dojo 1.7 (AMD)]

.. js ::
  
  require(['dojo/_base/declare'], function(declare){
    var A = declare(null,
      constructor: function(){ console.log("A"); }
    };
    var B = declare(A,
      constructor: function(){ console.log("B"); }
    };
    var C = declare(B,
      constructor: function(){ console.log("C"); }
    };
    new C();
  });

  // prints:
  // A
  // B
  // C

[Dojo < 1.7]

.. js ::
  
  var A = dojo.declare(null,
    constructor: function(){ console.log("A"); }
  };
  var B = dojo.declare(A,
    constructor: function(){ console.log("B"); }
  };
  var C = dojo.declare(B,
    constructor: function(){ console.log("C"); }
  };
  new C();
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

[Dojo 1.7 (AMD)]

.. js ::
  
  require(['dojo/_base/declare'], function(declare){
    var A = declare(null,
      constructor: function(){
        console.log("A");
      }
    };
    var B = declare(A,
      "-chains-": {
        constructor: "manual"
      },
      constructor: function(){
        console.log("B");
      }
    };
    var C = declare(B,
      constructor: function(){
        console.log("C - 1");
        this.inherited(arguments);
        console.log("C - 2");
      }
    };
    var x = new C();
  });

  // prints:
  // C - 1
  // B
  // C - 2

[Dojo < 1.7]

.. js ::
  
  var A = dojo.declare(null,
    constructor: function(){
      console.log("A");
    }
  };
  var B = dojo.declare(A,
    "-chains-": {
      constructor: "manual"
    },
    constructor: function(){
      console.log("B");
    }
  };
  var C = dojo.declare(B,
    constructor: function(){
      console.log("C - 1");
      this.inherited(arguments);
      console.log("C - 2");
    }
  };
  var x = new C();
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

[Dojo 1.7 (AMD)]

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

[Dojo < 1.7]

.. js ::
  
  var A = dojo.declare(null, {
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

Internally this method uses :ref:`dojo.safeMixin <dojo/safeMixin>`.

**Important note:** Do not forget that ``dojo.declare`` uses mixins to build a constructor from several bases. Remember that only the first base is inherited, the rest is mixed in by copying properties. It means that if you ``extend`` a constructor's prototype that was already used as a mixin and its methods became top methods in the chain of inheritance, these top methods would not be replaced because they are already copied.

Example:

[Dojo 1.7 (AMD)]

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

[Dojo < 1.7]

.. js ::
  
  var A = dojo.declare(null, {
    m1: function(){ console.log("A org"); },
    m2: function(){ console.log("A org"); }
  });

  var B = dojo.declare(null, {
    m2: function(){ this.inherited(arguments); console.log("B org"); },
    m3: function(){ this.inherited(arguments); console.log("B org"); }
  });

  var C = dojo.declare(null, {
    m3: function(){ this.inherited(arguments); console.log("C org"); },
    m4: function(){ this.inherited(arguments); console.log("C org"); }
  });

  var ABC = dojo.declare([A, B, C], {});

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

[Dojo 1.7 (AMD)]

.. js ::
  
  require(['dojo/_base/lang', 'dojo/_base/declare'], function(lang, declare){
    var A = declare(null,
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
    };

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

[Dojo < 1.7]

.. js ::
  
  var A = dojo.declare(null,
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
  };

  var B = dojo.declare(A, {
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

  // extend B using dojo.extend()
  dojo.extend(B, {
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

  // add a method on the fly using dojo.safeMixin()
  dojo.safeMixin(x, {
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

getInherited()
~~~~~~~~~~~~~~

This is a companion method to `inherited()`_. The difference is that it doesn't execute the found method, but returns it. It is up to the user to call it with proper arguments.

The method accepts up to two arguments:

* Optional name of the method to call. If it is specified it must match the name of the caller. Generally it should be specified when calling this method from an un-annotated method (the same rule as for `inherited()`_).
* ``arguments`` - literally ``arguments`` pseudo-variable, which is used for introspection.

The result is a superclass method or ``undefined``, if it was not found. You can use the result as you wish. The most useful case is to pass it to some other function, which cannot use `inherited()`_ directly for some reasons.

Examples:

[Dojo 1.7 (AMD)]

.. js ::
  
  require(['dojo/_base/declare'], function(declare){
    var A = declare(null,
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

[Dojo < 1.7]

.. js ::
  
  var A = dojo.declare(null,
    m1: function(){
      // ...
    },
    m2: function(){
      // ...
    }
  });

  var B = dojo.declare(A, {
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

Internally this method is a helper, which calls `inherited()`_ with ``true`` as the last argument.

isInstanceOf()
~~~~~~~~~~~~~~

This method checks if an instance is derived from a given class. It is modeled on ``instanceof`` operator. It is most useful when you have classes built with the multiple inheritance somewhere in your hierarchy.

The method accepts one argument: class (constructor). It returns ``true``/``false``.

Examples:

[Dojo 1.7 (AMD)]

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

[Dojo < 1.7]

.. js ::
  
  var A = dojo.declare(null);
  var B = dojo.declare(null);
  var C = dojo.declare(null);

  var D = dojo.declare([A, B]);

  var x = new D();

  console.log(x instanceof A);     // true
  console.log(x.isInstanceOf(A));  // true

  console.log(x instanceof B);     // false
  console.log(x.isInstanceOf(B));  // true

  console.log(x instanceof C);     // false
  console.log(x.isInstanceOf(C));  // false

  console.log(x instanceof D);     // true
  console.log(x.isInstanceOf(D));  // true

Using "raw" classes with dojo.declare()
---------------------------------------

``dojo.declare`` allows to use "raw" classes created by other means as a superclass. Such classes are considered to be monolithic (because their structure cannot be introspected) and they cannot use advanced features like `inherited()`_. But their methods will be called by `inherited()`_ and all their methods can be chained (see Chaining_) including constructors.

Examples:

[Dojo 1.7 (AMD)]

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

[Dojo < 1.7]

.. js ::
  
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
  dojo.extend(B, {
    m2: function(){
      // ...
    }
  });

  var C = dojo.declare([A, B], {
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

.. api-inline :: dojo.declare

See Also
========

* `Classy JavaScript with dojo.declare`_

.. _`Classy JavaScript with dojo.declare`: http://dojotoolkit.org/documentation/tutorials/1.7/declare/