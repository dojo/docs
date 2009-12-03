#format dojo_rst

dojox.rpc.Rest
==============

:Authors: Marcus Reimann, Kris Zyp
:Project owner: Kris Zyp
:Available: since V1.2

.. contents::
   :depth: 2

dojox.rpc.Rest provides a HTTP REST service with full range REST verbs include GET, PUT, POST and DELETE.


=====
Usage
=====

A normal GET query is done by using the service directly:

.. code-block :: javascript
  :linenos:

    var restService = dojox.rpc.Rest("Project");
    restService("4");


The modifying methods can be called as sub-methods of the rest service method like:

.. code-block :: javascript
  :linenos:

    services.myRestService.put("parameters","data to put in resource");
    services.myRestService.post("parameters","data to post to the resource");
    services.myRestService['delete']("parameters");


You can also use the SMD service to generate a REST service:

.. code-block :: javascript
  :linenos:

    var services = dojox.rpc.Service({services: {myRestService: {transport: "REST",...
    services.myRestService("parameters");


Note: dojox.rpc.Rest doesn't require dojox.rpc.Service, and if you want it you must require it yourself, and you must load it prior to dojox.rpc.Rest.


========
Examples
========

GET
---

This will do a HTTP GET for the URL "/Project/4":

.. code-block :: javascript
  :linenos:

    var restService = dojox.rpc.Rest("Project");
    restService("4");


PUT
---

This will do a HTTP PUT to the URL "/Project/4" with the content of "new content":

.. code-block :: javascript
  :linenos:

    var restService = dojox.rpc.Rest("Project");
    restService.put("4","new content");

POST
----

This will do a HTTP POST to the URL "/Project/4" with the content of "new content":

.. code-block :: javascript
  :linenos:

    var restService = dojox.rpc.Rest("Project");
    restService.post("4","new content");

DELETE
------

This will do a HTTP DELETE to the URL "/Project" with the content of "{item: "4"}":

.. code-block :: javascript
  :linenos:

    var restService = dojox.rpc.Rest("Project");
    restService['delete']({item: "4"});


Using the SMD service
---------------------

You can also use the SMD service to generate a REST service:

.. code-block :: javascript
  :linenos:

    var services = dojox.rpc.Service({services: {myRestService: {transport: "REST",...
    services.myRestService("parameters");


========
See also
========

* `dojox.rpc <dojox/rpc>`_
