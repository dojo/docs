#format dojo_rst

dojo.data.ItemFileReadStore
===========================

:Status: Contributed, Draft
:Version: 1.4
:Author: Jared Jurkiewicz
:Available: since V1.0

.. contents::
  :depth: 2

Dojo core provides an implementation of a read-only datastore, ItemFileReadStore. This store reads the JSON structured contents from an http endpoint (service or URL), or from an in-memory JavaScript object, and stores all the items in-memory for simple and quick access. ItemFileReadStore is designed to allow for flexibility in how it represents item hierarchy, references, and custom data types. It also provides options for which an attribute can act as the unique identifier (for dojo.data.api.Identity), and which attribute can be used as a general label for an item. This store has an expectation that data is provided to in a specific though very flexible, format. All of the examples on this page demonstrate the general format expected.

**Points of Consideration:**

1. The format used by ItemFileReadStore is *not* a requirement of the dojo.data API. The format it uses is designed to work well for the specific situations ItemFileReadStore is used for, which are moderately sized data sets that can be easily represented in a JavaScript Object tree. 
   Again, please do not take the storage format used by ItemFileReadStore as a definitive format all data stores use; *it is not*. Other stores use different formats, such as CSV structured data, XML, Opml, HTML, raw text, etc. The point of a data store is to hide the internal structure and always expose the data through the same API.

2. This is an in-memory store. It is not designed to operate as a remote server store and often trying to make it work with specific remote services ends up far more work than simply implementing a completely new data store that conforms to the dojo.data APIs. So, if you find it extremely complicated to modify for your needs, take a step back and look at what you're trying to do. It may be simpler to implement the data store interface over your services.

==============
Supported APIs
==============

The following dojo.data APIs are implemented by ItemFileReadStore

* `dojo.data.api.Read <dojo/data/api/Read>`_
* `dojo.data.api.Identity <dojo/data/api/Identity>`_


======================
Constructor Parameters
======================

**NOTE:** 'Since' refers to which version of dojo the parameter was added to the data store.

+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| **Parameter**  | **Required** | **Description**                                                                                | **Since** |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| url            | No           |This optional parameter specifies what URL from which to load the structured JSON data. Note    | 1.0       |
|                |              |that this URL is only loaded one time, as this is an in-memory data store. Only when combined   |           |
|                |              |with parameters *clearOnClose* and *urlPreventCache*, is it possible to reload the store        |           |
|                |              |instance with new data.                                                                         |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| data           | No           |A structured JavaScript Object to use to populate the store. This parameter can be used instead | 1.0       |
|                |              |of *url* when you wish to load data differently then modify it to fit the expected              |           |
|                |              |ItemFileReadStore format. This parameter is ignored if *url* is set.  The data object passed in |           |
|                |              |is directly used **and** modified.  If you want to reuse a data object, make sure you copy it   |           |
|                |              |before you pass it in.                                                                          |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| typeMap        | No           |This is a JavaScript Object that defines how to deserialize custom types. For more information  | 1.0       |
|                |              |on custom types, please refer to the section in this page on them. They are effectively a way   |           |
|                |              |to control how certain values of attributes are processed.                                      |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| clearOnClose   | No           |This boolean parameter controls the close() behavior of the store. If set, calling close() will | 1.2       |
|                |              |erase all items stored in the internal structures. A new call to fetch will invoke the URL      |           |
|                |              |to fetch a new set of items or reload data from a new data object assigned to 'data'            |           |
|                |              |                                                                                                |           |
|                |              |**:**                                                                                           |           |
|                |              |**Prior to 1.4:** The clearOnCloseflag would only allow resetting of url loaded data.           |           |
|                |              |                                                                                                |           |
|                |              |**:**                                                                                           |           |
|                |              |**Dojo Toolkit 1.4 Notes:**                                                                     |           |
|                |              |                                                                                                |           |
|                |              |As of the Dojo Toolkit, version 1.4, this parameter works better.  This parameter now allows    |           |
|                |              |for clearing and resetting of both URL and data object provided content of a store instance.    |           |
|                |              |Please refer to the examples section for demonstration of usage. Please                         |           |
|                |              |note that when resetting 'data' for data object provided loads, you must use new instances of   |           |
|                |              |data objects.  Reusing an object from a previous store will cause failures.                     |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| urlPreventCache| No           |This boolean value controls whether dojo attempts to prevent the browser caching mechanism from | 1.2       |
|                |              |caching values loaded from a webserver. This parameter is especially useful when combined with  |           | 
|                |              |*clearOnClose* to force a data reload.                                                          |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| hierarchical   | No           |This boolean value controls whether or not the ItemFileReadStore will treat the data as         | 1.4       |
|                |              |hierarchical.  The default value is true for backwards compatibility.                           |           |
|                |              |                                                                                                |           |
|                |              |  Prior to dojo 1.4, ItemFileReadStore, when loading the initial data set, treated attributes   |           |
|                |              |  that are JavaScript objects as data store items and processed them accordingly.  As of Dojo   |           |
|                |              |  1.4 this function can be disabled by setting this to true in the constructor or on the store  |           |
|                |              |  before the first fetch.  Note that 'custom types' and 'references' are still processed.       |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
  


