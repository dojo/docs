#format dojo_rst

Selecting (Filtering) items
===========================

.. contents::
  :depth: 3

========
Querying
========

There are many times when you might not want an entire item list. Though you could fetch the entire list, and loop through to select elements, dojo.data's API definition has facilities to do the tough work for you.

Selecting subsets of items requires a query. A query can be anything from a String to a JavaScript object that has attributes which look a lot like the attributes of the data store. In the case of a JavaScript object it's a kind of query-by-example. Most datastores in dojo and dojox implement their query function this way, so it will be used for this example. Just be aware it is possible for a datastore to provide alternate query syntaxes, such as a straight string.

In any event, on to what querying is all about:

Given a dataset like:

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

There are times it would be useful to only work with a subset of those items. For example, maybe you want to locate things only found in the spices aisle. In other words, you want to find all items that match:

.. code-block :: javascript 
  
  { aisle: "Spice" }

And you don't care what the other attributes are. For dojo.data.ItemFileReadStore (and dojo.data.itemFileWriteStore), the query query syntax is  just a subset match. And in fact, the above code example is your desired query to pass to the *fetch()*. Now, that's great, but what it you wanted to query a bit more loosely, say find all items that are in aisles that start with the letter S. Can you do that?   With dojo.data, yes you can. Since the query is data store defined, query syntaxes can use wildcards and the like. Please read the note below for further details:

  **Note:** Each type of data store can have its own query syntax. With JsonItemStore, you can use wildcards: * to mean any characters. and ? to mean one character. This notation will be familiar to you if you've worked with Perl, Java, UNIX shell regular expressions, or even old BATCH scripts. And in general, the dojo.data community would highly recommend that all stores try to follow this method of specifying the query for consistency. Even datastores that are backed by an SQL database should be able to handle such character matching, because * maps to %, and ? maps to _ in SQL syntax.

  So, for dojo.data.ItemFileReadStore, if you wanted to find all items in aisles starting with *Condiment*, the query is simply:
  
  .. code-block :: javascript 

    { aisle: "Condiment*" }


  For dojo.data.ItemFileReadStore, multiple attributes assume an "and" between the terms. So a query like the following one will match spices with the word pepper inside them, but not "green peppers" in the vegetable aisle:

  .. code-block :: javascript 

    { name: "*pepper*", aisle: "Spices" }


Once we have constructed the query, we pass it to fetch() along with the other parameters as shown in the following example:

.. code-block :: javascript 

  itemStore .fetch({ 
    query: { name: "*pepper*", aisle: "Spices" },
    onComplete: 
    ...    
  });

====================================
Case sensitivity and other modifiers
====================================

That's great, but what if I don't care about case sensitivity?  Dojo.data also provides a method for augmenting the query with options through the use of the queryOptions object. By default, dojo.data only defines two options that datastores should honor. They are *ignoreCase* and *deep*, and both are boolean valued. The ignoreCase option tells the datastore to compare the attributes for matches, but do so case-insensitively. The *deep* option only applies to stores which represent hierarchical data, and it instructs the search to search all child items (as well as all root items), for a match. So, if we take the above example and say we want to just ignore case so we get 'Black Pepper' and 'white pepper' as matches, the fetch call becomes:

.. code-block :: javascript 

  itemStore .fetch({ 
    query: { name: "*pepper*", aisle: "Spices" },
    queryOptions: { ignoreCase: true },
    onComplete: 
    ...    
  });

So,in general, any option that would affect the behavior of a query, such as making it case insensitive or doing a deep scan where it scans a hierarchy of items instead of just the top level items (the deep:true option), in a store belongs in the queryOptions argument.


=====================
Flexible store syntax
=====================

Why isn't it just SQL for a query?  Why can each store potentially define their own query syntax?  The simple and short answer to this question is that not all datastores are backed directly by a database that handles SQL. An immediate example is ItemFileReadStore, which just uses a structured JSON list for its data, so its query looks like structured JSON. Other examples would be datastores that wrap on top of services like Flickr and Delicious, because neither of those take SQL as the syntax for their services. 

