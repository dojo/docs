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
