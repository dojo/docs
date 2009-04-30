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

Constructor Parameters
----------------------

The constructor for TitlePane takes the following possible parameters in its keyword arguments:

+--------------------------+--------------------------------------------------------------------------------------------------------+
|**Parameter**             |**Description**                                                                                         |
+--------------------------+--------------------------------------------------------------------------------------------------------+
|title                     |The title to be displayed in the pane header. The default is an empty string.                           |
+--------------------------+--------------------------------------------------------------------------------------------------------+
|open                      |Boolean option whether or not to display the pane contents. The default is true.                        |
+--------------------------+--------------------------------------------------------------------------------------------------------+

Accessibility
-------------

Keyboard
~~~~~~~~

Each title pane title is included in the tab order of the document.

===================================     =====================================================
Action                                  Key
===================================     =====================================================
toggle open/close of the title pane     enter or space key with focus on the title pane title
Navigate into an opened title pane      tab
===================================     =====================================================

Screen Reader Information
~~~~~~~~~~~~~~~~~~~~~~~~~

The title pane container will have an ARIA labelledby property which points to the id of the title pane title. The title pane title has the ARIA role of button and property of haspopup=true to indicate that it controls the display of the pane. The role of button is used to indicate to the user that an action will occur when the button is activated. The tilte pane container will have an ARIA role of region which will be supported in Firefox 3 and identified by future versions of the screen readers.
