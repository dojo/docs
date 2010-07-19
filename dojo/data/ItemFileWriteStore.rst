#format dojo_rst

dojo.data.ItemFileWriteStore
============================

:Status: Contributed, Draft
:Version: 1.2
:Author: Jared Jurkiewicz
:Available: since V1.0

.. contents::
  :depth: 2

Dojo core provides the ItemFileWriteStore store as an extension to ItemFileReadStore that adds on the dojo.data.api.Write and dojo.data.api.Notification API support to ItemFileReadStore. It was specifically created as a separate class so that if you only need read capability, you do not incur the download penalty of the write and notification API support if you won't use it. If your application needs to write to the ItemFileStore instead of just Read, then ItemFileWriteStore is the store you should instantiate. The input data format is identical to `ItemFileReadStore <dojo/data/ItemFileReadStore>`_.


===========
API Support
===========

* `dojo.data.api.Read <dojo/data/api/Read>`_
* `dojo.data.api.Write <dojo/data/api/Write>`_
* `dojo.data.api.Identity <dojo/data/api/Identity>`_
* `dojo.data.api.Notification <dojo/data/api/Notification>`_

======================
Constructor Parameters
======================

The constructor for ItemFileWriteStore takes the same parameters as `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_ 

============
Custom Types
============

As with dojo.data.ItemFileReadStore, the ItemFileWriteStore supports using custom defined types in the data format. Since ItemFileWriteStore supports mechanisms for serializing the store contents back out, the custom type support has been extended to allow for custom serializers so that the complex types can be converted back into their necessary encodings.


Custom Type Examples
--------------------

By default, ItemFileWriteStore has registered a custom type handler for JavaScript Date objects. It uses the general case formatting option for the value, as shown below:

.. code-block :: javascript

  {
    "Date": {
      type: Date,
      deserialize: function (value) {
        return dojo.date.stamp.fromISOString(value);
      },
      serialize: function(obj) {
        return dojo.date.stamp.toISOString(obj, {zulu:true});
      }
    }
  
So, when Date objects are encountered, ItemFileWriteStore automatically serializes it out as a custom type of the following format:

.. code-block :: javascript

  { "_type":"Date", "value":"1993-05-24T00:00:00Z" }

============
Query Syntax
============

The query syntax for ItemFileWriteStore is identical to the query syntax of ItemFileReadStore so see that `section <dojo/data/ItemFileReadStore>`_  for more information.

=============
The Write API
=============

The write API implementation conforms to the dojo.data specification for Write. Ultimately, the best way to think about it is that you use functions *newItem*, *deleteItem*, *setValue(s)*, and *unsetAttribute* to modify contents of the store. These changes can be undone all in one function call by calling the store *revert* function, or they can be committed and made unreversable by the *save* function. Think of it as semi-transactional.

newItem(), deleteItem, save() and identities
--------------------------------------------

Care must be taken when defining an attribute that acts as an identifier for ItemFileWriteStore.  By defining it, you are in control of ensuring it remains unique.  This particularly matters with newItem and deleteItem.  ItemFileWriteStore uses the identifier to track changes.  This means that even if you delete an item, the identity of that item remains reserved and 'in use'.  So, if you go call newItem() and try to reuse the identifier you will get an exception.  The way to clear this issue and reuse the identifier is to commit your changes by calling save().  Save will apply all current changes and clear any pending state, including reserved identifiers. 

The reason this does not occur when you do not specify an identifier is that the store is auto-creating them for you and it makes sure they always remain unique.  In the auto-create case, the identifier isn't even exposed as a public attribute (there is no way to get it via a getValue call, only getIdentity can do it).  So by 're-inserting an item, all you effectively do is create an entirely new item with a new identity, and since it has a new identity, there is no collision.


The Behavior of the save() API
------------------------------

Since this store implements the dojo.data.api.Write feature, it must implement the *save* function. Since this is an in-memory data store, what exactly does *save* do when called?  By default, it only does three things:

* Clear out the record of all changed, deleted, and new items so that isDirty() will return false.
* Commit the changes to the internal main tree of items.
* Call any callbacks passed to the save function.

Okay, so it effectively removed the ability to revert out a set of changes. In other words, it acts like a commit. That's great, bit all of it just happens in the browser. What if I want to send data back to a server when save is called for persistence?  Can this be done?  The answer is **yes**. There are several ways to accomplish this. The first would be to simply replace the store *save* function with a different one to do whatever you want. However, that one ends up requiring knowing a lot about how things are stored internally, which is not always good to know about. So, ItemFileWriteStore provides hook functions for users to over-ride to customize saving behavior without having to replace the *save* function. This allows for you to define exactly what else you want the store to do with saved data results without having to know as much about internal representations:  The functions you can over-ride are defined below:


Save function Extension point: _saveEverything
----------------------------------------------

The *_saveEverything* function should be defined on your store when all you want to do is get text content of the internal state back into a JSONable string so it can be sent serverside. Effectively think of it as a way to get a JSON string back similar to the one you used to load the store. The callbacks are the same callbacks you normally pass to the *save* function of the store.

.. code-block :: javascript

  _saveEverything: function(saveCompleteCallback /*Your callback to call when save is completed */, 
                            saveFailedCallback /*Your callback to call if save fails*/, 
                            newFileContentString /*The generated JSON data to send somewhere*/)


Save function Extension point: _saveCustom
------------------------------------------

The *_saveCustom* function should be defined on your store when you want to control exactly how everything gets serialized back (be it in JSON, XML, or whatnot). The function signature is simple, it just takes the callbacks passed to the *save* API on the store. Your implementation should introspect through the store's information, generate the save format your service desires, then send it and call the callbacks on whether it succeeds or not. The *_saveCustom* function should be declared on the store as follows:

.. code-block :: javascript

  _saveCustom: function(saveCompleteCallback /*Your callback to call when save is completed */, 
                        saveFailedCallback /*Your callback to call if save fails*/)
  

The Behavior of the revert() API
--------------------------------

The revert API is intended to undo changes made through calls to *newItem*, *deleteItem*, and *setValue(s)*. What it effectively does is return the pristine data item states into the internal data array storing all the items for modified and deleted items. For new items it removes them from the internal data array.

  **Note:**  Revert does **not** generate Notification events in reverse order for every change it undoes. To detect revert changes to react accordingly, you should *dojo.connect* to the revert function on the store.


Referential Integrity
---------------------

As of dojo 1.1, dojo.data.ItemFileWriteStore Write actions are reference aware. This means that if you delete an item that is referenced by other items, then those other items are also updated to remove those references. This will also generate Notification events when it occurs.

To put it more simply, say you have Item C which is referenced by Items A and B. If you delete Item C, a deleteItem event occurs, then two onSet notifications will occur; one for Item A and one for Item B, indicating that the attribute that referenced Item C was modified because Item C was deleted.


====================
The Notification API
====================

ItemFileWriteStore supports dojo.data.api.Notification. This means that every action through *newItem*, *setValue(s)*, *unsetAttribute*, and *deleteItem* will generate events to indicate these actions. These events are functions on the store that widgets and user code can *dojo.connect* to. This allows for pages to be very dynamic in that a change from one widget in a data store can be detected and reacted to in another. For more details on Notification in general, please refer to the `Notification section <dojo/data/api/Notification>`_ of the dojo.data API.

===================
Pseudocode Examples
===================

For these examples, we'll assume a datasource as defined by the following example data:

.. code-block :: javascript

  { identifier: 'abbr',
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


Add in a new country
--------------------

.. code-block :: javascript

  var store = new dojo.data.ItemFileWriteStore({url: "countries.json"});
  var usa = store.newItem({abbr: 'us', name: 'United States of America', capital: 'Washington DC'});

  function saveDone(){
    alert("Done saving.");
  }  
  function saveFailed(){
    alert("Save failed.");
  }
  store.save({onComplete: saveDone, onError: saveFailed});


Delete a country
----------------

.. code-block :: javascript

  var store = new dojo.data.ItemFileWriteStore({url: "countries.json"});

  function saveDone(){
    alert("Done saving.");
  } 
  function saveFailed(){
    alert("Save failed.");
  }
  var gotNames= function(items, request){
    for (var i = 0; i < items.length; i++){
      console.log("Deleted country: " + store.getLabel(item);
      store.deleteItem(items[i]);
    }
    store.save({onComplete: saveDone, onError: saveFailed});  
  }
  var request = store.fetch({query: {name:"Egypt"}, queryOptions: {ignoreCase: true}, onComplete: gotNames}


===================
Functional Examples
===================

ItemFileWriteStore changes reflected in dojox.data.DataGrid
-----------------------------------------------------------

The following is a semi-complex example of the write API in action. In this example, there is a number spinner, a button, and the DataGrid. You use the number spinner to select a value. Then by pressing the button, a query to ItemFileWriteStore is made. The results of that query are iterated over and *setValue* is called on each item to modify its population attribute (or add it if it did not exist). The DataGrid is used to display results. Since the DataGrid is dojo.data.Notification aware, it binds to the DataStore and listens for change events on items. If an item is updated, then the grid automatically reflects it in its display. In this example, changing the population for all items should result in all rows showing a change in the population column when the button is pressed.

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojo.data.ItemFileWriteStore");
      dojo.require("dijit.form.Button");
      dojo.require("dijit.form.NumberSpinner");
      dojo.require("dijit.form.TextBox");
      dojo.require("dojox.grid.DataGrid");

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
      };    

      var layoutGeo = [
        [
          { field: "name", name: "Name", width: 10 },
          { field: "type", name: "Geography Type", width: 10 },
          { field: "population", name: "Population", width: 'auto' }
        ]
      ];

      //This function performs some basic dojo initialization. In this case it connects the button
      //onClick to a function which invokes the fetch(). The fetch function queries for all items 
      //and provides callbacks to use for completion of data retrieval or reporting of errors.
      function init2 () {
        //Function to perform a fetch on the datastore when a button is clicked
        function updateAll() {

           //Callback for processing a returned list of items.
          function gotAll(items, request) {
            var value = spinner.getValue();
            if ( value >= 0 ) { 
              var i;
              for (i = 0; i < items.length; i++) {
                var item = items[i];
                geoStore.setValue(item, "population", value);
              }
            }
          }
            
          //Callback for if the lookup fails.
          function fetchFailed(error, request) {
            alert("lookup failed.");
            alert(error);
          }
             
          //Fetch the data.
          geoStore.fetch({query: {}, onComplete: gotAll, onError: fetchFailed, queryOptions: {deep:true}});
        }
        //Link the click event of the button to driving the fetch.
        dojo.connect(button2, "onClick", updateAll);
      }
      //Set the init function to run when dojo loading and page parsing has completed.
      dojo.addOnLoad(init2);
    </script>

  .. cv :: html 

    <div dojoType="dojo.data.ItemFileWriteStore" data="geoData" jsId="geoStore"></div>
    <b>Set the population to assign to all items</b>
    <br>
    <br>
    <div dojoType="dijit.form.NumberSpinner" jsId="spinner" value="10000"></div>
    <br>
    <br>
    <div dojoType="dijit.form.Button" jsId="button2">Update all geography items populations!</div>
    <br>
    <br>
    <div id="grid"  
      style="width: 400px; height: 300px;"
      dojoType="dojox.grid.DataGrid" 
      store="geoStore" 
      structure="layoutGeo" 
      query="{}"
      queryOptions="{'deep':true}" 
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


ItemFileWriteStore deletions reflected in dijit.Tree
----------------------------------------------------

This example demonstrates how to use a function such as *deleteItem*. In this case dijit.Tree is used to show a hierarchy of items. By pressing the delete button, all items that are of type city are deleted. Since the tree is dojo.data.api.Notification aware, it catches the delete event and updates its rendering accordingly.

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.Tree");
      var storeData2 = { 
        identifier: 'name',
        label: 'name',
        items: [
          { name:'Africa', type:'continent', children:[
            { name:'Egypt', type:'country' }, 
            { name:'Kenya', type:'country', children:[
            { name:'Nairobi', type:'city' },
            { name:'Mombasa', type:'city' } ]
            },
            { name:'Sudan', type:'country', children:
              { name:'Khartoum', type:'city' } 
            } ]
          },
          { name:'Asia', type:'continent', children:[
            { name:'China', type:'country' },
            { name:'India', type:'country' },
            { name:'Russia', type:'country' },
            { name:'Mongolia', type:'country' } ]
          },
          { name:'Australia', type:'continent', population:'21 million', children:
            { name:'Commonwealth of Australia', type:'country', population:'21 million'}
          },
          { name:'Europe', type:'continent', children:[
            { name:'Germany', type:'country' },
            { name:'France', type:'country' },
            { name:'Spain', type:'country' },
            { name:'Italy', type:'country' } ]
          },
          { name:'North America', type:'continent', children:[
            { name:'Mexico', type:'country',  population:'108 million', area:'1,972,550 sq km', children:[
              { name:'Mexico City', type:'city', population:'19 million', timezone:'-6 UTC'},
              { name:'Guadalajara', type:'city', population:'4 million', timezone:'-6 UTC' } ]
            },
            { name:'Canada', type:'country',  population:'33 million', area:'9,984,670 sq km', children:[
              { name:'Ottawa', type:'city', population:'0.9 million', timezone:'-5 UTC'},
              { name:'Toronto', type:'city', population:'2.5 million', timezone:'-5 UTC' }]
            },
            { name:'United States of America', type:'country' } ]
          },
          { name:'South America', type:'continent', children:[
            { name:'Brazil', type:'country', population:'186 million' },
            { name:'Argentina', type:'country', population:'40 million' } ]
          } 
        ]
      };

      function init() {
        function deleteCities() {
          function gotCities(items, request) {
            if (items ) {
              var i;
              for (i = 0; i < items.length; i++) {
                var item = items[i];
                geographyStore2.deleteItem(item);
              }
            }
          }
          geographyStore2.fetch({query:{type: "city"}, onComplete: gotCities, queryOptions: {deep:true}});
        }
        dojo.connect(button3, "onClick", deleteCities);
      }
      dojo.addOnLoad(init);
    </script>

  .. cv :: html 

    <div dojoType="dojo.data.ItemFileWriteStore" data="storeData2" jsId="geographyStore2"></div>
    <b>Before pressing delete, be sure to expand out the tree so you can see nodes (items), being removed from it.</b>
    <br>
    <div dojoType="dijit.form.Button" jsId="button3">Delete All Cities!</div>
    <br>
    <br>
    <div dojoType="dijit.tree.ForestStoreModel" jsId="geographyModel2" store="geographyStore2" query="{type: 'continent'}" rootId="Geography" rootLabel="Geography"></div>
    <div dojoType="dijit.Tree" model="geographyModel2"></div>

ItemFileWriteStore changes reflected in dojox.data.DataGrid (with _saveCustom)
------------------------------------------------------------------------------

The following is a semi-complex example of the write API in action. In this example, there is a number spinner, a button, and the DataGrid. You use the number spinner to select a value. Then by pressing the button, a query to ItemFileWriteStore is made. The results of that query are iterated over and *setValue* is called on each item to modify its population attribute (or add it if it did not exist). The DataGrid is used to display results. Since the DataGrid is dojo.data.Notification aware, it binds to the DataStore and listens for change events on items. If an item is updated, then the grid automatically reflects it in its display. In this example, changing the population for all items should result in all rows showing a change in the population column when the button is pressed.  In addition, save() is called on the store, which in turn invokes a custom save handler.  This custom save handler generated a serialized view of the changes to send back to some location.  This view
is displayed in an alert.

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojo.data.ItemFileWriteStore");
      dojo.require("dijit.form.Button");
      dojo.require("dijit.form.NumberSpinner");
      dojo.require("dijit.form.TextBox");
      dojo.require("dojox.grid.DataGrid");

      var geoData2 = { 
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
      };    

      var layoutGeo2 = [
        [
          { field: "name", name: "Name", width: 10 },
          { field: "type", name: "Geography Type", width: 10 },
          { field: "population", name: "Population", width: 'auto' }
        ]
      ];

      //This function performs some basic dojo initialization. In this case it connects the button
      //onClick to a function which invokes the fetch(). The fetch function queries for all items 
      //and provides callbacks to use for completion of data retrieval or reporting of errors.
      function init3 () {

        var itemToJS = function(store, item) {
          // summary: Function to convert an item into a simple JS object.
          // store:
          //    The datastore the item came from.
          // item:
          //    The item in question.
          var js = {};
          if (item && store) {
            //Determine the attributes we need to process.
            var attributes = store.getAttributes(item);
            if (attributes && attributes.length > 0) {
              var i;
              for (i = 0; i < attributes.length; i++) {
                var values = store.getValues(item, attributes[i]);
                if (values) {
                  //Handle multivalued and single-valued attributes.
                  if (values.length > 1 ) {
                    var j;
                    js[attributes[i]] = [];
                    for (j = 0; j < values.length; j++ ) {
                      var value = values[j];
                      //Check that the value isn't another item. If it is, process it as an item.
                      if (store.isItem(value)) {
                        js[attributes[i]].push(itemToJS(store, value));
                      } else {
                        js[attributes[i]].push(value);
                      }
                    }
                  } else {
                    if (store.isItem(values[0])) {
                      js[attributes[i]] = itemToJS(store, values[0]);
                    } else {
                      js[attributes[i]] = values[0];
                    }
                  }
                }
              }
            }
          }
          return js;
        };

        geoStore2._saveCustom = function(saveComplete, saveFailed) {
           //  summary:  
           //    This is a custom save function for the geoStore to allow emitting only the modified items as
           //    a block of JSON text.
           var changeSet  = geoStore2._pending;
           var changes = {};
           changes.modified = [];
           for (var i in changeSet._modifiedItems) {
              //Use the identity to look up the current version of the item from the store's array
              //Can't use the object IN the modified items array because it is the saved state before modification.
              var item = null;
              //Find the modified item, it can be in one of two places to look up
              //Either by an explicit identity if it was specified, or by its index.
              if (geoStore2._itemsByIdentity) {
                 item = geoStore2._itemsByIdentity[i]; 
              } else {
                 item = geoStore2._arrayOfAllItems[i];
              }
              changes.modified.push(itemToJS(geoStore2, item));
           }
           alert(dojo.toJson(changes, true));
           saveComplete();
        };


        //Function to perform a fetch on the datastore when a button is clicked
        function updateAll() {

           //Callback for processing a returned list of items.
          function gotAll(items, request) {
            var value = spinner2.getValue();
            if ( value >= 0 ) { 
              var i;
              for (i = 0; i < items.length; i++) {
                var item = items[i];
                geoStore2.setValue(item, "population", value);
              }
            }
          }
            
          //Callback for if the lookup fails.
          function fetchFailed(error, request) {
            alert("lookup failed.");
            alert(error);
          }
             
          //Fetch the data.
          geoStore2.fetch({query: {type:"city"}, onComplete: gotAll, onError: fetchFailed, queryOptions: {deep:true}});
        }
        //Link the click event of the button to driving the fetch.
        dojo.connect(button3, "onClick", updateAll);
        dojo.connect(button3, "onClick", geoStore2, "save");
      }
      //Set the init function to run when dojo loading and page parsing has completed.
      dojo.addOnLoad(init3);
    </script>

  .. cv :: html 

    <div dojoType="dojo.data.ItemFileWriteStore" data="geoData2" jsId="geoStore2"></div>
    <b>Set the population to assign to all items of type city</b>
    <br>
    <br>
    <div dojoType="dijit.form.NumberSpinner" jsId="spinner2" value="10000"></div>
    <br>
    <br>
    <div dojoType="dijit.form.Button" jsId="button3">Update all geography items of type city with a new population!</div>
    <br>
    <br>
    <div id="grid2"   
      style="width: 400px; height: 300px;"
      dojoType="dojox.grid.DataGrid" 
      store="geoStore2" 
      structure="layoutGeo2" 
      query="{}"
      queryOptions="{'deep':true}" 
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
