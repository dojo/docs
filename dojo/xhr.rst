## page was renamed from 1.2/dojo/xhr
#format dojo_rst

dojo.xhr
========

:Status: Contributed, Draft
:Version: 1.0


TODO: insert documentation from the DojoBook


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
                dojo.xhrGet({
                  url: "#",
                  form: "myForm",
                  handleAs: "json",
                  timeout: 1000,
                  load: function(response, ioArgs) {
                    // do something
                    
                    // return the response for succeeding callbacks
                    return response;
                  },
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
