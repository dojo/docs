#format dojo_rst

dojox.data.JsonRestStore
========================

:Status: Contributed, Draft
:Version: 1.0
:Author: Kris Zyp
:Available Since: dojo 1.2

.. contents::
    :depth: 3

dojox.data.JsonRestStore is a lightweight datastore implementation of a RESTful client. JsonRestStore provides full read, write, and notification capabilities through standards based HTTP/REST interaction with the server using GET, PUT, POST, and DELETE commands. JsonRestStore supports JSON Referencing so objects can contain cyclic, multiple, cross-message, cross-table, and even cross-site references, which can be used for `lazy loading <quickstart/data/usingdatastores/lazyloading>`_. These references are automatically resolved such that properties are accessed as normal datastore attributes. JsonRestStore also store objects in a format to ease direct property access for significant performance advantages. 


Features
--------

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

8. Works directly with all current data bound widgets in dijit, including `dijit.Tree <dijit/Tree>`_, `dijit.form.ComboButton <dijit/form/ComboButton>`_, and well as `dojox.grid <dojox/grid>`_.


Examples
--------

TODO: insert a working example

See also
--------

* JsonRestStore is described in more detail here: http://www.sitepen.com/blog/2008/06/13/restful-json-dojo-data/

* You can read more about using JSON Referencing here: http://www.sitepen.com/blog/2008/06/17/json-referencing-in-dojo/

* And this article describes more about JsonRestStore and using referencing for lazy loading: http://blog.medryx.org/2008/07/24/jsonreststore-overview/
