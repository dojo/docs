#format dojo_rst

Hierarchical data and access through dojo.data
==============================================

.. contents::
  :depth: 3

=================
Hierarchical data
=================

One of the design goals of dojo.data was to handle the concept of hierarchical items.  What that means is that an item may have references to, or contain, other items.  The end result when viewed graphically is a Tree instead of a flat list.  So, this leads to the questions of how do you determine if there is hierarchy and how do you walk across it.  This is, in fact, quite easy to do using dojo.data.ItemFileReadStore as it supports data in hierarchical structure.

Lets take a look at an example hierarchy built up with references in dojo.data.ItemFileReadStore.  Please take note that the example information on constructing a structure that shows hierarchy is specific to dojo.data.ItemFileReadStore.  The concepts of how you then walk over the hierarchy is what is general and generic to dojo.data.  The internal format used by a store is not.

**Example data structure for ItemFileReadStore:**

.. code-block :: javascript

  { identifier: 'name',
    label: 'name',
    items: [
      { name:'Africa', type:'continent',
        children:[{_reference:'Egypt'}, {_reference:'Kenya'}, {_reference:'Sudan'}] },
      { name:'Egypt', type:'country' },
      { name:'Kenya', type:'country',
        children:[{_reference:'Nairobi'}, {_reference:'Mombasa'}] },
      { name:'Nairobi', type:'city' },
      { name:'Mombasa', type:'city' },
      { name:'Sudan', type:'country',
        children:{_reference:'Khartoum'} },
      { name:'Khartoum', type:'city' },
      { name:'Asia', type:'continent',
        children:[{_reference:'China'}, {_reference:'India'}, {_reference:'Russia'}, {_reference:'Mongolia'}] },
      { name:'China', type:'country' },
      { name:'India', type:'country' },
      { name:'Russia', type:'country' },
      { name:'Mongolia', type:'country' },
      { name:'Australia', type:'continent', population:'21 million',
        children:{_reference:'Commonwealth of Australia'}},
      { name:'Commonwealth of Australia', type:'country', population:'21 million'},
      { name:'Europe', type:'continent',
        children:[{_reference:'Germany'}, {_reference:'France'}, {_reference:'Spain'}, {_reference:'Italy'}] },
      { name:'Germany', type:'country' },
      { name:'France', type:'country' },
      { name:'Spain', type:'country' },
      { name:'Italy', type:'country' },
      { name:'North America', type:'continent',
        children:[{_reference:'Mexico'}, {_reference:'Canada'}, {_reference:'United States of America'}] },
      { name:'Mexico', type:'country',  population:'108 million', area:'1,972,550 sq km',
        children:[{_reference:'Mexico City'}, {_reference:'Guadalajara'}] },
      { name:'Mexico City', type:'city', population:'19 million', timezone:'-6 UTC'},
      { name:'Guadalajara', type:'city', population:'4 million', timezone:'-6 UTC' },
      { name:'Canada', type:'country',  population:'33 million', area:'9,984,670 sq km',
        children:[{_reference:'Ottawa'}, {_reference:'Toronto'}] },
      { name:'Ottawa', type:'city', population:'0.9 million', timezone:'-5 UTC'},
      { name:'Toronto', type:'city', population:'2.5 million', timezone:'-5 UTC' },
      { name:'United States of America', type:'country' },
      { name:'South America', type:'continent',
        children:[{_reference:'Brazil'}, {_reference:'Argentina'}] },
      { name:'Brazil', type:'country', population:'186 million' },
      { name:'Argentina', type:'country', population:'40 million' }
  ]}

There are two things to notice about the above structure.  The first is that yes, it is still a flat list of data items to feed to dojo.data.ItemFileReadStore.  But, as you can see, there is a special attribute, *_reference* that is used to point to another item in the list.  These references, when processed by ItemFileReadStore, will establish the relationships in the data.  This means that when you call store.getValues(item, children), the array returned is an array of the actual items pointed to.  So, if you then try to visualize it, you can see how the Tree of hierarchy is formed from the references.  Below is an example of using dijit.Tree with the above dataset to construct and display a tree.

==========================
Hierarchical data examples
==========================

Functional Example 1:  dijit.Tree displaying hierarchical data in a data store
------------------------------------------------------------------------------

