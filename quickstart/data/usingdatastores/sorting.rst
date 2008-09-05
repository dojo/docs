#format dojo_rst

Sorting
=======

.. contents:
  :depth: 3

=============
Sorting Items
=============

Items are, in general, returned in an indeterminate order. This isn't always what you want to happen; there are definite cases where sorting items based on specific attributes is important. Fortunately, you do not have to do the sorting yourself because dojo.data provides a mechanism to do it for you. The mechanism is just another option passed to fetch, the sort array.

The sort array will look something like the following example:

.. code-block :: javascript 

  var sortKeys = [{attribute: "aisle", descending: true}];

Each sort key has an attribute, which should be an attribute in the data store item, and a descending boolean flag. If an attribute passed isn't an actual attribute of the item, it will generally be ignored by the sorting; it is treated as an undefined comparison.

For compound sorts, you can define as many sort keys as you want. The order in the array defines which keys take priority over other keys when sorting. The following example shows this:

.. code-block :: javascript

  var sortKeys = [
    {attribute: "aisle", descending: true},
    {attribute: "name", descending: false}
  ];

========
Examples
========

While that seems simple, nothing is as useful as a complete example.  So, below is an example that will take a simple case and show how to use the dojo.data API to sort data items.  This example uses the same data used in examples elsewhere, the simple pantry data.


Sample 1:  Showing how sort attributes affect ordering
------------------------------------------------------

