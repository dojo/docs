#format dojo_rst

dojo.xhrGet
===========

:Status: Draft
:Version: 1.0
:Available: since V?

.. contents::
   :depth: 2

TODO: short summary of the component/class/method


============
Introduction
============

`xhrGet() <http://api.dojotoolkit.org/jsdoc/dojo/HEAD/dojo.xhrGet>`_ executes an Ajax request to a server and retrieves data from that server.


=====
Usage
=====

The xhrGet() function taks a dojo._IoArgs object as a parameter.   This object declares how the xhrGet() function should operate.  The core properties of the object are:

url
  The URL to the source of the data.  This must be on the same server as the original page was loaded.
sync
  A boolean value that says whether or not the xhrGet() function should block or return immediately
handleAs
  This is an indicator to xhrGet() on how to handle the response data.  Supported types include:

* text (default)
* json
* json-comment-optional
* json-comment-filtered
* javascript
* xml

load
  This is a callback function that is invoked when the data is received from the server.  It has one parameter which is the data returned from the server.
error
  This is a callback function that is invoked if there is an error on the received data.  It has two parameters.  The first is the data returned from the server while the second is of type ``dojo.__IoCallbackArgs``.

There are more properties than these.


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
