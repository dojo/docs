#format dojo_rst

A Simple Data Source
====================

.. contents::
  :depth: 3

A data source is what the name implies, a source that provides data to something. In the case of a data store, a data source is where the data store obtains its data. A data source can be a database, a REST service, or even a JSON file. For introductory purposes, we will look at the most simple data source available, a javascript object.

========
Examples
========

Example data
------------

For the following examples, the defined JavaScript will be used. Note that it has a defined structure which is used by the dojo.data.ItemFileReadStore. Be aware that dojo.data does not require this format for every datastore; this is simply the format expected by dojo.data.ItemFileReadStore.

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


In the following examples:

* The data source is the above javascript object
* Each item is a country, and each item has three attributes, name,abbr, and capital.
* The abbr attribute is an identifier. Each country has a different abbr for unique look up.

This is a simple, but powerful, way to represent data in the browser. It can also be quickly converted to a text format called `JavaScript Object Notation (JSON) <http://www.json.org>`_. The JSON format can be stored as files on your server and loaded via xhr calls. dojo.data.ItemFileReadStore allows for the data to be defined in browser as an object such as above, or from a JSON file of the same format. 

The following examples show how a datastore can be used to load the data shown above and how widgets that are dojo.data aware can make use of it to display it easily.

Connecting dijit.form.ComboBox
------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.form.ComboBox");

      var storeData =   { identifier: 'abbr', 
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

    <div dojoType="dojo.data.ItemFileReadStore" data="storeData" jsId="countryStore"></div>
    <div dojoType="dijit.form.ComboBox" store="countryStore" searchAttr="name"></div>


Connecting dijit.Tree
---------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.Tree");

      var storeData =   { identifier: 'abbr', 
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

    <div dojoType="dojo.data.ItemFileReadStore" data="storeData" jsId="countryStore"></div>
    <div dojoType="dijit.tree.ForestStoreModel" jsId="countryModel" store="countryStore" query="{}" rootId="Countries" rootLabel="Countries"></div>
    <div dojoType="dijit.Tree" model="countryModel"></div>

    
Connecting dijit.form.FilteringSelect
-------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.form.FilteringSelect");

      var storeData =   { identifier: 'abbr', 
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

    <div dojoType="dojo.data.ItemFileReadStore" data="storeData" jsId="countryStore"></div>
    <div dojoType="dijit.form.FilteringSelect" store="countryStore" searchAttr="name"></div>


Connecting dojox.grid.DataGrid
------------------------------

.. cv-compound ::

  .. cv :: javascript

    <script>
      dojo.require("dojox.grid.DataGrid");
      dojo.require("dojo.data.ItemFileReadStore");
      var layoutCountries = [
        [
          { field: "abbr", name: "Abbeviation", width: 10 },
          { field: "name", name: "Name", width: 10 },
          { field: "capital", name: "Capital", width: 'auto' }
        ]
      ];

      var storeData =   { identifier: 'abbr', 
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

    <div style="width: 400px; height: 300px;">
      <div dojoType="dojo.data.ItemFileReadStore" jsId="countryStoreForGrid" data="storeData"></div>
      <div id="grid" 
        dojoType="dojox.grid.DataGrid" 
        store="countryStoreForGrid" 
        structure="layoutCountries" 
        queryOptions="{deep:true}"
        query="{}" 
        rowsPerPage="40">
      </div>
    </div>

  .. cv:: css

    <style type="text/css">
      @import "{{baseUrl}}dojox/grid/resources/Grid.css";
      @import "{{baseUrl}}dojox/grid/resources/claroGrid.css";

      .dojoxGrid table {
        margin: 0;
      }
    </style>
