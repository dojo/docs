## page was renamed from 1.2/dijit/layout/AccordionContainer
#format dojo_rst

dijit.layout.AccordionContainer
===============================

:Status: Contributed, Draft
:Version: 1.0

Like StackContainer and TabContainer, an AccordionContainer holds a set of panes whose titles are all visible, but only one pane's content is visible at a time. Clicking on a pane title slides the currently-displayed one away, similar to a garage door.

Examples
--------

.. cv-compound::

  .. cv:: javascript

    <script type"text/jkavascript">
    dojo.require("dijit.layout.AccordionContainer");
    </script>

  .. cv:: html

    <div style="width: 300px">
      <div dojoType="dijit.layout.AccordionContainer" style="height: 400px;">
        <div dojoType="dijit.layout.AccordionPane" title="Heeh, this is an accordion pane">
        Hi!
        </div>
        <div dojoType="dijit.layout.AccordionPane" title="This is as well" selected="true">
        Hi how are you?
        </div>
        <div dojoType="dijit.layout.AccordionPane" title="This too">
        Hi how are you? .....Great, thx
        </div>
      </div>
    </div>