=================
Input Data Format
=================

While the data exposed from a data store is agnostic and consumable by many sources in an usually interchangable way, the input data formats of a data store may vary. The ItemFileReadStore expects a specific structure to its data, as defined below:

General Structure
-----------------

.. code-block :: javascript

  {
    "label": "some attribute",   //Optional attribute used to indicate which attribute on an item should act as a human-readable label for display purposes.


    "identifier": "some attribute",  //Optional attribute used to indicate which attribute on an item acts as a unique identifier for that item. If it is not defined, then the ItemFileReadStore will simply number the items and use that number as a unique index to the item.


    "items:" [  //The array of JavaScript objects that act as the root items of the data store
      { /* Some set of name/value attributes */ },
      { /* ... */ },
      ...
    ]
  }

Item Structure
--------------

To ItemFileReadStore, any JavaScript object is treated as an item. This includes any value of an attribute that is also a JavaScript object. This allows the format to be extremely flexible in what sort of data it can represent. 

Aside from regular, string, boolean, integer, object, etc, types that can be assigned as attribute values, there are special structures that when detected are treated differently from regular values. 

**References:**

The first is the the *_reference* structure. The *_reference* structure is a JavaScript Object with a single, special attribute of *_reference*. Its value should always be the identity of another item. With this structure, ItemFileReadStore can read in and set up relationships between items. An example of such a data structure is below:

.. code-block :: javascript

  {
    "identifier": "name",
    "items": [
      { "name": "Bob", "spouse": {"_reference":"Sally"),  "children": [ { "_reference":"Nancy"}]},
      { "name": "Sally", "spouse": {"_reference":"Bob"),  "children": [ { "_reference":"Nancy"}]},
      { "name": "Nancy"},           
    ]
  }

So, by calling store.getValue(bobItem, "spouse"), the return will be the datastore item identified by *Sally*.


**Custom Types:**

The other special structure is the custom type structure. The purpose of the custom type structure is a mechanism by which you can define JavaScript Objects that you do not which to be created and handled as a data store item. A good example of this is a JavaScript Date object. You likely do not wish it to be treated as another item, but as simply its JavaScript object. Another good example is the dojo.Color object. Again, it is unlikely you would wish this to be treated as a datastore item. So, ItemFileReadStore provides a mechanism by which these sort of objects can be represented in JSON and reconstructed back into their JavaScript equivalents. The custom type format is defined below:


.. code-block :: javascript

  {
    "items": [
      { "name": "Bob", "birthdate": { "_type": "Date", "_value": "1965-08-20T00:00:00Z"})
    ]
  }

When ItemFileReadStore parses that structure, it detects the JavaScript Object value for attribute *birthdate* has the special attributes *_type* and *_value*. what it then does with this is look into the type map of the store and determines if any deserializer has been defined for the value of *_type*. If it has, it takes the value of *_value*, and calls the deserializer function with it. The return of the deserializer will be a Date() object. 

=======================
Item Structure Examples
=======================

Items with References
---------------------

