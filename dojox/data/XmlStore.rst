#format dojo_rst

dojox.data.XmlStore
===================

:Status: Contributed, Draft
:Version: 1.0
:Author: Jared Jurkiewicz
:Available: since V1.0
 
.. contents::
  :depth: 3


XmlStore is a store provided by Dojo that is contained in the DojoX project. XmlStore is a read and write interface to basic XML data. XML is a common data interchange format and a store that can work with fairly generic XML documents is useful. The store is designed so that you can over-ride certain functions to get specific behaviors to occur when performing reads and saves.

==============
Supported APIs
==============

The following dojo.data APIs are implemented by XmlStore

* `dojo.data.api.Read <dojo/data/api/Read>`_
* `dojo.data.api.Write <dojo/data/api/Write>`_
* `dojo.data.api.Identity <dojo/data/api/Identity>`_  

  * **New for dojo 1.3!**  Identity API has been implemented.  The store wil return xpath for an item, or it will return the value of a key attribute you specified.  Specifying keyAttribute is not needed for client-side query and filtering case, but it is required for server-side query handling and update.


=================
Example XML Input
=================

The store is designed so that it can read generic XML and present back nodes as dojo.data items.  The following is an example of an XML document that this store can read:

::

  <?xml version="1.0" encoding="ISO-8859-1"?>
  <books>
	<book>
		<isbn>1</isbn>
		<title>Title of 1</title>
		<author>Author of 1</author>
	</book>
	<book>
		<isbn>2</isbn>
		<title>Title of 2</title>
		<author>Author of 2</author>
	</book>
	<book>
		<isbn>3</isbn>
		<title>Title of 3</title>
		<author>Author of 3</author>
	</book>
	<book>
		<isbn>4</isbn>
		<title>Title of 4</title>
		<author>Author of 4</author>
	</book>
	<book>
		<isbn>5</isbn>
		<title>Title of 5</title>
		<author>Author of 5</author>
	</book>
	<book>
		<isbn>6</isbn>
		<title>Title of 6</title>
		<author>Author of 6</author>
	</book>
        ...
  </books>
    
======================
Constructor Parameters
======================

The constructor for XmlStore takes the following possible parameters in its keyword arguments:


+--------------------------+--------------------------------------------------------------------------------------------------------+
|**Parameter**             |**Description**                                                                                         |
+--------------------------+--------------------------------------------------------------------------------------------------------+
|url                       |The URL from which to load the XML file containing the data. This URL is also the end point used for    |
|                          |posting data base in a save. This is optional.                                                          |
+--------------------------+--------------------------------------------------------------------------------------------------------+
|sendQuery                 |Boolean option whether or not to send the query to a server for processing. The default is false.       |
|                          |                                                                                                        |
|                          |false                                                                                                   |
|                          |  It is assumed the server sends back the entire store dataset and the filtering and sorting must       |
|                          |  occur on the client side.                                                                             |
|                          |                                                                                                        |
|                          |true                                                                                                    |
|                          |  It is assumed the server is handling the filtering and is only sending back XML nodes that match the  |
|                          |  query. No filtering occurs clientside.                                                                |
+--------------------------+--------------------------------------------------------------------------------------------------------+
|rootItem                  |A tag name for root items. This is optional. If it is not provided, then the XmlStore assumes the tags  |
|                          |under the root element of the document are the root items.                                              |
+--------------------------+--------------------------------------------------------------------------------------------------------+
|keyAttribute              |An attribute name for a key or an identity. This is optional unless server-side query handling is used. |
+--------------------------+--------------------------------------------------------------------------------------------------------+
|attributeMap              |An anonymous object that contains properties for attribute mapping, for example                         |
|                          |{"tag_name.item_attribute_name": "@xml_attribute_name", ...}.   This is optional. This is done so that  |
|                          |attributes which are actual XML tag attributes (and not sub-tags of an XML tag), can be referenced.     |
+--------------------------+--------------------------------------------------------------------------------------------------------+
|label                     |The attribute of an item to use for the return of getLabel(). This is optional.                         |
+--------------------------+--------------------------------------------------------------------------------------------------------+
| urlPreventCache          |This boolean value controls whether dojo attempts to prevent the browser caching mechanism from         |
| **(since dojo 1.4)**     |caching values loaded from a webserver.  The default is true for backwards compatibility                |
+--------------------------+--------------------------------------------------------------------------------------------------------+

