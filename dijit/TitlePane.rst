#format dojo_rst

dijit.TitlePane
===============

.. contents::
    :depth: 2

:Status: Draft
:Version: 1.2
:Authors: Bill Keese

A TitlePane is a pane that can be opened or collapsed, with a title on top. The visibility of the pane's contents is toggled by activating an arrow "button" on the title bar via the mouse or keyboard.  It extends `ContentPane </dijit/layout/ContentPane>`_ but since it isn't used inside other layout widgets it's not in the dijit.layout module.

Programatic TitlePane
---------------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.TitlePane");

      var tp;
      dojo.addOnLoad(function(){
	  tp = new dijit.TitlePane({title:"I'm a TitlePane", content: "Collapse me!"});
          dojo.byId("holder").appendChild(tp.domNode);
      });
    </script>

  .. cv:: html

    <div id="holder"></div>



Markup
------
Creation from markup is even easier.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.TitlePane");
    </script>

  .. cv:: html

    <div id="tp2" dojoType="dijit.TitlePane" title="I'm a TitlePane Too">
        Click arrow to close me.
    </div>


AccordionContainer substitute
-----------------------------
Sometimes when developers think they want an AccordionContainer what they really want is a set of TitlePanes.
With a set of TitlePanes the outer div doesn't have any fixed height, and you can open multiple panes at once (or close all of them).

For example:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.TitlePane");
    </script>

  .. cv:: html

    <div style="border: solid black 1px;">
      <div dojoType="dijit.TitlePane" title="Pane #1">
        I'm pane #1
      </div>
      <div dojoType="dijit.TitlePane" title="Pane #2">
        I'm pane #2
      </div>
      <div dojoType="dijit.TitlePane" title="Pane #3">
        I'm pane #3
      </div>
    </div>
