#format dojo_rst

dojox.store
===========

:Authors: Kris Zyp
:Project owner: Kris Zyp
:Available: coming with V1.6

.. contents::
  :depth: 2

Dojo Store is an uniform interface for the access and manipulation of stored data. Dojo Store is intended to supercede, integrate, and improve upon the Dojo Data API and Dojo Storage API with a simple, easy to implement and extend API, based on HTML5/W3C's IndexedDB object store API.


============
Design Goals
============

* We want to make it very easy to for people to implement their own object stores, essentially one should easily be able to write something up handle the communication to their server without having to deal with much more than writing the `XHR calls <dojo/_base/xhr>`_. Higher level functionality can be built on this. A key to this strategy is a very simple API, that requires a minimal amount of required complexity to implement.

* We want to maintain the same level of functionality that `Dojo Data <dojo/data>`_ provided. While there will be very little (if any) core parts of the object store API that MUST be implemented, there will numerous parts that can be implemented to incrementally add functionality. Optional functionality will be determined through feature detection (checking to see if a method exists). As I noted in the meeting, having lots of optional features does shift some complexity from the store implementors to the anyone who wishes to use stores in a completely generic fashion. However, I believe that our widgets are the primary generic store users, and that most application developers are working with a known store, with a known set of implemented features. In particular, if they know they are using a sync store, the interaction with the store becomes extremely simple. For now I will suggest that basically every method is optional, and the presence of the method indicates support for that feature. However, practically one would at least need to implement get and query, a store without read capabilities is pretty useless, but that should be self-evident.

* Every method can be implemented sync or async. The interface is the exactly the same for sync and async except that async returns promises/deferreds instead of plain values. The interface requires no other knowledge of specific callbacks to operate.

* Objects returned from the data store (via query or get) should be plain JavaScript objects whose properties can be typically accessed and modified through standard property access.


==============
Dojo Store API
==============

Every method in the API is optional, it's presence indicating support for that feature. Every method can return a promise (except where noted otherwise) to represent an asynchronous completion of the action. (Some of these are still wavering a bit in W3C's object store API):

=====================  ======================================================================
Method                 Description
=====================  ======================================================================
get(id)                Retrieves an object by its identifier, returning the object.

query(query, options)  Queries the store using the provided query.

                       The returned value should be an array or a promise with forEach, map, filter, reduce, subscribe, and close methods, and a totalCount property (the totalCount may be a promise). The options parameter is modeled after the Dojo Data keywordArgs and may include:

                       * start - Starting offset
                       * count - Number of objects to return
                       * sort - Follows the Dojo Data sort definition
                       * queryOptions - Follows the Dojo Data queryOptions definition

put(object, options)   Saves the given object. options.id (optional) indicates the identifier.

add(object, options)   Create a new object. options.id (optional) indicates the identifier.

delete(id)             Delete the object by id.

transaction()          Starts a transaction and returns a transaction object.

                       The transaction object should include:

                       * commit() - Commits all the changes that took place during the transaction.
                       * abort() - Aborts all the changes that took place during the transaction.

                       Note that a store user might not call transaction() prior to using put, delete, etc. in which case these operations effectively could be thought of as  "auto-commit" style actions.
=====================  ======================================================================


Store properties:

===========  ================  ======================================================================
Property     Type              Description
===========  ================  ======================================================================
idProperty   String            Name of the property to use as the identifier
data         Array of Objects  If the store has a collection of cached objects, it can make this available in this property. This is included so an additional layer could add referential integrity cleanup on object deletion (which is a pain to implement).
===========  ================  ======================================================================

Objects returned from store should primarily be treated as normal hash objects and have standard JavaScript properties to access their data and modify their data. However, the following methods are defined as possible methods that may also be available on the objects returned by the store (once again, they are optional). These methods should '''not''' be the object's own properties (hasOwnProperty(methodName) should return false), but rather should be inherited from one of the object's prototypes). This is to ensure ease of enumeration of data properties.  Once again, all of these methods are optional, and all may return promises if the operation will be performed asynchronously:

=========================  ======================================================================
Method                     Description
=========================  ======================================================================
get(property)              Returns the value of the given property.

                           Normally property values can be accessed with normal JavaScript member expresions (object.property -> value), but if get() is implemented, than get(property) should be used to retrieve property values. This allows for lazy evaluation of properties.