.. code-block :: javascript

  { 
    'identifier': 'name',
    'label': 'name',
    'items': [
      { 'name':'Africa', 'type':'continent',
        'children':[{'_reference':'Egypt'}, {'_reference':'Kenya'}, {'_reference':'Sudan'}] },
      { 'name':'Egypt', 'type':'country' },
      { 'name':'Kenya', 'type':'country',
        'children':[{'_reference':'Nairobi'}, {'_reference':'Mombasa'}] },
      { 'name':'Nairobi', 'type':'city' },
      { 'name':'Mombasa', 'type':'city' },
      { 'name':'Sudan', 'type':'country',
        'children':{'_reference':'Khartoum'} },
      { 'name':'Khartoum', type:'city' },
      { 'name':'Asia', 'type':'continent',
        'children':[{'_reference':'China'}, {'_reference':'India'}, {'_reference':'Russia'}, {'_reference':'Mongolia'}] },
      { 'name':'China', 'type':'country' },
      { 'name':'India', 'type':'country' },
      { 'name':'Russia', 'type':'country' },
      { 'name':'Mongolia', 'type':'country' },
      { 'name':'Australia', 'type':'continent', 'population':'21 million',
        'children':{'_reference':'Commonwealth of Australia'}},
      { 'name':'Commonwealth of Australia', 'type':'country', 'population':'21 million'},
      { 'name':'Europe', 'type':'continent',
        'children':[{'_reference':'Germany'}, {'_reference':'France'}, {'_reference':'Spain'}, {'_reference':'Italy'}] },
      { 'name':'Germany', 'type':'country' },
      { 'name':'France', 'type':'country' },
      { 'name':'Spain', 'type':'country' },
      { 'name':'Italy', 'type':'country' },
      { 'name':'North America', 'type':'continent',
        'children':[{'_reference':'Mexico'}, {'_reference':'Canada'}, {'_reference':'United States of America'}] },
      { 'name':'Mexico', 'type':'country', 'population':'108 million', 'area':'1,972,550 sq km',
        'children':[{'_reference':'Mexico City'}, {'_reference':'Guadalajara'}] },
      { 'name':'Mexico City', 'type':'city', 'population':'19 million', 'timezone':'-6 UTC'},
      { 'name':'Guadalajara', 'type':'city', 'population':'4 million', 'timezone':'-6 UTC' },
      { 'name':'Canada', 'type':'country',  'population':'33 million', 'area':'9,984,670 sq km',
        'children':[{'_reference':'Ottawa'}, {'_reference':'Toronto'}] },
      { 'name':'Ottawa', 'type':'city', 'population':'0.9 million', 'timezone':'-5 UTC'},
      { 'name':'Toronto', 'type':'city', 'population':'2.5 million', 'timezone':'-5 UTC' },
      { 'name':'United States of America', 'type':'country' },
      { 'name':'South America', 'type':'continent',
        'children':[{'_reference':'Brazil'}, {'_reference':'Argentina'}] },
      { 'name':'Brazil', 'type':'country', 'population':'186 million' },
      { 'name':'Argentina', 'type':'country', 'population':'40 million' }
    ]
  }    

Items with Hierarchy
--------------------

.. code-block :: javascript

  { 
    'identifier': 'name',
    'label': 'name',
    'items': [
      { 'name':'Africa', 'type':'continent', 'children':[
        { 'name':'Egypt', 'type':'country' }, 
        { 'name':'Kenya', 'type':'country', 'children':[
          { 'name':'Nairobi', 'type':'city' },
          { 'name':'Mombasa', 'type':'city' } ]
        },
        { 'name':'Sudan', 'type':'country', 'children':
          { 'name':'Khartoum', 'type':'city' } 
        } ]
      },
      { 'name':'Asia', 'type':'continent', 'children':[
        { 'name':'China', 'type':'country' },
        { 'name':'India', 'type':'country' },
        { 'name':'Russia', 'type':'country' },
        { 'name':'Mongolia', 'type':'country' } ]
      },
      { 'name':'Australia', 'type':'continent', 'population':'21 million', 'children':
        { 'name':'Commonwealth of Australia', 'type':'country', 'population':'21 million'}
      },
      { 'name':'Europe', 'type':'continent', 'children':[
        { 'name':'Germany', 'type':'country' },
        { 'name':'France', 'type':'country' },
        { 'name':'Spain', 'type':'country' },
        { 'name':'Italy', 'type':'country' } ]
      },
      { 'name':'North America', 'type':'continent', 'children':[
        { 'name':'Mexico', 'type':'country',  'population':'108 million', 'area':'1,972,550 sq km', 'children':[
          { 'name':'Mexico City', 'type':'city', 'population':'19 million', 'timezone':'-6 UTC'},
          { 'name':'Guadalajara', 'type':'city', 'population':'4 million', 'timezone':'-6 UTC' } ]
        },
        { 'name':'Canada', 'type':'country', 'population':'33 million', 'area':'9,984,670 sq km', 'children':[
          { 'name':'Ottawa', 'type':'city', 'population':'0.9 million', 'timezone':'-5 UTC'},
          { 'name':'Toronto', 'type':'city', 'population':'2.5 million', 'timezone':'-5 UTC' }]
        },
        { 'name':'United States of America', 'type':'country' } ]
      },
      { 'name':'South America', 'type':'continent', 'children':[
        { 'name':'Brazil', 'type':'country', 'population':'186 million' },
        { 'name':'Argentina', 'type':'country', 'population':'40 million' } ]
      } 
    ]
  }

Items with Custom Types
-----------------------

