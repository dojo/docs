#format dojo_rst

dojo/data/ItemFileReadStore
===========================

.. contents::
  :depth: 3

Dojo core provides a implementation of a read-only datastore, ItemFileReadStore. This store reads the JSON structured contents from an http endpoint (service or URL), or from an in-memory JavaScript object, and stores all the items in-memory for simple and quick access. ItemFileReadStore is designed to allow for flexibility in how it represents item hierarchy, references, and custom data types. It also provides options for which attribute can act as the unique identifier (for dojo.data.api.Identity), and which attribute can be used as a general label for an item. This store has an expectation that data is provided to in in a specific though very flexible, format. All of the examples on this page demonstrate the general format expected.

**Points of Consideration:**

1.)  The format used by ItemFileReadStore is *not* a requirement of the dojo.data API.  The format it uses is designed to work well for the specific situations ItemFileReadStore is used for, which are moderately sized data sets that can be easily represented in a JavaScript Object tree.  Again, please do not take the storage format used by ItemFileReadStore as a definitive format all data stores use; *it is not*.  Other stores use different formats, such as CSV structured data, XML, Opml, HTML, raw text, etc.  The point of a data store is to hide the internal structure and always expose the data through the same API.

2.)  This is an in-memory store.  It is not designed to operate as a remote server store and often trying to make it work with specific remote services ends up far more work than simply implementing a completely new data store that conforms to the dojo.data APIs.   So, if you find it extremely complicated to modify for your needs, take a set back and look at what you're trying to do.  It may be simpler to implement the data store interface over your services.

==============
Supported APIs
==============

The following dojo.data APIs are implemented by ItemFileReadStore

  * `dojo.data.api.Read <dojo/data/api/Read>`_
  * `dojo.data.api.Identity <dojo/data/api/Identity>`_


=================
Input Data Format
=================

While the data exposed from a data store is agnostic and consumable by many sources in an usually interchangable way, the input data formats of a data store may vary.   The ItemFileReadStore expects a specific structure to its data, as defined below:

.. code-block :: javascript

  {
    "label": "some attribute",   //Optional attribute used to indicate which attribute on an item should act as a human-readable label for display purposes.


    "identifier": "some attribute",  //Optional attribute used to indicate which attribute on an item acts as a unique identifier for that item.  If it is not defined, then the ItemFileReadStore will simply number the items and use that number as a unique index to the item.


    "items:" [  //The array of JavaScript objects that act as the root items of the data store
      { /* Some set of name/value attributes /* },
      { /* ... */ },
      ...
    ]
  }