set(property, value)       Sets the property value.

                           Normally property values can be mutated with normal JavaScript member expresions (object.property = value), but if set() is implemented, than set(property, value) should be used to modify property values.

load()                     Fully loads the current object.

                           If this method is present, it indicates that the object may not be fully loaded.

save()                     Saves the loaded object.

                           This should generally be shorthand for store.put(object);

watch(property, callback)  Listens for changes to this object.

getId()                    Normally a store just uses a single property (identified by idProperty) for the object identity. However, a store may provide getId() on the objects to create more complex identities (such as composite identities).

getMetadata()              Returns any metadata about the object. 

                           This may include attribution, cache directives, history, or version information. (addresses #3126, #3127)
=========================  ======================================================================


=====================
Subscriptions/Watches
=====================

One can subscribe to changes in data through the subscribe method on the result set (the object returned from a query). The subscribe method has the following signature:

  subscribe(event, callback)

Where an event can be:

* onAdd

  An object was created or modified such that the object now belongs in the set of objects defined by the query.

* onUpdate

  An object that belongs to the set of objects defined by the query was modified and still belongs to the query's set of objects.

* onRemove

  An object that belongs to the set of objects defined by the query was modified or deleted and no longer belongs to the query's set of objects.

When close() is called on a result set, notifications will no longer be fired.

[Rationale: The purpose of using this style of notifications (instead of the Dojo Data notification style of events on the store) is to deal with several problems I have seen with Dojo Data notifications. First, it neglects that fact that most of the time users only want to listen to events from the queried subset of the items in the store, and that subscriptions can be costly. While subscriptions are usually cheap on the client side, carte blance subscriptions can actually be very expensive on the server side (with Comet-style notifications), forcing the server to send excessive events and then forcing the client to filter them.

Also this subscription deals with an issue we have experience with Dojo Data in that often new items and item changes can affect query results in ways that the widget can not understand because the queries are opaque to the widget. With the grid, all onNew items result in an addition of a row, regardless of whether the new item actually matches the query. The grid itself knows nothing (and should know nothing) of how queries work, and so it can't filter these events. By putting notifications on the query action itself, notifications can be stated in terms of how they affect a given query result set, which is what the widget ultimately cares about.

I have intentionally used different event names to be clear that the semantics are different than the Dojo Data notifications. The distinctive events are defined by how they affect the query result set (not whether they have come into or gone out of existence by some definition of existence). Also, the onUpdate applies to an entire object, not per property modifications.

It also may be worth considering adding the notification events to an options parameter for get(id) calls.

We will need to include a helper mixin or wrapper to make it easy to implement the query function.]


I believe this generally facilitates all of the Dojo Data functionality. Some of it may require some composition, but I think most of the needed things would be in place to achieve anything you could with Dojo Data. The one thing I did intentionally omit was getLabel/getLabelAttributes, as I think is clearly a UI concern. It would be easy enough to include a labelProperty property on the store, but I don't think it is necessary.


==========================================
Core Functionality to be Shipped with Dojo
==========================================

Having an interface/API is not enough, we want to ship good out-of-the-box object stores that developers can readily utilize for common use cases and easily extend and customize. We also need good modular components for building stores. We could have the following two core stores based on the typical pattern of in-memory and server-based data stores:

* dojo.store.Memory

  An in-memory object store that queries, modifies, and accesses client-side in-memory data. This would fulfill the conceptual role of ItemFileReadStore/ItemFileWriteStore

* dojo.store.JsonRest

  An server-oriented JSON/REST object store that queries, modifies, and accesses data through RESTful HTTP requests. This would fulfill the conceptual role of JsonRestStore/QueryReadStore/ServiceStore.

We should also move in the direction of providing composable functionality by providing store "wrappers" or store "middleware" that takes a store and add functionality. A couple key store wrappers:

* dojo.store.Cache

  Adds caching capability to the store. This eliminates the need for a base store to deal with caching concerns.

* dojo.store.JsonSchema

  Handles validation of data through JSON Schema as well object referencing through JSON Schema's link definitions.

With this one could easily mix and match wrappers and base stores to achieve various types of functionality.

Another utility module would be a query helper.
