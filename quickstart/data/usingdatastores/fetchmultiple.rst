#format dojo_rst

**Fetching multiple items and values**
======================================

.. contents::
  :depth: 3

===========================
Working with Multiple Items
===========================

You will likely want to access multiple items from such a data source as in the preceding example. No problem! Dojo.data Read API provides a mechanism for loading a set of items. All you have to do is provide the following information to the fetch function of the Read API:

* This is what I want (if I don't tell you something, get everything)
* Do this if there is an error
* Do that when everything is loaded

If this sounds like it might be event-driven, that's because it is.  Most I/O methods in Ajax must perform operations asynchronously, so results and errors have to be returned through events (commonly called callbacks).  Because of the asynchronous requirements of the I/O methods, the dojo.data API was designed to operate in an asynchronous manner and use events for item retrieval.  Obtaining multiple items is one of the primary operations of dojo.data that people will use and first experience the necessities of callbacks.   

This page demonstrates the absolute basics of obtaining multiple items in one request.  The prime method called is the  dojo.data.api.Read.fetch()

In the following examples, the Read API is used with the following values:

**fetch()**
    Asynchronous API that fetches a set of items which match a list of attributes.
**getValue()**
    Takes an item and an attribute and returns the associated value.

The following example code fragment returns all items:

.. code-block :: javascript

  var pantryStore = new dojo.data.ItemFileReadStore({ url: "pantry_items.json" });
  //Define a callback that fires when all the items are returned.
  var gotList = function(items, request){
    var itemsList = "";
    dojo.forEach(items, function(i){
      itemsList += pantryStore.getValue(i, "name") + " ";
    });
    console.debug("All items are: " + itemsList);
  }
  var gotError = function(error, request){
    alert("The request to the store failed. " +  error);
  }
  //Invoke the search
  pantryStore.fetch({
    onComplete: gotList,
    onError: gotError
  });


That's great, but what is more useful is seeing a completely functional example.  In the following example, clicking a button retrieves a list of items and displays them.  Please note that this is a simple example using ItemFileReadStore, but the concepts it presents applies to all Data Stores.

===================
Functional Examples
===================


Loading all items through callbacks
-----------------------------------

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

        //This function performs some basic dojo initialization.  In this case it connects the button
        //onClick to a function which invokes the fetch().  The fetch function queries for all items 
        //and provides callbacks to use for completion of data retrieval or reporting of errors.
        function init () {
           //Function to perform a fetch on the datastore when a button is clicked
           function getAllItems () {

             //Callback to perform an action when the data items are starting to be returned:
             function clearOldList(size, request) {
               var list = dojo.byId("list");
               if (list) { 
                 while (list.firstChild) {
                   list.removeChild(list.firstChild);
                 }
               }
             }
  
             //Callback for processing a returned list of items.
             function gotItems(items, request) {
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
             
             //Fetch the data.  
             foodStore.fetch({onBegin: clearOldList, onComplete: gotItems, onError: fetchFailed});

           }
           //Link the click event of the button to driving the fetch.
           dojo.connect(button, "onClick", getAllItems);
        }
        //Set the init function to run when dojo loading and page parsing has completed.
        dojo.addOnLoad(init);
    </script>

  .. cv :: html 

    <div dojoType="dojo.data.ItemFileReadStore" data="storeData" jsId="foodStore"></div>
    <div dojoType="dijit.form.Button" jsId="button">Click me for a list!</div>
    <br>
    <br>
    <span id="list">
    </span>


==========================
Working with Lots of Items
==========================

Now that we've looked at dealing with getting a list of items in one batch, what if the list is huge? It could take a long time to get all the items, push them into an array, and then call the callback with the array of items. Wouldn't it be nice if you could stream the items in, one at a time, and do something each time a new item is available? Well, with dojo.data, you can do that! There is an alternate callback you can pass to fetch() that is called on an item by item basis. It is the onItem callback.

In the following examples, the code will request that all items be returned (an empty query). As each item gets returned, it will add a textnode to the document. In this example, the Read API is used with the following values:

**fetch()**
    Asynchronous API that fetches a set of items which match a list of attributes.
**getValue()**
    Takes an item and an attribute and returns the associated value.

The following code fragment loads all items and streams them back into the page:

.. code-block :: javascript

  var pantryStore = new dojo.data.ItemFileReadStore({url: "pantry_items.json" } );
  var body = dojo.body(); // node to put output in  
  
  // Define the onComplete callback to write
  // COMPLETED to the page when the fetch has
  // finished returning items.
  var done = function(items, request){
    body.appendChild(document.createTextNode("COMPLETED"));
  }   
  
  //Define the callback that appends a textnode into the document each time an item is returned.
  gotItem = function(item, request){
    body.appendChild(
      document.createTextNode(
        pantryStore.getValue(item, "name")
      )
    );
    body.appendChild(document.createElement("br"));
  }
  
  //Define a simple error handler.
  var gotError = function(error, request){
    console.debug("The request to the store failed. " +  error);
  }
  
  //Invoke the search
  pantryStore.fetch({
    onComplete: done,
    onItem: gotItem,
    onError: gotError
  });


Now, to demonstrate this concept in a functional example. In the following example, clicking a button retrieves a list of items and displays them.  Please note that this is a simple example using ItemFileReadStore, but the concepts it presents applies to all Data Stores.

==========================
Functional onItem Examples
==========================

Loading all items through the onItem callback
---------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.form.Button");

      var storeData2 = { identifier: 'name', 
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

        //This function performs some basic dojo initialization.  In this case it connects the button
        //onClick to a function which invokes the fetch().  The fetch function queries for all items 
        //and provides callbacks to use for completion of data retrieval or reporting of errors.
        function init2 () {
           //Function to perform a fetch on the datastore when a button is clicked
           function getStreamingItems () {

             //Callback to perform an action when the data items are starting to be returned:
             function clearOldList(size, request) {
               var list = dojo.byId("list2");
               if (list) { 
                 while (list.firstChild) {
                   list.removeChild(list.firstChild);
                 }
               }
             }
  
             //Callback for processing a single returned item.
             function gotItem(item, request) {
               var list = dojo.byId("list2");
               if (list) {
                 if (item) { 
                   list.appendChild(document.createTextNode(foodStore2.getValue(item, "name")));
                   list.appendChild(document.createElement("br"));
                 }
               }
             }
            
             //Callback for if the lookup fails.
             function fetchFailed(error, request) {
                alert("lookup failed.");
             }
             
             //Fetch the data.  
             foodStore2.fetch({onBegin: clearOldList, onItem: gotItem, onError: fetchFailed});
           }

           //Link the click event of the button to driving the fetch.
           dojo.connect(button2, "onClick", getStreamingItems);
        }
        //Set the init function to run when dojo loading and page parsing has completed.
        dojo.addOnLoad(init2);
    </script>

  .. cv :: html 

    <div dojoType="dojo.data.ItemFileReadStore" data="storeData2" jsId="foodStore2"></div>
    <div dojoType="dijit.form.Button" jsId="button2">Click me for a list!</div>
    <br>
    <br>
    <span id="list2">
    </span>


**Note:** If the onItem callback is present in the parameters to fetch, then the first parameter to the onComplete callback, the items array, will always be null. Therefore, onItem is streaming only mode and does not rely on onComplete for anything other than a signal that the streaming has ended.
