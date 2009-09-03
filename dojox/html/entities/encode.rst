#format dojo_rst

dojox.html.entities.encode
==========================

:Status: Contributed, Draft
:Version: 1.4
:Author: Jared Jurkiewicz
:Available: since V1.0

.. contents::
  :depth: 2

A flexible function for encoding defined UTF-8 characters into an entity encoding representation.  This function is particularly useful when working with text that is to be inserted as text content in HTML/XML markup.  Certain characters cannot be used directly in text (for example: &lt; and &gt;) as they mean special things to the parser.  So entity encodings are required so that the parser doesn't interpret them as meta data and yet they still display correctly.

This function will use the entity encodings for HTML and LATIN-1 as default encodings when called.  Users can over-ride the encoding map used by providing a new encoding map as the second parameter to the encode function.


========
Examples
========

Encoding HTML and LATIN-1 entities in a text string
---------------------------------------------------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4

  .. javascript::

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojox.html.entities");

      //Now set up a linkage so that the store can be reloaded.
      dojo.addOnLoad(function() {
         dojo.connect(dijit.byId("bEncode", "onClick", function()(
           var input = dojo.byId("input");
           var output = dojo.byId("output");
           var output.value = dojox.html.entities.encode(input.value);
         });
      });
    </script>

  .. html::

    <b>Enter some text, then press the button to see it in encoded format</b>
    <br>
    <textarea style="width: 100%; height: 100px;" id="input">
    </textarea>
    <br>
    <button id="bEncode" dojoType="dijit.form.Button">Press me to encode!</button>
    <br>
    <textarea style="width: 100%; height: 100px;" id="output" readonly="true">
    </textarea>
