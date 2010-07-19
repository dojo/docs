#format dojo_rst

dojox.data.KeyValueStore
========================

:Status: Contributed, Draft
:Version: 1.0
:Available: since V1.1

.. contents::
    :depth: 3

This is a dojo.data store implementation. The KeyValueStore is a store that takes content in a format similar to those used by property files, such as Java, and many other languages were there are unique keys mapping to some value for display. Think of it as an interface for reading property style files in dojo through the dojo.data interface.

============
Input Format
============

It can take in either a Javascript array, JSON string, or URL as the data source. Data is expected to be in the following format:

.. code-block :: javascript

  [
    { "key1": "value1" },
    { "key2": "value2" },
    ...
  ]

Each 'item' retrieved from this store from this store is a JS object representing a key-value pair. If an item in the above array has more than one key/value pair, only the first will be used/accessed.

Such a construct can be formed from a JS object of the form { k1:v1, k2:v2, ... } with code like

.. code-block :: javascript

  var myVar={"key1": "value1" , "key2": "value2", ... };
  var myData=[];
  for (var p in myVar) {
    var t={};
    t[p]=myVar[p];
    myData.push(t);
  }


======================
Constructor Parameters
======================

The constructor for the store can take three different parameters as a way to load the data; a URL to a JSON encoded file, a reference to a JavaScript object in key/value pair format, and a JSON encoded string. The parameters are documented below:

+---------------+------------------------------------------------------------------------------+------------------------------+
|**Parameter**  |**Description**                                                               |**Type**                      |
+---------------+------------------------------------------------------------------------------+------------------------------+
|url            |The URL from which to xhrGet load a JSON encoded file of the data.            |String                        |
+---------------+------------------------------------------------------------------------------+------------------------------+
|data           |A JSON encoded string of the data.                                            |String                        |
+---------------+------------------------------------------------------------------------------+------------------------------+
|dataVar        |A JavaScript Array object of the items.                                       |JavaScript Array              |
+---------------+------------------------------------------------------------------------------+------------------------------+
|urlPreventCache|Flag denoting whether or not browser caching should be avoided.  Defaults to  |boolean                       |
|               |false.  **New to Dojo 1.4**                                                   |                              |
+---------------+------------------------------------------------------------------------------+------------------------------+

===============
Item Attributes
===============

Items from the KeyValueStore have two well-defined attribute names 'key' and 'value', as well as the dynamic value of store.getValue(item, "key"). See the table below for further details.

+------------------------+------------------------------------------------------------------------------+------------------------------+
|**Attribute**           |**Description**                                                               |**Type**                      |
+------------------------+------------------------------------------------------------------------------+------------------------------+
|key                     |The value of this attribute is the named key used in the key/value pair.      |String                        |
+------------------------+------------------------------------------------------------------------------+------------------------------+
|value                   |The value of this attribute is the value assigned to be the key of the        |String                        |
|                        |key/value pair.                                                               |                              |
+------------------------+------------------------------------------------------------------------------+------------------------------+
|getValue(item, "key")   |The named key of the key/value pair.                                          |                              |
+------------------------+------------------------------------------------------------------------------+------------------------------+

========
Examples
========

List out all the attributes and values of a key/value data set
--------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.data.KeyValueStore");
      dojo.require("dijit.form.Button");

      var storeData = [
          { 'key1' : 'value1' },
          { 'key2' : 'value2' },
          { 'key3' : 'value3' },
          { 'key4' : 'value4' },
          { 'key5' : 'value5' }
        ];

        //This function performs some basic dojo initialization. In this case it connects the button
        //onClick to a function which invokes the fetch(). The fetch function queries for all items 
        //and provides callbacks to use for completion of data retrieval or reporting of errors.
        function init () {
           //Function to perform a fetch on the datastore when a button is clicked
           function getAllItems () {

             //Callback to perform an action when the data items are starting to be returned:
             function clearList(size, request) {
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
                   var field = document.createElement("b");
                   field.appendChild(document.createTextNode("Key: "));
                   list.appendChild(field);
                   list.appendChild(document.createTextNode(kvStore.getValue(item, "key")));
                   list.appendChild(document.createTextNode("  "));
                   field = document.createElement("b");
                   field.appendChild(document.createTextNode("Value: "));
                   list.appendChild(field);
                   list.appendChild(document.createTextNode(kvStore.getValue(item, "value")));
                   list.appendChild(document.createTextNode("  "));
                   field = document.createElement("b");
                   field.appendChild(document.createTextNode("Value by named key (" + kvStore.getValue(item, "key") + "): "));
                   list.appendChild(field);
                   list.appendChild(document.createTextNode(kvStore.getValue(item, kvStore.getValue(item, "key"))));
                   list.appendChild(document.createElement("br"));
                 }
               }
             }

             //Callback for if the lookup fails.
             function fetchFailed(error, request) {
                alert("lookup failed.");
             }
             
             //Fetch the data in a sorted order. 
             kvStore.fetch({onBegin: clearList, onComplete: gotItems, onError: fetchFailed});
           }
           //Link the click event of the button to driving the fetch.
           dojo.connect(button, "onClick", getAllItems);
        }
        //Set the init function to run when dojo loading and page parsing has completed.
        dojo.addOnLoad(init);
    </script>

  .. cv :: html 

    <div dojoType="dojox.data.KeyValueStore" data="storeData" jsId="kvStore"></div>
    <div dojoType="dijit.form.Button" jsId="button">Show me the key/value info!</div>
    <br>
    <br>
    <b>List of item information:</b>
    <br>
    <span id="list">
    </span>


Connecting key/value store to dojox.grid.DataGrid
-------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.data.HtmlStore");
      dojo.require("dojox.grid.DataGrid");

      var storeData2 = [
        { 'key1' : 'value1' },
        { 'key2' : 'value2' },
        { 'key3' : 'value3' },
        { 'key4' : 'value4' },
        { 'key5' : 'value5' }
      ];

      var layoutKeyValue = [
        [
          { field: "key", name: "KEY", width: 10 },
          { field: "value", name: "VALUE", width: 'auto' }
        ]
      ];

    </script>

  .. cv :: html 


    <b>dojox.grid.DataGrid connected to the KeyValueStore:</b><br> 
    <div dojoType="dojox.data.KeyValueStore" data="storeData2" jsId="kvStore2"></div>
    <div style="width: 400px; height: 200px;">
      <div id="grid" 
        dojoType="dojox.grid.DataGrid" 
        store="kvStore2" 
        structure="layoutKeyValue" 
        query="{}"
        rowsPerPage="40">
      </div>
    </div>

  .. cv:: css

    <style type="text/css">
      @import "{{baseUrl}}dojox/grid/resources/Grid.css";
      @import "{{baseUrl}}dojox/grid/resources/nihiloGrid.css";

      .dojoxGrid table {
        margin: 0;
      }
    </style>


Connecting key/value store to dijit.form.ComboBox
-------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.data.HtmlStore");
      dojo.require("dijit.form.ComboBox");

      var storeData3 = [
        { 'key1' : 'value1' },
        { 'key2' : 'value2' },
        { 'key3' : 'value3' },
        { 'key4' : 'value4' },
        { 'key5' : 'value5' }
      ];
    </script>

  .. cv :: html 

    <b>dijit.form.ComboBox connected to the KeyValueStore:</b><br> 
    <div dojoType="dojox.data.KeyValueStore" data="storeData3" jsId="kvStore3"></div>
    <div dojoType="dijit.form.ComboBox" store="kvStore3" searchAttr="key"></div>
