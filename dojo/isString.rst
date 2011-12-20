.. _dojo/isString:

=============
dojo.isString
=============

:since: V?

.. contents ::
   :depth: 2

Checks if the parameter is a String.

As with all dojo._base components, these functions are included within Dojo Base. You get this functionality by just including ``dojo.js`` in your page.


Usage
=====

Use this to test if a variable is a string

.. js ::
 
  // Dojo 1.7 (AMD)
  require(["dojo/_base/lang"], function(lang){
    if(lang.isString(foo)){ ...
  });
  // Dojo < 1.7
  if(dojo.isString(foo)){ ...


Examples
========

Test against isString()
-----------------------

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
            if(dojo.isString(t)){
                // dojooo: t is a string!
                dojo.attr(resultDiv, "innerHTML",
                    "Yes, good choice: 't' is a string.<br />Try another button.");

                // Change the backgroundColor:
                dojo.style(resultDiv, {
                    "backgroundColor": "#a4e672",
                    "color": "black"
                });
            }else{
                // no chance, this can't be an array:
                dojo.attr(resultDiv, "innerHTML",
                    "No chance: 't' can't be a string with such a value "
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

* :ref:`dojo.isArray <dojo/isArray>` - Checks if the parameter is an Array
* :ref:`dojo.isFunction <dojo/isFunction>` - Checks if the parameter is a Function
* :ref:`dojo.isObject <dojo/isObject>` - Checks if the parameter is an Object
* :ref:`dojo.isArrayLike <dojo/isArrayLike>` - Checks if the parameter is like an Array
* :ref:`dojo.isAlien <dojo/isAlien>` - Checks if the parameter is a built-in function
