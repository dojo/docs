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

The dojo.xhrGet() function is the cornerstone function of AJAX development.  Its purpose is to provide an easy to use and consistent interface to making asynchronous calls to retrieve data.  This API is an abstraction atop the browser's XMLHttpRequest object and makes usage the same regardless of which browser your application is running on.  This makes it much simpler to write cross-browser compatible AJAX style applications.  This function, in essence, implements making an HTTP 'GET' call.

===========
Limitations
===========

dojo.xhrGet (and other functions in the same line: dojo.xhrPost, dojo.xhrDelete, dojo.xhrPut), are bound by the 'same domain' security policy of the browser.  This means that they can only establish a connection back to the same server that served the HTML page.  If you wish to use this API to talk to servers other than the one that originated your page, then you will have to use a proxy on your originating server and have it forward the requests.  The only other solution to working around the same domain restriction is to use alternate IO methods, such as dojo.io.script.


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
|**sync**          |A boolean value that says whether or not the xhrGet() function should block until data is returned or return immediately and|
|                  |rely on callbacks for data handling.  The default value is *false*                                                          |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**preventCache**  |A boolean value that tells dojo.xhrGet to append a unique query parameter to each request.  The purpose of this  parameter  |
|                  |is to keep the browser from caching the results.  While it is generally good practice to let the server tell your browser   |
|                  |how to cache and when to clear, sometimes it is necessary to force the browser to not cache.                                |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**load**          |The function dojo.xhrGet should invoke when the data is returned from the server.  The function should expect to recieve at |
|                  |at least one parameter, the data returned from the url.  The format of the data is controlled by the previously mentioned   |
|                  |*handleAs* parameter.                                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**error**         |Sometimes xhrGet calls will fail.  Often these are 404 errors or server errors such as 500.  The error parameter is another |
|                  |callback function that is only invoked when an error occurs.  This allows you to control what happens when an error occurs  |
|                  |without having to put a lot of logic into your load function to check for error conditions.  The first parameter passed to  |
|                  |the error function is a JavaScript Error object indicating what the failure was.                                            |
+------------------+----------------------------------------------------------------------------------------------------------------------------+

For both the synchronous and asynchronous cases, the dojo.xhrGet() call will return a 'dojo.Deferred' object.  This object allows you to define additional callbacks for success and error conditions.  It can also be used in place of defining 'load' and error' functions in your request parameters for dojo.xhrGet().

For specific examples of how to use dojo.xhrGet, please refer to the next section.


========
Examples
========

Simple dojo.xhrGet call to fetch the dojo license.
--------------------------------------------------

Simple dojo.xhrGet call that errors.
------------------------------------

Alternate way to pass callbacks.
--------------------------------


========
See also
========

* `dojo.xhrPut <dojo/xhrPut>`_
* `dojo.rawXhrPut <dojo/rawXhrPut>`_
* `dojo.xhrPost <dojo/xhrPost>`_
* `dojo.rawXhrPost <dojo/rawXhrPost>`_
* `dojo.xhrDelete <dojo/xhrDelete>`_
