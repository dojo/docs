#format dojo_rst

dojo.indexOf
============

`TODOC: inline API information`

Returns the index of the item in the array, or -1 if false:

.. code-block :: javascript

  var arr = [ 1, 2, 3, 4, 5 ];
  var idx = dojo.indexOf(arr, 1); // returns 0
  var idx2 = dojo.indexOf(arr, 6) // returns -1

Creating a `has` function would be trivial:

.. code-block :: javascript

  dojo.has = function(array, item){
     return dojo.indexOf(array, item) >= 0;
  }
