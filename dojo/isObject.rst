#format dojo_rst

dojo.isObject
=============

:Status: Draft
:Version: 1.0
:Available: since V?

.. contents::
   :depth: 2

Checks if the parameter is an Object.


============
Introduction
============

TODO: introduce the component/class/method


=====
Usage
=====

TODO: how to use the component/class/method

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // your code
 </script>



========
Examples
========

Test against isObject()
-----------------------

.. cv-compound::

  .. cv:: css

     <style type="text/css">
         .style1 { background: #f1f1f1; padding: 10px; }
     </style>

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.Button");

        // test variable t:
        var t;

        function testIt() {
            // resultDiv is the spanning DIV around the result:
            var resultDiv = dojo.byId('resultDiv');

            // Here comes the test:
            // Is t an Object?
            if (dojo.isObject(t)) {
                // dojooo: t is an object!
                dojo.attr(resultDiv, "innerHTML", 
                    "Yes, good choice: 't' is an object.<br />Try another button.");

                // Change the backgroundColor:
                dojo.style(resultDiv, {
                    "backgroundColor": "#a4e672",
                    "color": "black"
                });
            } else {
                // no chance, this can't be an array:
                dojo.attr(resultDiv, "innerHTML", 
                    "No chance: 't' can't be an object with such a value.<br />Try another button.");

                // Change the backgroundColor:
                dojo.style(resultDiv, {
                    "backgroundColor": "#e67272",
                    "color": "white"
                });
            }
        }
    </script>

  .. cv:: html

    <div style="height: 100px;">
        <button dojoType="dijit.form.Button">
            t = 1000;
            <script type="dojo/method" event="onClick" args="evt">
                // Set t:
                t = 1000;

                // Test the type of t:
                testIt();
            </script>
        </button>
        <button dojoType="dijit.form.Button">
            t = "text";
            <script type="dojo/method" event="onClick" args="evt">
                // Set t:
                t = "text";

                // Test the type of t:
                testIt();
            </script>
        </button>
        <button dojoType="dijit.form.Button">
            t = [1, 2, 3];
            <script type="dojo/method" event="onClick" args="evt">
                // Set t:
                t = [1, 2, 3];

                // Test the type of t:
                testIt();
            </script>
        </button>
        <button dojoType="dijit.form.Button">
            t = { "property": 'value' };
            <script type="dojo/method" event="onClick" args="evt">
                // Set t:
                t = { "property": 'value' };

                // Test the type of t:
                testIt();
            </script>
        </button>
        <button dojoType="dijit.form.Button">
            t = function(a, b){ return a };
            <script type="dojo/method" event="onClick" args="evt">
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


========
See also
========

* `dojo.isString <dojo/isString>`_ - Checks if the parameter is a String
* `dojo.isArray <dojo/isArray>`_ - Checks if the parameter is an Array
* `dojo.isFunction <dojo/isFunction>`_ - Checks if the parameter is a Function
* `dojo.isArrayLike <dojo/isArrayLike>`_ - Checks if the parameter is like an Array
* `dojo.isAlien <dojo/isAlien>`_ - Checks if the parameter is a built-in function
