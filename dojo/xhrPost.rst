#format dojo_rst

dojo.xhrPost
============

:Available: since V0.9

.. contents::
   :depth: 2


============
Introduction
============

The dojo.xhrPost() function is another the cornerstone function of AJAX development.  Much like its `GET counterpart <dojo/xhrGet>`_ (dojo.xhrGet), its purpose is to provide an easy to use and consistent interface to making asynchronous calls.  The dojo.xhrPost is geared towards  sending data to the server, most often by posting FORM data, or some content body.  This function, in essence, implements making an asynchronous HTTP POST request.

The following information should get you up and going with dojo.xhrPost().  As with all dojo functions, always refer to the API docs for detailed information.

===========
Limitations
===========

* Unable to post binary data. Consider `dojo.io.iframe <dojo/io/iframe>`_
* The limitations are the same as `dojo.xhrGet <dojo/xhrGet>`_

=====
Usage
=====

The xhrPost() function takes an object as its parameter.  This object defines how the xhrPost should operate.  All the `dojo.xhrGet parameters <dojo/xhrGet#dojo-xhrget-supported-object-properties>`_ are valid, including how to set the load and errors handlers.  So, for specific information about those parameters, please refer to dojo.xhrGet.  This page only lists out the parameters which are usually only used in conjunction with an HTTP POST request.

dojo.xhrPost supported object properties
----------------------------------------

All of the dojo.xhrGet `object properties <dojo/xhrGet#dojo-xhrget-supported-object-properties>`_

+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**content**       |A JavaScript object of name/string value pairs. xhrPost will convert this into proper POST format and send it with the post |
|                  |data. Note that this parameter is handled differently from `dojo.xhrGet <dojo/xhrGet>`_, which encodes it as a query string |
|                  |in url.                                                                                                                     |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**form**          |For posting FORM data, you can provide either the DOM node of your form or the ID of the form. xhrPost will convert         |
|                  |this into proper POST format and send it with the post data.  If a url is not set in the args to dojo.xhrPost, then it tries|
|                  |to extract the url from the form 'action' attribute.                                                                        |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**postData**      |A string of data you wish to send as the post body.  dojo.xhrPost (and dojo.rawXhrPost), do not do any processing of this   |
|                  |It is merely passed through as the POST body.                                                                               |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+

**content**, **form**, and **postData** are mutually exclusive parameters. Please use only one at a time.

If you want to send some parameters in a query string, while making POST, you should include them in url yourself. Dojo provides a special helper for that: `dojo.objectToQuery() <dojo/objectToQuery>`_, which can convert a dictionary into a valid query string --- just like `dojo.xhrGet <dojo/xhrGet>`_ does.

Return type (dojo.Deferred)
---------------------------

The return type is the same as dojo.xhrGet.  Please refer to the `return type <dojo/xhrGet#return-type-dojo-deferred>`_ documentation for details.

Handling Status Codes
---------------------

Handling status codes for xhrPost is the same as handling them for xhrGet.  Please refer to the dojo.xhrGet `status code documentation <dojo/xhrGet#handling-status-codes>`_ for details.

========
Examples
========


For specific examples of how to use dojo.xhrPost, please refer to the following.  You can use Firebug with Firefox to see dojo making the xhr requests and the generated POST data.  For Internet Explorer, you will need to use a debugging proxy like 'Charles'.

Example 1: dojo.xhrPost call to send a form
-------------------------------------------


.. code-example::

  .. javascript::

    <script type="text/javascript">
      dojo.require("dijit.form.Button");
      dojo.require("dijit.form.TextBox");
      dojo.require("dijit.form.CheckBox");

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
              dojo.byId("response").innerHTML = "Form posted.";
            },
            error: function(error){
              //We'll 404 in the demo, but that's okay.  We don't have a 'postIt' service on the
              //docs server.
              dojo.byId("response").innerHTML = "Form posted.";
            }
          }
          //Call the asynchronous xhrPost
          dojo.byId("response").innerHTML = "Form being sent..."
          var deferred = dojo.xhrPost(xhrArgs);
        });
      }
      dojo.addOnLoad(sendForm);
    </script>

  .. html::

    <b>Simple Form:</b>
    <br>
    <blockquote>
      <form action="postIt" id="myform">
        Text: <input type="text" dojoType="dijit.form.TextBox" name="formInput" value="Some text"></input><br><br>
        Checkbox: <input type="checkbox" dojoType="dijit.form.CheckBox" name="checkboxInput"></input><br><br>
        <button type="submit" dojoType="dijit.form.Button" id="submitButton">Send it!</button>
      </form>
    </blockquote>
    <br>
    <b>Result</b>
    <div id="response"></div>

Example 2: dojo.xhrPost call to send some text data
---------------------------------------------------

.. code-example::

  .. javascript::

    <script type="text/javascript">
      dojo.require("dijit.form.Button");

      function sendText() {
        var button = dijit.byId("submitButton2");

        dojo.connect(button, "onClick", function(event){
          //The parameters to pass to xhrPost, the message, and the url to send it to
          //Also, how to handle the return and callbacks.
          var xhrArgs = {
            url: "postIt",
            postData: "Some random text",
            handleAs: "text",
            load: function(data){
              dojo.byId("response2").innerHTML = "Message posted.";
            },
            error: function(error){
              //We'll 404 in the demo, but that's okay.  We don't have a 'postIt' service on the
              //docs server.
              dojo.byId("response2").innerHTML = "Message posted.";
            }
          }
          dojo.byId("response2").innerHTML = "Message being sent..."
          //Call the asynchronous xhrPost
          var deferred = dojo.xhrPost(xhrArgs);
        });
      }
      dojo.addOnLoad(sendText);
    </script>

  .. html::

    <b>Push the button to POST some text.</b>
    <br>
    <br>
    <button dojoType="dijit.form.Button" id="submitButton2">Send it!</button>
    <br>
    <br>
    <b>Result</b>
    <div id="response2"></div>

========
See also
========

* `dojo.xhrGet <dojo/xhrGet>`_
* `dojo.xhrPut <dojo/xhrPut>`_
* `dojo.rawXhrPut <dojo/rawXhrPut>`_
* `dojo.xhrDelete <dojo/xhrDelete>`_