.. code-block :: javascript 

  {
    'identifier': 'abbr', 
    'label': 'name',
    'items': [
      { 'abbr':'ec', 'name':'Ecuador',           'capital':'Quito' },
      { 'abbr':'eg', 'name':'Egypt',             'capital':'Cairo' },
      { 'abbr':'sv', 'name':'El Salvador',       'capital':'San Salvador' },
      { 'abbr':'gq', 'name':'Equatorial Guinea', 'capital':'Malabo' },
      { 'abbr':'er',
        'name':'Eritrea',
        'capital':'Asmara',
        'independence':{'_type':'Date', '_value':"1993-05-24T00:00:00Z"} 
      },
      { 'abbr':'ee',
        'name':'Estonia',
        'capital':'Tallinn',
        'independence':{'_type':'Date', '_value':"1991-08-20T00:00:00Z"} 
      },
      { 'abbr':'et',
        'name':'Ethiopia',
        'capital':'Addis Ababa' }
    ]
  }

============
Custom Types
============

As mentioned in the Item Structure section, custom types are possible to create and use as values of attributes with this store. The caveat is, you have to tell the store, through a typeMap object, how to deserialize the cutom type value back into its object form. This is not as difficult as it first may sound. Below is the general structure information for creating a custom type map. There is a general format for all cases, and a compact format when the value can be directly used as a constructor argument.

**Note:** You can mix simplified form type maps with general case type maps in the same type map object. Therefore, you can use whatever is the easiest representation required to handle the custom object construction. 

**Note:** dojo.data.ItemFileReadStore implements a custom type map for JavaScript Date already. It uses the ISO-8601 serialization format for dates to keep it consistent with other date operations in dojo. If you wish to see how ItemFileReadStore defines it, refer to the source of dojo/data/ItemFileReadStore.js. The type mapping occurs in the constructor function.

General Case Type Map
---------------------
The general case type map handles the situation where some processing on the value of an attribute must occur before it can be converted back into its Object form. This often the case where a single value cannot be used as a constructor argument. 

**General Form Type Map**

.. code-block :: javascript

  {                
    "type0": {
	  "type": constructorFunction(), 
	  "deserialize": function(value) 
    },
    "type1": {
	  "type": constructorFunction(), 
	  "deserialize": function(value) 
    },
    "type2": {
	  "type": constructorFunction(), 
	  "deserialize": function(value) 
    },
    ...
    "typeN": {
      "type": constructorFunction(), 
      "deserialize": function(value) 
    }
  }

Example: General Case Type Map for JavaScript Date Objects
----------------------------------------------------------

.. code-block :: javascript 

  {
    "Date": {
      type: Date,
      deserialize: function(value){
        return dojo.date.stamp.fromISOString(value);
      }
    }
  }

Simplified Form Type Map
------------------------

The simplified form is more compact to write and works well when the value held by the custom type structure can be directly passed into a constructor to convert it back into its Object form. This often the case where a single value can be used as a constructor argument. 

**Simplified Form Type Map**

.. code-block :: javascript

  {                
    "type0": constructorFunction(),
    "type1": constructorFunction(),
    "type2": constructorFunction(),
    ...
    "typeN": constructorFunction()
  }

Example: Simplified Form Type Map for dojo.Color Objects
--------------------------------------------------------

.. code-block :: javascript 

  {
    "Color": dojo.Color
  }

Functional Example: Using custom type maps with ItemFileReadStore
-----------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.form.Button");

      var colorData = { identifier: 'name', 
        identifier:'name',
        items: [
          { name:'DojoRed', color:{_type:'Color', _value:'red'} },
          { name:'DojoGreen', color:{_type:'Color', _value:'green'} },
          { name:'DojoBlue', color:{_type:'Color', _value:'blue'} }
        ]
      };

      //This function performs some basic dojo initialization. In this case it connects the button
      //onClick to a function which invokes the fetch(). The fetch function queries for all items 
      //and provides callbacks to use for completion of data retrieval or reporting of errors.
      function init () {
        var colorStore = new dojo.data.ItemFileReadStore({data: colorData, typeMap: {'Color': dojo.Color}});
     
        //Function to perform a fetch on the datastore when a button is clicked
        function getItems () {
          //Callback to perform an action when the data items are starting to be returned:
          function clearOldList(size, request) {
            var list = dojo.byId("list");
            if (list) { 
              while (list.firstChild) {
                list.removeChild(list.firstChild);
              }
            }
          }
   
          //Callback for processing a single returned item.
          function gotItem(item, request) {
            var list = dojo.byId("list");
            if (list) {
              if (item) {
                var bold = document.createElement("b");
                bold.appendChild(document.createTextNode("Item Name: "));
                list.appendChild(bold);
                list.appendChild(document.createTextNode(colorStore.getValue(item, "name")));
                list.appendChild(document.createElement("br"));
                list.appendChild(document.createTextNode("Attribute color is of type: " + typeof colorStore.getValue(item, "color")));
                list.appendChild(document.createElement("br"));
                list.appendChild(document.createTextNode("Attribute color value is: " + colorStore.getValue(item, "color")));
                list.appendChild(document.createElement("br"));
                list.appendChild(document.createTextNode("Attribute color is instance of dojo.Color? " + (colorStore.getValue(item, "color") instanceof dojo.Color)));
                list.appendChild(document.createElement("br"));
                list.appendChild(document.createElement("br"));
              }
            }
          }
            
          //Callback for if the lookup fails.
          function fetchFailed(error, request) {
             console.log(error);
             alert("lookup failed.");
          }
             
          //Fetch the data. 
          colorStore.fetch({onBegin: clearOldList, onItem: gotItem, onError: fetchFailed});
        }

        //Link the click event of the button to driving the fetch.
        dojo.connect(button, "onClick", getItems);
      }
      //Set the init function to run when dojo loading and page parsing has completed.
      dojo.addOnLoad(init);
    </script>

  .. cv :: html 

    <div dojoType="dijit.form.Button" jsId="button">Click me to examine items and what the color attribute is!</div>
    <br>
    <br>
    <span id="list">
    </span>

