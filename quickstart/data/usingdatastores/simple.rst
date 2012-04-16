.. _quickstart/data/usingdatastores/simple:

====================
A Simple Data Source
====================

.. contents ::
  :depth: 3

A data source is what the name implies, a source that provides data to something. In the case of a data store, a data source is where the data store obtains its data. A data source can be a database, a REST service, or even a JSON file. For introductory purposes, we will look at the most simple data source available, a javascript object.

Examples
========

Example data
------------

For the following examples, the defined JavaScript will be used. Note that it has a defined structure which is used by the dojo.data.ItemFileReadStore. Be aware that dojo.data does not require this format for every datastore; this is simply the format expected by dojo.data.ItemFileReadStore.

.. js ::

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


In the following examples:

* The data source is the above JavaScript object
* Each item is a country, and each item has three attributes: name, abbr, and capital.
* The abbr attribute is an identifier. Each country has a different abbr for unique look up.

This is a simple, but powerful, way to represent data in the browser. It can also be quickly converted to a text format called `JavaScript Object Notation (JSON) <http://www.json.org>`_. The JSON format can be stored as files on your server and loaded via xhr calls. dojo.data.ItemFileReadStore allows for the data to be defined in browser as an object such as above, or from a JSON file of the same format.

The following examples show how a datastore can be used to load the data shown above and how widgets that are dojo.data aware can make use of it to display it easily.

Connecting dijit.form.ComboBox
------------------------------

.. code-example ::
 :djConfig: async: true, parseOnLoad: true
  
  .. js ::

        require(["dojo/store/Memory", "dijit/form/ComboBox", "dojo/parser"], function () {
            storeData =  [
                { abbr:'ec', name:'Ecuador',           capital:'Quito' },
                { abbr:'eg', name:'Egypt',             capital:'Cairo' },
                { abbr:'sv', name:'El Salvador',       capital:'San Salvador' },
                { abbr:'gq', name:'Equatorial Guinea', capital:'Malabo' },
                { abbr:'er', name:'Eritrea',           capital:'Asmara' },
                { abbr:'ee', name:'Estonia',           capital:'Tallinn' },
                { abbr:'et', name:'Ethiopia',          capital:'Addis Ababa' }
            ];
        });

  .. html ::

    <div data-dojo-type="dojo/store/Memory" data-dojo-props="data:storeData, idProperty:'abbr'" data-dojo-id="countryStore"></div>
    <div data-dojo-type="dijit/form/ComboBox" data-dojo-props="store:countryStore, searchAttr:'name'"></div>


Connecting dijit.Tree
---------------------

.. code-example ::
 :djConfig: async: true, parseOnLoad: true
  
  .. js ::

        require(["dojo/store/Memory", "dijit/tree/ObjectStoreModel", "dijit/Tree", "dojo/parser"], function () {
            storeData =  [
                { abbr:'world', name: 'Countries' },
                { abbr:'ec', name:'Ecuador',           capital:'Quito', parent: 'world' },
                { abbr:'eg', name:'Egypt',             capital:'Cairo', parent: 'world' },
                { abbr:'sv', name:'El Salvador',       capital:'San Salvador', parent: 'world' },
                { abbr:'gq', name:'Equatorial Guinea', capital:'Malabo', parent: 'world' },
                { abbr:'er', name:'Eritrea',           capital:'Asmara', parent: 'world' },
                { abbr:'ee', name:'Estonia',           capital:'Tallinn', parent: 'world' },
                { abbr:'et', name:'Ethiopia',          capital:'Addis Ababa', parent: 'world' }
            ];
        });


  .. html ::

     <div data-dojo-type="dojo/store/Memory" data-dojo-props="data:storeData, idProperty:'abbr'" data-dojo-id="countryStore">
     <script type="dojo/method" data-dojo-event="getChildren" data-dojo-args="object">
         // Supply a getChildren() method to store for the data model where
         // children objects point to their parent (aka relational model)
         return this.query({parent: object.abbr});
    </script>
        
    </div>

    <!-- Create the model bridging the store and the Tree -->
    <div data-dojo-type="dijit/tree/ObjectStoreModel" data-dojo-id="countryModel"
        data-dojo-props="store: countryStore, query: {'abbr':'world'}"></div>

    <!-- Create the tree -->
    <div data-dojo-type="dijit/Tree" id="myTree" data-dojo-props="model: countryModel"></div>

Connecting dijit.form.FilteringSelect
-------------------------------------

.. code-example ::
 :djConfig: async: true, parseOnLoad: true
  
  .. js ::

        require(["dojo/store/Memory", "dijit/form/FilteringSelect", "dojo/parser"], function () {
            storeData =  [
                { abbr:'ec', name:'Ecuador',           capital:'Quito' },
                { abbr:'eg', name:'Egypt',             capital:'Cairo' },
                { abbr:'sv', name:'El Salvador',       capital:'San Salvador' },
                { abbr:'gq', name:'Equatorial Guinea', capital:'Malabo' },
                { abbr:'er', name:'Eritrea',           capital:'Asmara' },
                { abbr:'ee', name:'Estonia',           capital:'Tallinn' },
                { abbr:'et', name:'Ethiopia',          capital:'Addis Ababa' }
            ];
        });


  .. html ::

    <div data-dojo-type="dojo/store/Memory" data-dojo-props="data:storeData, idProperty:'abbr'" data-dojo-id="countryStore"></div>
    <div data-dojo-type="dijit/form/FilteringSelect" data-dojo-props="store:countryStore, searchAttr:'name'"></div>


Connecting dojox.grid.DataGrid
------------------------------

.. code-example ::
 :djConfig: async: true, parseOnLoad: true
  
  .. js ::

        require(["dojo/store/Memory", "dojo/data/ObjectStore", "dojox/grid/DataGrid", "dojo/parser"], function () {
            layoutCountries = [[
                { field: "abbr", name: "Abbreviation", width: 10 },
                { field: "name", name: "Name", width: 10 },
                { field: "capital", name: "Capital", width: 'auto' }
            ]];

            storeData =  [
                { abbr:'ec', name:'Ecuador',           capital:'Quito' },
                { abbr:'eg', name:'Egypt',             capital:'Cairo' },
                { abbr:'sv', name:'El Salvador',       capital:'San Salvador' },
                { abbr:'gq', name:'Equatorial Guinea', capital:'Malabo' },
                { abbr:'er', name:'Eritrea',           capital:'Asmara'  },
                { abbr:'ee', name:'Estonia',           capital:'Tallinn' },
                { abbr:'et', name:'Ethiopia',          capital:'Addis Ababa' }
            ];
        });

  .. html ::

    <div style="width: 400px; height: 300px;">
          <div data-dojo-type="dojo.store.Memory" data-dojo-props="data:storeData, idProperty:'abbr'" data-dojo-id="countryStore">
          </div>

          <!-- Create the model bridging the store and the Tree -->
          <div data-dojo-type="dojo.data.ObjectStore" data-dojo-id="countryStoreForGrid"
              data-dojo-props="objectStore: countryStore"></div>

          <div id="grid"
              data-dojo-type="dojox/grid/DataGrid"
              data-dojo-props="store:countryStoreForGrid,
              structure:'layoutCountries',
              queryOptions:{deep:true},
              query:{},
              rowsPerPage:40">
          </div>
    </div>

  .. css ::

      @import "{{baseUrl}}dojox/grid/resources/Grid.css";
      @import "{{baseUrl}}dojox/grid/resources/claroGrid.css";

      .dojoxGrid table {
        margin: 0;
      }
