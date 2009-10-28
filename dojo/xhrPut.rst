#format dojo_rst

dojo.xhrPut
===========

:Available: since V0.9

.. contents::
   :depth: 2


============
Introduction
============

The dojo.xhrPut() function is lesser used function for pushing data for a server.  It is similar to POST, but in terms of the `HTTP spec <http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html>`_ it has different meaning.  Also, common patters like REST define a PUT and a POST as different things.  For services that follow `REST <http://en.wikipedia.org/wiki/Representational_State_Transfer>`_ conventions, this function will be important.  Much like its `GET counterpart <dojo/xhrGet>`_ (dojo.xhrGet), its purpose is to provide an easy to use and consistent interface to making asynchronous calls.  The dojo.xhrPut is geared towards sending raw data to the server as a content body.  This function, in essence, implements making an asynchronous HTTP 'PUT' call.

The following information should get you up and going with dojo.xhrPut().  As with all dojo functions, always refer to the API docs for detailed information.

===========
Limitations
===========

The limitations are the same as `dojo.xhrGet <dojo/xhrGet>`_

=====
Usage
=====

The xhrPut() function takes an object as its parameter.  This object defines how the xhrPost should operate.  All the `dojo.xhrGet parameters <dojo/xhrGet#dojo-xhrget-supported-object-properties>`_ are valid, including how to set the load and errors handlers.  So, for specific information about those parameters, please refer to dojo.xhrGet.  This page only lists out the parameters which are usually only used in conjunction with with a PUT.

dojo.xhrPost supported object properties
----------------------------------------

All of the dojo.xhrGet `object properties <dojo/xhrGet#dojo-xhrget-supported-object-properties>`_

+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**putData**       |A string of data you wish to send as the put body.  dojo.xhrPut (and dojo.rawXhrPut), do not do any processing of this      |
|                  |It is merely passed through as the PUT body.                                                                                |
|                  |                                                                                                                            |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+

Return type (dojo.Deferred)
---------------------------

The return type is the same as dojo.xhrGet.  Please refer to the `return type <dojo/xhrGet#return-type-dojo-deferred>`_ documentation for details.

Handling Status Codes
---------------------

Handling status codes for xhrPost is the same as handling them for xhrGet.  Please refer to the dojo.xhrGet `status code documentation <dojo/xhrGet#handling-status-codes>`_ for details.

========
Examples
========

For specific examples of how to use dojo.xhrPut, please refer to the following.  Firefox's Firebug does not show PUT content, unfortunately, so the only way to see the PUT content on the wire is to use a debugging proxy like 'Charles'.
 
Example 1: dojo.xhrPut call to send some text data
--------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");

      function sendText() {
        var button = dijit.byId("submitButton2");

        dojo.connect(button, "onClick", function(event){
          //The parameters to pass to xhrPut, the message, and the url to send it to
          //Also, how to handle the return and callbacks.
          var xhrArgs = {
            url: "putIt",
            putData: "Some random text",
            handleAs: "text",
            load: function(data){
              dojo.byId("response2").innerHTML = "Message put.";
            },
            error: function(error){
              //We'll 404 in the demo, but that's okay.  We don't have a 'putIt' service on the 
              //docs server.
              dojo.byId("response2").innerHTML = "Message put.";
            }
          }
          dojo.byId("response2").innerHTML = "Message being sent..."
          //Call the asynchronous xhrPost
          var deferred = dojo.xhrPut(xhrArgs);  
        });
      }
      dojo.addOnLoad(sendText);
    </script>

  .. cv :: html 

    <b>Push the button to PUT some text.</b>
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
* `dojo.xhrPost <dojo/xhrPost>`_
* `dojo.rawXhrPost <dojo/rawXhrPost>`_
* `dojo.xhrDelete <dojo/xhrDelete>`_
