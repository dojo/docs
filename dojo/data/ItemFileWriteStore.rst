#format dojo_rst

dojo/data/ItemFileWriteStore
============================

:Status: Contributed, Draft
:Version: 1.2
:Author: Jared Jurkiewicz
:Available: since V1.0

.. contents::
  :depth: 2

Dojo core provides the ItemFileWriteStore store as an extension to ItemFileReadStore that adds on the dojo.data.api.Write and dojo.data.api.Notification API support to ItemFileReadStore. It was specifically created as a separate class so that if you only need read capability, you do not incur the download penalty of the write and notification API support if you won't use it. If your application needs to write to the ItemFileStore instead of just Read, then ItemFileWriteStore is the store you should instantiate. The input data format is identical to `ItemFileReadStore <dojo/data/ItemFileReadStore>`_.


===========
API Support
===========

* `dojo.data.api.Read <dojo/data/api/Read>`_
* `dojo.data.api.Write <dojo/data/api/Write>`_
* `dojo.data.api.Identity <dojo/data/api/Identity>`_
* `dojo.data.api.Notification <dojo/data/api/Notification>`_

======================
Constructor Parameters
======================

The constructor for ItemFileWriteStore takes the same parameters as `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_ 

============
Custom Types
============

As with dojo.data.ItemFileReadStore, the ItemFileWriteStore supports using custom defined types in the data format.  Since ItemFileWriteStore supports mechanisms for serializing the store contents back out, the custom type support has been extended to allow for custom serializers so that the complex types can be converted back into their necessary encodings.  

--------------------
Custom Type Examples
--------------------

By default, ItemFileWriteStore has registered a custom type handler for JavaScript Date objects.  It uses the general case formatting option for the value, as shown below:

.. code-block :: javascript

  {
    "Date": {
      type: Date,
      deserialize: function (value) {
        return dojo.date.stamp.fromISOString(value);
      },
      serialize: function(obj) {
        return dojo.date.stamp.toISOString(obj, {zulu:true});
      }
    }
  
So, when Date objects are encountered, ItemFileWriteStore automatically serializes it out as a custom type of the following format:

.. code-block :: javascript

  { "_type":"Date", "value":"1993-05-24T00:00:00Z" }

============
Query Syntax
============

The query syntax for ItemFileWriteStore is identical to the query syntax of ItemFileReadStore so see that `section <dojox/data/ItemFileReadStore>`_  for more information.

==============================
The Behavior of the save() API
==============================

Since this store implements the dojo.data.api.Write feature, it must implement the *save* function.   So, what does that do when called?  By default, it only does two things:

* Clear out the record of all changed, deleted, and new items so that isDirty() will return false.
* Commit the changes to the internal main tree of items.
* Call any callbacks passed to the save function.

Okay, so it effectively removed the ability to revert out a set of changes.  In other words, it acts like a commit.  That's great, bit all of it just happens in the browser.  What if I want to send data back to a server when save is called for persistence?  Can this be done?  The answer is **yes**.  There are several ways to accomplish this.  The first would be to simply replace the store *save* function with a different one to do whatever you want.  However, that one ends up requiring knowing a lot about how things are stored internally, which is not always good to know about.  So, ItemFileWriteStore provides hook functions for users to over-ride to customize saving behavior without having to replace the *save* function.  This allows for you to define exactly what else you want the store to do with saved data results without having to know as much about internal representations:  The functions you can over-ride are defined below:

----------------------------------------------
Save function Extension point: _saveEverything
----------------------------------------------

The *_saveEverything* function should be defined on your store when all you want to do is get text content of the internal state back into a JSONable string so it can be sent serverside.  Effectively think of it as a way to get a JSON string back similar to the one you used to load the store.  The callbacks are the same callbacks you normally pass to the *save* function of the store.

.. code-block :: javascript

  _saveEverything: function(saveCompleteCallback /*Your callback to call when save is completed */, 
                            saveFailedCallback /*Your callback to call if save fails*/, 
                            newFileContentString /*The generated JSON data to send somewhere*/)


------------------------------------------
Save function Extension point: _saveCustom
------------------------------------------

The *_saveCustom* function should be defined on your store when you want to control exactly how everything gets serialized back (be it in JSON, XML, or whatnot).  The function signature is simple, it just takes the callbacks passed to the *save* API on the store.  Your implementation should introspect through the store's information, generate the save format your service desires, then send it and call the callbacks on whether it succeeds or not.  The *_saveCustom* function should be declared on the store as follows:

.. code-block :: javascript

  _saveCustom: function(saveCompleteCallback /*Your callback to call when save is completed */, 
                        saveFailedCallback /*Your callback to call if save fails*/)
  

================================
The Behavior of the revert() API
================================

The revert API is intended to undo changes made through calls to *newItem*, *deleteItem*, and *setValue(s)*.  What it effectively does is return the pristine data item states into the internal data array storing all the items for modified and deleted items.  For new items it removes them from the internal data array.   

  **Note:**  Revert does **not** generate Notification events in reverse order for every change it undoes.  To detect revert changes to react accordingly, you should *dojo.connect* to the revert function on the store.
