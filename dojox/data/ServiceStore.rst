#format dojo_rst

dojox.data.ClientFilter
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

dojox.rpc.Service provides a comprehensive mechanism for connecting to web services, and can be auto-configured based on Service Mapping Descriptions (SMDs) <http://groups.google.com/group/json-schema/web/service-mapping-description-proposal>, and these services can be used directly with the ServiceStore for use with Dojo Data store consumer. This page <http://www.sitepen.com/blog/2008/06/25/web-service-data-store/> provides directions for creating a ServiceStore from a web service. This page <http://www.sitepen.com/blog/2008/06/13/restful-json-dojo-data/> describes features of ServiceStore and it's subclass JsonRestStore.

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
