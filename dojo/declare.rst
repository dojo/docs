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
       }
   });
