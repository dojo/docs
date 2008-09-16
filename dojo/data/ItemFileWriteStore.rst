#format dojo_rst

dojo/data/ItemFileWriteStore
============================

:Status: Contributed, Draft
:Version: 1.2
:Author: Jared Jurkiewicz
:Available: since V1.0

.. contents::
  :depth: 2

Dojo core provides the ItemFileWriteStore store as an extension to ItemFileReadStore that adds on the dojo.data.api.Write and dojo.data.api.Notification API support to ItemFileReadStore. It was specifically created as a separate class so that if you only need read capability, you do not incur the download penalty of the write and notification API support if you won't use it. If your application needs to write to the ItemFileStore instead of just Read, then ItemFileWriteStore is the store you should instantiate. The input data format is identical to ItemFileReadStore.


===========
API Support
===========

* dojo.data.api.Read
* dojo.data.api.Write
* dojo.data.api.Identity
* dojo.data.api.Notification

======================
Constructor Parameters
======================

The constructor for ItemFileWriteStore takes the same parameters as `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_ 