==============
Custom Sorting
==============

ItemFileReadStore uses the dojo.data.util.sorter helper functions to implement item sorting. These functions provide a mechanism by which end users can customize how attributes are sorted. This is done by defining a *comparatorMap* on the store class. The comparator map maps an attribute name to some sorting function. The sorting function is expected to return 1, -1, or 0, base on whether the value for two items for the attribute was greater than, less than, or equal to, each other. An example of a custom sorter for attribute 'foo' is shown below:

.. code-block :: javascript

  var store = new dojo.data.ItemFileReadStore({data: { identifier: "uniqueId", 
    items: [ {uniqueId: 1, status:"CLOSED"},
      {uniqueId: 2,  status:"OPEN"}, 
	  {uniqueId: 3,  status:"PENDING"},
	  {uniqueId: 4,  status:"BLOCKED"},
	  {uniqueId: 5,  status:"CLOSED"},
	  {uniqueId: 6,  status:"OPEN"},
	  {uniqueId: 7,  status:"PENDING"},
	  {uniqueId: 8,  status:"PENDING"},
	  {uniqueId: 10, status:"BLOCKED"},
	  {uniqueId: 12, status:"BLOCKED"},
	  {uniqueId: 11, status:"OPEN"},
	  {uniqueId: 9,  status:"CLOSED"}
	]
  }});
		
  //Define the comparator function for status.
  store.comparatorMap = {};
  store.comparatorMap["status"] = function(a,b) { 
    var ret = 0;
    // We want to map these by what the priority of these items are, not by alphabetical.
    // So, custom comparator.
    var enumMap = { OPEN: 3, BLOCKED: 2, PENDING: 1, CLOSED: 0};
    if (enumMap[a] > enumMap[b]) {
      ret = 1;
    }
    if (enumMap[a] < enumMap[b]) {
      ret = -1;
    }
    return ret;
  };
		
  var sortAttributes = [{attribute: "status", descending: true}, { attribute: "uniqueId", descending: true}];
  function completed(items, findResult){
    for(var i = 0; i < items.length; i++){
      var value = store.getValue(items[i], "uniqueId");
      console.log("Item ID: [" + store.getValue(items[i], "uniqueId") + "] with status: [" + store.getValue(items[i], "status") + "]");
    }
  }
  function error(errData, request){
    console.log("Failed in sorting data.");
  }

  //Invoke the fetch.
  store.fetch({onComplete: completed, onError: error, sort: sortAttributes});

============
Query Syntax
============

The fetch method query syntax for ItemFileReadStore is simple and straightforward. It allows a list of attributes to match against in an AND fashion. For example, a query object to locate all items with attribute foo that has value bar and attribute bit that has value bite, would look like

.. code-block :: javascript

  { foo:"bar", bit:"bite"}

Okay, easy. Now what if I want to do a fuzzy match of items?  Can this be done?   Yes. ItemFileReadStore supports wildcard matching. Specifically, it supports multi-character * and single character ? as wildcards in attribute value queries.

**NOTE:**  As of The dojo Toolkit 1.4, a RegularExpression object can also be passed as a query on an attribute.  This is not dojo.data.api specified, but a feature specific to ItemFileReadStore.   Do not expect other stores to implement it.  Some may, some may not.  Always refer to their documentation on their query syntax.

.. code-block :: javascript

  { foo:new RegExp("/^bar$/"), bit:/^bite$/}

==============
Query Examples
==============

Match items with multi-character wildcard
-----------------------------------------

*Matching attribute foo that has a value starting with bar*

.. code-block :: javascript

  { foo:"bar*"}


Match items with single character wildcard
------------------------------------------

*Matching attribute foo the value of which ends with ar and starts with any character.*


.. code-block :: javascript

  { foo:"?ar"}


Match items on multiple attributes
----------------------------------

*Matching multiple attributes with various wildcards.*


