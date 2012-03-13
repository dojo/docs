.. _dojo/json:

=========
dojo/json
=========

:Authors: Kris Zyp
:Project owner: Kris Zyp
:since: 1.7.0

.. contents ::
  :depth: 2

The dojo/json module is a JSON parsing and serialization module based on the standard EcmaScript 5's JSON object.

The module provides two functions, parse() and stringify().

parse()
=======

The parse() function has a single required argument, the JSON string to be parsed, and an optional second argument indicating if secure parsing should always be used. The signature is:

.. js ::
  
  jsonModule.parse(jsonString, secure);

To parse a JSON string into a parsed value, we can use the dojo/json this:

.. js ::
  
  require(["dojo/json"], function(JSON){
    var parsed = JSON.parse(jsonString);
  });

If the target platform supports native JSON parsing, dojo/json will always use the native parser (and serializer). If no native parsing is available, dojo/json will use eval() to parse the JSON. When eval() is used, the parse() function's second argument indicates if secure parsing should be used. Secure parsing will verify that the JSON is safe before evaluating it. Performing this verification is slower than directly evaluating, and secure parsing should only be used if the JSON is from an unsecure source. The second argument has no effect on browsers with native parsing, since native parsing is always secure. For example, to parse a string securely, we could write:

.. js ::
  
  require(["dojo/json"], function(JSON){
    var parsed = JSON.parse(unsecureJSONString, true);
  });

stringify()
===========

The stringify() function takes a JavaScript value and serializes it to JSON. The signature of stringify is:

.. js ::

  jsonModule.stringify(value);


For example, to serialize an object we could write:

.. js ::

  require(["dojo/json"], function(JSON){
    var jsonString = JSON.stringify(object);
  });

The stringify() function takes the same arguments as the standard JSON.stringify() function. This is explained in more detail here:
https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/JSON/stringify
The second argument is a replacer function, and the third argument allows you to provide a spacer string for pretty formatting.
