## page was renamed from 1.2/dojo/declare
#format dojo_rst

dojo.declare
============

:Status: Contributed, Draft
:Version: 1.0

Javascript doesn't have a Class system like Java, though Dojo provides functionality to simulate this: dojo.declare. For some background on JavaScript and prototype-based object orientation, chapter 9 of David Flanagan's <i>JavaScript: The Definitive Guide, 5th edition</i> is a good read.  

This section has some pretty abstract stuff, and you may wish to skip it on the first read.  Certainly you can do a lot with Dojo without using dojo.declare or the other object orientation functions.  But a good knowledge of it will help you program faster and smarter.

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
