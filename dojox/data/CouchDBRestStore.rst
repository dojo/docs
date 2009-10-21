#format dojo_rst

dojox.data.CouchDBRestStore
===========================

:Status: Draft
:Version: 1.0
:Project owner: Kris Zyp
:Developers: Kris Zyp
:Authors: Kris Zyp, Marcus Reimann
:Available: since V1.2

.. contents::
    :depth: 3

**dojox.data.CouchDBRestStore** is a subclass of `JsonRestStore <dojo/data/JsonRestStore>`_ for connecting to the open source document-oriented database `Apache CouchDB <http://couchdb.org/>`_.


============
Introduction
============

CouchDBRestStore essentially has the same functionality as JsonRestStore, but has some extra adaptations for automatic creation of stores based on CouchDB's database listing and working properly with CouchDB's idiosyncrasies.


=====
Usage
=====

You can create a set of stores for all available CouchDB tables/databases:

.. code-block :: javascript

 myStores = dojox.data.CouchDBRestStore.getStores("http://192.168.0.68:5984/_utils/");

This will return a object where each property name is the name of the store, and each value is the actual store for interacting with the CouchDB database.


========
See also
========

* `Apache CouchDB <http://couchdb.org/>`_

* CouchDBRestStore is described in more detail here: http://www.sitepen.com/blog/2008/09/26/couchdbreststore/

* JsonRestStore is described in more detail here: http://www.sitepen.com/blog/2008/06/13/restful-json-dojo-data/
