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

The xhrPost() function takes an object as its parameter.  This object defines how the xhrPost should operate.  Like its counterpart, dojo.xhrGet,  this object must contain a 'url' attribute so that the function knows where to send the request.  Additionally, all the `dojo.xhrGet parameters <dojo/xhrGet#dojo-xhrget-supported-object-properties>`_ are valid, including how to set the load and errors handlers.  So, for specific information about those parameters, please refer to dojo.xhrGet.  This page only lists out the parameters which are usually only used in conjunction with with a POST.

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

The return type is the same as dojo.xhrGet.  Please refer to the `return type <dojo/xhrGet#dojo-xhrget-supported-object-properties>`_ documentation for details.

Handling Status Codes
---------------------

Handling status codes for xhrPost is the same as handling them for xhrGet.  Please refer to the `status code documentation <dojo/xhrGet#handling-status-codes>`_ for details.

========
Examples
========

For specific examples of how to use dojo.xhrPost, please refer to the following.  You can use Firebug with Firefox to see dojo making the xhr requests and the generated POST data.

Example 1: dojo.xhrPost call to send a form
-------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dijit.form.TextBox");

      function sendForm() {
        var button = dijit.byId("submitButton");

        dojo.connect(button, "onClick", function(event){
          //Stop the submit event since we want to control form submission.
          event.preventDefault();
          event.stopPropagation();

          //The parameters to pass to xhrPost, the form, how to handle it, and the callbacks.
          //Note that there isn't a url passed.  xhrPost will extract the url to call from the form's
          //'action' attribute.  You could also leave off the action attribute and set the url of the xhrPost object
          //either should work.
          var xhrArgs = {
            form: dojo.byId("myform"),
            handleAs: "text",
            load: function(data){
              dojo.byId("response").innerHTML = "Message posted.";
            },
            error: function(error){
              //We'll 404 in the demo, but that's okay.  We don't have a 'postIt' service on the 
              //docs server.
              dojo.byId("response").innerHTML = "Message posted.";
            }
          }
          //Call the asynchronous xhrPost
          var deferred = dojo.xhrPost(xhrArgs);  
        });
      }
      dojo.addOnLoad(sendForm);
    </script>

  .. cv :: html 

    <b>Simple Form:</b>
    <form action=postIt" id="myform">
      <input type="text" dojoType="dijit.form.TextBox" name="formInput"></input>
      <button type="submit" dojoType="dijit.form.Button" id="submitButton">Send it!</button>
    </form>
    <br>
    <b>Result</b>
    <div id="response"></div>

========
See also
========

* `dojo.xhrGet <dojo/xhrGet>`_
* `dojo.xhrPut <dojo/xhrPut>`_
* `dojo.rawXhrPut <dojo/rawXhrPut>`_
* `dojo.xhrDelete <dojo/xhrDelete>`_