Therefore, the dojo.data API defines basic guidelines and syntax stores that can be easily mapped to a service (for example, attribute names can map directly to parameters in a query string). The same is true for an SQL backed datastore. The attributes become substitutions in a prepared statement that the stores use (when they pass back the query to the server) and a simple common pattern matching syntax, the * and ?, which also map easily across a wide variety of datasource query syntax.

  **Note:** dojo.data recommends that stores generally use the dojo.data.ItemFileReadStore syntax, because it is fairly generic, works well in javascript, and can be mapped into other native syntaxes easily. Nearly all, if not all, datastores provided in the dojox.data module use the exact same syntax and will under the covers map it to the native syntaxes needed by the back-end services that provide the data store query and return (for remove data stores), and in-memory datastores, such as dojo.data.ItemFileReadStore work well with the structured JavaScript format.

========
Examples
========

This section covers some basic query examples to familiarize users with the general expected flow for using queries.

Query for all Spices  (Basic query)
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
          { name: 'white pepper', aisle: 'Spices',  price: 1.01 },
          { name: 'Black Pepper', aisle: 'Spices',  price: 1.01 }
        ]};

        //This function performs some basic dojo initialization. In this case it connects the button
        //onClick to a function which invokes the fetch(). The fetch function queries for all items 
        //and provides callbacks to use for completion of data retrieval or reporting of errors.
        function init () {
           //Function to perform a fetch on the datastore when a button is clicked
           function getSpices () {

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
             foodStore.fetch({query: { aisle: "Spices"}, onBegin: clearOldList, onComplete: gotItems, onError: fetchFailed});

           }
           //Link the click event of the button to driving the fetch.
           dojo.connect(button, "onClick", getSpices);
        }
        //Set the init function to run when dojo loading and page parsing has completed.
        dojo.addOnLoad(init);
    </script>

  .. cv :: html 

    <div dojoType="dojo.data.ItemFileReadStore" data="storeData" jsId="foodStore"></div>
    <div dojoType="dijit.form.Button" jsId="button">Click to find the spices!</div>
    <br>
    <br>
    <span id="list">
    </span>


Query for all food in aisles starting with C 
--------------------------------------------

*Basic query with wildcard*

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
          { name: 'white pepper', aisle: 'Spices',  price: 1.01 },
          { name: 'Black Pepper', aisle: 'Spices',  price: 1.01 }
        ]};

        //This function performs some basic dojo initialization. In this case it connects the button
        //onClick to a function which invokes the fetch(). The fetch function queries for all items 
        //and provides callbacks to use for completion of data retrieval or reporting of errors.
        function init2 () {
           //Function to perform a fetch on the datastore when a button is clicked
           function getCAisle () {

             //Callback to perform an action when the data items are starting to be returned:
             function clearOldList(size, request) {
               var list = dojo.byId("list2");
               if (list) { 
                 while (list.firstChild) {
                   list.removeChild(list.firstChild);
                 }
               }
             }
  
             //Callback for processing a returned list of items.
             function gotItems(items, request) {
               var list = dojo.byId("list2");
               if (list) { 
                 var i;
                 for (i = 0; i < items.length; i++) {
                   var item = items[i];
                   list.appendChild(document.createTextNode(foodStore2.getValue(item, "name")));
                   list.appendChild(document.createElement("br"));
                 }
               }
             }
            
             //Callback for if the lookup fails.
             function fetchFailed(error, request) {
                alert("lookup failed.");
                alert(error);
             }
             
             //Fetch the data.
             foodStore2.fetch({query: { aisle: "C*"}, onBegin: clearOldList, onComplete: gotItems, onError: fetchFailed});

           }
           //Link the click event of the button to driving the fetch.
           dojo.connect(button2, "onClick", getCAisle );
        }
        //Set the init function to run when dojo loading and page parsing has completed.
        dojo.addOnLoad(init2);
    </script>

  .. cv :: html 

    <div dojoType="dojo.data.ItemFileReadStore" data="storeData2" jsId="foodStore2"></div>
    <div dojoType="dijit.form.Button" jsId="button2">Click to find the items in an aisle starting with C!</div>
    <br>
    <br>
    <span id="list2">
    </span>


Enter your own query for name and aisle
---------------------------------------

