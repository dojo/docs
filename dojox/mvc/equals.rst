.. _dojox/mvc/equals:

================
dojox.mvc.equals
================

:Authors: Akira Sudoh, Ed Chatelain
:Developers: Akira Sudoh, Ed Chatelain
:since: V1.8

.. contents ::
  :depth: 2

====================
dojox/mvc/equals API
====================

The module's value is a equals function that can be directly called to compare two dojo.Stateful objects.
The equals function is in below form:

.. js ::

  equals(dst, src, options);

The following parameters should be provided to the equals function:

* dst - The value to compare with the second argument (src).
* src - The value to compare with the first argument (dst).
* options - Optional object to specify comparison options. (See `Comparison options`_ section for details)

------------------
Comparison options
------------------

By default, equals function does the following:

* Iterate properties in dojo.Stateful or plain object
* Iterate elements in dojox.mvc.StatefulArray or plain array
* Compare Epoch time for date object
* Do normal comparison for others

By providing the optional second argument to equals function, above behavior can be changed. The optional second argument should be an object, having the following functions as properties:

* getType - Returns what category of type the given value has.
* equalsXXX - Returns the comparison result for the given two values. XXX here is what getType function returns, with the first character capitalized.

Below is an example of the optional second argument:

.. js ::

  {
      getType: function(/*Anything*/ v){
          // summary:
          //        Returns the type of the given value.
          // v: Anything
          //        The value.

          return lang.isArray(v) ? "array" : lang.isFunction((v || {}).getTime) ? "date" : v != null && ({}.toString.call(v) == "[object Object]" || lang.isFunction((v || {}).set) && lang.isFunction((v || {}).watch)) ? "object" : "value";
      },

      equalsArray: function(/*Anything[]*/ dst, /*Anything[]*/ src){
          // summary:
          //        Returns if the given two stateful arrays are equal.
          // dst: Anything[]
          //        The array to compare with.
          // src: Anything[]
          //        The array to compare with.

          for(var i = 0, l = Math.max(dst.length, src.length); i < l; i++){
              if(!equals(dst[i], src[i])){ return false; }
          }
          return true;
      },

      equalsDate: function(/*Date*/ dst, /*Date*/ src){
          return dst.getTime() == src.getTime();
      },

      equalsObject: function(/*Object*/ dst, /*Object*/ src){
          // summary:
          //        Returns if the given two stateful objects are equal.
          // dst: Object
          //        The object to compare with.
          // src: Object
          //        The object to compare with.

          var list = lang.mixin({}, dst, src);
          for(var s in list){
              if(!(s in Stateful.prototype) && s != "_watchCallbacks" && !equals(dst[s], src[s])){ return false; }
          }
          return true;
      },

      equalsValue: function(/*Anything*/ dst, /*Anything*/ src){
          // summary:
          //        Returns if the given two values are equal.

          return dst === src; // Boolean
      }
  }
