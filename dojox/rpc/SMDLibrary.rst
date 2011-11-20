.. _dojox/rpc/SMDLibrary:

SMDLibrary
==========

Here lives several :ref:`Service-based <dojox/rpc/Service>` SMD's contributed to Dojo. They wrap major public API's for convenience.

* ``google.smd`` - Provides access to all Google AJAX API processes. Web, Image, Book, Blog, Local, News, Feeds, and Translate.
* ``yahoo.smd`` - Utilizes Yahoo, Inc's public RPC 
* ``geonames.smd`` - Provides many useful geo/location APIs, courtesy GeoNames
* ``dojo-api.smd`` - An SMD to hook directly into Dojo's API page data
* ``wikipedia.smd`` - Data provided by WikiPedia. 

These SMD's are all available at a defined place/filename in the Dojo source archives. Simply point your Service at them:

.. code-block :: javascript

  dojo.require("dojo.io.script"); // x-domain RPC
  dojo.require("dojox.rpc.Service");
  dojo.addOnLoad(function(){
    var libRoot = "dojox.rpc.SMDLibrary";
    var googAPI = new dojox.rpc.Service(dojo.moduleUrl(libRoot, "google.smd"));
    var dojoAPI = new dojox.rpc.Service(dojo.moduleUrl(libRoot, "dojo-api.smd"));
    var wikiAPI = new dojox.rpc.Service(dojo.moduleUrl(libRoot, "wikipedia.smd"));
  });

If you know of a service providing JSONP-based API, please let us know. If you wish to define your own SMD for said service, please feel free, and contribute it back for community consumption.
