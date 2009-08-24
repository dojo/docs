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

The following information should get you up and going with dojo.xhrGet().  As with all dojo functions, always refer to the API docs for detailed information.

===========
Limitations
===========

dojo.xhrGet (and other functions in the same line: dojo.xhrPost, dojo.xhrDelete, dojo.xhrPut), are bound by the 'same domain' security policy of the browser.  This means that they can only establish a connection back to the same server that served the HTML page.  If you wish to use this API to talk to servers other than the one that originated your page, then you will have to use a proxy on your originating server and have it forward the requests.  The only other solution to working around the same domain restriction is to use alternate IO methods, such as dojo.io.script.


=====
Usage
=====

The xhrGet() function takes an object as its parameter.  This object defines how the xhrGet should operate.  Minimally, this object must contain a 'url' attribute so that the function knows where to send the request.   Having just a 'url' attribute isn't the most useful approach to calling the function, though.  You can also embed information such as how to handle the return data (As XML, JSON, or text), and what do do when it completes.  It also accepts other useful parameters such as 'preventCache', and 'sync', which alter its behavior slightly.  For a reasonable list of all the options it supports, see the following table:

dojo.xhrGet supported object properties
---------------------------------------

+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**url**           |The URL to request data from.  This URL must go to the same server that originated the page or it will fail the load.  This |
|                  |is due to the same domain browser security restriction.                                                                     +
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**handleAs**      |This parameter specifies how to handle the data returned from the server.  It usually takes values of 'text', 'xml', or     |
|                  |'json'.  What those values do is instruct it to try and hand the data to the asynchronous callback functions in that format.|
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
|                  |                                                                                                                            |
|                  |                                                                                                                            |
|                  |  **Note:** As a matter of best practice, you should avoid using synchronized xhr calls unless there is no alternative.     |
|                  |  Synchronized xhr calls block all other activity in the browser and can make it appear hung.                               |
|                  |                                                                                                                            |
|                  |  **Note:** Setting sync disables timeout.  The browsers themselves do not permit timeouts xhr calls.  All timeout          |
|                  |  functionality is done by dojo code which cannot execute when 'sync' is set.                                               |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**preventCache**  |A boolean value that tells dojo.xhrGet to append a unique query parameter to each request.  The purpose of this  parameter  |
|                  |is to keep the browser from caching the results.  While it is generally good practice to let the server tell your browser   |
|                  |how to cache and when to clear, sometimes it is necessary to force the browser to not cache.                                |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**content**       |A JavaScript object of name/string value pairs.  These items are converted to query parameters and passed on as part of the |
|                  |url.  Example request made by the browser:  <url>?key1=value1&key2=value2&key3=value3..                                     |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**headers**       |A JavaScript object of name/string value pairs.  These are the headers to send as part of the request.  For example, you can|
|                  |use the headers option to set the Content-Type, X-Method-Override, or Content-Encoding headers of the HTTP request.         |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**timeout**       |Number of milliseconds to wait until timing out the request.  Default is '0', which means infinite (no timeout).            |
|                  |                                                                                                                            |
|                  |  **Note:** This parameter is ignored when 'sync is set.  Browser limitation.                                               |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**user**          |If your end point requires BASIC web authentication, then use can pass the user name using this parameter in the xhr request|
|                  |options.                                                                                                                    |
|                  |                                                                                                                            |
|                  |  **Note:**  This does **NOT** work for FORM based authentication. FORM based authentication is a use of POST, where the    |
|                  |  POST body contains the credentials.  FORM authentication is server implementation specific.                               | 
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**password**      |If your end point requires BASIC web authentication, then use can pass the password using this parameter in the xhr request |
|                  |options.                                                                                                                    |
|                  |                                                                                                                            |
|                  |  **Note:**  This does **NOT** work for FORM based authentication. FORM based authentication is a use of POST, where the    |
|                  |  POST body contains the credentials.  FORM authentication is server implementation specific.                               |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**load**          |The function dojo.xhrGet should invoke when the data is returned from the server.  The function should expect to receive at |
|                  |at least one parameter, the data returned from the url.  The format of the data is controlled by the previously mentioned   |
|                  |*handleAs* parameter.                                                                                                       |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**error**         |Sometimes xhrGet calls will fail.  Often these are 404 errors or server errors such as 500.  The error parameter is another |
|                  |callback function that is only invoked when an error occurs.  This allows you to control what happens when an error occurs  |
|                  |without having to put a lot of logic into your load function to check for error conditions.  The first parameter passed to  |
|                  |the error function is a JavaScript Error object indicating what the failure was.                                            |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**handle**        |Sometimes you want to do something regardless of whether a call completes or fails.  Thats where handle comes it, it will be|
|                  |invoked by xhr regardless.  The first parameter passed to this callback is the response (or error) and the second parameter |
|                  |is the IO args object, from which you can get the status code and determine success or failure.                             |                            
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|``New in 1.4``    |By default, dojo.xhrGet outputs an error to the console when there is a transport error.  Setting **failOk** to true will   |
|**failOk**        |prevent that behavior and will suppress the error message.                                                                  |                  |                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+

