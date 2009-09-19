#format dojo_rst

dojox.data.PersevereStore
=========================

:Status: Draft
:Version: 1.0
:Authors: Kris Zyp
:Developers: Kris Zyp
:Available: since V1.2

.. contents::
    :depth: 3

**dojox.data.PersevereStore** is a subclass of `JsonRestStore <dojo/data/JsonRestStore>` for connecting to a Persevere <http://sitepen.com/labs/persevere.php> server.


============
Introduction
============

PersevereStore essentially has the same functionality as JsonRestStore, but has some extra adaptations for automatic creation of stores based on Persevere's introspective table/class querying.

=====
Usage
=====

You can create a set of stores for all available Persevere classes/tables:

.. code-block :: javascript

 myStores = dojox.data.PersevereStore.getStores("/",true); // do it synchronously
 ... or ...
 dojox.data.PersevereStore.getStores("/").addCallback(function(results){
   // do it asynchronously
   myStores = results;
 });

This will return a object where each property name is the name of the store, and each value is the actual store for interacting with the Persevere database.

========
See also
========

* PersevereStore is described in more detail here: http://www.sitepen.com/blog/2008/07/23/getting-started-with-persevere-using-dojo/

* The functionality provided by JsonRestStore is described in more detail here: http://www.sitepen.com/blog/2008/06/13/restful-json-dojo-data/

* JSON Query documentation from the Persevere project: http://docs.persvr.org/documentation/jsonquery

* Persevere project documentation: http://docs.persvr.org/documentation

* Sitepen blog persevere posts: http://www.sitepen.com/blog/category/persevere/
