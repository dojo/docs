.. _dojox/data/ServiceStore:

dojox.data.ServiceStore
=======================

:Status: Draft
:Version: 1.0
:Authors: Kris Zyp
:Developers: Kris Zyp
:Available: since V1.2

.. contents::
   :depth: 2

ServiceStore is an adapter for web services to implement the Dojo Data API, providing simple Dojo Data access for web services.


============
Introduction
============

dojox.rpc.Service provides a comprehensive mechanism for connecting to web services, and can be auto-configured based on `Service Mapping Descriptions (SMDs) <http://groups.google.com/group/json-schema/web/service-mapping-description-proposal>`_, and these services can be used directly with the ServiceStore for use with Dojo Data store consumer. `This page <http://www.sitepen.com/blog/2008/06/25/web-service-data-store/>`_ provides directions for creating a ServiceStore from a web service. `This page <http://www.sitepen.com/blog/2008/06/13/restful-json-dojo-data/>`__ describes features of ServiceStore and it's subclass JsonRestStore.


=====
Usage
=====

To create an instance of a ServiceStore, simply instantiate providing the service to be used as the source:

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
    // first include ServiceStore:
    dojo.require('dojox.data.ServiceStore');

    myService = new dojox.rpc.Service(mySMD);
    myServiceStore = new dojox.data.ServiceStore({service:myService});
  </script>

When extending this class, if you would like to create lazy objects, you can follow the example from dojox.data.tests.stores.ServiceStore:

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
    var lazyItem = {
        _loadObject: function(callback){
            this.name="loaded";
            delete this._loadObject;
            callback(this);
        }
    };
  </script>

dojox.data.ServiceStore should be instantiated with a single argument that is an object that can have any of these properties:

The *schema* parameter

This is a schema object for this store. This should be JSON Schema format.

The *service* parameter

This is the service object that is used to retrieve lazy data and save results 
The function should be directly callable with a single parameter of an object id to be loaded

The *idAttribute* parameter

Defaults to 'id'. The name of the attribute that holds an objects id.
This can be a preexisting id provided by the server.  
If an ID isn't already provided when an object
is fetched or added to the store, the autoIdentity system
will generate an id for it and add it to the index. 

The *syncMode* parameter

Setting this to true will set the store to using synchronous calls by default.
Sync calls return their data immediately from the calling function, so
callbacks are unnecessary. This will only work with a synchronous capable service.
