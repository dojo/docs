.. _dojox/data/AndOrReadStore:

==========================
dojox.data.AndOrReadStore
==========================

:Author: Frank Fortson
:Since: 1.2

.. contents ::
  :depth: 3

dojox.data.AndOrReadStore is a clone of dojo.data.ItemFileReadStore. The only significant difference is that it supports more complex queries than the simple AND format property matching. Specifically, it can perform AND and ORing, and NOT. For general functions, data format, and information refer to :ref:`dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`.

Supported APIs
==============

The following dojo.data APIs are implemented by AndOrReadStore

* :ref:`dojo.data.api.Read <dojo/data/api/Read>`
* :ref:`dojo.data.api.Identity <dojo/data/api/Identity>`

Query Syntax
============
AndOrReadStore supports all the same query capability as dojo.data.ItemFileReadStore as well as several others that allow for more complicated queries. In specific, it allows for chaining of ANDs, ORs, and NOTs for attributes (along with wildcards), for a much more flexible structure.

**Supported Operators:**
  
  , NOT AND OR ( ) ! && ||  Note: "," included for legacy queries (translated to AND).

Example queries
===============

String Query
------------

::
  
  ...
  store.fetch({query: "NOT id:23* AND (type:'test*' OR dept:'bob') && !filed:true", onComplete: doSomething}
  ...

Object-Based Query
------------------

::
  
  ...
  store.fetch({query: {complexQuery:"NOT id:23* AND (type:'test*' OR dept:'bob') && !filed:true"}, onComplete: doSomething}
  ...


Functional Examples
===================

Finding all Continents and Cities
---------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dojox.data.AndOrReadStore");
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
      };

      // This function performs some basic dojo initialization. In this case it connects the button
      // onClick to a function which invokes the fetch(). The fetch function queries for all items
      // and provides callbacks to use for completion of data retrieval or reporting of errors.
      // Set the init function to run when dojo loading and page parsing has completed.
      dojo.ready(function(){
        // Function to perform a fetch on the datastore when a button is clicked
        function getItems(){

          // Callback to perform an action when the data items are starting to be returned:
          function clearOldCList(size, request){
            var list = dojo.byId("list2");
            if(list){
              while(list.firstChild){
                list.removeChild(list.firstChild);
              }
            }
          }
  
          // Callback for processing a returned list of items.
          function gotItems(items, request){
            var list = dojo.byId("list2");
            if(list){
              var i;
              for(i = 0; i < items.length; i++){
                var item = items[i];
                list.appendChild(document.createTextNode(geoStore.getValue(item, "name")));
                list.appendChild(document.createElement("br"));
              }
            }
          }
            
          // Callback for if the lookup fails.
          function fetchFailed(error, request){
            alert("lookup failed.");
            alert(error);
          }
             
          // Fetch the data.
          geoStore.fetch({query: { complexQuery: "type:\"continent\" OR type:\"city\""}, onBegin: clearOldCList, onComplete: gotItems, onError: fetchFailed, queryOptions: {deep:true}});
        }
        // Link the click event of the button to driving the fetch.
        dojo.connect(button2, "onClick", getItems );
      });

  .. html ::

    <div data-dojo-type="dojox.data.AndOrReadStore" data-dojo-props="data:geoData" data-dojo-id="geoStore"></div>
    <div data-dojo-type="dijit.form.Button" data-dojo-id="button2">Find continents!</div>
    <br>
    <br>
    <b>List of all Continents and Cities</b>
    <br>
    <span id="list2">
    </span>
