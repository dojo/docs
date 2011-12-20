.. _dojo/replace:

============
dojo.replace
============

:since: 1.4
:Author: Eugene Lazutkin

.. contents ::
    :depth: 2

This function provides a light-weight foundation for substitution-based templating. It is a sane alternative to string concatenation technique, which is brittle and doesn't play nice with localization.

Basic Usage
===========

dojo.replace accepts 3 arguments:

* String template to be interpolated.
* Object or function to be used for substitutions.
* Optional regular expression pattern to look for. By default all patterns looking like ``{abc}`` are going to be found and replaced.

With dictionary
---------------

If the second argument is an object, all names within braces are interpreted as property names within this object. All names separated by ``.`` (dot) will be interpreted as subobjects. This default behavior provides a great flexibility:

[ Dojo 1.7 AMD ]

.. js ::
  
  require(["dojo/_base/lang"], function(lang){
    var output = lang.replace(
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


[ Dojo < 1.7 ]

.. js ::
  
  var output = dojo.replace(
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

You can see this code in action:

.. code-example::
  :toolbar: none
  :width:  600
  :height: 400
  :djConfig: parseOnLoad: false

  A complex object can be used with dojo.replace.

[ Dojo 1.7 AMD ]

.. js ::

      require(["dojo/_base/lang", "dojo/ready", "dojo/dom"], function(lang, ready, dom){
        ready(function(){
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
      });


[ Dojo < 1.7 ]

.. js ::

      dojo.ready(function(){
        dojo.byId("output").innerHTML = dojo.replace(
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


Minimalistic HTML for our example.

.. html ::

    <p id="output"></p>

You don't need to use all properties of an object, you can list them in any order, and you can reuse them as many times as you like.

With array
----------

In most cases you may prefer an array notation effectively simulating the venerable ``printf``:

.. js ::
  
  // Dojo 1.7 (AMD)
  require(["dojo/_base/lang"], function(lang){
    var output = lang.replace(
      "Hello, {0} {2} AKA {3}!",
      ["Robert", "X", "Cringely", "Bob"]
    );
  });
  // Dojo < 1.7
  var output = dojo.replace(
    "Hello, {0} {2} AKA {3}!",
    ["Robert", "X", "Cringely", "Bob"]
  );

This code in action:

.. code-example::
  :toolbar: none
  :width:  600
  :height: 400
  :version: local
  :djConfig: parseOnLoad: false

  An array can be used with dojo.replace.

  .. js ::

      dojo.ready(function(){
        dojo.byId("output").innerHTML = dojo.replace(
          "Hello, {0} {2} AKA {3}!",
          ["Robert", "X", "Cringely", "Bob"]
        );
      });

  Minimalistic HTML for our example.

  .. html ::

    <p id="output"></p>

Advanced Usage
==============

With function
-------------

For ultimate flexibility you can use dojo.replace with a function as the second argument. The function is going to be called with 4 arguments:

* Whole match.
* Name between found braces.
* Offset of the match.
* Whole string.

Essentially these arguments are the same as in `String.replace() <https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Global_Objects/String/replace>`_ when a function is used. Usually the second argument is the most useful one.

Let's take a look at example:

[ Dojo 1.7 AMD ]

.. js ::
  
  require(["dojo_base/array", "dojo/_base/lang"], function(array, lang){
    // helper function
    function sum(a){
      var t = 0;
      array.forEach(a, function(x){ t += x; });
      return t;
    }

    var output = lang.replace(
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


[ Dojo < 1.7 ]

.. js ::
  
  // helper function
  function sum(a){
    var t = 0;
    dojo.forEach(a, function(x){ t += x; });
    return t;
  }

  var output = dojo.replace(
    "{count} payments averaging {avg} USD per payment.",
    dojo.hitch(
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

As you can see in this example we are calculating values lazily on demand from a potentially dynamic source.

This code in action:

.. code-example::
  :toolbar: none
  :width:  600
  :height: 400
  :version: local
  :djConfig: parseOnLoad: false

  A function can be used with dojo.replace.

  .. js ::

      // helper function
      function sum(a){
        var t = 0;
        dojo.forEach(a, function(x){ t += x; });
        return t;
      }

      dojo.ready(function(){
        dojo.byId("output").innerHTML = dojo.replace(
          "{count} payments averaging {avg} USD per payment.",
          dojo.hitch(
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

  Minimalistic HTML for our example.

  .. html ::

    <p id="output"></p>

With custom pattern
-------------------

In some cases you may want to use different braces, e.g., because your interpolated strings contain patterns similar to ``{abc}``, but they should not be evaluated and replaced, or your server-side framework already uses these patterns for something else. In this case you should replace the pattern:

.. js ::
  
  // Dojo 1.7 (AMD)
  require(["dojo/_base/lang"], function(lang){
    var output = lang.replace(
      "Hello, %[0] %[2] AKA %[3]!",
      ["Robert", "X", "Cringely", "Bob"],
      /\%\[([^\]]+)\]/g
    );
  });
  // Dojo < 1.7
  var output = dojo.replace(
    "Hello, %[0] %[2] AKA %[3]!",
    ["Robert", "X", "Cringely", "Bob"],
    /\%\[([^\]]+)\]/g
  );

This code in action:

.. code-example::
  :toolbar: none
  :width:  600
  :height: 400
  :version: local
  :djConfig: parseOnLoad: false

  A pattern can be replaced.

  .. js ::

      dojo.ready(function(){
        dojo.byId("output").innerHTML = dojo.replace(
          "Hello, %[0] %[2] AKA %[3]!",
          ["Robert", "X", "Cringely", "Bob"],
          /\%\[([^\]]+)\]/g
        );
      });

  Minimalistic HTML for our example.

  .. html ::

    <p id="output"></p>

It is advised for the new pattern to be:

* Global
* It should capture one substring, usually some text inside "braces".

Examples
========

Below are real-world examples of using dojo.replace.

Highlighting substitutions
--------------------------

Let's add highlighting to all substituted fields:

[ Dojo 1.7 AMD ]

.. js ::
  
  require(["dojo/_base/lang"], function(lang){
    function hiliteReplace(tmpl, dict){
      // add highlights first
      var hilited = lang.replace(tmpl, function(_, name){
        return "<span class='hilite'>{" + name + "}</span>";
      });
      // now perform real substitutions
      return lang.replace(hilited, dict);
    }
    // that is how we use it:
    var output = hiliteReplace("Hello, {0} {2} AKA {3}!",
      ["Robert", "X", "Cringely", "Bob"]
    );
  });


[ Dojo < 1.7 ]

.. js ::
  
  function hiliteReplace(tmpl, dict){
    // add highlights first
    var hilited = dojo.replace(tmpl, function(_, name){
      return "<span class='hilite'>{" + name + "}</span>";
    });
    // now perform real substitutions
    return dojo.replace(hilited, dict);
  }
  // that is how we use it:
  var output = hiliteReplace("Hello, {0} {2} AKA {3}!",
    ["Robert", "X", "Cringely", "Bob"]
  );

Take a look at this code in action:

.. code-example::
  :toolbar: none
  :width:  600
  :height: 400
  :version: local
  :djConfig: parseOnLoad: false

  Highlighting replaced fields.

  .. js ::

      function hiliteReplace(tmpl, dict){
        var hilited = dojo.replace(tmpl, function(_, name){
          return "<span class='hilite'>{" + name + "}</span>";
        });
        return dojo.replace(hilited, dict);
      }
      dojo.ready(function(){
        dojo.byId("output").innerHTML = hiliteReplace(
          "Hello, {0} {2} AKA {3}!",
          ["Robert", "X", "Cringely", "Bob"]
        );
      });

  Minimalistic CSS for our example.

  .. css ::

      .hilite {font-weight: bold; color: green;}

  Minimalistic HTML for our example.

  .. html ::

    <p id="output"></p>

Escaping substitutions
----------------------

Let's escape substituted text for HTML to prevent possible exploits.
Dijit templates implement similar technique.
We will borrow Dijit syntax: all names starting with ``!`` are going to be placed as is (example: ``{!abc}``),
while everything else is going to be filtered.

[ Dojo 1.7 AMD ]

.. js ::
  
  require(["dojo/_base/lang"], function(lang){
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
    // that is how we use it:
    var output = safeReplace("<div>{0}</div",
      ["<script>alert('Let\' break stuff!');</script>"]
    );
  });


[ Dojo < 1.7 ]

.. js ::
  
  function safeReplace(tmpl, dict){
    // convert dict to a function, if needed
    var fn = dojo.isFunction(dict) ? dict : function(_, name){
      return dojo.getObject(name, false, dict);
    };
    // perform the substitution
    return dojo.replace(tmpl, function(_, name){
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
  // that is how we use it:
  var output = safeReplace("<div>{0}</div",
    ["<script>alert('Let\' break stuff!');</script>"]
  );

You can check the result here:

.. code-example::
  :toolbar: none
  :width:  600
  :height: 400
  :version: local
  :djConfig: parseOnLoad: false

  Escaping replaced fields.

  .. js ::

      function safeReplace(tmpl, dict){
        // convert dict to a function, if needed
        var fn  = dojo.isFunction(dict) ? dict : function(_, name){
          return dojo.getObject(name, false, dict);
        };
        // perform the substitution
        return dojo.replace(tmpl, function(_, name){
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
      dojo.ready(function(){
        // we don't want to break the Code Glass widget here
        var bad = "{script}alert('Let\' break stuff!');{/script}";
        // let's reconstitute the original bad string
        bad = bad.replace(/\{/g, "<").replace(/\}/g, ">");
        // now the replacement
        dojo.byId("output").innerHTML = safeReplace("<div>{0}</div", [bad]);
      });

  Minimalistic HTML for our example.

  .. html ::

    <p id="output"></p>

Formatting substitutions
------------------------

Let's add a simple formatting to substituted fields. We will use the following notation in this example:

* ``{name}`` - use the result of substitution directly.
* ``{name:fmt}`` - use formatter ``fmt`` to format the result.
* ``{name:fmt:a:b:c}`` - use formatter ``fmt`` with optional parameters ``a``, ``b``, and ``c``. Any number of parameters can be used. Their interpretation depends on a formatter.

In this example we are going to format numbers as fixed or exponential with optional precision.

[ Dojo 1.7 AMD ]

.. js ::
  
  require(["dojo/_base/lang"], function(lang){
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
    var output2 = format(
      "big = {big}<br>big:e = {big:e}<br>big:e:5 = {big:e:5}",
      {pi: Math.PI, big: 1234567890},
      customFormatters
    );
  });


[ Dojo < 1.7 ]

.. js ::
  
  function format(tmpl, dict, formatters){
    // convert dict to a function, if needed
    var fn = dojo.isFunction(dict) ? dict : function(_, name){
      return dojo.getObject(name, false, dict);
    };
    // perform the substitution
    return dojo.replace(tmpl, function(_, name){
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
  var output2 = format(
    "big = {big}<br>big:e = {big:e}<br>big:e:5 = {big:e:5}",
    {pi: Math.PI, big: 1234567890},
    customFormatters
  );

You can check the result here:

.. code-example::
  :toolbar: none
  :width:  600
  :height: 400
  :version: local
  :djConfig: parseOnLoad: false

  Formatting replaced fields.

  .. js ::

      function format(tmpl, dict, formatters){
        // convert dict to a function, if needed
        var fn = dojo.isFunction(dict) ? dict : function(_, name){
          return dojo.getObject(name, false, dict);
        };
        // perform the substitution
        return dojo.replace(tmpl, function(_, name){
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
      dojo.ready(function(){
        dojo.byId("output1").innerHTML = format(
          "pi = {pi}<br>pi:f = {pi:f}<br>pi:f:5 = {pi:f:5}",
          {pi: Math.PI, big: 1234567890},
          customFormatters
        );
        dojo.byId("output2").innerHTML = format(
          "big = {big}<br>big:e = {big:e}<br>big:e:5 = {big:e:5}",
          {pi: Math.PI, big: 1234567890},
          customFormatters
        );
      });

  Minimalistic HTML for our example.

  .. html ::

    <p id="output1"></p>
    <p id="output2"></p>
