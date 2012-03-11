.. _dojo/indexOf:

============
dojo.indexOf
============

`TODOC: inline API information`

Returns the index of the item in the array, or -1 if false:

.. js ::
  
  require(["dojo/_base/array"], function(array){
    var arr = [ 1, 2, 3, 4, 5 ];
    var idx = array.indexOf(arr, 1); // returns 0
    var idx2 = array.indexOf(arr, 6) // returns -1
  });

Because `0` is a valid index in an array, you need to check if the return is >= 0 to test truth,

Creating a `contains` function would be trivial:

.. js ::
  
  require(["dojo/_base/array"], function(array){
    function contains(arr, item){
      return array.indexOf(arr, item) >= 0;
    }
  });
