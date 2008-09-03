#format dojo_rst

**Selecting (Filtering) items**
===============================

There are many times when you might not want an entire item list. Though you could fetch the entire list, and loop through to select elements, dojo.data's API definition has facilities to do the tough work for you.

Selecting subsets of items requires a query. A query can be anything from a String to a a JavaScript object that has attributes which look a lot like the attributes of the data store. In the case of a JavaScript object it's a kind of query-by-example.  Most datastores in dojo and dojox implement their query function this way, so it will be used for this example.  Just be aware it is possible for a datastore to provide alternate query syntaxes, such as a straight string.

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
      { name: 'pepper', aisle: 'Spices',  price: 1.01 }
  ]}

There are times it would be useful to only work with a subset of those items.  For example,, maybe you want to locate things only found in the spices aisle.  In other words, you want to find all items that match:

.. code-block :: javascript 
  
  { aisle: "Spice" }

And you don't care what the other attributes are.  For dojo.data.ItemFileReadStore (and dojo.data.itemFileWriteStore), the query query syntax is  just a subset match.  And in fact, the above code example is your desired query to pass to the *fetch()*.  Now, that's great, but what it you wanted to query a bit more loosely, say find all items that are in aisles that start with the letter S.  Can you do that?   With dojo.data, yes you can.  Since the query is data store defined, query syntaxes can use wildcards and the like.  Please read the note below for further details:

  **Note:** Each type of data store can have its own query syntax. With JsomItemStore, you can use wildcards: * to mean any characters. and ? to mean one character. This notation will be familiar to you if you've worked with Perl, Java, UNIX shell regular expressions, or even old BATCH scripts. And in general, the dojo.data community would highly recommend that all stores try to follow this method of specifying the query for consistency. Even datastores that are backed by an SQL database should be able to handle such character matching, because * maps to %, and ? maps to _ in SQL syntax.

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


That's great, but what if I don't care about case sensitivity?  Dojo.data also provides a method for augmenting the query with options through the use of the queryOptions object.  By default, dojo.data only defines two options that datastores should honor.  They are *ignoreCase* and *deep*, and both are boolean valued.  The ignoreCase option tells the datastore to compare the attributes for matches, but do so case-insensitively. The *deep* option only applies to stores which represent hierarchical data, and it instructs the search to search all child items (as well as all root items), for a match.  So, if we take the above example and say we want to just ignore case so we get 'Black Pepper' and 'white pepper' as matches, the fetch call becomes:

.. code-block :: javascript 
  itemStore .fetch({ 
    query: { name: "*pepper*", aisle: "Spices" },
    queryOptions: { ignoreCase: true },
    onComplete: 
    ...    
  });


This example will match both "Black Pepper" and "white pepper."

In general, any option that would affect the behavior of a query, such as making it case insensitive or doing a deep scan where it scans a hierarchy of items instead of just the top level items (the deep:true option), in a store belongs in the queryOptions argument.
Why isn't it just SQL for a query?

The simple and short answer to this question is that not all datastores are backed directly by a database that handles SQL. An immediate example is ItemFileReadStore, which just uses a structured JSON list for its data. Other examples would be datastores that wrap on top of services like Flickr and Delicious, because neither of those take SQL as the syntax for their services. Therefore, the dojo.data API defines basic guidelines and syntax stores that can be easily mapped to a service (for example, attribute names can map directly to parameters in a query string). The same is true for an SQL backed datastore. The attributes become substitutions in a prepared statement that the stores use (when they pass back the query to the server) and a simple common pattern matching syntax, the * and ?, which also map easily across a wide variety of datasource query syntax.
