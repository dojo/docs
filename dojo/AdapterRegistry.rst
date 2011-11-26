.. _dojo/AdapterRegistry:

====================
dojo.AdapterRegistry
====================

.. contents :: 
    :depth: 2
    
A registry to make contextual calling/searching easier. Objects of this class keep list of arrays in the form [name, check, wrap, directReturn] that are used to determine what the contextual result of a set of checked arguments is. All check/wrap functions in this registry should be of the same arity (have the same number of arguments).

Example
=======

Dojo 1.7 (AMD)
--------------

.. js ::
  
  require(["dojo/AdapterRegistry"], function(reg){
      reg.register("handleString",
        dojo.isString,
        function(str){
          // do something with the string here
        }
      );
      reg.register("handleArr",
        dojo.isArray,
        function(arr){
          // do something with the array here
        }
      );

      // now we can pass reg.match() *either* an array or a string and the value we pass will get handled by the right function
      reg.match("someValue"); // will call the first function
      reg.match(["someValue"]); // will call the second
  });

Dojo < 1.7
----------

.. js ::
  
    // create a new registry
    var reg = new dojo.AdapterRegistry();
    reg.register("handleString",
      dojo.isString,
      function(str){
        // do something with the string here
      }
    );
    reg.register("handleArr",
      dojo.isArray,
      function(arr){
        // do something with the array here
      }
    );
    // now we can pass reg.match() *either* an array or a string and the value we pass will get handled by the right function
    reg.match("someValue"); // will call the first function
    reg.match(["someValue"]); // will call the second


There is also possible to unregister adapter from registry however there are performance problems on a large registry.

.. js ::
  
  // Dojo 1.7 (AMD)
  require(["dojo/AdapterRegistry"], function(reg){
      reg.unregister("handleArr");
  });

  // Dojo < 1.7
  reg.unregister("handleArr");


.. api-inline :: dojo.AdapterRegistry
