#format dojo_rst

dojox.data.AppStore
===================

:Status: Draft
:Version: 1.0
:Project owner: Benjamin Schell
:Available: since V1.3

.. contents::
   :depth: 2

A store implementing an Atom store with complete ATOM Publishing Protocol support. Allows reading and writing of ATOM formatted feeds.

============
Introduction
============

The dojox.data.AppStore is data store implementation of the ATOM Publishing Protocol (APP).  It makes use of the dojox.atom subproject for handling ATOM feeds and entries.  

===========
Limitations
===========

The AppStore makes use of dojo.xhr to get and modify feeds and entries.  Because of this, the AppStore is limited by the browser same domain policy, where xhr can only open connections back to the server that originated the page.  If you require accessing ATOM feeds from external services, you will need to make use of a proxy.

==============
Supported APIs
==============

The following dojo.data APIs are implemented by AppStore

* `dojo.data.api.Read <dojo/data/api/Read>`_
* `dojo.data.api.Write <dojo/data/api/Write>`_
* `dojo.data.api.Identity <dojo/data/api/Identity>`_

======================
Constructor Parameters
======================

+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| **Parameter**  | **Required** | **Description**                                                                                | **Since** |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
| url            | No           |This parameter specifies what URL from which to load the ATOM feed document, and is also the    |1.3        |
|                |              |base url used for publishing new feed entries if the feed supports it.                          |           |
+----------------+--------------+------------------------------------------------------------------------------------------------+-----------+
  


=================
Input Data Format
=================

The input data format is the standard `ATOM <http://en.wikipedia.org/wiki/Atom_(standard)>`_ feed format.  An example of an ATOM feed is below:

.. code

=====
Usage
=====

TODO: how to use the component/class/method

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // your code
 </script>



========
Examples
========

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

TODO: example


========
See also
========

* TODO: links to other related articles