**Note:** *The tree model selects root nodes via a query attribute.  This query attribute is directly passed to the data store as part of the fetch made to generate the list of root items.*

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.Tree");
      var storeData = { identifier: 'name',
        label: 'name',
        items: [
          { name:'Africa', type:'continent',
            children:[{_reference:'Egypt'}, {_reference:'Kenya'}, {_reference:'Sudan'}] },
          { name:'Egypt', type:'country' },
          { name:'Kenya', type:'country',
            children:[{_reference:'Nairobi'}, {_reference:'Mombasa'}] },
          { name:'Nairobi', type:'city' },
          { name:'Mombasa', type:'city' },
          { name:'Sudan', type:'country',
            children:{_reference:'Khartoum'} },
          { name:'Khartoum', type:'city' },
          { name:'Asia', type:'continent',
            children:[{_reference:'China'}, {_reference:'India'}, {_reference:'Russia'}, {_reference:'Mongolia'}] },
          { name:'China', type:'country' },
          { name:'India', type:'country' },
          { name:'Russia', type:'country' },
          { name:'Mongolia', type:'country' },
          { name:'Australia', type:'continent', population:'21 million',
            children:{_reference:'Commonwealth of Australia'}},
          { name:'Commonwealth of Australia', type:'country', population:'21 million'},
          { name:'Europe', type:'continent',
            children:[{_reference:'Germany'}, {_reference:'France'}, {_reference:'Spain'}, {_reference:'Italy'}] },
          { name:'Germany', type:'country' },
          { name:'France', type:'country' },
          { name:'Spain', type:'country' },
          { name:'Italy', type:'country' },
          { name:'North America', type:'continent',
            children:[{_reference:'Mexico'}, {_reference:'Canada'}, {_reference:'United States of America'}] },
          { name:'Mexico', type:'country',  population:'108 million', area:'1,972,550 sq km',
            children:[{_reference:'Mexico City'}, {_reference:'Guadalajara'}] },
          { name:'Mexico City', type:'city', population:'19 million', timezone:'-6 UTC'},
          { name:'Guadalajara', type:'city', population:'4 million', timezone:'-6 UTC' },
          { name:'Canada', type:'country',  population:'33 million', area:'9,984,670 sq km',
            children:[{_reference:'Ottawa'}, {_reference:'Toronto'}] },
          { name:'Ottawa', type:'city', population:'0.9 million', timezone:'-5 UTC'},
          { name:'Toronto', type:'city', population:'2.5 million', timezone:'-5 UTC' },
          { name:'United States of America', type:'country' },
          { name:'South America', type:'continent',
            children:[{_reference:'Brazil'}, {_reference:'Argentina'}] },
          { name:'Brazil', type:'country', population:'186 million' },
          { name:'Argentina', type:'country', population:'40 million' }
      ]};
    </script>

  .. cv :: html 

    <div dojoType="dojo.data.ItemFileReadStore" data="storeData" jsId="geographyStore"></div>
    <div dojoType="dijit.tree.ForestStoreModel" jsId="geographyModel" store="geographyStore" query="{type: 'continent'}" rootId="Geography" rootLabel="Geography"></div>
    <div dojoType="dijit.Tree" model="geographyModel"></div>



Okay, hopefully the above example helped visually display how nested items are represented.  Nested items are no more than an attribute in a datastore item that has a value that is another data store item.  There is nothing more to it than that, ultimately.  If the above example was too confusing since the hierarchy was constructed through references ... another way to demonstrate hierarchy of items can be presented with dojo.data.ItemFileReadStore.  The ItemFileReadStore also supports a basic hierarchical format instead of item references.  

Example 2:  A hierarchical format without references
----------------------------------------------------

.. code-block :: javascript

  { identifier: 'name',
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
  }

Functional Example 2:  dijit.Tree displaying hierarchical data in a data store
------------------------------------------------------------------------------

**Note:** *The tree model selects root nodes via a query attribute.  This query attribute is directly passed to the data store as part of the fetch made to generate the list of root items.*

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
    </script>

  .. cv :: html 

    <div dojoType="dojo.data.ItemFileReadStore" data="storeData2" jsId="geographyStore2"></div>
    <div dojoType="dijit.tree.ForestStoreModel" jsId="geographyModel2" store="geographyStore2" query="{type: 'continent'}" rootId="Geography" rootLabel="Geography"></div>
    <div dojoType="dijit.Tree" model="geographyModel2"></div>

