.. _dojo/xhr:

==============
dojo.xhr
==============

:since: V0.9

.. contents ::
    :depth: 2

*Deprecated* - See :ref:`dojo/request/xhr <dojo/request/xhr>` instead.

**dojo.xhr** offers AJAX I/O transports and utility methods.

As with all dojo._base components, these functions are included within Dojo Base. You get this functionality by just including ``dojo.js`` in your page.


Introduction
============

The XMLHTTP request object (XHR for short) is one of the basic building blocks for constructing responsive Ajax-drive interactions. By allowing you to retrieve data on the user's behalf without refreshing the whole page the XHR object provides tremendous, but cross-browser XHR usage is beset by memory leaks, divergent APIs, a lack of built-in form encoding from JavaScript, and painful corner cases when de-serializing response data.

Dojo provides a solid set of battle-tested XHR wrapper functions to allow you to build Ajax interactions with confidence, use a unified API, and handle forms with ease. Read on to learn how easy it is to build powerful Ajax interactions with Dojo.


Features
========

* :ref:`dojo.formToJson <dojo/formToJson>` : Convert a DOM Form to JSON. It is an alias to domForm.toJson function.
* :ref:`dojo.formToObject <dojo/formToObject>` : Convert a DOM Form to a JavaScript object.It is an alias to domForm.toObject function.
* :ref:`dojo.formToQuery <dojo/formToQuery>` : Convert a DOM Form to a query string.It is an alias to domForm.toQuery function.
* :ref:`dojo.objectToQuery <dojo/objectToQuery>` : Convert a JavaScript object to a query string.It is an alias to ioq.objectToQuery function
* :ref:`dojo.queryToObject <dojo/queryToObject>` : Convert a query string to a JavaScript Object.It is an alias to ioq.queryToObject function
* :ref:`dojo.xhrDelete <dojo/xhrDelete>` : Use HTTP DELETE method to make an xhr call.
* :ref:`dojo.xhrGet <dojo/xhrGet>` : Use HTTP GET method to make an xhr call.
* :ref:`dojo.xhrPost <dojo/xhrPost>` : Use HTTP POST method to make an xhr call.
* :ref:`dojo.xhrPut <dojo/xhrPut>` : Use HTTP PUT method to make an xhr call.
* :ref:`dojo.rawXhrPost <dojo/rawXhrPost>` : Use HTTP POST method to make an xhr call.
* :ref:`dojo.rawXhrPut <dojo/rawXhrPut>` : Use HTTP PUT method to make an xhr call.


Examples
========

Each of the functions above have example use cases provided in their documentation.  Please refer to those examples for further details on the particular function usage.

One example is included below to get you started with xhrGet.  For more xhrGet examples, refer to the :ref:`xhrGet documentation <dojo/xhrGet>`.

Example 1:  dojo.xhrGet and form submission.
--------------------------------------------

dojo.xhr allows you to submit all the values of your form with minimal effort:

.. code-example ::

  .. js ::

        dojo.require("dijit.form.Form");
        dojo.require("dijit.form.Button");
        dojo.require("dijit.form.ValidationTextBox");

  .. html ::

    <form data-dojo-type="dijit/form/Form" id="myForm" data-dojo-id="myForm"
        encType="multipart/form-data" action="" method="">
        <label for="name">Name:</label>
        <input data-dojo-type="dijit/form/ValidationTextBox"
            type="text"
            id="name"
            name="name"
            value="your name"
            trim="true"
            maxLength="30" />

        <div data-dojo-type="dijit/form/Button">
            Submit
            <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
                // We are using dojo.xhrGet in this example, but
                // you can also use dojo.xhrPost or dojo.xhrPut.
                dojo.xhrGet({
                    // The target URL on your webserver:
                    url: "#",

                    // The form node, which contains the
                    // to be transferred form elements:
                    form: "myForm",

                    // The used data format.  Text is the most basic, no processing is done on it.
                    handleAs: "text",

                    // Timeout in milliseconds:
                    timeout: 5000,

                    // Event handler on successful call:
                    load: function(response, ioArgs){
                        // do something
                        // ...
                        dojo.byId("results").innerHTML = "Form submitted successfully.";
                    
                        // return the response for succeeding callbacks
                        return response;
                    },

                    // Event handler on errors:
                    error: function(response, ioArgs){
                        debug.dir(response);
                        dojo.byId("results").innerHTML = "Form submission failed.";
                    
                        // return the response for succeeding callbacks
                        return response;
                    }
                });
            </script>
        </div>
    </form>
    <br>
    <b> Submission results:</b>
    <br>
    <div id="results"></div>

In fact, the attribute "form:" could be set on each node, not only on form nodes. If your page contains more than one form and these forms are enclosed with a div- or span-tag, then you're able to submit all these forms, if you set "form:" to the surrounding div- or span-tag.


See also
========

* :ref:`quickstart/ajax <quickstart/ajax>`

  AJAX quickstart tutorial
