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

This function willuse the entity encodings for HTML and LATIN-1 as default encodings when called.  Users can over-ride the encoding map used by providing a new encoding map as the second parameter to the encode function.


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
         dojo.connect(dijit.byId("reloadButton2"), "onClick", function() {
            //Reset the url and call close.  Note this could be a different JSON file, but for this example, just 
            //Showing how you would set the URL.
            reloadableStore2.url = "/moin_static163/js/dojo/trunk/release/dojo/dojox/data/tests/stores/countries.json"; 
            reloadableStore2.close();
         });
      });
    </script>

  .. html::

    <b>Enter some text, then press the button to see it in encoded format</b>
    <textarea width="100%" height="20" id="input">
    </textarea>
    <button dojoType="dijit.form.Button">Press me to encode!</button>

    <textarea width="100%" height="20" id="output" readOnly="true">
    </textarea>