=================================
User-provided function over-rides
=================================

The following functions can be over-ridden to alter save behavior, as described:

_getPostUrl(item)
    Function that can be over-ridden to alter the way the store POSTs new items to the service. Note that this follows the REST convention in which an HTTP POST is a creation of a new resource.
_getPutUrl(item)
    Function that can be over-ridden to alter the way the store PUTs updated items to the service. Note that this follows the REST convention in which an HTTP PUT is an update of an existing resource.
_getDeleteUrl(item)
    Function that can be over-ridden to alter the way the store sends a DELETE item to the service. Note that this follows the REST convention in which an HTTP DELETE is used to remove a resource.

============
Query Syntax
============

The fetch method query syntax for XmlStore is simple and straightforward. It allows for a list of attributes to match against in an AND fashion, just like `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_. For example, the following query object will locate all items that have attributes of those names that match both of those values:

::

  { foo:"bar", bit:"bite"}

Note that XmlStore supports the use of wild cards (multi-character * and single character ?) in its attribute value matching.
Examples

To find all items with attribute foo that start with bar, the query would be:

::

  { foo:"bar*"}

To find all items with attribute foo the value of which ends with ar and ignoring only the first character, the query would be:

::
  
  { foo:"?ar"}

**NOTE:** Other stores should follow the same query definition semantics for consistency.

=============
Query Options
=============

Dojo.data defines support for a 'queryOptions' modifier object that affects the behavior of the query. The two defined options listed by the API are *ignoreCase* and *deep*. dojox.data.XmlStore supports these options. The affect of these options on a query is defined below.

+------------+------------------------------------------------------------------------------------------------------------------------+
| **Option** | **Result**                                                                                                             |
+------------+------------------------------------------------------------------------------------------------------------------------+
| ignoreCase |The default is **false**. When set to true, the match on attributes is done in a case-insensitive fashion. This means   |
|            |with ignoreCase: true, a query of A* would match *Apple* and *acorn*                                                    |
+------------+------------------------------------------------------------------------------------------------------------------------+
| deep       |This option affects searching when the structure passed to ItemFileReadStore has hierarchy. For an example of that,     |
|            |refer to *Item Structure Example: Items with Hierarchy*. the default value for this option is false, which means the    |
|            |query is only applied against root items in the tree of data items. If it is set to true, then the query is applied to  |
|            |root items and *all* child data items. Think of it as a recursive search.                                               |
+------------+------------------------------------------------------------------------------------------------------------------------+

==============
Usage Examples
==============

For these examples, we'll assume a data source as defined by the example data format in this page.


Query for all books that start with ISBN: A9B57
-----------------------------------------------

.. code-block :: javascript 

  var store = new dojox.data.XmlStore({url: "books.xml", rootItem: "book"});
  var gotBooks = function(items, request){
    for (var i = 0; i < items.length; i++){
      var item = items[i];
      console.log("Located book: " + store.getValue(item, "title");
    }
  }
  var request = store.fetch({query: {isbn:"A9B57*"}, onComplete: gotBooks});


Query for all books that start with ISBN: A9B57 Case insensitively
------------------------------------------------------------------

.. code-block :: javascript

  var store = new dojox.data.XmlStore({url: "books.xml", rootItem: "book"});
  var gotBooks = function(items, request){
    for (var i = 0; i < items.length; i++){
      var item = items[i];
      console.log("Located book: " + store.getValue(item, "title");
    }
  }
  var request = store.fetch({query: {isbn:"a9b57*"}, queryOptions: {ignoreCase: true}, onComplete: gotBooks});


=========================
Functional Usage Examples
=========================


Searching node attributes
-------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.data.XmlStore");
      dojo.require("dijit.form.Button");
      dojo.require("dijit.form.TextBox");
      dojo.require("dijit.form.CheckBox");

        //This function performs some basic dojo initialization. In this case it connects the button
        //onClick to a function which invokes the fetch(). The fetch function queries for all items 
        //and provides callbacks to use for completion of data retrieval or reporting of errors.
        function init3 () {
           //Function to perform a fetch on the datastore when a button is clicked
           function search() {
             var queryObj = {};

             //Build up the query from the input boxes.
             var isbn = isbnBox.getValue();
             if ( isbn && dojo.trim(isbn) !== "" ) {
               queryObj["isbn"] = isbn;       
             }

             var qNode = dojo.byId("query");
             if (qNode ) {
               qNode.innerHTML = dojo.toJson(queryObj);   
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
                   list.appendChild(document.createTextNode("ISBN: " + bookStore.getValue(item, "isbn") + " TITLE:" + bookStore.getValue(item, "title")));
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
             bookStore.fetch({query: queryObj, onBegin: clearOldList, onComplete: gotItems, onError: fetchFailed});

           }
           //Link the click event of the button to driving the fetch.
           dojo.connect(button3, "onClick", search);
        }
        //Set the init function to run when dojo loading and page parsing has completed.
        dojo.addOnLoad(init3);
    </script>

  .. cv :: html 


    <b>ISBN:  </b><input dojoType="dijit.form.TextBox" jsId="isbnBox" value="*"></input>
    <br>
    <br>
    <div dojoType="dojox.data.XmlStore" jsId="bookStore" url="{{dataUrl}}dojox/data/tests/stores/books.xml"></div>
    <div dojoType="dijit.form.Button" jsId="button3">Click to search!</div>
    <br>
    <br>
    <b>Query used: </b><span id="query"></span
    <br>
    <br>
    <b>Books located:</b>
    <br>
    <span id="list3">
    </span>


Connecting XmlStore to dijit.form.ComboBox
------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.data.XmlStore");
      dojo.require("dijit.form.ComboBox");
    </script>

  .. cv :: html 

    <div dojoType="dojox.data.XmlStore" url="{{dataUrl}}dojox/data/tests/stores/books.xml" jsId="bookStore2"></div>
    <div dojoType="dijit.form.ComboBox" store="bookStore2" searchAttr="title"></div>


Connecting XmlStore to dojox.grid.DataGrid
------------------------------------------

.. cv-compound ::

  .. cv :: javascript

    <script>
      dojo.require("dojox.grid.DataGrid");
      dojo.require("dojox.data.XmlStore");

      var layoutBooks = [
        [
          { field: "isbn", name: "ISBN", width: 10, formatter: function(item) { return item.toString(); } },
          { field: "author", name: "Author", width: 10, formatter: function(item) { return item.toString(); } },
          { field: "title", name: "Title", width: 'auto', formatter: function(item) { return item.toString(); } }
        ]
      ];
    </script>

  .. cv :: html

    <div dojoType="dojox.data.XmlStore" url="{{dataUrl}}dojox/data/tests/stores/books.xml" jsId="bookStore3" label="title"></div>

    <div id="grid" style="width: 400px; height: 300px;"
      dojoType="dojox.grid.DataGrid" 
      store="bookStore3" 
      structure="layoutBooks" 
      query="{}"
      rowsPerPage="40">
    </div>

  .. cv:: css

    <style type="text/css">
      @import "{{baseUrl}}dojox/grid/resources/Grid.css";
      @import "{{baseUrl}}dojox/grid/resources/nihiloGrid.css";

      .dojoxGrid table {
        margin: 0;
      }
    </style>
