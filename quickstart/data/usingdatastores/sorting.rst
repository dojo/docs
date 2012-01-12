.. _quickstart/data/usingdatastores/sorting:

=======
Sorting
=======

.. contents ::
  :depth: 3

Sorting Items
=============

Items are, in general, returned in an indeterminate order. This isn't always what you want to happen; there are definite cases where sorting items based on specific attributes is important. Fortunately, you do not have to do the sorting yourself because dojo.data provides a mechanism to do it for you. The mechanism is just another option passed to fetch, the sort array.

The sort array will look something like the following example:

.. js ::

  var sortKeys = [{attribute: "aisle", descending: true}];

Each sort key has an attribute, which should be an attribute in the data store item, and a descending boolean flag. If an attribute passed isn't an actual attribute of the item, it will generally be ignored by the sorting; it is treated as an undefined comparison. You can effectively think of the sort attributes as similar to the SQL *order by* modifier.

For compound sorts, you can define as many sort keys as you want. The order in the array defines which keys take priority over other keys when sorting. The following example shows this:

.. js ::

  var sortKeys = [
    {attribute: "aisle", descending: true},
    {attribute: "name", descending: false}
  ];

Examples
========

While that seems simple, nothing is as useful as a complete example. So, below is an example that will take a simple case and show how to use the dojo.data API to sort data items. This example uses the same data used in examples elsewhere, the simple grocery data.

Showing how sort attributes affect ordering
-------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.form.Button");

      var storeData = { identifier: 'name',
        items: [
          { name: 'Adobo', aisle: 'Mexican', price: 3.01 },
          { name: 'Balsamic vinegar', aisle: 'Condiments', price: 4.01 },
          { name: 'Basil', aisle: 'Spices', price: 3.59  },
          { name: 'Bay leaf', aisle: 'Spices',  price: 2.01 },
          { name: 'Beef Bouillon Granules', aisle: 'Soup',  price: 5.01 },
          { name: 'Vinegar', aisle: 'Condiments',  price: 1.99  },
          { name: 'White cooking wine', aisle: 'Condiments',  price: 2.01 },
          { name: 'Worcestershire Sauce', aisle: 'Condiments',  price: 3.99 },
          { name: 'pepper', aisle: 'Spices',  price: 1.01  }
        ]};

        // This function performs some basic dojo initialization. In this case it connects the button
        // onClick to a function which invokes the fetch(). The fetch function queries for all items
        // and provides callbacks to use for completion of data retrieval or reporting of errors.
        function init(){
           // Function to perform a fetch on the datastore when a button is clicked
           function getAllItems(){

             // Callback to perform an action when the data items are starting to be returned:
             function clearSortedList(size, request){
               var list = dojo.byId("sortedList");
               if(list){
                 while(list.firstChild){
                   list.removeChild(list.firstChild);
                 }
               }
             }

             function clearUnSortedList(size, request){
               var list = dojo.byId("unSortedList");
               if(list){
                 while(list.firstChild){
                   list.removeChild(list.firstChild);
                 }
               }
             }

             // Callback for processing a returned list of items.
             function gotSortedItems(items, request){
               var list = dojo.byId("sortedList");
               if(list){
                 var i;
                 for(i = 0; i < items.length; i++){
                   var item = items[i];
                   var field = document.createElement("b");
                   field.appendChild(document.createTextNode("Aisle: "));
                   list.appendChild(field);
                   list.appendChild(document.createTextNode(foodStore.getValue(item, "aisle")));
                   list.appendChild(document.createTextNode("  "));
                   field = document.createElement("b");
                   field.appendChild(document.createTextNode("Name: "));
                   list.appendChild(field);
                   list.appendChild(document.createTextNode(foodStore.getValue(item, "name")));
                   list.appendChild(document.createTextNode("  "));
                   list.appendChild(document.createElement("br"));
                 }
               }
             }

             // Callback for processing a returned list of unsorted items.
             function gotUnSortedItems(items, request){
               var list = dojo.byId("unSortedList");
               if(list){
                 var i;
                 for(i = 0; i < items.length; i++){
                   var item = items[i];
                   var field = document.createElement("b");
                   field.appendChild(document.createTextNode("Aisle: "));
                   list.appendChild(field);
                   list.appendChild(document.createTextNode(foodStore.getValue(item, "aisle")));
                   list.appendChild(document.createTextNode("  "));
                   field = document.createElement("b");
                   field.appendChild(document.createTextNode("Name: "));
                   list.appendChild(field);
                   list.appendChild(document.createTextNode(foodStore.getValue(item, "name")));
                   list.appendChild(document.createTextNode("  "));
                   list.appendChild(document.createElement("br"));
                 }
               }
             }

             // Callback for if the lookup fails.
             function fetchFailed(error, request){
                alert("lookup failed.");
             }

             // Fetch the data in a sorted order.
             foodStore.fetch({onBegin: clearSortedList, onComplete: gotSortedItems, onError: fetchFailed, sort: [{ attribute: "aisle"},{attribute: "name"}]});

             // Fetch the data in an unsorted order.
             foodStore.fetch({onBegin: clearUnSortedList, onComplete: gotUnSortedItems, onError: fetchFailed});
           }
           // Link the click event of the button to driving the fetch.
           dojo.connect(button, "onClick", getAllItems);
        }
        // Set the init function to run when dojo loading and page parsing has completed.
        dojo.ready(init);

  .. html ::

    <div data-dojo-type="dojo/data/ItemFileReadStore" data-dojo-props="data:storeData" data-dojo-id="foodStore"></div>
    <div data-dojo-type="dijit/form/Button" data-dojo-id="button">Click me to show sorted and unsorted lists!</div>
    <br>
    <br>
    <b>Sorted List (Sorted by Aisle first and Name second):</b>
    <br>
    <span id="sortedList">
    </span>
    <br>
    <br>
    <b>Unsorted List:</b>
    <br>
    <span id="unSortedList">
    </span>
