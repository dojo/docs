#format dojo_rst

dojo.xhrGet
===========

:Status: Draft
:Version: 1.0
:Available: since V0.9

.. contents::
   :depth: 2


============
Introduction
============

The dojo.xhrGet() function is the cornerstone function of AJAX development.  Its purpose is to provide an easy to use and consistent interface to making asynchronous calls to retrieve data.  This API is an abstraction atop the browser's XMLHttpRequest object and makes usage the same regardless of which browser your application is running on.  This makes it much simpler to write cross-browser compatible AJAX style applications.

===========
Limitations
===========

Keep in mind that since dojo.xhrGet (and other functions in the same line: dojo.xhrPost, dojo.xhrDelete, dojo.xhrPut), are bound by the 'same domain' security policy of the browser.  This means that they can only establish a connection back to the same server that served the HTML page.  If you wish to use this API to talk to servers other than the one that originated your page, then you will have to use a proxy on your originating server and have it forward the requests.  The only other solution to working around the same domain restriction is to use alternate IO methods, such as dojo.io.script.


=====
Usage
=====

The xhrGet() function takes an object as its parameter.  This object defines how the xhrGet should operate.  Minimally, this object must contain a 'url' attribute so that the function knows where to send the request.   Having just a 'url' attribute isn't the most useful approach to calling the function, though.  You can also embed information such as how to handle the return data (As XML, JSON, or text), and what do do when it completes.  It also accepts other useful parameters such as 'preventCache', and 'sync', which alter its behavior slightly.  For a reasonable list of all the options it supports, see the following table:

+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**url**           |The URL to request data from.  This URL must go to the same server that originated the page or it will fail the load.  This |
|                  |is due to the same domain browser security restriction.                                                                     +
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**handleAs**      |This parameter specifies how to handle the data returned from the browser.  It usually takes values of 'text', 'xml', or    |
|                  |'json'.  What those values do is instruct it to try and hand the data to the asynchronous callback functions in those       |
|                  |Naturally if you specify a format that doesn't match what the server sends you will likely get an error.                    |
|                  |                                                                                                                            |
|                  |The currently supported options are:                                                                                        |
|                  |                                                                                                                            |
|                  |* text (default)                                                                                                            |
|                  |* json                                                                                                                      |
|                  |* json-comment-optional                                                                                                     |
|                  |* json-comment-filtered                                                                                                     |
|                  |* javascript                                                                                                                |
|                  |* xml                                                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------------------------------+

are:

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
preventCache
  A boolean value.  When set to true, caching is prevented.

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
