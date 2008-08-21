## page was renamed from 1.2/dojo/xhr
#format dojo_rst

dojo.xhr
========

.. contents::
    :depth: 2

:Status: Contributed, Draft
:Version: 1.0


The XMLHTTP request object (XHR for short) is one of the basic building blocks for constructing responsive Ajax-drive interactions. By allowing you to retrieve data on the user's behalf without refreshing the whole page the XHR object provides tremendous, but cross-browser XHR usage is beset by memory leaks, divergent APIs, a lack of built-in form encoding from JavaScript, and painful corner cases when de-serializing response data.

Dojo provides a solid set of battle-tested XHR wrapper functions to allow you to build Ajax interactions with confidence, use a unified API, and handle forms with ease. These APIs are built into Dojo Base, so you can use them in any page that includes dojo.js. Read on to learn how easy it is to build powerful Ajax interactions with Dojo.


Submitting Form values
----------------------

dojo.xhr allows you to submit all the values of your Form without effort:

.. cv-compound::

  .. cv:: javascript

    <script>
        dojo.require("dojo.xhrGet");
        dojo.require("dijit.form.Form");
        dojo.require("dijit.form.Button");
        dojo.require("dijit.form.ValidationTextBox");
    </script>

  .. cv:: html

    <form dojoType="dijit.form.Form" id="myForm" jsId="myForm"
        encType="multipart/form-data" action="" method="">
        <label for="name">Name:</label> 
        <input dojoType="dijit.form.ValidationTextBox" 
            type="text"  
            id="name" 
            name="name" 
            value="your name"  
            trim="true" 
            maxLength="30" />         

        <div dojoType="dijit.form.Button">
            Submit
            <script type="dojo/method" event="onClick" args="evt">
                // We are using dojo.xhrGet in this example, but
                // you can also use dojo.xhrPost or dojo.xhrPut.
                dojo.xhrGet({
                    // The URL on your webserver:
                    url: "#",

                    // The form node, which contains the to be
                    // transfered form elements:
                    form: "myForm",

                    // The used transfer protocol:
                    handleAs: "json",

                    // Timeout in milliseconds:
                    timeout: 1000,

                    // Event function on successful call:
                    load: function(response, ioArgs) {
                        // do something
                        // ...
                    
                        // return the response for succeeding callbacks
                        return response;
                    },

                    // Event function on errors:
                    error: function(response, ioArgs){
                        debug.dir(response);
                    
                        // return the response for succeeding callbacks
                        return response;
                    }
                });
            </script>
        </div>
    </form>

In fact, the attribute "form:" could be set on each node, not only on form nodes. If your page contains more than one form and these forms are enclosed with a div- or span-tag, then you're able to submit all these forms, if you set "form:" to the surronding div- or span-tag.
