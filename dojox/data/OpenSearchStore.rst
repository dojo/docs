#format dojo_rst

dojox.data.OpenSearchStore
==========================

:Status: Draft
:Version: 1.0
:Project owner: Benjamin Schell
:Available: since V1.3

.. contents::
   :depth: 2

A store implementing the dojo.data.Read API for talking to OpenSearch based search providing services.  

============
Introduction
============

This store takes in the OpenSearch Descriptor and uses that to configure how a search query is issued.  It can also take the search results and present them as data store formatted items for a wide variety of return formarts for OpenSearch results.  For more information on the general concepts behind OpenSearch, please refer to `OpenSearch project <http://www.opensearch.org/Home>`_.


Supported OpenSearch Return Formats
-----------------------------------

* ATOM 
* RSS
* XML

===========
Limitations
===========

* This store uses dojo.xhrGet and other xhr functions to fetch the OpenSearch descriptor and make search queries.  Therefore, the OpenSearchStore is limited by the brower 'same domain' policy for xhr requests.  Therefore, to make OpenSearch calls to providers that reside on servers other than the one that provided the HTML file that instantiated the OpenSearchStore, a proxy must be used.
* The OpenSearchStore does not currently support HTML return formats.  The reason for this is an open issue with dojo.query and searching by ID.  The bug the OpenSearchStore is blocked on can be found `here <http://trac.dojotoolkit.org/ticket/4425>`_.

==============
Supported APIs
==============

The following dojo.data APIs are implemented by AppStore:

* `dojo.data.api.Read <dojo/data/api/Read>`_

======================
Constructor Parameters
======================

+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| **Parameter**  | **Required** | **Description**                                                                                | **Since** |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| url            | Yes          |This parameter specifies the URL from which to load the OSD (OpenSearch Descriptor) document    |1.3        |
|                |              |from.  This is required as the OSD file contains all the information required to configure the  |           |
|                |              |store to issue queries.                                                                         |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
