#format dojo_rst

dojo.io.frame
=============

:Status: Contributed, Draft
:Version: 1.0
:Available: since V0.9

.. contents::
  :depth: 2

dojo.io.frame sends an AJAX I/O call using an IFrame (for instance, to upload files).

============
Introduction
============

The iframe IO functions are intended to handle complex IO operations that cannot be done through a basic dojo.xhr*() call.  These situations are fairly common and include the following:

* Calling a service on a server other than the one that originated the calling page (cross-domain request). Note that in this case, the response body cannot be read.  So you can send stuff, but not get any replies.
* Uploading files from a form (File Input controls).  The normal XHR mechanism cannot access file data referenced by file selection tags as a security measure.  An iframe, however, can, so by proxying those calls through an iframe make it possible to still do file uploads in an asynchronous manner.

It also retains much of the same operating semantics as dojo.xhrGet with regards to how you get the response from the service.  All results are response data is returned through callbacks.  There is a caveat to this; it requires the server to send the responese back in a very specific format, please refer to the `Additional Information <dojo/io/iframe#id1>`_ section.

=====
Usage
=====

Usage is similar to `dojo.xhrGet <dojo/xhrGet>`_ and `dojo.xhrPost <dojo/xhrPost>`_.  Please see below for information on specific properties that are accepted by the dojo.io.iframe functions and what they control.

dojo.io.iframe supported object properties
-------------------------------------------

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
|                  |* javascript                                                                                                                |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**method**        |The HTTP method to use when sending the iframe IO request.  It can be either **GET** or **POST** with the value of POST as  |
|                  |the default.                                                                                                                |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**form**          |For posting FORM data, you can provide a either the DOM node of your form or the ID of the form.  The dojo.io.iframe call   |
|                  |will convert this into proper POST format (query params or form content) and send it via the iframe                         |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**content**       |A JavaScript object of name/string value pairs.  These items are normally converted to query parameters and passed on as    |
|                  |part of the url.  The caveat to this is if you also specify a 'form' argument.  If a form  argument was also provided, then |
|                  |then the parameters of 'content' are merged into the values from the form and the whole thing is send as a multi-part form  |
|                  |post.                                                                                                                       |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+


Additional Information
----------------------

dojo.io.iframe calls cannot be made synchronous; therefore trying to set the 'sync' parameter (as shown in dojo.xhrGet()) will do nothing.  

**IMPORTANT:** For all values EXCEPT html, The server response should be an HTML file with a textarea element. The response data should be inside the textarea element. Using an HTML document is the only reliable, cross-browser way this transport can know when the response has loaded. For the text/html mimetype, just return a normal HTML document. NOTE: text/xml or any other XML type is NOT supported by this transport.  In other words, your services for XML, JSON, and Text formats should return the data wrapped as the following:

.. code-block :: javascript
  :linenos:

  <html>
    <body>
      <textarea>
        payload
      </textarea>
    </body>
  </html>


Other than the reason noted above about reliability (getting proper events indicating data retrieved), the choice of using textarea was because a textarea provides a fixed container that dojo can locate in the iframe DOM and extract the contents from.  And since it is a text area, it can contain JSON, XML, Text, etc.  Once the data is obtained, the usual data handlers from dojo process it and pass it back through the callbacks specified by the user.


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
        // The form node, which contains the
        // data. We also pull the URL and METHOD from it:
        form: "myForm",

        // The used data format:
        handleAs: "json",

        // Callback on successful call:
        load: function(response, ioArgs) {
            // do something
            // ...
                    
            // return the response for succeeding callbacks
            return response;
        }
    });
  </script>


Gather all parameters from a form, over-riding some
----------------------------------------------------

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
    dojo.require("dojo.io.iframe");

    // gather all parameters from a form:
    dojo.io.iframe.send({
        // The target URL on your webserver:
        url: "iframeHandler.php",

        // The HTTP method to use, form specified POST:
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
            param2: "my poor electrons!"
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

========
See Also
========

A common use of dojo.io.iframe is for uploading files in an Ajax-like manner. There are prefabricated widgets to do this as well, some using iframe transports, some using flash 9+

* `File Uploader <dojox/form/FileUploader>`_
* `File Input <dojox/form/FileInput>`_
