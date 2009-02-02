#format dojo_rst

dojo.withDoc
===============

:Status: Draft
:Version: 1.0
:Available: since V0.9

.. contents::
   :depth: 2

dojo.withDoc provides a mechanism by which a function can have the document root temporarily changed for the execution of the function.  This allows document scope changes without affecting other items in the current dojo application.

============
Introduction
============

This function provides a quick way to alter the 'document' root as seen by dojo for specific operations.  This is most notably useful when iframes are involved and you want to use a core dojo function, such as dojo.query or dojo.style against contents of that iframe.  

=====
Usage
=====

Use this function to replace the dojo.doc for a function . Only during the function execution, dojo.doc is assigned the values you specify.

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   var iframeDoc = frames['myIframe'].document;
   console.log(iframeDoc);

   //Call a callback with different 'global' values and context. 
   dojo.withDoc(iframeDoc  function() {
     var someDiv = dojo.query("someDiv");
     dojo.style(someDiv, "color", "red");
   }, this)); 
 </script>


========
Examples
========

Example 1: Using dojo.withDoc alter documents in an iFrame.
-----------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.Button");

      function changeStyles() {
        //Look up the node we'll stick the text under.
        var button = dijit.byId("changeStyles");

        dojo.connect(button, "onClick", function() {
         var frameDoc = frames['myFrame'].document;
         dojo.withDoc(frameDoc, function() {
           console.debug(dojo.doc);
           var table= dojo.query("table");
           console.debug(table);
           dojo.style(table, "color", "red");
           console.debug("Blah");
         });
        });
      }
      dojo.addOnLoad(changeStyles);
    </script>

  .. cv :: html 

    <button id="changeStyles" dojoType="dijit.form.Button">Change Text Color in iFrame</button>
    <br><br>
    <iframe name="myFrame" src="/moin_static163/js/dojo/trunk/release/dojo/dojox/data/tests/stores/books.html" width="500", height="500">
    </iframe>



========
See also
========

* `dojo.doc <dojo/doc>`_
