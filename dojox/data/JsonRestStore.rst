#format dojo_rst

dojox.data.JsonRestStore
========================

:Status: Draft
:Version: 1.0
:Authors: Kris Zyp
:Developers: Bryan Forbes, Kris Zyp
:Available: since V1.2

.. contents::
    :depth: 3

**dojox.data.JsonRestStore** is a lightweight datastore implementation of a RESTful client.


============
Introduction
============

JsonRestStore provides full read, write, and notification capabilities through standards based HTTP/REST interaction with the server using GET, PUT, POST, and DELETE commands. 

JsonRestStore supports JSON Referencing so objects can contain cyclic, multiple, cross-message, cross-table, and even cross-site references, which can be used for `lazy loading <quickstart/data/usingdatastores/lazyloading>`_. These references are automatically resolved such that properties are accessed as normal datastore attributes. 

JsonRestStore also store objects in a format to ease direct property access for significant performance advantages. 


========
Features
========

1. The datastore implement the following dojo.data APIs:  

   - `dojo.data.api.Read <dojo/data/api/Read>`_, 
   - `dojo.data.api.Identity <dojo/data/api/Identity>`_, 
   - `dojo.data.api.Write <dojo/data/api/Write>`_, 
   - `dojo.data.api.Notification <dojo/data/api/Notification>`_.

2. Client/server interaction follows the HTTP specification for RESTful interaction, using standard HTTP verbs and headers to handle updates, paging, and id assignment.

3. Full JSON Referencing capabilities. Create circular references, multiples references, reference objects from other tables, and even references objects from other domains

4. Flexible modular design allows for easy extension and customization. Multiple subclasses in Dojo already use JsonRestStore, including `CouchDBRestStore <dojox/data/CouchDBRestStore>`_, `PersevereStore <dojox/data/PersevereStore>`_, and `S3Store <dojox/data/S3Store>`_. Custom queries can easily be generated.

5. Integrates with the `dojox.rpc.Service <dojox/rpc/Service>`_ system, any service can be customized to be a REST service for the system.

6. Integrates with `dojox.rpc.OfflineRest <dojox/rpc/OfflineRest>`_ for automatic offline usage. Application built JsonRestStore can almost instantaneously be made offline.

7. Integrates with the RestChannels Comet module to support server sent notifications of data changes. The data store automatically routes these updates as data notifications to widgets.

8. Works directly with all current data bound widgets in dijit, including `dijit.Tree <dijit/Tree>`_, `dijit.form.ComboButton <dijit/form/ComboButton>`_, and as well `dojox.grid <dojox/grid>`_.

=====
Usage
=====

dojox.data.JsonRestStore should be instantiated with a single argument that is an object that can have any of these properties:

schema
  This is a schema object for this store. This should be JSON Schema format.

service
  This is the service object that is used to retrieve lazy data and save results.

  The function should be directly callable with a single parameter of an object id to be loaded. The function should also have the following methods:

  * **put(id,value)**

    puts the value at the given id

  * **post(id,value)**

    posts (appends) the value at the given id

  * **delete(id)**

    deletes the value corresponding to the given id

  Note that it is critical that the service parses responses as JSON. If you are using dojox.rpc.Service, the easiest way to make sure this happens is to make the responses have a content type of application/json. If you are creating your own service, make sure you use handleAs: "json" with your XHR requests.

target

  This is the target URL for this Service store. This may be used in place of a service parameter to connect directly to RESTful URL without using a dojox.rpc.Service object.

idAttribute

  Defaults to 'id'. The name of the attribute that holds an objects id. This can be a preexisting id provided by the server. If an ID isn't already provided when an object is fetched or added to the store, the autoIdentity system will generate an id for it and add it to the index.

syncMode

  Setting this to true will set the store to using synchronous calls by default. Sync calls return their data immediately from the calling function, so callbacks are unnecessary.


========
Examples
========


.. code-block :: javascript

 store = new dojox.data.JsonRestStore({target:"/Table/", idAttribute:"id"});
 ... or ...
 store = new dojox.data.JsonRestStore({service:myService, syncMode: true});


========
See also
========

* JsonRestStore is described in more detail here: http://www.sitepen.com/blog/2008/06/13/restful-json-dojo-data/

* You can read more about using JSON Referencing here: http://www.sitepen.com/blog/2008/06/17/json-referencing-in-dojo/

* And this article describes more about JsonRestStore and using referencing for lazy loading: http://blog.medryx.org/2008/07/24/jsonreststore-overview/
