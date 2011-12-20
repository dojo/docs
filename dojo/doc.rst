.. _dojo/doc:

========
dojo.doc
========

:since: V0.9

.. contents ::
   :depth: 2

Alias for the current document.  This is normally the value of window["document"];


Introduction
============

The purpose of this class is twofold.  First, it provides a shorter reference to getting ahold of the current document.  Second, all references that make use of it can have its document scope altered temporarily by changes to the dojo.doc variable.  This is used by other functions :ref:`dojo.withDoc <dojo/withDoc>` and :ref:`dojo.setContext <dojo/setContext>` to change the document scope during certain operations.

Usage
=====

Use this variable in place of calls to window.document.  That way you are assured you will be working against the document that is considered to be the current 'page'.  And .. by using this variable, things that alter it will still operate properly against your widget during document changes.  This is particularly important for your custom widgets if they are to be used inside iframes and the like.

Dojo 1.7 (AMD)
--------------

.. js ::

   require(["dojo/_base/window"], function(win){
      var currentBody = win.body();  // You can also use: dojo.body() to get the current document body.
      var newText = win.doc.createTextNode("Some text");
      currentBody.appendChild(newText);
   });


Dojo < 1.7
----------

.. js ::

   var currentBody = dojo.doc.body;  // You can also use: dojo.body() to get the current document body.
   var newText = dojo.doc.createTextNode("Some text");
   currentBody.appendChild(newText);


Examples
========

Example usage of dojo.doc as replacement for document calls
-----------------------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.Button");
      function addText(){
        dojo.connect(dijit.byId("addTextButton"), "onClick", function(){
           var newText = dojo.doc.createTextNode("New Text!");
           dojo.doc.body.appendChild(newText);
           dojo.doc.body.appendChild(dojo.doc.createElement("br"));
        });
      }
      dojo.ready(addText);

  .. html ::

    <button id="addTextButton" data-dojo-type="dijit.form.Button">Click me to add 'New Text!' to the page</button><br><br>
    <b>Click the button several times, then scroll down to see the appended text.</b>


See also
========

* :ref:`dojo.withDoc <dojo/withDoc>`
* :ref:`dojo.setContext <dojo/setContext>`
