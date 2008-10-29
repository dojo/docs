#format dojo_rst

dojo.declare
============

:Status: Draft
:Version: 1.0
:Available: since V0.?

.. contents::
    :depth: 2

Javascript doesn't have a Class system like Java, though Dojo provides functionality to simulate this: dojo.declare. For some background on JavaScript and prototype-based object orientation, chapter 9 of David Flanagan's *JavaScript: The Definitive Guide, 5th edition* is a good read.  

This section has some pretty abstract stuff, and you may wish to skip it on the first read.  Certainly you can do a lot with Dojo without using dojo.declare or the other object orientation functions.  But a good knowledge of it will help you program faster and smarter.


===========
Basic Usage
===========

dojo.declare accepts three arguments. The first is the name of the Class to declare, and is a string representation of the name. The second is either an object or an array of objects, each mixed into your Class in order from left to right. The third is an object hash of properties to be mixed in after all other inheritance has been solved. 

.. code-block :: javascript
  :linenos:

  dojo.declare("my.Thinger", null, { 
      constructor: function(/* Object */args){
          dojo.mixin(this, args);
      }
  });

Here, we've declared a simple class named 'my.Thinger', mixing in 'null' Classes, and finally providing a single property named constructor. The constructor function is run once for each mixed Class. In this example, we've simply mixed the passed arguments into 'this', or our scoped reference to an instance of my.Thinger. You could then create a Thinger like so:

.. code-block :: javascript
  :linenos:

  var thing = new my.Thinger({ count:100 }); 
  console.log(thing.count); 

The dojo.mixin call (in the constructor) then mixes the variable count into the properties of the instance, making it available as a member of the instance. We can supply defaults to use from within dojo.declare itself.

.. code-block :: javascript 
  :linenos:

  dojo.declare("my.Thinger", null, {
      count: 100,
      constructor: function(args){
         dojo.mixin(this, args);
      }
  }); 
  var thing1 = new my.Thinger(); 
  var thing2 = new my.Thinger({ count:200 }); 
  console.log(thing1.count, thing2.count);


Now we have a 'base class', called my.Thinger. To show how the inheritance chain works, we will create a new class derrived from this base Class:

.. code-block :: javascript
  :linenos:

  dojo.declare("my.OtherThinger", [my.Thinger], {
       divisor: 5,
       constructor: function(args){
         console.log('OtherThinger constructor called');
         this.total = this.count / this.divisor;
       }
  });
  var thing = new my.OtherThinger({ count:50 });
  console.log(thing.total); // 10


First, the constructor of 'my.Thinger' is called, mixing in the args parameter. Then, we're using the reserved word 'this' to access instance variables, creating a new variable 'total' based on some simple code. 

Above we passed an object hash exclusively as the parameter to our Class instantiation. The constructor is passed whichever arguments are passed during instantiation. 

.. code-block :: javascript
  :linenos:

  dojo.declare("Person", null, {
	constructor: function(name, age, currentResidence){
		this.name=name;
		this.age=age;
		this.currentResidence = currentResidence;
	}
  });
  var folk = new Person("phiggins", 42, "Tennessee");
 