*Wildcards * and ? are supported by the dojo.data.ItemFileReadStore:*

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.form.Button");
      dojo.require("dijit.form.TextBox");
      dojo.require("dijit.form.CheckBox");

      var storeData3 = { identifier: 'name', 
        items: [
          { name: 'Adobo', aisle: 'Mexican', price: 3.01 },
          { name: 'Balsamic vinegar', aisle: 'Condiments', price: 4.01 },
          { name: 'Basil', aisle: 'Spices', price: 3.59  },          
          { name: 'Bay leaf', aisle: 'Spices',  price: 2.01 },
          { name: 'Beef Bouillon Granules', aisle: 'Soup',  price: 5.01 },
          { name: 'Vinegar', aisle: 'Condiments',  price: 1.99  },
          { name: 'White cooking wine', aisle: 'Condiments',  price: 2.01 },
          { name: 'Worcestershire Sauce', aisle: 'Condiments',  price: 3.99 },
          { name: 'white pepper', aisle: 'Spices',  price: 1.01 },
          { name: 'Black Pepper', aisle: 'Spices',  price: 1.01 }
        ]};

        //This function performs some basic dojo initialization. In this case it connects the button
        //onClick to a function which invokes the fetch(). The fetch function queries for all items 
        //and provides callbacks to use for completion of data retrieval or reporting of errors.
        function init3 () {
           //Function to perform a fetch on the datastore when a button is clicked
           function search() {
             var queryObj = {};

             //Build up the query from the input boxes.
             var name = nameBox.getValue();
             if ( name && dojo.trim(name) !== "" ) {
               queryObj["name"] = name;       
             }
             var aisle = aisleBox.getValue();
             if ( aisle && dojo.trim(aisle) !== "" ) {
               queryObj["aisle"] = aisle;       
             }

             var qNode = dojo.byId("query");
             if (qNode ) {
               qNode.innerHTML = dojo.toJson(queryObj);   
             }


             //Build up query options, if any.
             var queryOptionsObj = {};

             if ( checkBox.getValue()) {
               queryOptionsObj["ignoreCase"] = true;
             }

             var qoNode = dojo.byId("queryOptions");
             if (qoNode ) {
               qoNode.innerHTML = dojo.toJson(queryOptionsObj);   
             }

             //Callback to perform an action when the data items are starting to be returned:
             function clearOldList(size, request) {
               var list = dojo.byId("list3");
               if (list) { 
                 while (list.firstChild) {
                   list.removeChild(list.firstChild);
                 }
               }
             }
  
             //Callback for processing a returned list of items.
             function gotItems(items, request) {
               var list = dojo.byId("list3");
               if (list) { 
                 var i;
                 for (i = 0; i < items.length; i++) {
                   var item = items[i];
                   list.appendChild(document.createTextNode(foodStore3.getValue(item, "name")));
                   list.appendChild(document.createElement("br"));
                 }
               }
             }
            
             //Callback for if the lookup fails.
             function fetchFailed(error, request) {
                alert("lookup failed.");
                alert(error);
             }
             
             //Fetch the data.
             foodStore3.fetch({query: queryObj, queryOptions: queryOptionsObj, onBegin: clearOldList, onComplete: gotItems, onError: fetchFailed});

           }
           //Link the click event of the button to driving the fetch.
           dojo.connect(button3, "onClick", search);
        }
        //Set the init function to run when dojo loading and page parsing has completed.
        dojo.addOnLoad(init3);
    </script>

  .. cv :: html 


    <b>Name:  </b><input dojoType="dijit.form.TextBox" jsId="nameBox" value="*"></input>
    <br>
    <br>
    <b>Aisle: </b><input dojoType="dijit.form.TextBox" jsId="aisleBox" value="*"></input>
    <br>
    <br>
    <b>Case Insensitive: </b><div dojoType="dijit.form.CheckBox" checked="false" jsId="checkBox"></div>
    <br>
    <br>
    <div dojoType="dojo.data.ItemFileReadStore" data="storeData3" jsId="foodStore3"></div>
    <div dojoType="dijit.form.Button" jsId="button3">Click to search!</div>
    <br>
    <br>
    <b>Query used: </b><span id="query"></span>
    <br>
    <br>
    <b>Query Options used: </b><span id="queryOptions"></span>
    <br>
    <br>
    <b>Items located:</b>
    <br>
    <span id="list3">
    </span>
