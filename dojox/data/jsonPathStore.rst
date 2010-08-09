#format dojo_rst

dojox.data.jsonPathStore
========================

:Status: Contributed, Draft
:Version: 1.2
:Authors: Dustin Machi
:Developers: Dustin Machi
:Available: V1.0 to 1.3, Removed in 1.4

.. contents::
   :depth: 2

Note: This API was removed for the Dojo 1.4 release. http://svn.dojotoolkit.org/dojoc/dmachi/data/ contains a JsonStore that is the most suitable replacement for this in Dojo 1.4 and 1.5.

A local (in memory) store which can attach a dojo.data interface to each JavaScript object and uses jsonPath as the query language. It takes an arbitrary JavaScript object as its data structure and attaches to this data structure to present a dojo.data.api interface. Each JavaScript object in the store is an Item in dojo.data parlance.

============
Introduction
============

JsonPathStore is intended to allow any Object data structure to easily be accessed and controlled by various widgets. It uses `JsonPath </dojox/JsonPath`_ as a query language. It is a very lightweight server, yet it is flexible enough to allow you to define a single store maintaining several unrelated data sets in a single store. Furthermore, it implements a synchronous mode which makes manipulation of the store possible when appropriate for an application.


==============
Supported APIs
==============

* `dojo.data.api.Read <dojo/data/api/Read>`_
* `dojo.data.api.Identity <dojo/data/api/Identity>`_
* `dojo.data.api.Write <dojo/data/api/Write>`_
* `dojo.data.api.Notification <dojo/data/api/Notification>`_

* release also includes experimental synchronous API.

  All async features remain the same, but since data is local, custom widgets and code can take advantage of these features while still allowing other normal widgets async access. See the mode property in the constructor parameters

Additional methods
------------------

In addition to the the standard store api, the store provides a few additional methods of note:

* setData(data)

  Set the store's data to the supplied object and then load or setup that data with the required meta info.

* cleanMeta(data)

  Recurse through the provided data object and remove any meta information that has attached. This method also removes any IDs that were auto generated. IDs provided to the store will not be touched.

* dump(options)

  Takes a options keyword parameter accepting clone, cleanMeata, and suppressExportMeta Boolean options and an export type option that takes "raw" or "json" as the parameters.

Two addtional notification events are also triggered in this store, onSave() and onRevert() which will each be called after their respective
events have completed.


=====
Usage
=====

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
    var store = new dojox.data.jsonPathStore({url: "/stores/store.js"});
  </script>

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
    var store = new dojox.data.jsonPathStore({data: {
         fruits: [
              {id: 1, type: apple}, 
              {id: 2, type: orange}
         ], 
         vegetables: [
              {id: 3, type: "brocolli"}
         ]
     });
  </script>


Constructor Parameters
----------------------

The jsonPathStore takes a single optional parameter in the form of a javascript object containing one or more of the following properties:

data
  JSON String or Javascript Object
  JSON String or Javascript object this store will control JSON is converted into an object, and an object passed to the store will be used directly. If no data and no url is provide, an empty object, {}, will be used as the initial store.

url - string   
  Load data from this url in JSON format and use the Object created from the data as the data source.

indexOnLoad - Boolean 
  Parse the data object and set individual objects up as appropriate. This will add meta data and assign id's to objects that dont' have them as defined by the idAttribute option. Disabling this option will keep this parsing from happening until a query is performed at which time only the top level of an item has meta info stored. This might work in some situations, but you will almost always want to indexOnLoad or use another option which will create an index. Defaults to true.

idAttribute - string
  Defaults to '_id'. The name of the attribute that holds an objects id. This can be a preexisting id provided by the server. If an ID isn't already provided when an object is fetched or added to the store, the autoIdentity system will generate an id for it and add it to the index. There are utility routines for exporting data from the store that can clean any generated IDs before exporting and leave preexisting id's in tact.

metaLabel - string 
  Defaults to '_meta' overrides the attribute name that is used by the store for attaching meta information to an object while in the store's control. Defaults to '_meta'.

hideMetaAttributes - Boolean 
  Defaults to False. When enabled, calls to getAttributes() will not include the meta attribute.

autoIdPrefix: string
  Defaults to "_auto_". This string is used as the prefix to any objects which have a generated id. A numeric index is appended to this string to complete the ID
                        
mode: dojox.data.ASYNC_MODE || dojox.data.SYNC_MODE
  Defaults to ASYNC_MODE. This option sets the default mode for this store.
  Sync calls return their data immediately from the calling function instead of calling the callback functions. Functions such as fetchItemByIdentity() and fetch() both accept a string parameter in addition to the normal keywordArgs parameter. When passed this option, SYNC_MODE will automatically be used even when the default mode of the system is ASYNC_MODE. A normal request to fetch or fetchItemByIdentity (with kwArgs object) can also include a mode property to override this setting for that one request.


========
Examples
========

Programmatic example
--------------------

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
    var store = new dojox.data.jsonPathStore({data: {
         fruits: [
              {id: 1, type: apple}, 
              {id: 2, type: orange}
         ], 
         vegetables: [
              {id: 3, type: "brocolli"}
         ]
     });
  </script>

Declarative example
-------------------
.. code-block :: javascript
  :linenos:

  <div jsId="store" dojoType="dojox.data.jsonPathStore" url="/path/to/store.js"></div>
