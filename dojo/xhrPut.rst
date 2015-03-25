.. _dojo/xhrPut:

===========
dojo.xhrPut
===========

:since: V0.9

.. contents ::
   :depth: 2

*Deprecated* - See :ref:`dojo/request/xhr <dojo/request/xhr>` instead.

Introduction
============

The dojo.xhrPut() function is lesser used function for pushing data for a server.  It is similar to POST, but in terms of the `HTTP spec <http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html>`_ it has different meaning.  Also, common patters like REST define a PUT and a POST as different things.  For services that follow `REST <http://en.wikipedia.org/wiki/Representational_State_Transfer>`_ conventions, this function will be important.  Much like its `GET counterpart <dojo/xhrGet>`_ (dojo.xhrGet), its purpose is to provide an easy to use and consistent interface to making asynchronous calls.  The dojo.xhrPut is geared towards sending raw data to the server as a content body.  This function, in essence, implements making an asynchronous HTTP 'PUT' call.

The following information should get you up and going with dojo.xhrPut().  As with all dojo functions, always refer to the API docs for detailed information.

Limitations
===========

The limitations are the same as :ref:`dojo.xhrGet <dojo/xhrGet>`

Usage
=====

The xhrPut() function takes an object as its parameter.  This object defines how the xhrPut should operate.  All the :ref:`dojo.xhrGet parameters <dojo/xhrGet>` are valid, including how to set the load and errors handlers.  So, for specific information about those parameters, please refer to dojo.xhrGet.  This page only lists out the parameters which are usually only used in conjunction with with a PUT.

dojo.xhrPut supported object properties
----------------------------------------

All of the dojo.xhrGet :ref:`object properties <dojo/xhrGet>`

+------------------+----------------------------------------------------------------------------------------------------------------------------+
|**data**          |A string of data you wish to send as the put body.  dojo.xhrPut (and dojo.rawXhrPut), do not do any processing of this      |
|                  |It is merely passed through as the PUT body.                                                                                |
|                  |                                                                                                                            |
|                  |                                                                                                                            |
|                  |**This parameter is optional**                                                                                              |
+------------------+----------------------------------------------------------------------------------------------------------------------------+

Return type (dojo.Deferred)
---------------------------

The return type is the same as dojo.xhrGet.  Please refer to the :ref:`return type <dojo/xhrGet>` documentation for details.

Handling Status Codes
---------------------

Handling status codes for xhrPut is the same as handling them for xhrGet.  Please refer to the dojo.xhrGet :ref:`status code documentation <dojo/xhrGet>` for details.

Examples
========

For specific examples of how to use dojo.xhrPut, please refer to the following.  PUT content can be observed in Firebug's Net tab, as well as by using a debugging proxy like 'Charles'.
 
Example 1: dojo.xhrPut call to send some text data
--------------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.Button");

      function sendText(){
        var button = dijit.byId("submitButton2");

        dojo.connect(button, "onClick", function(event){
          // The parameters to pass to xhrPut, the message, and the url to send it to
          // Also, how to handle the return and callbacks.
          var xhrArgs = {
            url: "putIt",
            data: "Some random text",
            handleAs: "text",
            load: function(data){
              dojo.byId("response2").innerHTML = "Message put.";
            },
            error: function(error){
              // We'll 404 in the demo, but that's okay.  We don't have a 'putIt' service on the
              // docs server.
              dojo.byId("response2").innerHTML = "Message put.";
            }
          }
          dojo.byId("response2").innerHTML = "Message being sent..."
          // Call the asynchronous xhrPut
          var deferred = dojo.xhrPut(xhrArgs);
        });
      }
      dojo.ready(sendText);

  .. html ::

    <b>Push the button to PUT some text.</b>
    <br>
    <br>
    <button data-dojo-type="dijit/form/Button" id="submitButton2">Send it!</button>
    <br>
    <br>
    <b>Result</b>
    <div id="response2"></div>

See also
========

* :ref:`dojo.xhrGet <dojo/xhrGet>`
* :ref:`dojo.xhrPost <dojo/xhrPost>`
* :ref:`dojo.rawXhrPost <dojo/rawXhrPost>`
* :ref:`dojo.xhrDelete <dojo/xhrDelete>`