.. code-block :: javascript

  { foo:"?ar", bar:"bob", bit:"*it*"}


=============
Query Options
=============

Dojo.data defines support for a 'queryOptions' modifier object that affects the behavior of the query. The two defined options listed by the API are *ignoreCase* and *deep*. ItemFileReadStore supports these options. The affect of these options on a query is defined below.

+------------+------------------------------------------------------------------------------------------------------------------------+
| **Option** | **Result**                                                                                                             |
+------------+------------------------------------------------------------------------------------------------------------------------+
| ignoreCase |The default is **false**. When set to true, the match on attributes is done in a case-insensitive fashion. This means   |
|            |with ignoreCase: true, a query of A* would match *Apple* and *acorn*                                                    |
+------------+------------------------------------------------------------------------------------------------------------------------+
| deep       |This option affects searching when the structure passed to ItemFileReadStore has hierarchy. For an example of that,     |
|            |refer to *Item Structure Example: Items with Hierarchy*. the default value for this option is **false**, which means the|
|            |query is only applied against root items in the tree of data items. If it is set to true, then the query is applied to  |
|            |root items and *all* child data items. Think of it as a recursive search.                                               |
+------------+------------------------------------------------------------------------------------------------------------------------+


==============
Usage Examples
==============

Connecting ItemFileReadStore to ComboBox
----------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.form.ComboBox");

      var storeData2 =   { identifier: 'abbr', 
        label: 'name',
        items: [
          { abbr:'ec', name:'Ecuador',           capital:'Quito' },
          { abbr:'eg', name:'Egypt',             capital:'Cairo' },
          { abbr:'sv', name:'El Salvador',       capital:'San Salvador' },
          { abbr:'gq', name:'Equatorial Guinea', capital:'Malabo' },
          { abbr:'er', name:'Eritrea',           capital:'Asmara' },
          { abbr:'ee', name:'Estonia',           capital:'Tallinn' },
          { abbr:'et', name:'Ethiopia',          capital:'Addis Ababa' }
      ]}
    </script>

  .. cv :: html 

    <div dojoType="dojo.data.ItemFileReadStore" data="storeData2" jsId="countryStore"></div>
    <div dojoType="dijit.form.ComboBox" store="countryStore" searchAttr="name"></div>

