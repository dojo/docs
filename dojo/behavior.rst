#format dojo_rst

dojo.behavior
=============

``TODOC``

A very simple, lightweight mechanism for applying code to existing documents, based around `dojo.query <wiki:dojo/query>`_ for node selection, and a simple two-command API: dojo.behavior.add() and dojo.behavior.apply();

To use, simply require in the dojo.behavior module, after ``dojo.js`` is loaded:

.. code-block :: javascript

  dojo.require("dojo.behavior");

Then, define a "behavior". This behavior is just an object, with a lot of special tokens. They work by selecting nodes using a CSS3 selector: 

.. code-block :: javascript

  var myBehavior = {
     // all <a class="noclick"></a> nodes:
     "a.noclick" : {
          // event names become event connections:
          onclick: function(e){
             console.log('clicked! ', e.target); 
          }
      },
      // all <span> nodes
      "span" : {
          // for each:
          found: funcion(n){
              console.log('found', n);
          }
       }
  };
  dojo.behavior.add(myBehavior);
