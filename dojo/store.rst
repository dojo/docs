.. _dojo/store:

==========
dojo.store
==========

:Authors: Kris Zyp
:Project owner: Kris Zyp
:since: 1.6.0

.. contents ::
  :depth: 2

Dojo Store is an uniform interface for the access and manipulation of stored data. Dojo Store is intended to supersede, integrate, and improve upon the Dojo Data API and Dojo Storage API with a simple, easy to implement and extend API, based on `HTML5/W3C's IndexedDB object store API <http://www.w3.org/TR/IndexedDB/#object-store-sync>`_. The Dojo Storage API (implemented in `dojox.storage </dojox/storage>`_)  is already a compatible subset of the Dojo object store API.

Dojo Store API
==============


Methods
-------

Every method in the API is optional, it's presence indicating support for that feature. Every method can return a promise (except where noted otherwise) to represent an asynchronous completion of the action. (Some of these are still wavering a bit in W3C's object store API):

================================================  ======================================================================
Method                                            Description
================================================  ======================================================================
get(id)                                           Retrieves an object by its identifier, returning the object.

query(query, options)                             Queries the store using the provided query.

                                                  The returned value should be an array or a promise with forEach, map, filter, reduce, subscribe, and optional close and watch methods, and a total property (the total may be a promise). The options parameter may include the following properties (all our optional):

                                                  * start - Starting offset
                                                  * count - Number of objects to return
                                                  * sort - This is an array of sort definitions, where each definition contains an "attribute" property indicating which property to sort on and a "descending" property indicating the direction of sort. For example: [{attribute:"price, descending: true}]. If the sort parameter is omitted, then the natural order of the store may be applied if there is a natural order.

put(object, options)                              Saves the given object. The (optional) options argument may be an object with the following properties (each of these is optional and advisory, stores are not required to implement or respond to each property):

                                                  * id - Indicates the identity of the object if a new object is created
                                                  * before - If the collection of objects in the store has a natural ordering, this indicates that the created or updated object should be placed before the object specified by the value of this property. A value of null indicates that the object should be last.
                                                  * parent - If the store is hierarchical (with single parenting) this property indicates the new parent of the created or updated object.
                                                  * overwrite - If this is provided as a boolean it indicates that the object should or should not overwrite an existing object. A value of true indicates that a new object should not be created, the operation should update an existing object. A value of false indicates that an existing object should not be updated, a new object should be created (which is the same as an add() operation). When this property is not provided, either an update or creation is acceptable.

add(object, options)                              Create a new object. The (optional) options argument is defined the same as put() (except overwrite is assumed to be false).

remove(id)                                        Delete the object by id.

getIdentity(object)                               Returns an object's identity

queryEngine(query, options)                       This takes a query and query options and returns a function that can execute the provided query on a JavaScript array. The queryEngine may be replace to provide more sophisticated querying capabilities. The returned query function may have a "matches" property that can be used to determine if an object matches the query.

transaction()                                     Starts a transaction and returns a transaction object.

                                                  The transaction object should include:

                                                  * commit() - Commits all the changes that took place during the transaction.
                                                  * abort() - Aborts all the changes that took place during the transaction.

                                                  Note that a store user might not call transaction() prior to using put, delete, etc. in which case these operations effectively could be thought of as  "auto-commit" style actions. Also note that within a transaction, notification events may still occur immediately, rather after a commit. Consequently, aborting a transaction may require sending new notification events to notify of the rollback of the data.

getChildren(object, options)                      Returns the children of an object. The options parameter may include the same properties as query options

getMetadata(object)                               Returns any metadata about the object.
                                                  This may include attribution, cache directives, history, or version information. (addresses #3126, #3127)
================================================  ======================================================================

Properties
----------

===========  ================  ======================================================================
Property     Type              Description
===========  ================  ======================================================================
idProperty   String            Name of the property to use as the identifier
data         Array of Objects  If the store has a collection of cached objects, it can make this available in this property. This is included so an additional layer could add referential integrity cleanup on object deletion (which is a pain to implement).
===========  ================  ======================================================================


Returned Objects
================

Objects returned from store should primarily be treated as normal hash objects and have standard JavaScript properties to access their data and modify their data. However, methods may also be defined on the objects returned by the store (once again, they are optional). These methods should '''not''' be the object's own properties (hasOwnProperty(methodName) should return false), but rather should be inherited from one of the object's prototypes). This is to ensure ease of enumeration of data properties.  In particular, a store may choose to return objects that are instances of dojo.Stateful (although none of the core stores do this).


Observing Result Sets
=====================

When a store is wrapped with ``dojo.store.Observable``, one can listen for changes in data through the observe method on the result set (the object returned from a query). The observe method has the following signature:

========================================================  =======================================================================
Method                                                    Description
========================================================  =======================================================================
observe(listener)                                         The listener function is called with following arguments:
                                                          listener(object, removedFrom, insertedInto);
                                                                      
                                                          * The object parameter indicates the object that was create, modified, or deleted.
                                                          * The removedFrom parameter indicates the index in the result array where the object used to be. If the value is -1, then the object is an addition to this result set (due to a new object being created, or changed such that it is a part of the result set).
                                                          * The insertedInto parameter indicates the index in the result array where the object should be now. If the value is -1, then the object is a removal from this result set (due to an object being deleted, or changed such that it is not a part of the result set).

close                                                     When close() is called on a result set, notifications will no longer be fired.
========================================================  =======================================================================

Core Stores included with Dojo
==============================

The following stores, store wrappers, and utilities ship with Dojo. These provide a solid base of good modular components for using stores and building more complex store technology. The following two core stores based on the typical pattern of in-memory and server-based data stores:

* :ref:`dojo.store.Memory <dojo/store/Memory>`

  An in-memory object store that queries, modifies, and accesses client-side in-memory data. This can be created with a simple array of JavaScript objects.

* :ref:`dojo.store.JsonRest <dojo/store/JsonRest>`

  An server-oriented JSON/REST object store that queries, modifies, and accesses data through RESTful HTTP requests. This would fulfill the conceptual role of JsonRestStore/QueryReadStore/ServiceStore.

There is also an adapter store for using legacy Dojo Data stores with the new API:

* :ref:`dojo.store.DataStore <dojo/store/DataStore>`

We are also moving in the direction of providing composable functionality by providing store "wrappers" or store "middleware" that takes a store and adds functionality. Several key store wrappers:

* :ref:`dojo.store.Observable <dojo/store/Observable>` This augments a store with the data monitoring capability, adding a observe method on the query result sets that notifies of data changes.

* :ref:`dojo.store.Cache <dojo/store/Cache>`

  Adds caching capability to the store. This eliminates the need for a base store to deal with caching concerns.

* Future: JsonSchema

  Handles validation of data through JSON Schema as well object referencing through JSON Schema's link definitions.

With this one can easily mix and match wrappers and base stores to achieve various types of functionality. A common pattern may be:

.. js ::

  store = Observable(new Memory({data: someData}));

There are also a couple of utility modules:

* :ref:`dojo.store.util.SimpleQueryEngine <dojo/store/util/SimpleQueryEngine>`

  This is basic query engine that provides simple object hash style filtering or function based filtering.

* :ref:`dojo.store.util.QueryResults <dojo/store/util/QueryResults>`

  This utility will take an array or a promise for an array and return a result set object with all the standard iterative methods that should be available on a result set (forEach, map, and filter).



Rationale
---------

[Rationale: The purpose of using this style of notifications (instead of the Dojo Data notification style of events on the store) is to deal with several problems I have seen with Dojo Data notifications. First, it neglects that fact that most of the time users only want to listen to events from the queried subset of the items in the store, and that subscriptions can be costly. While subscriptions are usually cheap on the client side, carte blanche subscriptions can actually be very expensive on the server side (with Comet-style notifications), forcing the server to send excessive events and then forcing the client to filter them.

Also this subscription deals with an issue we have experience with Dojo Data in that often new items and item changes can affect query results in ways that the widget can not understand because the queries are opaque to the widget. With the grid, all onNew items result in an addition of a row, regardless of whether the new item actually matches the query. The grid itself knows nothing (and should know nothing) of how queries work, and so it can't filter these events. By putting notifications on the query action itself, notifications can be stated in terms of how they affect a given query result set, which is what the widget ultimately cares about.

I have intentionally used different event names to be clear that the semantics are different than the Dojo Data notifications. The distinctive events are defined by how they affect the query result set (not whether they have come into or gone out of existence by some definition of existence). Also, the onUpdate applies to an entire object, not per property modifications.

It also may be worth considering adding the notification events to an options parameter for get(id) calls.

We will need to include a helper mixin or wrapper to make it easy to implement the query function.]


I believe this generally facilitates all of the Dojo Data functionality. Some of it may require some composition, but I think most of the needed things would be in place to achieve anything you could with Dojo Data. The one thing I did intentionally omit was getLabel/getLabelAttributes, as I think is clearly a UI concern. It would be easy enough to include a labelProperty property on the store, but I don't think it is necessary.


Design Goals
============

* We want to make it very easy to for people to implement their own object stores, essentially one should easily be able to write something up handle the communication to their server without having to deal with much more than writing the :ref:`XHR calls <dojo/xhr>`. Higher level functionality can be built on this. A key to this strategy is a very simple API, that requires a minimal amount of required complexity to implement.

* We want to maintain the same level of functionality that :ref:`Dojo Data <dojo/data>` provided. While there will be very little (if any) core parts of the object store API that MUST be implemented, there will numerous parts that can be implemented to incrementally add functionality. Optional functionality will be determined through feature detection (checking to see if a method exists). As I noted in the meeting, having lots of optional features does shift some complexity from the store implementors to the anyone who wishes to use stores in a completely generic fashion. However, I believe that our widgets are the primary generic store users, and that most application developers are working with a known store, with a known set of implemented features. In particular, if they know they are using a sync store, the interaction with the store becomes extremely simple. For now I will suggest that basically every method is optional, and the presence of the method indicates support for that feature. However, practically one would at least need to implement get and query, a store without read capabilities is pretty useless, but that should be self-evident.

* Every method can be implemented sync or async. The interface is the exactly the same for sync and async except that async returns promises/deferreds instead of plain values. The interface requires no other knowledge of specific callbacks to operate.

* Objects returned from the data store (via query or get) should be plain JavaScript objects whose properties can be typically accessed and modified through standard property access.

See Also
========

* `SitePen Blog Post on Object Stores <http://www.sitepen.com/blog/2011/02/15/dojo-object-stores/>`_
