#format dojo_rst

dojo.xhrPost
============

:Status: Draft
:Version: 1.0
:Available: since V0.9

.. contents::
   :depth: 2


============
Introduction
============

The dojo.xhrPost() function is another the cornerstone function of AJAX development.  Much like its `GET counterpart <dojo/xhrGet>`_ (dojo.xhrGet), its purpose is to provide an easy to use and consistent interface to making asynchronous calls.  The dojo.xhrPost is geared towards  sending data to the server, most often by posting FORM data, or some content body.  This function, in essence, implements making an asynchronous HTTP 'POST' call.

The following information should get you up and going with dojo.xhrPost().  As with all dojo functions, always refer to the API docs for detailed information.

===========
Limitations
===========

dojo.xhrPost (and other functions in the same line: dojo.xhrGet, dojo.xhrDelete, dojo.xhrPut), are bound by the 'same domain' security policy of the browser.  This means that they can only establish a connection back to the same server that served the HTML page.  If you wish to use this API to talk to servers other than the one that originated your page, then you will have to use a proxy on your originating server and have it forward the requests.  The only other solution to working around the same domain restriction is to use alternate IO methods, such as dojo.io.script.


=====
Usage
=====

The xhrPst() function takes an object as its parameter.  This object defines how the xhrPost should operate.  Like its counterpart, dojo.xhrGet,  this object must contain a 'url' attribute so that the function knows where to send the request.  Additionally, all the dojo.xhrGet parameters are valid, including how to set the load and errors handlers.  So, for specific information about those parameters, please refer to dojo.xhrGet.  This page only lists out the parameters which are usually only used in conjunction with with a POST.

dojo.xhrPost supported object properties
----------------------------------------

All of the dojo.xhrGet `object properties <dojo/xhrGet#dojo-xhrget-supported-object-properties>`_

+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**form**          |For posting FORM data, you can provide a either the DOM node of your form or the ID of the form.  The xhrPost will convert  |
|                  |this into proper POST format and send it with the post data.                                                                |
|                  |                                                                                                                            |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**postContent**   |A string of data you wish to send as the post body.  dojo.xhrPost (and dojo.rawXhrPost), do not do any processing of this   |
|                  |It is merely passed through as the POST body.                                                                               |
|                  |                                                                                                                            |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+


Return type (dojo.Deferred)
---------------------------

The return type is the same as dojo.xhrGet.  Please refer to the `return type <dojo/xhrGet#dojo-xhrget-supported-object-properties>` documentation for details.

Handling Status Codes
---------------------

Handling status codes for xhrPost is the same as handling them for xhrGet.  Please refer to the `status code documentation <dojo/xhrGet#handling-status-codes>`_ for details.

========
Examples
========

For specific examples of how to use dojo.xhrPost, please refer to the following.  You can use Firebug with Firefox to see dojo making the xhr requests.

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


========
See also
========

* `dojo.xhrGet <dojo/xhrPost>`_
* `dojo.xhrPut <dojo/xhrPut>`_
* `dojo.rawXhrPut <dojo/rawXhrPut>`_
* `dojo.xhrDelete <dojo/xhrDelete>`_
