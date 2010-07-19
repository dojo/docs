#format dojo_rst

dojo.withDoc
===============

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

Use this function to replace the dojo.doc reference for a specific function call. Only during that specific function execution is dojo.doc assigned the document you specify.  The below example demonstrates how to use it against an iframe document to query into the iframe and make updates.

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   var iframeDoc = dojo.byId("someFrameId").contentWindow.document;

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
        var button = dijit.byId("changeStyles");
        dojo.connect(button, "onClick", function() {
         
         //Apply styles to the document contained by the iframe
         var frameDoc = dojo.byId("simpleFrame").contentWindow.document;
         dojo.withDoc(frameDoc, function() {
           var tds= dojo.query("td");
           dojo.forEach(tds, function(cell) {
             dojo.style(cell, "color", "red");
           }, this);
         });
        });
      }
      dojo.addOnLoad(changeStyles);
    </script>

  .. cv :: html 

    <button id="changeStyles" dojoType="dijit.form.Button">Change Text Color in iFrame</button>
    <br><br>
    <iframe id="simpleFrame" name="simpleFrame" src="{{dataUrl}}dojox/data/tests/stores/books.html" style="width: 500px; height: 500px;">
    </iframe>



========
See also
========

* `dojo.doc <dojo/doc>`_
