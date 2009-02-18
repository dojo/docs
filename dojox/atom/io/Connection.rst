#format dojo_rst

dojox.atom.io.Connection
========================

:Status: Draft
:Version: 1.0
:Project owner: Benjamin Schell
:Available: since V1.3

.. contents::
   :depth: 2

The *dojox.atom.io.Connection* module is a IO class for performing APP (ATOM Publishing Protocol) styled IO actions with a server.

============
Introduction
============

This module simplifies performing APP by handling the configuration of all the necessary xhr parameters as well as selecting the correct xhr method for performing a particular type of ATOM action, from getting a Feed (xhrGet), to publishing a new entry (xhrPut).  This class makes use of the dojox.atom.io.model class as its backing representation of the ATOM document and elements.

===========
Limitations
===========

Since this module uses the core `dojo.xhr <dojo/xhr>`_ functions for performing server communication, it is limited by the browser same-domain policy for xhr requests.  This means that it can only issue requests back to the server and port that served the HTML page using the API.  For accessing alternate servers, you will need to use a proxy to broker the request to the target server.

======================
Constructor Parameters
======================

+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| **Parameter**  | **Required** | **Description**                                                                                | **Since** |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| sync           | no           |This parameter configures the instance of Connection to issue its requests using the xhr 'sync' | 1.3       |
|                |              |option.  If it is set to true, then all calls will block until the data is returned.  This is   |           |
|                |              |not recommended, but available as an option.  The default is false.                             |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| preventCache   | No           |This parameter tells the Connection whether or not to append a query param to the URL to prevent|1.3        |
|                |              |the browser from caching the results of the IO call.  The default is false.                     |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+

=========
Functions
=========

+--------------------------------------------------------------+-----------------------------------------------------------------------------+
| **Function**                                                 | **Descriptions**                                                                                                                                 |
+--------------------------------------------------------------+-----------------------------------------------------------------------------+
| getFeed: function(url, callback, errorCallback, scope)       | Function to load a feed from a URL                                          |
+--------------------------------------------------------------+-----------------------------------------------------------------------------+



========
See Also
========

* `dojox.atom.io.model <dojox/atom/io/model>`_: The backing model for the Feed used by this connection API.
* `dojox.data.AppStore <dojox/data/AppStore>`_: A datastore built ontop of this API.  Provides full APP support.
