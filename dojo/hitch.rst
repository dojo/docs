#format dojo_rst

dojo.hitch
==========

:Status: Draft
:Version: 1.2


Dojo.hitch is a neat function. It returns a function that will execute a given function in a given scope.

Basic Example
-------------

.. cv-compound::

  Let's look at a quick example:

  .. cv:: javascript

    var myObj = {
      foo: "bar"
    };
    var func = dojo.hitch(myObj, function() {
      console.log(this.foo);
    });
    func();

  When we open up firebug, we should get "bar" printed. That's because the scope we provided in dojo.hitch was 'myObj', so inside the function, 'this' refers to 'myObj'.

Using Methods in the Scope
--------------------------

.. cv-compound::

  Let's say I want to call a method in a given scope. I could do:

  .. cv-javascript
    
    var myObj = {
      foo: "bar",
      method: function(someArg) {
        console.log(this.foo);
      }
    };
    var func = dojo.hitch(myObj, myObj.method);
    func();
  
  But that is too much typing. If there's a method that you want to use that's already in the scope, you can just provide the method's name as the second argument.

  .. cv-javascript
    
    var myObj = {
      foo: "bar",
      method: function(someArg) {
        console.log(this.foo);
      }
    };
    var func = dojo.hitch(myObj, "method");
    func();

  firebug should output "bar".

Providing Arguments
-------------------

.. cv-compound::

  You can also provide arguments to the function you're calling. Here's an example:

  .. cv-javascript
    
    var myObj = {
      foo: "bar",
      method: function(someArg) {
        console.log(someArg+" "+this.foo);
      }
    };
    var func = dojo.hitch(myObj, "method", "baz");
    func();
  
  The output from firebug should be "baz bar". Any arguments provided after the first two will be passed to the function.

Real-World Examples
-------------------

.. cv-compound::

  Lets say I want to stop right clicking on my page. This is a one-liner with dojo.hitch.

  .. cv-javascript

    document.onconextmenu = dojo.hitch(dojo, "stopEvent");

.. cv-compound::

  Ok, so another issue is, if I want to pass a function in dojo.xhrGet, and it's in an object, I can't use 'this' anymore in that function.

  .. cv-javascript

    var myObj = {
      foo: "bar",
      method: function(someArg) {
        console.log(this.foo+" "+data);
      }
    };
   dojo.xhrGet({
     url: "/something.php",
     load: myObj.method
   });

  The above example won't work. If we want to access this.foo, we need to have 'method' called inside of 'myObj'. Giving myObj.method to dojo.xhrGet only passes the function. You can use dojo.hitch to get around this:

  .. cv-javascript

    var myObj = {
      foo: "bar",
      method: function(data) {
        console.log(this.foo+" "+data);
      }
    };
   dojo.xhrGet({
     url: "/something.php",
     load: dojo.hitch(myObj, "method")
   });
