#format dojo_rst

dojo.hitch
==========

:Status: Draft
:Version: 1.2


Dojo.hitch is a neat function. It returns a function that will execute a given function in a given scope.  This function allows you to control how a function executes, particularly in asynchronous operations.  How many times have you done something like:

.. code-block :: javascript

  var args = {
    url: "foo",
    load: this.dataLoaded
  }
  dojo.xhrGet(args);  

Only to have it fail with a cryptic error like:
dataLoaded is not a function, or errors about unresolved variables?   Why does that occur?  Well, because in asynchronous callbacks such as above, you're changing the scope of 'dataLoaded' when you assign it into an associative map.  It will no longer refer to the widget that originally provided it, but its scope will now refer to the enclosing object, the xhr arguments!  To get around this, you can use hitch to force the function to retain its original scope.  The same code done properly will look like:

.. code-block :: javascript

  var args = {
    url: "foo",
    load: dojo.hitch(this, "dataLoaded")
  }
  dojo.xhrGet(args);  


And now when the xhrGet call runs the load function, it will run in the appropriate widget scope.



Basic Example
-------------

Let's look at a quick example:

.. code-example::
  :type: inline

  .. javascript::
    
    <script type="text/javascript">
      var myObj = {
        foo: "bar"
      };
      var func = dojo.hitch(myObj, function() {
        console.log(this.foo);
      });
      func();
    </script>

When we open up firebug, we should get "bar" printed. That's because the scope we provided in dojo.hitch was 'myObj', so inside the function, 'this' refers to 'myObj'.

Using Methods in the Scope
--------------------------

Let's say I want to call a method in a given scope. I could do:

.. code-example::
  :type: inline

  .. javascript::

    <script type="text/javascript">
      var myObj = {
        foo: "bar",
        method: function(someArg) {
          console.log(this.foo);
        }
      };
      var func = dojo.hitch(myObj, myObj.method);
      func();
    </script>
  
But that is too much typing. If there's a method that you want to use that's already in the scope, you can just provide the method's name as the second argument:

.. code-example::
  :type: inline

  .. javascript::

    <script type="text/javascript">
      var myObj = {
        foo: "bar",
        method: function(someArg) {
          console.log(this.foo);
        }
      };
      var func = dojo.hitch(myObj, "method");
      func();
    </script>

Firebug should output "bar".

Providing Arguments
-------------------

You can also provide arguments to the function you're calling. Here's an example:

.. code-example::
  :type: inline

  .. javascript::

    <script type="text/javascript">
      var myObj = {
        foo: "bar",
        method: function(someArg) {
          console.log(someArg+" "+this.foo);
        }
      };
      var func = dojo.hitch(myObj, "method", "baz");
      func();
    </script>
  
The output from firebug should be "baz bar". Any arguments provided after the first two will be passed to the function.


Real-World Examples
-------------------

Let's say I want to stop right clicking on my page. This is a one-liner with dojo.hitch.

.. code-example::
  :type: inline

  .. javascript::

    <script type="text/javascript">
      document.onconextmenu = dojo.hitch(dojo, "stopEvent");
    </script>

Ok, so another issue is, if I want to pass a function in dojo.xhrGet, and it's in an object, I can't use 'this' anymore in that function.

.. code-example::
  :type: inline

  .. javascript::

    <script type="text/javascript">
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
    </script>

The above example won't work. If we want to access this.foo, we need to have 'method' called inside of 'myObj'. Giving myObj.method to dojo.xhrGet only passes the function. You can use dojo.hitch to get around this:

.. code-example::
  :type: inline

  .. javascript::

    <script type="text/javascript">
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
    </script>
