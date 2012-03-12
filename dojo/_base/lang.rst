.. _dojo/_base/lang:

===============
dojo/_base/lang
===============

:since: V0.9

.. contents ::
    :depth: 2

**dojo/_base/lang** contains functions for supporting Polymorphism.


clone()
=======
Clones `anything` objects and/or nodes, returning a new `anything`.

Simply pass _something_ to clone(), and a new version of that _something_ will be made.

.. js ::
 
  require(["dojo/_base/lang"], function(lang){
    // clone an object
    var obj = { a:"b", c:"d" };
    var thing = lang.clone(obj);

    // clone an array
    var newarray = lang.clone(["a", "b", "c"]);
  });

Often times, you want to clone a DOM Node. The easiest way to locate a DOM Node is :ref:`byId <dom.byId>`, though consideration to change the id after cloning is required (id's are unique, and should be used as such)

.. js ::
  
  require(["dojo/_base/lang", "dojo/dom", "dojo/dom-attr"], function(lang, dom, attr){
    var node = dom.byId("someNode");
    var newnode = lang.clone(node);
    attr.set(newnode, "id", "someNewId");
  });

If you have a pointer to some node already, or want to avoid id's all together, :ref:`query() <query()>` may be useful:

.. js ::
  
  require(["dojo/_base/lang", "query()", "dojo/dom-construct", "dojo/_base/window"], function(lang, query, ctr, win){
    // get a reference to some node
    var n = query(".someNode")[0];

    // create 10 clones of this node and append to body
    var i = 10;
    while(i--){
      ctr.place(lang.clone(n), win.body());
    }
  });

clone() is always "deep". Cyclic (e.g., circular or DAG) cases are explicitly not supported due to speed and space concerns.

    * If you want a shallow copy of an object y = mixin()({}, x);
    * If you want a shallow copy of an array: y = map()(x, "return value;");
    * The rest will be covered by the deep copy: y = clone()(x);

TODOC: clone + events?


delegate()
==========
Returns a new object which "looks" to obj for properties which it does not have a value for. Optionally takes a bag of properties to seed the returned object with initially.


This is a small implementation of the Boodman/Crockford delegation pattern in JavaScript. An intermediate object constructor mediates the prototype chain for the returned object, using it to delegate down to obj for property lookup when object-local lookup fails. This can be thought of similarly to ES4's "wrap", save that it does not act on types but rather on pure objects.


.. js ::
 
   require(["dojo/_base/lang", function(lang){
      var myNewObject = lang.delegate(anOldObject, { myNewProperty: "value or text"});
   });

Examples
--------

.. js ::

   require(["dojo/_base/lang", function(lang){
     var anOldObject = { bar: "baz" };
     var myNewObject = lang.delegate(anOldObject, { thud: "xyzzy"});
     myNewObject.bar == "baz"; // delegated to anOldObject
     anOldObject.thud == undefined; // by definition
     myNewObject.thud == "xyzzy"; // mixed in from props
     anOldObject.bar = "thonk";
     myNewObject.bar == "thonk"; // still delegated to anOldObject's bar
   });


exists()
========
Check if all objects in a dot-separated string object path exist, such as ``"A.B.C"``.


``exists()`` is a convenience function, particularly useful for testing long object paths. It accepts a string as its first parameter, and walks down the path it represents. You can optionally provide a root for the path as a second parameter, otherwise it will use a default value of the global object. Each portion of the '.' delimited string is tested for defined-ness, returning true only if each object exists as defined in the strong.

.. js ::
 
   require(["dojo/_base/lang"], function(lang){
     if( lang.exists("myns.widget.Foo") ){
       console.log("myns.widget.Foo exists");
     }
   });


The second ``root`` parameter is optional, ``exists()`` will use the value of ``dojo/kernel::global`` by default (which is usually the current ``window``). You can use it to root the path in a different window object, or a particular namespace:

.. js ::
 
 require(["dojo/_base/lang", "dijit/dijit"], function(lang, dijit){
   var widgetType = "form.Button";
   var myNamespace = docs;

   if( lang.exists(widgetType, myNamespace) ){
     console.log( "There's a docs.form.Button available");
   }else if( lang.exists(widgetType, dijit) ){
     console.log( "Dijits form.Button class is available");
   }else{
     console.log( "No form.Button classes are available");
   }
 });

extend()
========
extend() works much like `mixin()`, though works directly on an object's prototype. Following the same pattern as mixin, extend() mixes members from the right-most object into the first object, modifying the object directly.

We can use extend() to extend functionality into existing classes. Consider the following:

.. js ::
  
  require(["dojo/_base/lang", "dijit/TitlePane"], function(lang, TitlePane){
    lang.extend(TitlePane, {
      randomAttribute:"value"
    });
  });

The way the :ref:`dojo/parser <dojo/parser>` works, a custom attribute on the node will be recognized, as in the interest of performance, only declared members are mixed as part of the parsing process. Before the above extend() call, this sample would not recognize the follow markup:

.. html ::
    
     <div data-dojo-type="dijit/TitlePane" data-dojo-props="randomAttribute:'newValue'"></div>

After the extend, any new instances of a TitlePane will have the 'randomAttribute' member mixed into the instance. extend() affects all future instances of a Class (or rather, any object with a .prototype).

Extending _Widget
-----------------

A potentially confusing result of the above actually provides us a lot of flexibility. All Dijit widgets inherit from ``dijit._WidgetBase`` in one way or another. Some widgets, like the :ref:`BorderContainer <dijit/layout/BorderContainer>` can contain arbitrary widgets, though require a 'region' parameter on the contained widget, though rather than manually adding a "region" parameter to each declaration across Dijit, BorderContainer simply extends _WidgetBase with the member, and anyone using any widget within a BorderContainer can specify a region:

.. js ::
  
  require(["dojo/_base/lang", "dijit/_WidgetBase"], function(lang, _WidgetBase){
    lang.extend(_WidgetBase, {
      region:"center"
    });
  });

The side-effect of this is a documentation nightmare. Now ``every`` Dijit appears to have a region variable, when in fact it is just there for the benefit of BorderContainer.

Example: extend() vs mixin()
----------------------------

.. js ::
  
    require(["dojo/_base/lang", "json()"], function(lang, json){
        // define a class
        var myClass = function(){
            this.defaultProp = "default value";
        };
        myClass.prototype = {};
        console.log("the class (unmodified):", json.stringify(myClass.prototype));
    
        // extend the class
        lang.extend(myClass, {"extendedProp": "extendedValue"});
        console.log("the class (modified with lang.extend):", json.stringify(myClass.prototype));
    
        var t = new myClass();
        // add new properties to the instance of our class
        lang.mixin(t, {"myProp": "myValue"});
        console.log("the instance (modified with lang.mixin):", json.stringify(t));
    });

getObject()
===========
getObject() returns the property of an object from a dot-separated string such as "A.B.C"


The simplest way to use getObject() is to pass a dot-separated string as shown below:

.. js ::
 
     // define an object (outside function, in global scope to demonstrate)
     var foo = {
       bar: "some value"
     };
     require(["dojo/_base/lang"], function(lang){
       // get the "foo.bar" property
       lang.getObject("foo.bar");  // returns "some value"
     });

getObject() also takes an optional boolean parameter which, if `true`, will create the property if it does not exist. Any other properties along the path will also be created along the way. The default value is `false`.

.. js ::
 
     // define an object (outside function, in global scope to demonstrate)
     var foo = {
       bar: "some value"
     };
     require(["dojo/_base/lang"], function(lang){
        // get the "foo.baz" property, create it if it doesn't exist
        lang.getObject("foo.baz", true); // returns foo.baz - an empty object {}
        /*
          foo == {
            bar: "some value",
            baz: {}
          }
        */
     });

You can also pass an object as the third parameter. This will define the context in which to search for the property. By default, the context is :ref:`global() <global()>`.

.. js ::
 
     require(["dojo/_base/lang"], function(lang){
        // define an object
        var foo = {
           bar: "some value"
        };
    
        // get the "bar" property of the foo object
        lang.getObject("bar", false, foo); // returns "some value"
     });


hitch()
=======
hitch() is a neat function. It returns a function that will execute a given function in a given scope.  This function allows you to control how a function executes, particularly in asynchronous operations.  How many times have you done something like:

.. js ::

  require(["dojo/_base/xhr"], function(xhr){
    var args = {
      url: "foo",
      load: this.dataLoaded
    };
    xhr.get(args);
  });


Only to have it fail with a cryptic error like:
dataLoaded is not a function, or errors about unresolved variables?   Why does that occur?  Well, because in asynchronous callbacks such as above, you're changing the scope of 'dataLoaded' when you assign it into an associative map.  It will no longer refer to the widget that originally provided it, but its scope will now refer to the enclosing object, the xhr arguments!  To get around this, you can use hitch to force the function to retain its original scope.  The same code done properly will look like:

.. js ::

  require(["dojo/_base/xhr", "dojo/_base/lang"], function(xhr, lang){
    var args = {
      url: "foo",
      load: lang.hitch(this, "dataLoaded")
    };
    xhr.get(args);
  });

And now when the xhr.get call runs the load function, it will run in the appropriate widget scope.



Example
-------------

Let's look at a quick example:

.. code-example::
 
  .. js ::

      require(["dojo/_base/lang"], function(lang){
          var myObj = {
            foo: "bar"
          };
          var func = lang.hitch(myObj, function(){
            console.log(this.foo);
          });
          func();
      });

When we open up firebug, we should get "bar" printed. That's because the scope we provided in hitch() was 'myObj', so inside the function, 'this' refers to 'myObj'.

Using Methods in the Scope
--------------------------

Let's say I want to call a method in a given scope. If there's a method that you want to use that's already in the scope, you can just provide the method's name as the second argument:

.. code-example::

  .. js ::

      require(["dojo/_base/lang"], function(lang){
          var myObj = {
            foo: "bar",
            method: function(someArg){
              console.log(this.foo);
            }
          };
          var func = lang.hitch(myObj, "method");
          func();
      });

Firebug should output "bar".

Providing Arguments
-------------------

You can also provide arguments to the function you're calling. Here's an example:

.. code-example::

  .. js ::

      require(["dojo/_base/lang"], function(lang){
          var myObj = {
            foo: "bar",
            method: function(someArg){
              console.log(someArg+" "+this.foo);
            }
          };
          var func = lang.hitch(myObj, "method", "baz");
          func();
      });

The output from firebug should be "baz bar". Any arguments provided after the first two will be passed to the function.


Real-World Examples
-------------------

Let's say I want to stop right clicking on my page. This is a one-liner with hitch():

.. js ::

      document.onconextmenu = lang.hitch(event, "stop");

Ok, so another issue is, if I want to pass a function in xhr.get(), and it's in an object, I can't use 'this' anymore in that function.

.. js ::

      var myObj = {
        foo: "bar",
        method: function(someArg){
          console.log(this.foo+" "+data);
        }
      };
      xhr.get({
        url: "/something.php",
        load: myObj.method
      });

The above example won't work. If we want to access this.foo, we need to have 'method' called inside of 'myObj'. Giving myObj.method to xhr.get() only passes the function. You can use hitch() to get around this:

.. js ::

      var myObj = {
        foo: "bar",
        method: function(data){
          console.log(this.foo+" "+data);
        }
      };
      xhr.get()({
        url: "/something.php",
        load: lang.hitch(myObj, "method")
      });

mixin()
=======
mixin() is a simple utility function for mixing objects together. Mixin combines two objects from right to left, overwriting the left-most object, and returning the newly mixed object for use. mixin() is very similar to :ref:`extend() <extend()>` but only works on objects, whereas extend explicitly extends an object.prototype. Merging two objects


Simple Mixes
------------

Merge two objects (join two objects) together with mixin():

.. js ::
  
  require(["dojo/_base/lang"], function(lang){
    var a = { b:"c", d:"e" };
    lang.mixin(a, { d:"f", g:"h" });
    console.log(a); // b:c, d:f, g:h
  });

This example overwrites the "d" member from the second object, leaving the variable "a" with three members: b, d, and g. To expand on this, we can illustrate how to use mixin to overwrite defaults for some function:

.. js ::
  
  require(["dojo/_base/lang", "dojo/_base/fx"], function(lang, fx){
    var generatedProps = { node:"someNode", onEnd:function(){ /*code*/ } };
    var defaultProps = { duration:1000 };
    fx.fadeIn(lang.mixin(generatedProps, defaultProps)).play();
  });

This will create and play a fadeIn animation passing and onEnd function and node, using a default duration.


Creating new Objects
--------------------

Mixin modifies the first object in the list, mixing in second object. If you wish to make an entirely new object from the mixed results, you have a couple options. First, clone the existing object with clone(), then mix:

.. js ::
  
  require(["dojo/_base/lang"], function(lang){
    var newObject = lang.mixin(lang.clone(a), b);
  });

Here, the return from :ref:`clone() <clone()>` is a new object, then b is mixed in.

Alternately, you can pass an empty object as the first mix, and mix another object into it. You can then repeat this pattern as often as you'd like:

.. js ::
  
  require(["dojo/_base/lang"], function(lang){
    var newObject = lang.mixin({}, b);
    lang.mixin(newObject, c);
    lang.mixin(newObject, lang.mixin(e, f));
    // and so on
  });

Just remember the object instance in the first position will always be overwritten, and the right-most object will take precedence in the mix.


Mixins with Classes
-------------------

A common pattern when creating class objects is to pass an object-hash of properties to the constructor. mixin() provides a technique for easy override of default in you own classes. Consider the follow class declaration:

.. js ::
  
  require(["dojo/_base/lang", "dojo/_base/declare"], function(lang, declare){
    declare("my.Thinger", null, {
      defaultValue: "red",
      constructor: function(args){
          lang.mixin(this, args);
      }
    });
  });

Now, any time we create a new instance of a my.Thinger, it will have a member variable "defaultValue" set to red. If we provide a new defaultValue, the constructor will immediately overwrite the existing one:

.. js ::
  
  var thing = new my.Thinger({ defaultValue:"blue" });

Mixing into instances
---------------------

Sometimes is it useful to mix custom variables and members into instances of widgets and other objects. Mixing into an instance allows you to easily add arbitrary references or overwrite functionality after instantiation.

.. js ::
  
  require(["dojo/_base/lang"], function(lang){
    var cp = new dijit.layout.ContentPane();
    lang.mixin(cp, { _timeCreated: new Date() });
  });

Now, that instance of the ContentPane as a Date object attached in the _timeCreated member, which is accessible to the widget as 'this._timeCreated'.

Mixing methods
--------------

If you want to mix in some methods into an instance using two previous techniques, be aware that :ref:`declare() <declare()>` decorates them, while ``mixin()`` does not, which may affect how ``this.inherited()`` works, if used in mixed-in methods. Use :ref:`safeMixin() <safeMixin()>`, which correctly handles all properties in ``declare()``-compatible way.

partial()
=========

Have you ever wanted to control arguments being passed into a function?  For example, have you ever had the need to set the first parameter of a function to a defined value and allow the others to still vary?  Well, provides() a way to do that!  Partial is a cousin to 'hitch' in that it's a function that returns a function.  What it does is allow you to fix the first N parameters of a function call to some specific value.  This can be very powerful, especially when you want to pass in object references or the like into notification functions of DataStores.

Let's take a quick look at a pseudo-code example of using partial:

.. js ::

  require(["dojo/_base/lang", "dojo/_base/xhr"], function(lang, xhr){
    var dataLoaded = function(someFirstParam, data, ioargs){};

    var args = {
      url: "foo",
      load: dataLoaded
    };
    xhr.get(args);
  });

Okay, so that will invoke the dataLoaded function when the xhr.get function returns ... but load of xhr.get expects param structure of:
load(data, ioargs).  So how the heck do we make sure that xhr.get's expectations are honored even with that new first param called 'someFirstParam'?  Enter partial()!  Here's how you would do it:

.. js ::

  require(["dojo/_base/lang", "dojo/_base/xhr"], function(lang, xhr){
    var dataLoaded = function(someFirstParam, data, ioargs){};

    var args = {
      url: "foo",
      load: lang.partial(dataLoaded, "firstValue");
    };
    xhr.get(args);
  });

What that does is create a new function that wraps dataLoaded and affixes the first parameter with the value "firstValue".  Note that partial() allows you to do N parameters, so you can keep defining as many values as you want for fixed-value parameters of a function.

Example
-------

.. code-example ::

  Let's look at a quick running example:

  .. js ::

      require(["dojo/dom", "dojo/_base/lang", "dojo/on", "dojo/domReady!"], function(dom, lang, on){
            var myClick = function(presetValue, event){
               var node = dom.byId("appendLocation");
               node.appendChild(document.createTextNode(presetValue));
               node.appendChild(document.createElement("br"));
            };
            on(dom.byId("myButton"), "click", lang.partial(myClick, "This is preset text!"));
      });

  .. html ::
    
    <button id="myButton">Click me to append in a preset value!</button>
    <div id="appendLocation"></div>

replace()
=========
This function provides a light-weight foundation for substitution-based templating. It is a sane alternative to string concatenation technique, which is brittle and doesn't play nice with localization.

Basic Usage
-----------

replace() accepts 3 arguments:

* String template to be interpolated.
* Object or function to be used for substitutions.
* Optional regular expression pattern to look for. By default all patterns looking like ``{abc}`` are going to be found and replaced.

With dictionary
~~~~~~~~~~~~~~~

If the second argument is an object, all names within braces are interpreted as property names within this object. All names separated by ``.`` (dot) will be interpreted as subobjects. This default behavior provides a great flexibility:


.. code-example::
  :djConfig: parseOnLoad: false

  .. js ::

      require(["dojo/_base/lang", "dojo/dom", "dojo/domReady!"], function(lang, dom){
          dom.byId("output").innerHTML = lang.replace(
            "Hello, {name.first} {name.last} AKA {nick}!",
            {
              name: {
                first:  "Robert",
                middle: "X",
                last:   "Cringely"
              },
              nick: "Bob"
            }
          );
      });

  .. html ::

    <p id="output"></p>

You don't need to use all properties of an object, you can list them in any order, and you can reuse them as many times as you like.

With array
~~~~~~~~~~

In most cases you may prefer an array notation effectively simulating the venerable ``printf``:

.. code-example::
  :djConfig: parseOnLoad: false

  .. js ::

      require(["dojo/_base/lang", "dojo/dom", "dojo/domReady!"], function(lang, dom){
        dom.byId("output").innerHTML = lang.replace(
          "Hello, {0} {2} AKA {3}!",
          ["Robert", "X", "Cringely", "Bob"]
        );
      });

  .. html ::

    <p id="output"></p>

Advanced Usage
--------------

With function
~~~~~~~~~~~~~

For ultimate flexibility you can use replace() with a function as the second argument. The function is going to be called with 4 arguments:

* Whole match.
* Name between found braces.
* Offset of the match.
* Whole string.

Essentially these arguments are the same as in `String.replace() <https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Global_Objects/String/replace>`_ when a function is used. Usually the second argument is the most useful one.

Let's take a look at example where we are calculating values lazily on demand from a potentially dynamic source.

This code in action:

.. code-example::
  :djConfig: parseOnLoad: false

  .. js ::

      require(["dojo/_base/array", "dojo/_base/lang", "dojo/dom", "dojo/domReady!"],
      function(array, lang, dom){

          // helper function
          function sum(a){
            var t = 0;
            array.forEach(a, function(x){ t += x; });
            return t;
          }

          dom.byId("output").innerHTML = lang.replace(
              "{count} payments averaging {avg} USD per payment.",
              lang.hitch(
                  { payments: [11, 16, 12] },
                  function(_, key){
                      switch(key){
                          case "count": return this.payments.length;
                          case "min":   return Math.min.apply(Math, this.payments);
                          case "max":   return Math.max.apply(Math, this.payments);
                          case "sum":   return sum(this.payments);
                          case "avg":   return sum(this.payments) / this.payments.length;
                      }
                  }
              )
          );
      });

  .. html ::

    <p id="output"></p>

With custom pattern
~~~~~~~~~~~~~~~~~~~

In some cases you may want to use different braces, e.g., because your interpolated strings contain patterns similar to ``{abc}``, but they should not be evaluated and replaced, or your server-side framework already uses these patterns for something else. In this case you should replace the pattern:

.. code-example::
  :djConfig: parseOnLoad: false

  .. js ::

      require(["dojo/_base/lang", "dojo/dom", "dojo/domReady!"], function(lang, dom){
        dom.byId("output").innerHTML = lang.replace(
          "Hello, %[0] %[2] AKA %[3]!",
          ["Robert", "X", "Cringely", "Bob"],
          /\%\[([^\]]+)\]/g
        );
      });

  .. html ::

    <p id="output"></p>

It is advised for the new pattern to be:

* Global
* It should capture one substring, usually some text inside "braces".

Examples
--------

Below are real-world examples of using replace().

Escaping substitutions
~~~~~~~~~~~~~~~~~~~~~~

Let's escape substituted text for HTML to prevent possible exploits.
Dijit templates implement similar technique.
We will borrow Dijit syntax: all names starting with ``!`` are going to be placed as is (example: ``{!abc}``),
while everything else is going to be filtered.

.. code-example::
  :djConfig: parseOnLoad: false

  .. js ::

	  require(["dojo/dom", "dojo/_base/lang", "dojo/domReady!"], function(dom, lang){
		function safeReplace(tmpl, dict){
		  // convert dict to a function, if needed
		  var fn = lang.isFunction(dict) ? dict : function(_, name){
			return lang.getObject(name, false, dict);
		  };
		  // perform the substitution
		  return lang.replace(tmpl, function(_, name){
			if(name.charAt(0) == '!'){
			  // no escaping
			  return fn(_, name.slice(1));
			}
			// escape
			return fn(_, name).
			  replace(/&/g, "&amp;").
			  replace(/</g, "&lt;").
			  replace(/>/g, "&gt;").
			  replace(/"/g, "&quot;");
		  });
		}

		// we don't want to break the Code Glass widget here
		var bad = "{script}alert('Let\' break stuff!');{/script}";
		// let's reconstitute the original bad string
		bad = bad.replace(/\{/g, "<").replace(/\}/g, ">");
		// now the replacement
		dom.byId("output").innerHTML = safeReplace("<div>{0}</div", [bad]);
	  });

  .. html ::

    <p id="output"></p>

Formatting substitutions
~~~~~~~~~~~~~~~~~~~~~~~~

Let's add a simple formatting to substituted fields. We will use the following notation in this example:

* ``{name}`` - use the result of substitution directly.
* ``{name:fmt}`` - use formatter ``fmt`` to format the result.
* ``{name:fmt:a:b:c}`` - use formatter ``fmt`` with optional parameters ``a``, ``b``, and ``c``. Any number of parameters can be used. Their interpretation depends on a formatter.

In this example we are going to format numbers as fixed or exponential with optional precision.

.. code-example::
  :djConfig: parseOnLoad: false

  .. js ::

	  require(["dojo/dom", "dojo/_base/lang", "dojo/domReady!"], function(dom, lang){
		function format(tmpl, dict, formatters){
		  // convert dict to a function, if needed
		  var fn = lang.isFunction(dict) ? dict : function(_, name){
			return lang.getObject(name, false, dict);
		  };
		  // perform the substitution
		  return lang.replace(tmpl, function(_, name){
			var parts = name.split(":"),
			value = fn(_, parts[0]);
			if(parts.length > 1){
			  value = formatters[parts[1]](value, parts.slice(2));
			}
			return value;
		  });
		}
		// simple numeric formatters
		var customFormatters = {
		  f: function(value, opts){
			// return formatted as a fixed number
			var precision = opts && opts.length && opts[0];
			return Number(value).toFixed(precision);
		  },
		  e: function(value, opts){
			// return formatted as an exponential number
			var precision = opts && opts.length && opts[0];
			return Number(value).toExponential(precision);
		  }
		};
		// that is how we use it:
		var output1 = format(
		  "pi = {pi}<br>pi:f = {pi:f}<br>pi:f:5 = {pi:f:5}",
		  {pi: Math.PI, big: 1234567890},
		  customFormatters
		);

		dom.byId("output1").innerHTML = format(
		  "pi = {pi}<br>pi:f = {pi:f}<br>pi:f:5 = {pi:f:5}",
		  {pi: Math.PI, big: 1234567890},
		  customFormatters
		);
		dom.byId("output2").innerHTML = format(
		  "big = {big}<br>big:e = {big:e}<br>big:e:5 = {big:e:5}",
		  {pi: Math.PI, big: 1234567890},
		  customFormatters
		);
	  });

  .. html ::

    <p id="output1"></p>
    <p id="output2"></p>

setObject()
===========
Set a property from a dot-separated string, such as "A.B.C".

In JavaScript, a dot separated string like obj.parent.child refers to an item called child inside an object called parent inside of obj.

setObject will let you set the value of child, creating the intermediate parent object(s) if they don't exist.

Without `setObject()`, we often see code like this:

.. js ::

  // ensure that intermediate objects are available
  if(!obj["parent"]){ obj.parent ={}; }
  if(!obj.parent["child"]){ obj.parent.child={}; }

  // now we can safely set the property
  obj.parent.child.prop = "some value";


Wheras with `setObject()`, we can shorten that to:

.. js ::

  require(["dojo/_base/lang"], function(lang){
    lang.setObject("parent.child.prop", "some value", obj);
  });


trim()
======
This function implements a frequently required functionality: it removes white-spaces from both ends of a string. This functionality is part of ECMAScript 5 standard and implemented by some browsers. In this case trim() delegates to the native implementation. More information can be found here: `String.trim() at MDC <https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Global_Objects/String/Trim>`_.

trim's implementation was informed by `Steven Levithan's blog post <http://blog.stevenlevithan.com/archives/faster-trim-javascript>`_. We chose to implement the compact yet performant version. If your application requires even more speed, check out `dojo/string::trim <dojo/string#trim>`_, which implements the fastest version.

Usage
-----

trim() accepts the only argument: a string to be trimmed.

.. code-example::
  :djConfig: parseOnLoad: false

  .. js ::

	  require(["dojo/dom", "dojo/_base/lang", "dojo/domReady!"], function(dom, lang){
		  function show(str){
			return "|" + lang.trim(str) + "|";
		  }
		  dom.byId("output1").innerHTML = show("   one");
		  dom.byId("output2").innerHTML = show("two ");
		  dom.byId("output3").innerHTML = show("   three ");
		  dom.byId("output4").innerHTML = show("\tfour\r\n");
		  dom.byId("output5").innerHTML = show("\f\n\r\t\vF I V E\f\n\r\t\v");
	  });

  .. html ::

      <p id="output1"></p>
      <p id="output2"></p>
      <p id="output3"></p>
      <p id="output4"></p>
      <p id="output5"></p>


Deprecated
==========
See :ref:`Testing Object Types <releasenotes/migration-2.0#testing-object-types>` for advice on how to
differentiate between different types of objects without using methods().  The methods below are deprecated:

* isString()

  Checks if the parameter is a String

* isArray()

  Checks if the parameter is an Array

* isFunction()

  Checks if the parameter is a Function

* isObject()

  Checks if the parameter is a Object

* isArrayLike()

  Checks if the parameter is like an Array

* isAlien()

  Checks if the parameter is a built-in function


See also
========

* :ref:`dojox/lang <dojox/lang/index>`
