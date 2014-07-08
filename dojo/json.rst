.. _dojo/json:

=========
dojo/json
=========

:Authors: Kris Zyp
:Project owner: Kris Zyp
:since: 1.7.0

.. contents ::
  :depth: 2

**dojo/json** is a module for JSON parsing and serialization based on the standard EcmaScript 5's JSON object.

The module provides two functions, ``parse()`` and ``stringify()``, which are orthogonal to each other: parse()
converts a JSON string to a javascript object, stringify() takes a javascript object and returns a JSON string.

Usage
=====

.. _dojo/json#parse:

parse()
-------

The parse() function parses a JSON string representing a javascript object and returns the latter.
parse() has a single required argument, the JSON string to be parsed, and an optional second argument 
indicating if secure parsing should be used. For example:

.. js ::

  require(["dojo/json"], function(JSON){
    var obj = JSON.parse('{"hello":"world"}', true);
  });

If the target platform supports native JSON parsing, ``dojo/json`` will always use the native parser (and serializer). 

If no native parsing is available, ``dojo/json`` will use ``eval()`` to parse the JSON. When ``eval()`` is used, the 
``parse()`` function's second argument indicates if secure parsing should be used. Secure parsing will verify that the 
JSON is safe before evaluating it. Performing this verification is slower than directly evaluating, and secure parsing 
should only be used if the JSON is from an unsecure source, such as user generated content or third-party APIs. 
The second argument has no effect on browsers with native parsing, since native parsing is always secure.

.. _dojo/json#stringify:

stringify()
-----------

The ``stringify()`` function takes a JavaScript value and serializes it to JSON, which it returns. For example, to serialize an object we 
could write:

.. js ::

  require(["dojo/json"], function(JSON){
    var jsonString = JSON.stringify({ hello: "world" });
  });

The ``stringify()`` function takes the same arguments as the standard ``JSON.stringify()`` function. This is explained 
in more detail here: `JSON.stringify() <https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/JSON/stringify>`_

The second argument is a replacer function, and the third argument allows you to provide a spacer string for pretty 
formatting.

Examples
========

.. code-example ::
  :djConfig: async:true, parseOnLoad:false

  Converts a JSON string into a JavaScript object, modifies it and then outputs the JSON string again.

  .. js ::

    require(["dojo/json", "dojo/dom", "dojo/on", "dojo/domReady!"], 
    function(JSON, dom, on){
      on(dom.byId("convert"), "click", function(){
        var origin = '{"hello": "world"}';
        
        var obj = JSON.parse(origin);
        
        obj.hello = "Dojo";
        obj.something = "New";
        
        var output = JSON.stringify(obj);
        
        dom.byId("output").innerHTML = output;
      });
    });

  .. html ::

    <button type="button" id="convert">Convert!</button>
    <p><strong>Original JSON</strong></p>
    <pre>{"hello": "world"}</pre>
    <p><strong>Converted JSON</strong></p>
    <pre id="output"></pre>

See Also
========

* :ref:`dojo/string <dojo/string>` - String handling enhancements

* :ref:`dojo/_base/array <dojo/_base/array>` - Array handling enhancements
