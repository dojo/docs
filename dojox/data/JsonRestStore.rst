#format dojo_rst

dojox.data.JsonRestStore
========================

:Status: Contributed, Draft
:Version: 1.0
:Author: Kris Zyp
:Available Since: dojo 1.2


dojox.data.JsonRestStore is a lightweight datastore implementation of a RESTful client. JsonRestStore provides full read, write, and notification capabilities through standards based HTTP/REST interaction with the server using GET, PUT, POST, and DELETE commands. JsonRestStore supports JSON Referencing so object can contain cyclic, multiple, cross-message, cross-table, and even cross-site references. These references are automatically resolved such that properties are accessed as normal datastore attributes. JsonRestStore also store objects in a format to ease direct property access for significant performance advantages.

**Features**
------------

1. The datastore implement the following dojo.data APIs:  dojo.data.api.Read, dojo.data.api.Identity, dojo.data.api.Write, dojo.data.api.Notification.
2. Client/server interaction follows the HTTP specification for RESTful interaction, using standard HTTP verbs and headers to handle updates, paging, and id assignment.
3. Full JSON Referencing capabilities. Create circular references, multiples references, reference objects from other tables, and even references objects from other domains
4. Flexible modular design allows for easy extension and customization. Multiple subclasses in Dojo already use JsonRestStore, including CouchDBRestStore, PersevereStore, and S3Store. Custom queries can easily be generated.
5. Integrates with the dojox.rpc.Service system, any service can be customized to be a REST service for the system.
6. Integrates with OfflineRest for automatic offline usage. Application built JsonRestStore can almost instantaneously be made offline.
7. Integrates with the RestChannels Comet module to support server sent notifications of data changes. The data store automatically routes these updates as data notifications to widgets.
8. Works directly with all current data bound widgets in dijit, including dijit.Tree, dijit.form.ComboBox, and well as dojox.grid.
