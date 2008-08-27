#format dojo_rst

**A Simple Data Source**
========================

A data source is what the name imples, a source that provides data to something.  In the case of a data store, a data source is where the data store obtains its data.  A data source can be a database, a REST service, to even a JSON file.  For introductory purposes, we will look at the most simple data source available, a javascript object.

For the following examples, the defined JavaScript will be used.  Note that it has a defined structure which is used by the dojo.data.ItemFileReadStore.  Be aware that dojo.data does not require this format for every datastore; this is simply the format expected by dojo.data.ItemFileReadStore.

**Example data:**

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


**In this example:**

* The data source is the above javascript object
* Each item is a country, and each item has three attributes, name,abbr, and capital.
* The abbr attribute is an identifier. Each country has a different abbr to prevent confusion.

This is a simple, but powerful, way to represent data in the browser.  It can also be quickly converted to a test format called `JavaScript Object Notation (JSON) <http://www.json.org>`_.  The JSON format can be stored as files on your server and loaded via xhr calls.  dojo.data.ItemFileReadStore allows for the data to be defined in browser as an object such as above, or from a JSON file of the same format.  


Below is a simple example of how a datastore can be used to load data and how widgets that are dojo.data aware can make use of it to display it with no changes to the widgets.

** Example 1:  Connecting dijit.form.ComboBox to the above data:**

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



** Example 2:  Connecting dijit.Tree to the above data:**

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

    
