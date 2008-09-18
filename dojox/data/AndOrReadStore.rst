#format dojo_rst

dojox.data.AndOrReadtore
==========================

:Status: Draft
:Version: 1.0
:Since: 1.2

.. contents::
  :depth: 3

dojox.data.AndOrReadStore is a clone of dojo.data.ItemFileReadStore.  The only significant difference is that it supports more complex qyeries than the simple AND format property matching.  Specifically, it can perform AND and ORing, and NOT.  For general functions, data format, and information refer to `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_.


============
Query Syntax
============
AndOrReadStore supports all the same query capability as dojo.data.ItemFileReadStore as well as several others that allow for more complicated queries.  In specific, it allows for chaining of ANDs, ORs, and NOTs for attributes (along with wildcards), for a much more flexible structure. 

**Supported Operators:**
  
  , NOT AND OR ( ) ! && ||  Note: "," included for legacy queries (translated to AND). 

---------------
Example queries
---------------

Example 1: String Query
-----------------------

::
  
  ...
  store.fetch({query: "NOT id:23* AND (type:'test*' OR dept:'bob') && !filed:true", onComplete: doSomething}
  ...

Example 1: Object-Based Query
------------------------------

::
  
  ...
  store.fetch({query: {complexQuery:"NOT id:23* AND (type:'test*' OR dept:'bob') && !filed:true"}, onComplete: doSomething}
  ...
