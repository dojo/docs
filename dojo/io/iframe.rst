#format dojo_rst

dojo.io.frame
=============

:Status: Contributed, Draft
:Version: 1.0
:Available: since V0.9

.. contents::
  :depth: 2

dojo.io.frame sends an AJAX I/O call using an IFrame (for instance, to upload files).


=====
Usage
=====

dojo.xhrGet supported object properties
---------------------------------------

+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**url**           |The URL to make the iframe request to.  This URL can refer to servers other than the one that originated the calling page.  | 
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**handleAs**      |This parameter specifies how to handle the data returned from the server.  It usually takes values of 'text', 'xml', or     |
|                  |'json'.  What those values do is instruct it to try and hand the data to the asynchronous callback functions in that format.|
|                  |Naturally if you specify a format that doesn't match what the server sends you will likely get an error.                    |
|                  |                                                                                                                            |
|                  |The currently supported options are:                                                                                        |
|                  |                                                                                                                            |
|                  |* text (default)                                                                                                            |
|                  |* json                                                                                                                      |
|                  |* xml                                                                                                                       |
|                  |* html                                                                                                                      |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**method**        |The HTTP method to use when sending the iframe IO request.  It can be either **GET** or **POST** with the value of POST as  |
|                  |the default.                                                                                                                |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**content**       |A JavaScript object of name/string value pairs.  These items are normally converted to query parameters and passed on as    |
|                  |part of the url.  The caveat to this is if you also specify a 'form' argument.  If a form  argument was also provided, then |
|                  |then the parameters of 'content' are merged into the values from the form and the whole thing is send as a multi-part form  |
|                  |post.  
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+


Important usage notes
---------------------

**IMPORTANT:** For all values EXCEPT html, The server response should be an HTML file with a textarea element. The response data should be inside the textarea element. Using an HTML document the only reliable, cross-browser way this transport can know when the response has loaded. For the text/html mimetype, just return a normal HTML document. NOTE: text/xml or any other XML type is NOT supported by this transport.  In other words, your services for XML, JSON, and Text formats should return the data wrapped as the following:

.. code-block :: javascript
  :linenos:

  <html>
    <body>
      <textarea>
        payload
      </textarea>
    </body>
  </html>


Other that the reason noted above about reliability (getting proper events indicating data retrieved), the choice of using textarea was because a textarea provides a fixed container that dojo can locate in the iframe DOM and extract the contents from.  And since it is a text area, it can contain JSON, XML, Text, etc.  Once the data is obtained, the usual data handlers from dojo process it and pass it back through the callbacks specified by the user.


========
Examples
========

Gather all parameters from a form
---------------------------------

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
    dojo.require("dojo.io.iframe");

    // gather all parameters from a form:
    dojo.io.iframe.send({
        // The target URL on your webserver:
        url: "iframeHandler.php",

        // The HTTP method to use:
        method: "GET",

        // The form node, which contains the
        // to be transfered form elements:
        form: "myForm",

        // The used data format:
        handleAs: "json",

        // Callback on successful call:
        load: function(response, ioArgs) {
            // do something
            // ...
                    
            // return the response for succeeding callbacks
            return response;
        },

        // Callback on errors:
        error: function(response, ioArgs){
            debug.dir(response);
                    
            // return the response for succeeding callbacks
            return response;
        }
    });
  </script>


Pass in parameters manually
---------------------------

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
    dojo.require("dojo.io.iframe");

    // pass in all of the parameters manually:
    dojo.io.iframe.send({
        // The target URL on your webserver:
        url: "iframeHandler.php",

        // The HTTP method to use:
        method: "GET",

        // the content to submit:
        content: {
            param1: "la dee dah",
            param2: "my poor electrons!",
        },

        // The used data format:
        handleAs: "json",

        // Callback on successful call:
        load: function(response, ioArgs) {
            // do something
            // ...
                    
            // return the response for succeeding callbacks
            return response;
        },

        // Callback on errors:
        error: function(response, ioArgs){
            debug.dir(response);
                    
            // return the response for succeeding callbacks
            return response;
        }
    });
  </script>
