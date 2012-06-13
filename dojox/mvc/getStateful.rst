.. _dojox/mvc/getStateful:

=====================
dojox.mvc.getStateful
=====================

:Authors: Akira Sudoh, Ed Chatelain
:Developers: Akira Sudoh, Ed Chatelain
:since: V1.8

.. contents ::
  :depth: 2

=========================
dojox/mvc/getStateful API
=========================

The module's value is a getStateful function that can be directly called to create dojo.Stateful object hierarchy from a plain object.
The getStateful function is in below form:

.. js ::

  getStateful(value, options);

The following parameters should be provided to the getStateful function:

* value - The plain object to convert to dojo.Stateful object hierarchy.
* options - Optional object to specify conversion options. (See `Conversion options`_ section for details)

------------------
Conversion options
------------------

By default, getStateful function does the following:

* Convert plain objects to dojo.Stateful
* Convert arrays to dojox.mvc.StatefulArray
* Keep others intact

By providing the optional second argument to getStateful function, above behavior can be changed. The optional second argument should be an object, having the following functions as properties:

* getType - Returns what category of type the given value has.
* getStatefulXXX - Returns the converted value of given one. XXX here is what getType function returns, with the first character capitalized.

Below is an example of the optional second argument:

.. js ::

  {
    getType: function(/*Anything*/ v){
        // summary:
        //        Returns the type of the given value.
        // v: Anything
        //        The value.

        return lang.isArray(v) ? "array" : v != null && {}.toString.call(v) == "[object Object]" ? "object" : "value";
    },

    getStatefulArray: function(/*Anything[]*/ a){
        // summary:
        //        Returns the stateful version of the given array.
        // a: Anything[]
        //        The array.

        return new StatefulArray(array.map(a, function(item){ return getStateful(item, this); }, this)); // dojox.mvc.StatefulArray
    },

    getStatefulObject: function(/*Object*/ o){
        // summary:
        //        Returns the stateful version of the given object.
        // o: Object
        //        The object.

        var stateful = new Stateful();
        for(var s in o){
            stateful[s] = getStateful(o[s], this);
        }
        return stateful; // dojo.Stateful
    },

    getStatefulValue: function(/*Anything*/ v){
        // summary:
        //        Just returns the given value.

        return v; // Anything
    }
 }

