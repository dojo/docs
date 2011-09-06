#format dojo_rst

dojo.indexOf
============

`TODOC: inline API information`

Returns the index of the item in the array, or -1 if false:

.. code-block :: javascript
  
  //Before dojo 1.7
  var arr = [ 1, 2, 3, 4, 5 ];
  var idx = dojo.indexOf(arr, 1); // returns 0
  var idx2 = dojo.indexOf(arr, 6) // returns -1

  //From dojo 1.7 on
  require(["dojo/_base/array"], function(array){
    var arr = [ 1, 2, 3, 4, 5 ];
    var idx = array.indexOf(arr, 1); // returns 0
    var idx2 = array.indexOf(arr, 6) // returns -1
  });

Because `0` is a valid index in an array, you need to check if the return is >= 0 to test truth,

Creating a `has` function would be trivial:

.. code-block :: javascript

  //Before dojo 1.7
  dojo.has = function(array, item){
     return dojo.indexOf(array, item) >= 0;
  }

  //From dojo 1.7 on
  require(["dojo/_base/array"], function(array){
    dojo.has = function(arrayObject, item){
      return array.indexOf(arrayObject, item) >= 0;
    }
  });
