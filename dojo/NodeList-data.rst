#format dojo_rst

dojo.NodeList-data
==================

.. contents::
   :depth: 2

:author: Peter Higgins
:since: 1.6.0

========
Overview
========

Provides a simple Data abstraction API to `dojo.NodeList <dojo/NodeList>`_, which is the result of calling `dojo.query <dojo/query>`_. This allows you to bind data items to individual nodes, knowing you will be able to retrieve the data later if you get a reference to that node. 

The public APIs for the module are exposed on `dojo.NodeList <dojo/NodeList>`_ as *data* and *removeData*. The *data* method acts as a setter getter, and *removeData* does as it's name suggests: remove all or some data from this node reference.

============
Using data()
============



=========
See Also:
=========

  * `dojo.data <dojo/data>`_ - dojo.data is an opaque Data API, unrelated to direct node references. More powerful and abstract than this node-data module. 
