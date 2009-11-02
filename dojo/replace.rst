#format dojo_rst

dojo.replace
============

:Status: Draft
:Version: 1.4
:Available: since V1.4

.. contents::
    :depth: 2

This function provides a light-weight foundation for substitution-based templating. It is a sane alternative to string concatenation technique, which is brittle and doesn't play nice with localization.

===========
Basic Usage
===========

dojo.replace accepts 3 arguments:

* String template to be interpolated.
* Object or a function to bu used for substitutions.
* Optional regular expression pattern to look for. By default all patterns "{abc}" are going to be found and replaced.

If the second argument is an object, all names within braces are interpreted as property names within this object. All "." will be interpreted as subobjects. This default behavior provides a great flexibility.

Example:

.. code-block :: javascript
  :linenos:

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
  :version: local
  :djConfig: parseOnLoad: false

  A complex object can be used with dojo.replace.

  .. javascript::
    :label: Object example

    <script>
      dojo.addOnLoad(function(){
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
    </script>

  Minimalistic HTML for our example.

  .. html::
    :label: Minimal HTML.

    <p id="output"></p>

In most cases you may prefer an array notation effectively simulating the venerable ``printf``:

.. code-block :: javascript
  :linenos:

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

  .. javascript::
    :label: Object example

    <script>
      dojo.addOnLoad(function(){
        dojo.byId("output").innerHTML = dojo.replace(
          "Hello, {0} {2} AKA {3}!",
          ["Robert", "X", "Cringely", "Bob"]
        );
      });
    </script>

  Minimalistic HTML for our example.

  .. html::
    :label: Minimal HTML.

    <p id="output"></p>

You don't need to use all properties of an object, you can list them in any order, and you can reuse them as many times as you like.

==============
Advanced Usage
==============

For ultimate flexibility you can use `dojo.replace`_ with a function as the second argument. The function is going to be called with 4 arguments:

* Whole match.
* Name between found braces.
* Offset of the match.
* Whole string.

Essentially these arguments are the same as in `String.replace() <https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Global_Objects/String/replace>`_ when a function is used. Usually the second argument is the most useful one.

Let's take a look at example:

.. code-block :: javascript
  :linenos:

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

  .. javascript::
    :label: Object example

    <script>
      // helper function
      function sum(a){
        var t = 0;
        dojo.forEach(a, function(x){ t += x; });
        return t;
      }

      dojo.addOnLoad(function(){
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
    </script>

  Minimalistic HTML for our example.

  .. html::
    :label: Minimal HTML.

    <p id="output"></p>

In some cases you may want to use different braces, e.g., because your interpolated strings contain patterns similar to "{abc}", but they should not be evaluated and replaced, or your server-side framework already uses these patterns for something else. In this case you should replace the pattern:

.. code-block :: javascript
  :linenos:

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

  .. javascript::
    :label: Object example

    <script>
      dojo.addOnLoad(function(){
        dojo.byId("output").innerHTML = dojo.replace(
          "Hello, %[0] %[2] AKA %[3]!",
          ["Robert", "X", "Cringely", "Bob"],
          /\%\[([^\]]+)\]/g
        );
      });
    </script>

  Minimalistic HTML for our example.

  .. html::
    :label: Minimal HTML.

    <p id="output"></p>

========
Examples
========

Below are real-world examples of using `dojo.replace`_

Highlighting substitutions
--------------------------

Let's add highlighting to all substituted feeds:

.. code-block :: javascript
  :linenos:

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

  .. javascript::
    :label: Object example

    <script>
      function hiliteReplace(tmpl, dict){
        var hilited = dojo.replace(tmpl, function(_, name){
          return "<span class='hilite'>{" + name + "}</span>";
        });
        return dojo.replace(hilited, dict);
      }
      dojo.addOnLoad(function(){
        dojo.byId("output").innerHTML = hiliteReplace(
          "Hello, {0} {2} AKA {3}!",
          ["Robert", "X", "Cringely", "Bob"]
        );
      });
    </script>

  Minimalistic CSS for our example.

  .. css::
    :label: Minimal CSS.

    <style>
      .hilite {font-weight: bold; color: green;}
    </style>

  Minimalistic HTML for our example.

  .. html::
    :label: Minimal HTML.

    <p id="output"></p>

Escaping substitutions
----------------------

Let's escape substituted text for HTML to prevent possible exploits. Dijit templates implement similar technique. We will borrow Dijit syntax: all names starting with "!" are going to be placed as is (example: ``{!abc}``), while everything else is going to be filtered.

.. code-block :: javascript
  :linenos:

  function safeReplace(tmpl, dict){
    // convert dict to a function, if needed
    dict = dojo.isFunction(dict) ? dict : function(_, name){
      return dojo.getObject(name, false, dict);
    };
    // perform the substitution
    return dojo.replace(tmpl, function(_, name){
      if(name.charAt(0) == '!'){
        // no escaping
        return dict(_, name.slice(1));
      }
      // escape
      return dict(_, name).
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

  Highlighting replaced fields.

  .. javascript::
    :label: Object example

    <script>
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
      dojo.addOnLoad(function(){
        // we don't want to break the Code Glass widget here
        var bad = "{script}alert('Let\' break stuff!');{/script}";
        // let's reconstitute the original bad string
        bad = bad.replace(/\{/g, "<").replace(/\}/g, ">");
        // now the replacement
        dojo.byId("output").innerHTML = safeReplace("<div>{0}</div", [bad]);
      });
    </script>

  Minimalistic HTML for our example.

  .. html::
    :label: Minimal HTML.

    <p id="output"></p>

Formatting substitutions
------------------------

Let's add a simple formatting to substituted fields.
