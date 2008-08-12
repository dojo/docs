#format dojo_rst

dijit.layout.StackContainer
===========================

:Status: Draft
:Version: 1.2

A container that has multiple children, but shows only one child at a time (like looking at the pages in a book one by one). This container is good for wizards, slide shows, and long lists or text blocks.

Examples
--------

.. cv-compound::
  
  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.StackContainer");
    dojo.require("dijit.layout.ContentPane");
    </script>

  .. cv:: html
  
    <div dojoType="dijit.layout.StackContainer">
      <div dojoType="dijit.layout.ContentPane" title="Questions">
      Please answer following questions
      </div>
      <div dojoType="dijit.layout.ContentPane" title="Answers">
      Here is what you should have answered :P
      </div>
    </div>