Searching for all continents
----------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.form.Button");

      var geoData = { 
        'identifier': 'name',
        'label': 'name',
        'items': [
          { 'name':'Africa', 'type':'continent', children:[
            { 'name':'Egypt', 'type':'country' }, 
            { 'name':'Kenya', 'type':'country', children:[
              { 'name':'Nairobi', 'type':'city' },
              { 'name':'Mombasa', 'type':'city' } ]
            },
            { 'name':'Sudan', 'type':'country', 'children':
              { 'name':'Khartoum', 'type':'city' } 
            } ]
          },
          { 'name':'Asia', 'type':'continent', 'children':[
            { 'name':'China', 'type':'country' },
            { 'name':'India', 'type':'country' },
            { 'name':'Russia', 'type':'country' },
            { 'name':'Mongolia', 'type':'country' } ]
          },
          { 'name':'Australia', 'type':'continent', 'population':'21 million', 'children':
            { 'name':'Commonwealth of Australia', 'type':'country', 'population':'21 million'}
          },
          { 'name':'Europe', 'type':'continent', 'children':[
            { 'name':'Germany', 'type':'country' },
            { 'name':'France', 'type':'country' },
            { 'name':'Spain', 'type':'country' },
            { 'name':'Italy', 'type':'country' } ]
          },
          { 'name':'North America', 'type':'continent', 'children':[
            { 'name':'Mexico', 'type':'country',  'population':'108 million', 'area':'1,972,550 sq km', 'children':[
              { 'name':'Mexico City', 'type':'city', 'population':'19 million', 'timezone':'-6 UTC'},
              { 'name':'Guadalajara', 'type':'city', 'population':'4 million', 'timezone':'-6 UTC' } ]
            },
            { 'name':'Canada', 'type':'country', 'population':'33 million', 'area':'9,984,670 sq km', 'children':[
              { 'name':'Ottawa', 'type':'city', 'population':'0.9 million', 'timezone':'-5 UTC'},
              { 'name':'Toronto', 'type':'city', 'population':'2.5 million', 'timezone':'-5 UTC' }]
            },
            { 'name':'United States of America', 'type':'country' } ]
          },
          { 'name':'South America', 'type':'continent', children:[
            { 'name':'Brazil', 'type':'country', 'population':'186 million' },
            { 'name':'Argentina', 'type':'country', 'population':'40 million' } ]
          } 
        ]
      }    

      //This function performs some basic dojo initialization. In this case it connects the button
      //onClick to a function which invokes the fetch(). The fetch function queries for all items 
      //and provides callbacks to use for completion of data retrieval or reporting of errors.
      function init2 () {
        //Function to perform a fetch on the datastore when a button is clicked
        function getContinents () {

          //Callback to perform an action when the data items are starting to be returned:
          function clearOldCList(size, request) {
            var list = dojo.byId("list2");
            if (list) { 
              while (list.firstChild) {
                list.removeChild(list.firstChild);
              }
            }
          }
  
          //Callback for processing a returned list of items.
          function gotContinents(items, request) {
            var list = dojo.byId("list2");
            if (list) { 
              var i;
              for (i = 0; i < items.length; i++) {
                var item = items[i];
                list.appendChild(document.createTextNode(geoStore.getValue(item, "name")));
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
          geoStore.fetch({query: { type: "continent"}, onBegin: clearOldCList, onComplete: gotContinents, onError: fetchFailed, queryOptions: {deep:true}});
        }
        //Link the click event of the button to driving the fetch.
        dojo.connect(button2, "onClick", getContinents );
      }
      //Set the init function to run when dojo loading and page parsing has completed.
      dojo.addOnLoad(init2);
    </script>

  .. cv :: html 

    <div dojoType="dojo.data.ItemFileReadStore" data="geoData" jsId="geoStore"></div>
    <div dojoType="dijit.form.Button" jsId="button2">Find continents!</div>
    <br>
    <br>
    <span id="list2">
    </span>

Doing wildcard searches and option setting
------------------------------------------

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
    <b>Query used: </b><span id="query"></span
    <br>
    <br>
    <b>Query Options used: </b><span id="queryOptions"></span
    <br>
    <br>
    <b>Items located:</b>
    <br>
    <span id="list3">
    </span>

Demonstrating custom sorting
----------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.form.Button");

      var sortData = { identifier: "uniqueId", 
        items: [ {uniqueId: 1, status:"CLOSED"},
          {uniqueId: 2,  status:"OPEN"}, 
	  {uniqueId: 3,  status:"PENDING"},
	  {uniqueId: 4,  status:"BLOCKED"},
	  {uniqueId: 5,  status:"CLOSED"},
	  {uniqueId: 6,  status:"OPEN"},
	  {uniqueId: 7,  status:"PENDING"},
	  {uniqueId: 8,  status:"PENDING"},
	  {uniqueId: 10, status:"BLOCKED"},
	  {uniqueId: 12, status:"BLOCKED"},
	  {uniqueId: 11, status:"OPEN"},
	  {uniqueId: 9,  status:"CLOSED"}
	]
      };

      //This function performs some basic dojo initialization. In this case it connects the button
      //onClick to a function which invokes the fetch(). The fetch function queries for all items 
      //and provides callbacks to use for completion of data retrieval or reporting of errors.
      function init4 () {
        //Define the comparator function for status.
        sortStore.comparatorMap = {};
        sortStore.comparatorMap["status"] = function(a,b) { 
          var ret = 0;
          // We want to map these by what the priority of these items are, not by alphabetical.
          // So, custom comparator.
          var enumMap = { OPEN: 3, BLOCKED: 2, PENDING: 1, CLOSED: 0};
          if (enumMap[a] > enumMap[b]) {
            ret = 1;
          }
          if (enumMap[a] < enumMap[b]) {
            ret = -1;
          }
          return ret;
        };
		
        //Function to perform a fetch on the datastore when a button is clicked
        function getItems () {

          //Callback to perform an action when the data items are starting to be returned:
          function clearOldCList(size, request) {
            var list = dojo.byId("list4");
            if (list) { 
              while (list.firstChild) {
                list.removeChild(list.firstChild);
              }
            }
          }
  
          //Callback for processing a returned list of items.
          function gotItems(items, request) {
            var list = dojo.byId("list4");
            if (list) { 
              var i;
              for (i = 0; i < items.length; i++) {
                var item = items[i];
                list.appendChild(document.createTextNode("Item ID: [" + sortStore.getValue(items[i], "uniqueId") + "] with status: [" + sortStore.getValue(items[i], "status") + "]"));
                list.appendChild(document.createElement("br"));
              }
            }
          }
            
          //Callback for if the lookup fails.
          function fetchFailed(error, request) {
            alert("lookup failed.");
            alert(error);
          }

          var sortAttributes = [{attribute: "status", descending: true}, { attribute: "uniqueId", descending: true}];
          //Fetch the data.
          sortStore.fetch({query: {}, onBegin: clearOldCList, onComplete: gotItems, onError: fetchFailed, queryOptions: {deep:true}, sort: sortAttributes});
        }
        //Link the click event of the button to driving the fetch.
        dojo.connect(button4, "onClick", getItems );
      }
      //Set the init function to run when dojo loading and page parsing has completed.
      dojo.addOnLoad(init4);
    </script>

  .. cv :: html 

    <div dojoType="dojo.data.ItemFileReadStore" data="sortData" jsId="sortStore"></div>
    <div dojoType="dijit.form.Button" jsId="button4">Custom sort!</div>
    <br>
    <br>
    <span id="list4">
    </span>


Reloading/Refreshing ItemFileReadStore from a 'data' object (Dojo Toolkit 1.4+)
-------------------------------------------------------------------------------
*Note that you must set data to a new object.  Reusing a data object that had already been processed by the datastore will cause errors.*

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4
  
  .. javascript::

    <script>
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.form.ComboBox");
      dojo.require("dijit.form.Button");

      var storeData10 =   { identifier: 'abbr', 
        label: 'name',
        items: [
          { abbr:'ec', name:'Ecuador',           capital:'Quito' },
          { abbr:'eg', name:'Egypt',             capital:'Cairo' },
          { abbr:'sv', name:'El Salvador',       capital:'San Salvador' },
          { abbr:'gq', name:'Equatorial Guinea', capital:'Malabo' },
          { abbr:'er', name:'Eritrea',           capital:'Asmara' },
          { abbr:'ee', name:'Estonia',           capital:'Tallinn' },
          { abbr:'et', name:'Ethiopia',          capital:'Addis Ababa' }
      ]};

      //Simple global so we can show how many times the data gets reset.
      var reloadCount = 0;

      //Now set up a linkage so that the store can be reloaded.
      dojo.addOnLoad(function() {
         dojo.connect(dijit.byId("reloadButton1"), "onClick", function() {
            reloadCount++;
            reloadableStore1.clearOnClose = true;
            reloadableStore1.data = {identifier: 'abbr', 
              label: 'name',
              items: [
                { abbr:'ec', name:'Ecuador RELOADED: ' + reloadCount,           capital:'Quito' },
                { abbr:'eg', name:'Egypt RELOADED: ' + reloadCount,             capital:'Cairo' },
                { abbr:'sv', name:'El Salvador RELOADED: ' + reloadCount,       capital:'San Salvador' },
                { abbr:'gq', name:'Equatorial Guinea RELOADED: ' + reloadCount, capital:'Malabo' },
                { abbr:'er', name:'Eritrea RELOADED: ' + reloadCount,           capital:'Asmara' },
                { abbr:'ee', name:'Estonia RELOADED: ' + reloadCount,           capital:'Tallinn' },
                { abbr:'et', name:'Ethiopia RELOADED: ' + reloadCount,          capital:'Addis Ababa' }
            ]};
            reloadableStore1.close();
         });
      });
    </script>

  .. html::

    <div dojoType="dojo.data.ItemFileReadStore" data="storeData10" jsId="reloadableStore1"></div>
    <div dojoType="dijit.form.ComboBox" store="reloadableStore1" searchAttr="name"></div>
    <div id="reloadButton1" dojoType="dijit.form.Button">Reload DataStore</div>

Reloading/Refreshing ItemFileReadStore from a url (Dojo Toolkit 1.4+)
---------------------------------------------------------------------
*Note that you can see the data reload after clicking the button then activating the dropdown in Firebug or if you are viewing the demo through a proxy that shows requests made.*

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4

  .. javascript::

    <script>
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.form.ComboBox");
      dojo.require("dijit.form.Button");

      //Now set up a linkage so that the store can be reloaded.
      dojo.addOnLoad(function() {
         dojo.connect(dijit.byId("reloadButton2"), "onClick", function() {
            //Reset the url and call close.  Note this could be a different JSON file, but for this example, just 
            //Showing how you would set the URL.
            reloadableStore2.url = "{{dataUrl}}/dojox/data/tests/stores/countries.json"; 
            reloadableStore2.close();
         });
      });
    </script>

  .. html::

    <div dojoType="dojo.data.ItemFileReadStore" url="{{dataUrl}}/dojox/data/tests/stores/countries.json" jsId="reloadableStore2" urlPreventCache="true" clearOnClose="true"></div>
    <div dojoType="dijit.form.ComboBox" store="reloadableStore2" searchAttr="name"></div>
    <div id="reloadButton2" dojoType="dijit.form.Button">Reload DataStore</div>


========
See Also
========

* `Refeshing an ItemFileReadStore <http://dojocampus.org/content/2009/01/31/refeshing-an-itemfilereadstore>`_ - 2009-01-31 - How do you clear out the existing Data in a store, and populate it with new Data in Dojo 1.2?
* Consider `dojox.data.AndOrReadStore <dojox/data/AndOrReadStore>`_ if you want an ItemFileReadStore with better querying capabilities, but don't want to use an entirely different flavour of store.
