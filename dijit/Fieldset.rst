.. _dijit/Fieldset:

===============
dijit.Fieldset
===============

:Authors: Bill Keese
:Project owner: Bill Keese

.. contents ::
    :depth: 2


Introduction
============

A Fieldset widget is a fieldset that can be opened or collapsed.
The visibility of the Fieldset's contents is toggled by clicking the Fieldset's legend.
It extends :ref:`TitlePane <dijit/TitlePane>`.

Examples
========

Programmatic example
--------------------

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dijit/Fieldset", "dojo/dom", "dojo/domReady!"], function(Fieldset, dom){
        var tp = new Fieldset({title:"I'm a Fieldset", content: "Collapse me!"});
        dom.byId("holder").appendChild(tp.domNode);
        tp.startup();
    });

  .. html ::

    <div id="holder"></div>

Note that when created programatically, the Fieldset's legend is called "title", to be consistent with programmatic
creation of other widgets.

Declarative markup
------------------

Creation from markup is even easier.

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

      require(["dojo/parser", "dijit/Fieldset"]);

  .. html ::

    <div id="tp2" data-dojo-type="dijit/Fieldset">
        <legend>My legend</legend>
        Click legend to close me.
    </div>


Accessibility
=============

Keyboard
--------

Each Fieldset legend is included in the tab order of the document.

===================================     =====================================================
Action                                  Key
===================================     =====================================================
toggle open/close                       enter or space key with focus on the legend
Navigate into an opened Fieldset        tab
===================================     =====================================================
