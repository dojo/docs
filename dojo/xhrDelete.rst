#format dojo_rst

dojo.xhrDelete
==============

:Status: Draft
:Version: 1.0
:Available: since V0.9

.. contents::
   :depth: 2


============
Introduction
============

The dojo.xhrDelete() function is is a lesser used, but still important, function for doing asynchronous actions to a server.  This function is mostly used in REST style environments, where an application wishes to delete a resource on the server   This function, in essence, implements making an asynchronous HTTP 'DELETE' call.  You can refer to the `HTTP spec <http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html>1_ for more information on what is defined and expected for a DELETE operation.

The following information should get you up and going with dojo.xhrDelete().  As with all dojo functions, always refer to the API docs for detailed information.

===========
Limitations
===========

The general limitations are the same as `dojo.xhrGet <dojo/xhrGet>`_.  Also be aware that your server side must permit the DELETE operation for this method to work with a server.  Some servers by default disable HTTP DELETE support.  So, when using this method be sure your server allows HTTP DELETE and that your services will understand and do the appropriate action.

=====
Usage
=====

The xhrDelete() function takes an object as its parameter.  This object defines how the xhrDelete should operate.  Generally the `dojo.xhrGet parameters <dojo/xhrGet#dojo-xhrget-supported-object-properties>`_ are valid, including how to set the load and errors handlers.  So, for specific information about those parameters, please refer to dojo.xhrGet.  This page only lists out the parameters which are usually only used in conjunction with with a DELETE.  Bear in mind that since the HTTP DELETE operation is for deleting resources at a URI, the URI (URL + query params), are the critical identifiers.  DELETEs do not normally have content bodies.

dojo.xhrDelete supported object properties
----------------------------------------

All of the dojo.xhrGet `object properties <dojo/xhrGet#dojo-xhrget-supported-object-properties>`_

Return type (dojo.Deferred)
---------------------------

The return type is the same as dojo.xhrGet.  Please refer to the `return type <dojo/xhrGet#dojo-xhrget-supported-object-properties>`_ documentation for details.

Handling Status Codes
---------------------

Handling status codes for xhrPost is the same as handling them for xhrGet.  Please refer to the dojo.xhrGet `status code documentation <dojo/xhrGet#handling-status-codes>`_ for details.

========
Examples
========

For specific examples of how to use dojo.xhrPost, please refer to the following.  You can use Firebug with Firefox to see dojo making the xhr requests and the generated POST data.  For Internet Explorer, you will need to use a debugging proxy like 'Charles'.
 
Example 1: dojo.xhrPost call to send a form
-------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
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

  .. cv :: html 

    <b>Simple Form:</b>
    <br>
    <blockquote>
      <form action=postIt" id="myform">
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

.. cv-compound ::
  
  .. cv :: javascript

    <script>
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

  .. cv :: html 

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
