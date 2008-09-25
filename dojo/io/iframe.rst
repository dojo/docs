#format dojo_rst

dojo.io.frame
=============

:Status: Contributed, Draft
:Version: 1.0
:Available: since V0.9

.. contents::
  :depth: 2

dojo.io.frame sends an IO call using an IFrame (for instance, to upload files).


=====
Usage
=====

Specific arguments for dojo.io.iframe calls:

* method: "POST". 

  What type of HTTP method to use for the request. Valid values are "POST" (default) or "GET".

* handleAs: Valid values are "text", "html", "xml", "json" and "javascript. 

  IMPORTANT: For all values EXCEPT html, The server response should be an HTML file with a textarea element. The response data should be inside the textarea element. Using an HTML document the only reliable, cross-browser way this transport can know when the response has loaded. For the text/html mimetype, just return a normal HTML document. NOTE: text/xml or any other XML type is NOT supported by this transport.


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
