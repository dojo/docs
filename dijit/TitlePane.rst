.. _dijit/TitlePane:

===============
dijit.TitlePane
===============

:Authors: Bill Keese, Marcus Reimann
:Project owner: Bill Keese

.. contents ::
    :depth: 2


Introduction
============

A TitlePane is a pane that can be opened or collapsed, with a title on top.
The visibility of the pane's contents is toggled by activating an arrow "button" on the title bar via the mouse or keyboard.
It extends :ref:`ContentPane <dijit/layout/ContentPane>`
but since it isn't used inside other layout widgets it's not in the dijit.layout module.


Usage
=====

The constructor for TitlePane takes the following possible parameters in its keyword arguments:

=========  ==================================  ==================================================
Parameter  Type                                Description
=========  ==================================  ==================================================
title      String                              The title to be displayed in the pane header. The default is an empty string.
content    DomNode | NodeList | dijit._Widget  The content (innerHTML) to be displayed in the pane.
open       Boolean                             Boolean option whether or not to display the pane contents. The default is true.
=========  ==================================  ==================================================


Examples
========

Programmatic example
--------------------

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dijit/TitlePane", "dojo/dom", "dojo/domReady!"], function(TitlePane, dom){
        var tp = new TitlePane({title:"I'm a TitlePane", content: "Collapse me!"});
        dom.byId("holder").appendChild(tp.domNode);
        tp.startup();
    });

  .. html ::

    <div id="holder"></div>


Declarative markup
------------------

Creation from markup is even easier.

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

      require(["dojo/parser", "dijit/TitlePane"]);

  .. html ::

    <div id="tp2" data-dojo-type="dijit/TitlePane" data-dojo-props="title: 'I\'m a TitlePane Too'">
        Click arrow to close me.
    </div>


AccordionContainer substitute
-----------------------------

Sometimes when developers think they want an AccordionContainer what they really want is a set of TitlePanes.
With a set of TitlePanes the outer div doesn't have any fixed height, and you can open multiple panes at once (or close all of them).

For example:

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/TitlePane"]);

  .. html ::

    <div style="border: solid black 1px;">
        <div data-dojo-type="dijit/TitlePane" data-dojo-props="title: 'Pane #1'">
            I'm pane #1
        </div>
        <div data-dojo-type="dijit/TitlePane" data-dojo-props="title: 'Pane #2'">
            I'm pane #2
        </div>
        <div data-dojo-type="dijit/TitlePane" data-dojo-props="title: 'Pane #3'">
            I'm pane #3
        </div>
    </div>


Accessibility
=============

Keyboard
--------

Each title pane title is included in the tab order of the document.

===================================     =====================================================
Action                                  Key
===================================     =====================================================
toggle open/close of the title pane     enter or space key with focus on the title pane title
Navigate into an opened title pane      tab
===================================     =====================================================

Screen Reader Information
-------------------------

The title pane container will have an ARIA labelledby property which points to the id of the title pane title.
The title pane title has the ARIA role of button and property of haspopup=true to indicate that it controls the display of the pane.
The role of button is used to indicate to the user that an action will occur when the button is activated.
The TitlePane container will have an ARIA role of region which will be supported in Firefox 3 and identified by future versions of the screen readers.