Each of the ordered parameters are passed (as seen by the constructor's function signature) and then manually added to 'this' by direct variable assignment. 

Let's add some content to a new class by giving it a name and showing what the constructor can do. Following is a Person class with a constructor and a moveToNewState() function:

.. code-block :: javascript
  :linenos:

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


Note the use of anonymous functions here.  You are passing to dojo.declare an associative array of anonymous functions.  "That's not an anonymous function," you might say, "their names are constructor and moveToNewState!"  Strictly speaking, no they aren't.  They are anonymous functions with the *keys* constructor and moveToNewState.  

In pure JavaScript, this is handled by a prototype function named after the class - for example, Person.prototype.  Dojo wires in your constructor as a part of the prototype, but then adds extra goodies like calling the superclass constructor and initializing extra properties.


======================================
Arrays and Objects as member variables
======================================

If your class contains arrays or other objects, they should be declared in the constructor so that each instance gets it's own copy. Simple types (literal strings and numbers) and are fine to declare in the class directly.


.. code-block :: javascript 
  :linenos:

  dojo.declare("my.classes.bar", my.classes.foo, {
	someData: [1, 2, 3, 4], // doesn't do what I want: ends up being static
	numItem : 5, // one per bar
	strItem : "string", // one per bar

	 constructor: function() {
		this.someData = [ ]; // better, each bar has it's own array
		this.expensiveResource = new expensiveResource(); // one per bar 
	}
  });

On the other hand, if you want an object or array to be static (shared between all instances of *my.classes.bar*), then you should do something like this: 

.. code-block :: javascript 
  :linenos:

  dojo.declare("my.classes.bar", my.classes.foo, {
	constructor: function() {
		dojo.debug("this is bar object # " + this.statics.counter++);
	},

	statics: { counter: 0, somethingElse: "hello" }
  });


"Statics" is not a special dojo construct - you can use any name you want, like "constants".  In this example, you'd refer to the variable as myInstance.statics.counter both inside and outside the class definition.  

Why is this true for arrays and objects, but not primitives?  It's because, like most OOP languages, JavaScript uses object references. For example, given:

.. code-block :: javascript 

  x = { fruit: "apple" };
  y = x;

Now *x* and *y* both refer to the same object. Modifying *x.fruit* will also affect *y.fruit*.


===========
Inheritance
===========

A person can only do so much, so let's create an Employee class that extends the Person class.The second argument in the dojo.declare() function is for extending classes.

.. code-block :: javascript
  :linenos:

  dojo.declare("Employee", Person, {
	constructor: function(name, age, currentResidence, position){
                // remember, Person constructor is called automatically
		this.password="";
		this.position=position;
	},

	login: function(){
	    if(this.password){
		alert('you have successfully logged in');
	    }else{
		alert('please ask the administrator for your password');
	    }
        }
  });

Dojo handles all of the requirements for setting up the inheritance chain, including calling the superclass constructor automatically. Methods or variables can be overridden by setting the name to the same as it is in the parent class. The Employee class can override the Person class moveToNewState(), perhaps by letting the company pay for moving expenses.

You initialize the subclass the same as the Person class with the new keyword.

.. code-block :: javascript 

  var kathryn = new Employee(' Kathryn ', 26, 'Minnesota', 'Designer');


The Employee class passes the first three arguments down to the Person class, and sets the position.Kathryn has access to the login() function found in the Employee class, and also the moveToNewState() function by calling kathryn.moveToNewState("Texas"); Matt on the other hand, does not have access to the Employee login() function.

Calling Superclass Methods
--------------------------

Often when you're overriding a method, you want to *add* something to the superclasses method, not totally replace it.  Dojo has helper functions to make this easy.

But you don't have to worry in the constructor.  As we said above, superclass constructors are *always* called automatically, and *always* before the subclass constructor. This convention reduces boilerplate in 90% of cases.

For all other methods, you can use ``inherited(arguments)`` to call the superclass method of the same name.  Take for example:

.. code-block :: javascript 
  :linenos:

    someMethod: function() {
      // call base class someMethod
      this.inherited(arguments);
      // now do something else
    }


Inherited will climb up the scope chain, from superclass to superclass and through mixin classes as well, until it finds "someMethod", then it will invoke that method.

The argument is always literally ``arguments``, a special Javascript array variable which holds all the arguments (like argv in C).

You can send custom parameters to the ancestor function.  Just place the extra arguments in array literal notation with brackets:

.. code-block :: javascript

  this.inherited(arguments, [ customArg1, customArg2 ])


======
Mixins
======

Just as Dojo adds class-based inheritance to JavaScript, so it adds support for *multiple inheritance*.  We do this through Dojo *mixins*.   The methods and properties of a mixed-in class are simply added to each instance. 

In pure object-oriented languages like Java, you must use typecasts to make an object "act like" its mixed-in class (in Java, this is through interfaces).  Not in Dojo.  You can use the mixed-in properties directly.

Suppose, for example, you have a class called VanillaSoftServe, and classes MandMs and CookieDough.  Here's how to make a Blizzard:

.. code-block :: javascript 
  :linenos:

  dojo.declare("VanillaSoftServe",null, {
    constructor: function() { console.debug ("mixing in Vanilla"); }
  });

  dojo.declare("MandMs",null, {
    constructor: function() { console.debug("mixing in MandM's"); },
    kind: "plain"
  });

  dojo.declare("CookieDough",null, {
    chunkSize: "medium"
  });

  dojo.declare("Blizzard", [VanillaSoftServe, MandMs, CookieDough], {
        constructor: function() {
             console.debug("A blizzard with "+
                 this.kind+" M and Ms and "+
                 this.chunkSize+" chunks of cookie dough."
             );
        }
  });
  // make a Blizzard:
  new Blizzard();


This will first print "mixing in Vanilla" on the debug console because VanillaSoftServe is the superclass of Blizzard.  In fact, VanillaSoftServe is the *only* superclass of Blizzard - the first mixin is always the superclass. Next the constructors of the mixins are called, so "mixing in MandMs" will appear.  Then "A blizzard with plain M and Ms and medium chunks of cookie dough." will appear.

Mixins are used a lot in defining Dijit classes, with most classes extending ``dijit._Widget`` and mixing in ``dijit._Templated``.


=======================
Mixin inheritance chain
=======================

Given:

   dojo.declare("foo", [bar, zot, nim])

Then the inheritance chain looks like this:

.. code-block :: html

   foo -> nim -> zot -> bar

It specifically does not look like this:

.. code-block :: html

   foo -> bar
       -> zot
       -> nim

This can be confusing because of the nomenclature. "Mixins" sounds a lot
like the latter, but it's really "multiple base classes with limitations".
Sometimes we use the phrase "mixin classes" to describe it, but that's not
ideal either.

Note also that "mixin classes" can have their own arbitrarily complex
hierarchy. So the "inherits" can also walk a tree.

The upshot of this is that, in general, every mixin method should be calling this.inherited(arguments).   Of course that's assuming it'll be mixed in where the superclass has a method in the base class with the same name.
