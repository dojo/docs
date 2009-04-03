#format dojo_rst

Paging Data
===========

.. contents::
  :depth: 3

As shown in the other datastore sections, the fetch method of the Read API can query across and return sets of items in a variety of ways. However, there is generally only so much space on a display to list all the data returned. Certainly, an application could implement its own custom display logic for just displaying subsets of the data, but that would be inefficient because the application would have had to load all the data in the first place. And, if the data set is huge, it could severely increase the memory usage of the browser. Therefore, dojo.data provides a mechanism by which the store itself can do the paging for you. When you use the paging options of fetch, all that is returned in the callbacks for fetch is the page of data you wanted, no more. This allows the application to deal with data in small chunks, the parts currently visible to you.

The paging mechanism is used by specifying a start parameter in the fetch arguments. The start parameter says where, in the full list of items, to start returning items. The index 0 is the first item in the collection. The second argument you specify is the count argument. This option tells dojo.data how many items, starting at start, to return in a request. If start isn't specified, it is assumed to be 0. If count isn't specified, it is assumed to return all the items starting at start until it reaches the end of the collection. With this mechanism, you can implement simple paging easily.

=======================
Pagination general flow 
=======================

To demonstrate the paging function, we'll assume an ItemFileReadStore with the following datasource:

.. code-block :: javascript 

  { identifier: 'name',
    items: [
      { name: 'Adobo', aisle: 'Mexican', price: 3.01 },
      { name: 'Balsamic vinegar', aisle: 'Condiments', price: 4.01 },
      { name: 'Basil', aisle: 'Spices', price: 3.59  },
      { name: 'Bay leaf', aisle: 'Spices',  price: 2.01 },
      { name: 'Beef Bouillon Granules', aisle: 'Soup',  price: 5.01  },
      { name: 'Vinegar', aisle: 'Condiments',  price: 1.99  },
      { name: 'White cooking wine', aisle: 'Condiments',  price: 2.01 },
      { name: 'Worcestershire Sauce', aisle: 'Condiments',  price: 3.99 },
      { name: 'white pepper', aisle: 'Spices',  price: 1.01 },
      { name: 'Black Pepper', aisle: 'Spices',  price: 1.01 }
  ]}

The following example code fragment shows the general flow with Pagination:

*The sample returns 2 items per page*

.. code-block :: javascript

  var store = new dojo.data.ItemFileReadStore({url: "pantryStore.json" });

  var pageSize = 2;
  var request = null;
  var outOfItems = false;

  //Define a function that will be connected to a 'next' button
  var onNext = function(){
    if(!outOfItems){
    request.start += pageSize;
      store.fetch(request);
    }
  };
    
  //Connect this function to the onClick event of the 'next' button
  //Done through dojo.connect() generally.

  //Define a function will be connected to a 'previous' button.
  var onPrevious = function(){
    if (request.start > 0){
      request.start -= pageSize;
        store.fetch(request);
    }
  };


  //Connect this function to the onClick event of the 'previous' button
  //Done through dojo.connect() generally.

  //Define how we handle the items when we get it
  var itemsLoaded = function(items, request){
    if (items.length < pageSize){
      //We have found all the items and are at the end of our set.  
      outOfItems = true;
    }else{
      outOfItems = false;
    }
    //Display the items in a table through the use of store.getValue() on the items and attributes desired.
    ...
  }

  //Do the initial request. Without a query, it should just select all items. The start and count limit the number returned.
  request = store.fetch({onComplete: itemsLoaded, start: 0, count: pageSize});


===================
Functional Examples
===================

Paging over items
-----------------

*The sample returns 2 items per page*

.. cv-compound ::
  
  .. cv :: javascript

    <script>
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

        //This function performs some basic dojo initialization. In this case it connects the button
        //onClick to a function which invokes *fetch()*es. The fetch function queries for only a subset
        //and provides callbacks to use for completion of data retrieval or reporting of errors.
        function init () {

           //These are some lage controls used to know when to disable forward/previous buttons.
           var totalItems = 0;   //How many total items should we expect.
           var request = null;   //Our request object we're using to hold the positions and the callbacks.
           var currentStart = 0; //Current index into the pages.
           currentCount = 2;     //Current size of the page.

           //Callback to perform an action when the data items are starting to be returned:
           function clearOldList(size, request) {
             var list = dojo.byId("list");
             if (list) { 
               while (list.firstChild) {
                 list.removeChild(list.firstChild);
               }
             }
             //Save off the total size. We need it to determine when to ignore the buttons.
             totalItems = size;
           }
  
           //Callback for processing a returned list of items.
           function gotItems(items, request) {
             //Save off the current page info being displayed.
             currentStart = request.start;
             currentCount = request.count;
             var list = dojo.byId("list");
             if (list) { 
               var i;
               for (i = 0; i < items.length; i++) {
                 var item = items[i];
                 list.appendChild(document.createTextNode(foodStore.getValue(item, "name")));
                 list.appendChild(document.createElement("br"));
               }
             }
           }
            
           //Callback for if the lookup fails.
           function fetchFailed(error, request) {
             alert("lookup failed.");
           }
           
           //Button event to page forward.
           function nextPage() {
             //If we haven't hit the end of the pages yet, allow for requesting another.
             if ((currentStart + currentCount) < totalItems ) {
               request.start += currentCount;
               request = foodStore.fetch(request);
             }
           }

           //Button event to page back;
           function previousPage() {
             //If we haven't hit the beginning of the pages yet, allow for another shift backwards.
             if (currentStart > 0) {
               request.start -= currentCount;
               request = foodStore.fetch(request);
             }
           }

           //Fetch the data.
           request = foodStore.fetch({onBegin: clearOldList, onComplete: gotItems, onError: fetchFailed, start: currentStart, count: currentCount });

           //Link the click event of the button to driving the fetch.
           dojo.connect(forward, "onClick", nextPage);
           dojo.connect(back, "onClick", previousPage);
        }
        //Set the init function to run when dojo loading and page parsing has completed.
        dojo.addOnLoad(init);
    </script>

  .. cv :: html 

    <div dojoType="dojo.data.ItemFileReadStore" data="storeData" jsId="foodStore"></div>
    <div dojoType="dijit.form.Button" jsId="back">Click me for the previous page!</div>
    <div dojoType="dijit.form.Button" jsId="forward">Click me for the next page!</div>

    <br>
    <br>
    <b>The current page of (up to) 2 grocery items:</b>
    <br>
    <span id="list">
    </span>
