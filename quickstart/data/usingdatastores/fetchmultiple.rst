#format dojo_rst

**Fetching multiple items and values**
======================================

**Working with Multiple Items**

You will likely want to access multiple items from such a data source as in the preceding example. No problem! Dojo.data Read API provides a mechanism for loading a set of items. All you have to do is provide the following information to the fetch function of the Read API:

* This is what I want (if I don't tell you something, get everything)
* Do this if there is an error
* Do that when everything is loaded

If this sounds like it might be event-driven, that's because it is.  Most I/O methods in Ajax must perform operations asynchronously, so results and errors have to be returned through events (commonly called callbacks).  Because of the asynchronous requirements of the I/O methods, the dojo.data API was designed to operate in an asynchronous manner and use events for item retrieval.  Obtaining multiple items is one o the primary operations of dojo.data that people will use and first experience the necessities of callbacks.   

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


That's great, but what is more useful is seeing a completely functional example.  In the following example, clicking a button retrieves a list of items and displays them.

**Functional Example 1: Loading all items through callbacks:**

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
        //onClick to a function which invokes the fetch().  The fetch function queries for all items and provides
        //callbacks to use for completion of data retrieval or reporting of errors.
        function init () {
           //Function to perform a fetch on the datastore when a button is clicked
           function getAllItems () {
             alert("Trying tp get items");   
             //Callback for processing a returned list of items.
             function gotItems(items, request) {
               var list = dojo.byId("list");
               if (list) { 
                 while (list.firstChild) {
                   list.removeChild(list.firstChild);
                 }
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
             foodStore.fetch({onComlete: gotItems, onError: fetchFailed});

           }
           //Link any change events in the combo to driving the fetchItemByIdentity lookup.
           dojo.connect(button, "onclick", getAllItems);
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