Okay, great!  Two examples showing examples of hierarchical structures using one datastore, dojo.data.ItemFileReadStore.  But, it doesn't immediately answer how you use the dojo.data APIs to walk this.  How you do it is simple, it just uses isItem() to detect if an attribute value is also considered a data item by the store.   So ... code that would walk over an item and identify sub items would look like:

Sample code:  Detecting child items
-----------------------------------

.. code-block :: javascript

  var store = new dojo.data.ItemFileReadStore({url: "countries.json"});

  //Load completed function for walking across the attributes and child items of the
  //located items.
  var gotContinents = function(items, request){
    //Cycle over all the matches.
    for(var i = 0; i < items.length; i++){
      var item = items[i];

      //Cycle over all the attributes.
      var attributes = store.getAttributes(item);
      for (var j = 0; j < attributes.length; j++){
        //Assume all attributes are multi-valued and loop over the values ...
        var values = store.getValues(item, attributes[j]);
        for(var k = 0; k < values.length; k++){
          var value = values[k];
                
          if(store.isItem(value)){
            console.log("Located a child item with label: [" + store.getLabel(value) + "]");
          }else{
            console.log("Attribute: [" + attributes[j] + "] has value: [" + value + "]");
          }
        }           
      }
    }
  }
  //Call the fetch of the toplevel continent items.
  store.fetch({query: {type: "continent"}, onComplete: gotContinents});

============
Lazy-Loading
============

Okay, detecting if items contain child items looks simple; one function call to isItem().  But ... doesn't dojo.data also support lazy-loading of items to keep from having to pull down data that may never be used?  Yes, it does.  This is done through using two more functions to perform tests to see if an item is completely inflated or not, *isItemLoaded(item)* and *loadItem(keywordargs)*.  These functions provide methods for loading items that are currently only stubs and not fully inflated.  So if we wish to make the **Sample One**, what would it look like?  See below for an example:

Sample code:  Detecting child items and lazy-loading items on demand
--------------------------------------------------------------------

.. code-block :: javascript

  var store = new dojo.data.ItemFileReadStore({url: "countries.json"});

  //Load completed function for walking across the attributes and child items of the
  //located items.
  var gotContinents = function(items, request){
    //Cycle over all the matches.
    for(var i = 0; i < items.length; i++){
      var item = items[i];

      //Cycle over all the attributes.
      var attributes = store.getAttributes(item);
      for (var j = 0; j < attributes.length; j++){
        //Assume all attributes are multi-valued and loop over the values ...
        var values = store.getValues(item, attributes[j]);
        for(var k = 0; k < values.length; k++){
          var value = values[k];
                
          if(store.isItem(value)){
            //Test to see if the items data is fully loaded or needs to be demand-loaded in (the item in question is just a stub).
            if(store.isItemLoaded(value)){
              console.log("Located a child item with label: [" + store.getLabel(value) + "]");
            }else{
              //Asynchronously load in the child item using the stub data to get the real data.
              var lazyLoadComplete = function(item){
                console.log("Lazy-Load of item complete.  Located child item with label: [" + store.getLabel(item) + "]");
              }
              store.loadItem({item: value, onItem: lazyLoadComplete});
            }
          }else{
            console.log("Attribute: [" + attributes[j] + "] has value: [" + value + "]");
          }
        }           
      }
    }
  }
  //Call the fetch of the toplevel continent items.
  store.fetch({query: {type: "continent"}, onComplete: gotContinents});

Excellent, that looks simple too.  Something to be aware of is that not all datastores support hierarchical data formats and not all support lazy-loading.  For those stores, no attribute value should return true for *isItem()* and *isItemLoaded(item)* always returns true.  So, code that is hierarchical and lazy-load aware will still work fine with those stores.  

Are there examples of Lazy-Loading stores in dojo?  Yes, there is.  A great example can be found at: `dojox.data.FileStore <dojox/data/FileStore>`_ .  The FileStore is designed to expose a remote file system in a lazy-load manner.  The code of the FileStore is also a great template for starting developers who want to develop their own lazy-loading data stores.