Return type (dojo.Deferred)
---------------------------

For both the synchronous and asynchronous cases, the dojo.xhrGet() call will return a 'dojo.Deferred' object.  This object allows you to define additional callbacks for success and error conditions.  It can also be used in place of defining 'load' and error' functions in your request parameters for dojo.xhrGet().  See Example 4 for details on how to use the dojo.Deferred object to set your load and error handlers.

Handling Status Codes
---------------------

There are times where knowing of a request was 'good' or 'bad' isn't really enough.  There are, in fact, many successful status codes that mean the request was completed successfully, but have specific meaning in how it was completed.  This situation often comes up in REST based implementations with server status codes like: 

* 201: (Created)
* 202: (Accepted), 
* 203: (Non-Authoritative Information)
* 204: (No Content).  

There are also many status codes in the 3XX range that have specific meaning as well.  So ... can dojo.xhrGet (And the others dojo.xhrPut, dojo.xhrDelete, etcera), provide the status code so a 'load' function can do something based on the status code?  

  **The answer is:  Yes.**

A second parameter is always passed to the 'load', 'error', and 'handle' functions.  This parameter is the 'ioargs' parameter.  It contains a lot of detail about the xhr request, including a reference to the actual native xhr object.  You can access the status code off that object via: 'ioargs.xhr.status'.  Please see Examples 6, 7, and 9 for a usage example of doing that.  

By making use of this status check, you can implement handling for authentication, proxy authentication, and myraid of other items you may need to react to, to make your application dynamic and user friendly.

========
Examples
========

For specific examples of how to use dojo.xhrGet, please refer to the following.  You can use Firebug with Firefox to see dojo making the xhr requests.

Example 1: dojo.xhrGet call to fetch the dojo license.
------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      function getLicense() {
        //Look up the node we'll stick the text under.
        var targetNode = dojo.byId("licenseContainer");
        
        //The parameters to pass to xhrGet, the url, how to handle it, and the callbacks.
        var xhrArgs = {
          url: "/moin_static163/js/dojo/trunk/dojo/LICENSE",
          handleAs: "text",
          load: function(data){
            //Replace newlines with nice HTML tags.
            data = data.replace(/\n/g, "<br>");

            //Replace tabs with spacess.
            data = data.replace(/\t/g, "&nbsp;&nbsp;&nbsp;");

            targetNode.innerHTML = data;
          },
          error: function(error){
            targetNode.innerHTML = "An unexpected error occurred: " + error;
          }
        }

        //Call the asynchronous xhrGet
        var deferred = dojo.xhrGet(xhrArgs);  
      }
      dojo.addOnLoad(getLicense);
    </script>

  .. cv :: html 

    <b>The Dojo License:</b>
    <div id="licenseContainer" style="height: 200px;"></div>


Example 2: dojo.xhrGet call to fetch the dojo license with preventCache.
------------------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      function getLicensePreventCache() {
        //Look up the node we'll stick the text under.
        var targetNode = dojo.byId("licenseContainerPreventCache");
        
        //The parameters to pass to xhrGet, the url, how to handle it, and the callbacks.
        var xhrArgs = {
          url: "/moin_static163/js/dojo/trunk/dojo/LICENSE",
          handleAs: "text",
          preventCache: true,
          load: function(data){
            //Replace newlines with nice HTML tags.
            data = data.replace(/\n/g, "<br>");

            //Replace tabs with spacess.
            data = data.replace(/\t/g, "&nbsp;&nbsp;&nbsp;");

            targetNode.innerHTML = data;
          },
          error: function(error){
            targetNode.innerHTML = "An unexpected error occurred: " + error;
          }
        }

        //Call the asynchronous xhrGet
        var deferred = dojo.xhrGet(xhrArgs);  
      }
      dojo.addOnLoad(getLicensePreventCache);

    </script>

  .. cv :: html 

    <div id="licenseContainerPreventCache" style="height: 200px;"></div>


Example 3: dojo.xhrGet call that errors.
----------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      function callError() {
        //Look up the node we'll stick the text under.
        var targetNode = dojo.byId("errorContainer");
        
        //The parameters to pass to xhrGet, the url, how to handle it, and the callbacks.
        var xhrArgs = {
          url: "/moin_static163/js/dojo/trunk/dojo/NoSuchFile",
          handleAs: "text",
          preventCache: true,
          load: function(data){
            targetNode.innerHTML = "Odd.  We should not see this text, an error should have occurred";
          },
          error: function(error){
            targetNode.innerHTML = "An expected error occurred for referencing of unavailable file (404): <br>&nbsp;&nbsp;&nbsp;" + error;
          }
        }

        //Call the asynchronous xhrGet
        var deferred = dojo.xhrGet(xhrArgs);  

      }
      dojo.addOnLoad(callError);

    </script>

  .. cv :: html 

    <div id="errorContainer" style="height: 100px;"></div>


Example 4: Alternate way to pass callbacks.
-------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      function getLicenseAlternateCB() {
        //Look up the node we'll stick the text under.
        var targetNode = dojo.byId("getLicenseAlternateCB");
        
        //The parameters to pass to xhrGet, the url, how to handle it, and the callbacks.
        var xhrArgs = {
          url: "/moin_static163/js/dojo/trunk/dojo/LICENSE",
          handleAs: "text",
          preventCache: true
        }

        //Call the asynchronous xhrGet
        var deferred = dojo.xhrGet(xhrArgs);  

        //Now add the callbacks
        deferred.addCallback(function(data) {
          //Replace newlines with nice HTML tags.
          data = data.replace(/\n/g, "<br>");

          //Replace tabs with spacess.
          data = data.replace(/\t/g, "&nbsp;&nbsp;&nbsp;");
  
          targetNode.innerHTML = data;
        });

        deferred.addErrback(function(error){
          targetNode.innerHTML = "An unexpected error occurred: " + error;
        });

      }
      dojo.addOnLoad(getLicenseAlternateCB);

    </script>

  .. cv :: html 

    <div id="getLicenseAlternateCB" style="height: 200px;"></div>

Example 5: dojo.xhrGet call with 'content' (query params).
----------------------------------------------------------

*Note:  You will need to use firebug or a proxy to see the query params appended to the url*

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      function getLicenseQueryParams() {
        //Look up the node we'll stick the text under.
        var targetNode = dojo.byId("getLicenseQueryParams");
        
        //The parameters to pass to xhrGet, the url, how to handle it, and the callbacks.
        var xhrArgs = {
          url: "/moin_static163/js/dojo/trunk/dojo/LICENSE",
          handleAs: "text",
          preventCache: true,
          content: {
            key1: "value1",
            key2: "value2",
            key3: "value3"
          },
          load: function(data){
            //Replace newlines with nice HTML tags.
            data = data.replace(/\n/g, "<br>");

            //Replace tabs with spacess.
            data = data.replace(/\t/g, "&nbsp;&nbsp;&nbsp;");

            targetNode.innerHTML = data;
          },
          error: function(error){
            targetNode.innerHTML = "An unexpected error occurred: " + error;
          }
        }

        //Call the asynchronous xhrGet
        var deferred = dojo.xhrGet(xhrArgs);  
      }
      dojo.addOnLoad(getLicenseQueryParams);
    </script>

  .. cv :: html 

    <div id="getLicenseQueryParams" style="height: 200px;"></div>

Example 6: dojo.xhrGet call and checking the xhr 'status' code
--------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      function getLicenseStatus() {
        //Look up the node we'll stick the text under.
        var targetNode = dojo.byId("getLicenseStatus");
        
        //The parameters to pass to xhrGet, the url, how to handle it, and the callbacks.
        var xhrArgs = {
          url: "/moin_static163/js/dojo/trunk/dojo/LICENSE",
          handleAs: "text",
          preventCache: true,
          load: function(data, ioargs){
            targetNode.innerHTML = "XHR returned HTTP status: " + ioargs.xhr.status;
          },
          error: function(error, ioargs){
            targetNode.innerHTML = "An unexpected error occurred: " + error;
          }
        }

        //Call the asynchronous xhrGet
        var deferred = dojo.xhrGet(xhrArgs);  
      }
      dojo.addOnLoad(getLicenseStatus);
    </script>

  .. cv :: html 

    <div id="getLicenseStatus" style="height: 100px;"></div>

Example 7: dojo.xhrGet call and checking the xhr 'status' code in error handler
-------------------------------------------------------------------------------
*Note: This ust shows using switch in an error handler to display some message based on a particular failure.*

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      function getLicenseErrorStatus() {
        //Look up the node we'll stick the text under.
        var targetNode = dojo.byId("getLicenseErrorStatus");
        
        //The parameters to pass to xhrGet, the url, how to handle it, and the callbacks.
        var xhrArgs = {
          url: "/moin_static163/js/dojo/trunk/dojo/LICENSE_NOT_THERE",
          handleAs: "text",
          preventCache: true,
          load: function(data, ioargs){
            targetNode.innerHTML = "XHR returned HTTP status: " + ioargs.xhr.status;
          },
          error: function(error, ioargs){
            var message = "";
            switch(ioargs.xhr.status){
               case 404:
                 message = "The requested page was not found";
                 break;
               case 500:
                 message = "The server reported an error.";
                 break;
               case 407:
                 message = "You need to authenticate with a proxy.";
                 break;
               default:
                 message = "Unknown error.";
            }
            targetNode.innerHTML = message;
          }
        }

        //Call the asynchronous xhrGet
        var deferred = dojo.xhrGet(xhrArgs);  
      }
      dojo.addOnLoad(getLicenseErrorStatus);
    </script>

  .. cv :: html 

    <div id="getLicenseErrorStatus" style="height: 100px;"></div>


Example 8: dojo.xhrGet call with headers
----------------------------------------

*Note:  You will need to use firebug or a proxy to see the headers set in the request*

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      function getLicenseHeaders() {
        //Look up the node we'll stick the text under.
        var targetNode = dojo.byId("getLicenseHeaders");
        
        //The parameters to pass to xhrGet, the url, how to handle it, and the callbacks.
        var xhrArgs = {
          url: "/moin_static163/js/dojo/trunk/dojo/LICENSE",
          handleAs: "text",
          preventCache: true,
          headers: {
            "Content-Type": "text/plain",
            "Content-Encoding": "ISO-8859-1",
            "X-Method-Override": "FANCY-GET"
          },
          load: function(data){
            //Replace newlines with nice HTML tags.
            data = data.replace(/\n/g, "<br>");

            //Replace tabs with spacess.
            data = data.replace(/\t/g, "&nbsp;&nbsp;&nbsp;");

            targetNode.innerHTML = data;
          },
          error: function(error){
            targetNode.innerHTML = "An unexpected error occurred: " + error;
          }
        }

        //Call the asynchronous xhrGet
        var deferred = dojo.xhrGet(xhrArgs);  
      }
      dojo.addOnLoad(getLicenseHeaders);
    </script>

  .. cv :: html 

    <div id="getLicenseHeaders" style="height: 200px;"></div>


Example 9: dojo.xhrGet call and checking the xhr 'status' code in 'handle'
--------------------------------------------------------------------------
*Note: This shows using switch in a generic handle function to error display some message based on a particular failure or success.*

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      function getLicenseErrorStatusWithHandle() {
        //Look up the node we'll stick the text under.
        var targetNode = dojo.byId("getLicenseErrorStatusWithHandle");
        
        //The parameters to pass to xhrGet, the url, how to handle it, and the callbacks.
        var xhrArgs = {
          url: "/moin_static163/js/dojo/trunk/dojo/LICENSE_NOT_THERE",
          handleAs: "text",
          preventCache: true,
          handle: function(error, ioargs){
            var message = "";
            switch(ioargs.xhr.status){
               case 200: 
                 message = "Good request.";
                 break;
               case 404:
                 message = "The requested page was not found";
                 break;
               case 500:
                 message = "The server reported an error.";
                 break;
               case 407:
                 message = "You need to authenticate with a proxy.";
                 break;
               default:
                 message = "Unknown error.";
            }
            targetNode.innerHTML = message;
          }
        }

        //Call the asynchronous xhrGet
        var deferred = dojo.xhrGet(xhrArgs);  
      }
      dojo.addOnLoad(getLicenseErrorStatusWithHandle);
    </script>

  .. cv :: html 

    <div id="getLicenseErrorStatusWithHandle" style="height: 100px;"></div>


========
See also
========

* `dojo.xhrPost <dojo/xhrPost>`_
* `dojo.rawXhrPost <dojo/rawXhrPost>`_
* `dojo.xhrPut <dojo/xhrPut>`_
* `dojo.rawXhrPut <dojo/rawXhrPut>`_
* `dojo.xhrDelete <dojo/xhrDelete>`_
