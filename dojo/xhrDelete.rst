#format dojo_rst

dojo.xhrDelete
==============

:Available: since V0.9

.. contents::
   :depth: 2


============
Introduction
============

The dojo.xhrDelete() function is is a lesser used, but still important, function for doing asynchronous actions to a server.  This function is mostly used in REST style environments, where an application wishes to delete a resource on the server   This function, in essence, implements making an asynchronous HTTP 'DELETE' call.  You can refer to the `HTTP spec <http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html>`_ for more information on what is defined and expected for a DELETE operation.

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
------------------------------------------

All of the dojo.xhrGet `object properties <dojo/xhrGet#dojo-xhrget-supported-object-properties>`_

Return type (dojo.Deferred)
---------------------------

The return type is the same as dojo.xhrGet.  Please refer to the `return type <dojo/xhrGet#return-type-dojo-deferred>`_ documentation for details.

Handling Status Codes
---------------------

Handling status codes for xhrPost is the same as handling them for xhrGet.  Please refer to the dojo.xhrGet `status code documentation <dojo/xhrGet#handling-status-codes>`_ for details.

========
Examples
========

For specific examples of how to use dojo.xhrDelete, please refer to the following.  You can use Firebug with Firefox to see dojo making the xhr requests and the fact it makes an HTTP DELETE call.  For Internet Explorer, you will need to use a debugging proxy like 'Charles'.
 
Example 1: dojo.xhrDelete call to request a 'delete' of a URI
-------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");

      function deleteUri() {
        var button = dijit.byId("deleteButton");

        dojo.connect(button, "onClick", function(event){
          //The parameters to pass to xhrPost, the message, and the url to send it to
          //Also, how to handle the return and callbacks.
          var xhrArgs = {
            url: "deleteIt",
            handleAs: "text",
            load: function(data){
              dojo.byId("response").innerHTML = "Delete completed";
            },
            error: function(error){
              //We'll 404 in the demo, but that's okay.  We don't have a 'postIt' service on the 
              //docs server.  This is fine.  Just treat it as a success for purposes of the example.
              dojo.byId("response").innerHTML = "Delete completed";
            }
          }
          dojo.byId("response").innerHTML = "Delete requested..."
          //Call the asynchronous xhrDelete
          var deferred = dojo.xhrDelete(xhrArgs);  
        });
      }
      dojo.addOnLoad(deleteUri);
    </script>

  .. cv :: html 

    <b>Push the button to request a DELETE via xhr.</b>
    <br>
    <br>
    <button dojoType="dijit.form.Button" id="deleteButton">Call DELETE!</button>
    <br>
    <br>
    <b>Result</b>
    <div id="response"></div>

========
See also
========

* `dojo.xhrGet <dojo/xhrGet>`_
* `dojo.xhrPost <dojo/xhrPost>`_
* `dojo.rawXhrPost <dojo/rawXhrPost>`_
* `dojo.xhrPut <dojo/xhrPut>`_
* `dojo.rawXhrPut <dojo/rawXhrPut>`_
