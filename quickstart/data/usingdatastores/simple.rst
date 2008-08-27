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

The easiest data store is a static one, so let's begin with that. The file in the following example has the /pantry_spices.json URL:
