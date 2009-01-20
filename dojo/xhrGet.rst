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
|**content**       |A JavaScript object of name/string value pairs.  These items are converted to query parameters and passed on as part of the |
|                  |url.  Example request made by the browser:  <url>?key1=value1&key2=value2&key3=value3...                                    |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**timeout**       |Number of milliseconds to wait until timing out the request.  Default is unlimited.                                         |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**load**          |The function dojo.xhrGet should invoke when the data is returned from the server.  The function should expect to receive at |
|                  |at least one parameter, the data returned from the url.  The format of the data is controlled by the previously mentioned   |
|                  |*handleAs* parameter.                                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**error**         |Sometimes xhrGet calls will fail.  Often these are 404 errors or server errors such as 500.  The error parameter is another |
|                  |callback function that is only invoked when an error occurs.  This allows you to control what happens when an error occurs  |
|                  |without having to put a lot of logic into your load function to check for error conditions.  The first parameter passed to  |
|                  |the error function is a JavaScript Error object indicating what the failure was.                                            |
+------------------+----------------------------------------------------------------------------------------------------------------------------+

For both the synchronous and asynchronous cases, the dojo.xhrGet() call will return a 'dojo.Deferred' object.  This object allows you to define additional callbacks for success and error conditions.  It can also be used in place of defining 'load' and error' functions in your request parameters for dojo.xhrGet().

For specific examples of how to use dojo.xhrGet, please refer to the next section.  You can use Firebug with Firefox to see dojo making the xhr requests.

========
Examples
========

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
            key1="value1",
            key2="value2",
            key3="value3"
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

    <div id="getLicenseQueryParams" style="height: 100px;"></div>


========
See also
========

* `dojo.xhrPut <dojo/xhrPut>`_
* `dojo.rawXhrPut <dojo/rawXhrPut>`_
* `dojo.xhrPost <dojo/xhrPost>`_
* `dojo.rawXhrPost <dojo/rawXhrPost>`_
* `dojo.xhrDelete <dojo/xhrDelete>`_
