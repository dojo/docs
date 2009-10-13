#format dojo_rst

dojo.contentHandlers
====================

:Status: Draft
:Version: 1.4
:Available: since V1.4

.. contents::
   :depth: 2

dojo.contentHandlers is an object containing several pre-defined "handlers" for Ajax traffic, exposed as a public API to allow your own custom handlers to be mixed in.

=====
Usage
=====

The most common usage of contentHandlers is indirect. When making an Ajax call, the "handleAs" attribute is used to lookup in the dojo.contentHandlers dictionary. The function defined in the dictionary with a matching key is called, passing the XHR object used for the Ajax call. The **return** value from a contentHandler function is then passed to any "load", "handle" or callback functions. 

The default contentHandler is text, and requires no action:

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
     dojo.xhrGet({
         url:"foo.txt",
         load: function(data){
             // this uses the default dojo.contentHandlers.text. It simply returns plaintext.
         }
     });
 </script>



==================
Available Handlers
==================

There are several pre-defined contentHandlers available to use. The value represents the key in the handlers map. 

  * **text** (default) - Simply returns the response text
  * **json** - Converts response text into a JSON object
  * **xml** - Returns a XML document
  * **javascript** - Evaluates the response text
  * **json-comment-filtered** - A (arguably unsafe) handler to preventing JavaScript hijacking
  * **json-comment-optional** - A handler which detects the presence of a filtered response and toggles between json or json-comment-filtered appropriately. 
  
Programmatic example
--------------------

.. code-block :: javascript
  :linenos:

  dojo.xhrGet({
      url:"foo.json", 
      handleAs: "json",
      load: function(data){
          if(data && !data.error){ 
             // see if our response contains an `error` member. { error:"Something is wrong" } for example
          }else{
             // something went wrong :)
          }
      }
  });

=========================
Creating a custom handler
=========================

To create a custom contentHandler, simply mix a new key into the dojo.contentHandlers object defining the 'handleAs' value. The XHR object is passed to this function. For example: 

.. code-block :: javascript
  :linenos:

  dojo.mixin(dojo.contentHandlers, {
      "makeUpper": function(xhr){
           return xhr.responseText.toUpper();
       }
  });

  // then later:
  dojo.xhrPost({
      url:"foo.php", 
      handleAs:"makeUpper",
      load: function(data){
          // data is a CAPS version of the original responseText
      }
  });

One can create any number of content handlers, and can do about anything they choose within the provided API. For instance, the original args used to create the XHR object are stored on the object itself as `ioArgs` (eg: xhr.ioArgs) and can be used to mix custom attributes and instructions to the handler. 

For instance, we can create a handler that will populate a node with the response text automatically:

.. code-block :: javascript
  :linenos:

  // you don't need to mix(), you can just set the object directly if you prefer:
  dojo.contentHandlers.loadNode = function(xhr){
      var n = dojo.byId(xhr.ioArgs.node);
      n && n.innerHTML = xhr.responseText;
  }

  // to use:
  dojo.xhrGet({
       url:"foo.html", 
       handleAs:"loadNode",
       node: "someId"
  });

This will inject foo.html content into a node with id="someId". 

=====
Notes
=====

This functionality is "new" in Dojo 1.4. An alias to the "private" dojo._contentHandlers will remain in place until 2.0. Version prior to 1.4 can use the "private" alias the same way as outlined in this document. 
