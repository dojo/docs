.. _dojo/isArray:

============
dojo.isArray
============

:since: V0.9

.. contents ::
   :depth: 2

Checks if the passed parameter is an Array.

As with all dojo._base components, these functions are included within Dojo Base. You get this functionality by just including ``dojo.js`` in your page.


Introduction
============

A simple utility function to check if an object is truly and array.


Usage
=====

isArray returns a Boolean you can use directly in conditionals:

.. js ::
 
  // Dojo 1.7+ (AMD)
  require(["dojo/_base/lang"], function(lang){
    if(lang.isArray(someVariable)){
      // do something
    }
  });

  // Dojo < 1.7
  if(dojo.isArray(someVariable)){
    // do something
  }

Anything that is an Array can be iterated over by using :ref:`dojo.forEach <dojo/forEach>`

[ Dojo 1.7+ (AMD) ]

.. js ::
  
  require(["dojo/_base/lang", "dojo/_base/array"], function(lang, array){
    if(lang.isArray(list)){
      array.forEach(list, function(item, i){
        // each item in list
      });
    }else{
      // something went wrong? we wanted an array here
    }
  });
  

[ Dojo < 1.7 ]

.. js ::
  
  if(dojo.isArray(list)){
    dojo.forEach(list, function(item, i){
        // each item in list
    });
  }else{
    // something went wrong? we wanted an array here
  }


Caveats
=======

It is important to understand that dojo.isArray checks to see if the provided value is an instance of *the* Array constructor from the current frame. If an array is passed in from a different frame, it is not an instance of the current frame's Array and therefore dojo.isArray will properly return false. Also, the arguments variable is not considered an array. One can test for these array like entities with dojo.isArrayLike(value). If you want to dojo.isArray to work on array instances from any frame, it is possible to monkey patch it with something like:

.. js ::

 // Dojo 1.7+ (AMD)
 require(["dojo/_base/lang"], function(lang){
   lang.isArray = function(it){
     return it && Object.prototype.toString.call(it)=="[object Array]";
   });
 });

 // Dojo < 1.7
 dojo.isArray = function(it){
    return it && Object.prototype.toString.call(it)=="[object Array]";
 });

However, this technique is *not* recommended, as it will break on Array subclasses and can be slower. Only use this if absolutely necessary in a multi-frame environment.

Examples
========

Test against isArray()
----------------------

.. code-example ::

  .. css ::

         .style1 { background: #f1f1f1; padding: 10px; }

  .. js ::

        dojo.require("dijit.form.Button");

        // test variable t:
        var t;

        function testIt(){
            // resultDiv is the spanning DIV around the result:
            var resultDiv = dojo.byId('resultDiv');

            // Here comes the test:
            // Is t an Array?
            if(dojo.isArray(t)){
                // dojooo: t is an array!
                dojo.attr(resultDiv, "innerHTML",
                    "Yes, good choice: 't' is an array.<br />Try another button.");

                // Change the backgroundColor:
                dojo.style(resultDiv, {
                    "backgroundColor": "#a4e672",
                    "color": "black"
                });
            }else{
                // no chance, this can't be an array:
                dojo.attr(resultDiv, "innerHTML",
                    "No chance: 't' can't be an array with such a value "
                     + "('t' seems to be a " + typeof t + ").<br />"
                     + "Try another button.");

                // Change the backgroundColor:
                dojo.style(resultDiv, {
                    "backgroundColor": "#e67272",
                    "color": "white"
                });
            }
        }

  .. html ::

    <div style="height: 100px;">
        <button data-dojo-type="dijit.form.Button">
            t = 1000;
            <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
                // Set t:
                t = 1000;

                // Test the type of t:
                testIt();
            </script>
        </button>
        <button data-dojo-type="dijit.form.Button">
            t = "text";
            <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
                // Set t:
                t = "text";

                // Test the type of t:
                testIt();
            </script>
        </button>
        <button data-dojo-type="dijit.form.Button">
            t = [1, 2, 3];
            <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
                // Set t:
                t = [1, 2, 3];

                // Test the type of t:
                testIt();
            </script>
        </button>
        <button data-dojo-type="dijit.form.Button">
            t = { "property": 'value' };
            <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
                // Set t:
                t = { "property": 'value' };

                // Test the type of t:
                testIt();
            </script>
        </button>
        <button data-dojo-type="dijit.form.Button">
            t = function(a, b){ return a };
            <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
                // Set t:
                t = function(a, b){ return a } ;

                // Test the type of t:
                testIt();
            </script>
        </button>

        <div id="resultDiv" class="style1">
            Click on a button, to test the associated value.
        </div>
    </div>


See also
========

* :ref:`dojo.isString <dojo/isString>` - Checks if the parameter is a String
* :ref:`dojo.isFunction <dojo/isFunction>` - Checks if the parameter is a Function
* :ref:`dojo.isObject <dojo/isObject>` - Checks if the parameter is an Object
* :ref:`dojo.isArrayLike <dojo/isArrayLike>` - Checks if the parameter is like an Array
* :ref:`dojo.isAlien <dojo/isAlien>` - Checks if the parameter is a built-in function
