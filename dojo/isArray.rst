#format dojo_rst

dojo.isArray
============

:Status: Draft
:Version: 1.0
:Available: since 0.9

.. contents::
   :depth: 2

Checks if the passed parameter is an Array.

============
Introduction
============

A simple utility function to check if an object is truly and array.

=====
Usage
=====

isArray returns a Boolean you can use directly in conditionals:

.. code-block :: javascript
 :linenos:

  if(dojo.isArray(someVariable)){
    // do something
  }

Anything that is an Array can be iterated over by using `dojo.forEach <dojo/forEach>`_

.. code-block :: javascript
  :linenos: 

  if(dojo.isArray(list)){
    dojo.forEach(list, function(item, i){
        // each item in list
    });
  }else{
    // something went wrong? we wanted an array here
  }

========
Examples
========

.. code-block :: javascript
  :linenos:

  console.log( dojo.isArray([1,2,3]) );
  >>> true

  console.log( dojo.isArray(new dojo.NodeList()) );
  >>> true

  console.log( dojo.isArray( { "a":1 } );
  >>> false


.. cv-compound::

  .. cv:: css

     <style type="text/css">
         .style1 { position: absolute; top: 50px; background: #f1f1f1; padding: 10px; }
     </style>

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dijit.form.Button");
        dojo.require("dojo.fx");

        // test variable t:
        var t;

        function testIt() {
            // resultDiv is the spanning DIV around the result:
            var resultDiv = dojo.byId('resultDiv');
            // resultNode is the SPAN tag, in which we will write the result:
            var resultNode = dojo.byId('result');

            // wipeOut resultDiv:
            dojo.fx.wipeOut({ node: resultDiv, duration: 0 }).play();

            // Here comes the test:
            // Is t an Array?
            if (dojo.isArray(t)) {
                // dojooo: t is an array!
                dojo.attr(resultDiv, "innerHTML", 
                    "Yes, 't' is an array.<br />Try another button.");
                dojo.attr(resultDiv, "style", "backgroundColor: #a4e672;");
            } else {
                // no chance, this can't be an array:
                dojo.attr(resultDiv, "innerHTML", 
                    "No chance, 't' can't be an array with such a value.<br />Try another button.");
                dojo.attr(resultDiv, "style", "backgroundColor: #e67272;");
            }

            // wipeIn resultDiv:
            dojo.fx.wipeIn({ node: resultDiv, duration: 300 }).play();
        }
    </script>

  .. cv:: html

    <div style="height: 110px;">
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

        <div id="resultDiv" class="style1">
            Click on a button, to test the associated value.
        </div>
    </div>

========
See also
========

* `dojo.isArrayLike <dojo/isArrayLike>`_
* `dojo.isFunction <dojo/isFunction>`_
* `dojo.isString <dojo/isString>`_
* `dojo.isObject <dojo/isObject>`_
