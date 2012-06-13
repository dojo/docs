.. _dojox/mvc/getPlainValue:

=======================
dojox.mvc.getPlainValue
=======================

:Authors: Akira Sudoh, Ed Chatelain
:Developers: Akira Sudoh, Ed Chatelain
:since: V1.8

.. contents ::
  :depth: 2

===========================
dojox/mvc/getPlainValue API
===========================

The module's value is a getPlainValue function that can be directly called to create plain object from a dojo.Stateful object hierarchy.
The getPlainValue function is in below form:

.. js ::

  getPlainValue(value, options);

The following parameters should be provided to the getPlainValue function:

* value - The value, typically dojo.Stateful object hierarhy, to convert to plain object.
* options - Optional object to specify conversion options. (See `Conversion options`_ section for details)

------------------
Conversion options
------------------

By default, getPlainValue function does the following:

* Convert dojo.Stateful to plain object
* Convert dojox.mvc.StatefulArray to plain array
* Keep others intact

By providing the optional second argument to getPlainValue function, above behavior can be changed. The optional second argument should be an object, having the following functions as properties:

* getType - Returns what category of type the given value has.
* getPlainXXX - Returns the converted value of given one. XXX here is what getType function returns, with the first character capitalized.

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

      getPlainArray: function(/*Anything[]*/ a){
          // summary:
          //        Returns the stateful version of the given array.
          // a: Anything[]
          //        The array.

          return array.map(a, function(item){ return getPlainValue(item, this); }, this); // Anything[]
      },

      getPlainObject: function(/*Object*/ o){
          // summary:
          //        Returns the stateful version of the given object.
          // o: Object
          //        The object.

          var plain = {};
          for(var s in o){
              if(!(s in Stateful.prototype) && s != "_watchCallbacks"){
                  plain[s] = getPlainValue(o[s], this);
              }
          }
          return plain; // Object
      },

      getPlainValue: function(/*Anything*/ v){
          // summary:
          //        Just returns the given value.

          return v; // Anything
      }
  }
