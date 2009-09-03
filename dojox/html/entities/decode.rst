#format dojo_rst

dojox.html.entities.decode
==========================

:Status: Contributed, Draft
:Version: 1.4
:Author: Jared Jurkiewicz
:Available: since V1.4

.. contents::
  :depth: 2

A flexible function for decoding entity encoded characters back to their UTF-8 representation.  This function is particularly useful when working with text that is to be inserted as text content in HTML/XML markup.  Certain characters cannot be used directly in text (for example: < and >) as they mean special things to the parser.  So entity encodings are required so that the parser doesn't interpret them as meta data and yet they still display correctly.  This function can decode those entities back to the real character.

This function will use the entity encodings for HTML and LATIN-1 as default encodings to convert when called.  Users can over-ride the encoding map used by providing a new encoding map as the second parameter to the decode function.


========
Examples
========

Decoding HTML and LATIN-1 entities in a text string
---------------------------------------------------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4

  .. javascript::

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojox.html.entities");

      dojo.addOnLoad(function() {
         dojo.connect(dijit.byId("bEncode1"), "onClick", function(){
           var input = dojo.byId("input1");
           var output = dojo.byId("output1");
           output.value = dojox.html.entities.decode(input.value);
         });
      });
    </script>

  .. html::

    <b>Enter some text, then press the button to see it in encoded format</b>
    <br>
    <!-- 
      Note that for the text below, the reason for the encoding og & is that textarea auto-decodes them
      when input this way, so it needs to be escaped so the textarea returns a still-encoded string.
    -->
    <textarea style="width: 100%; height: 100px;" id="input1">
      &amp;lt;sometag&amp;gt;
        blah blah &amp;amp; blah!
      &amp;lt;/sometag&amp;gt;
    </textarea>
    <br>
    <button id="bEncode1" dojoType="dijit.form.Button">Press me to decode!</button>
    <br>
    <textarea style="width: 100%; height: 100px;" id="output1" readonly="true">
    </textarea>


Decoding custom entities in a text string
-----------------------------------------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4

  .. javascript::

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojox.html.entities");

      dojo.addOnLoad(function() {
         dojo.connect(dijit.byId("bEncode2"), "onClick", function(){
           var customMap =[["\u0026","amp"]]; 
           var input = dojo.byId("input2");
           var output = dojo.byId("output2");
           output.value = dojox.html.entities.decode(input.value, customMap);
         });
      });
    </script>

  .. html::

    <b>Enter some text, then press the button to see it in encoded format</b>
    <br>
    <textarea style="width: 100%; height: 100px;" id="input2">
      <sometag>
        blah blah &amp;amp; blah!
      </sometag>
    </textarea>
    <br>
    <button id="bEncode2" dojoType="dijit.form.Button">Press me to decode!</button>
    <br>
    <textarea style="width: 100%; height: 100px;" id="output2" readonly="true">
    </textarea>

========
See Also
========

* `dojox.html.entities <dojox/html/entities>`_
* `dojox.html.entities.encode <dojox/html/entities/encode>`_
