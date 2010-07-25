#format dojo_rst

dojox.widget.Dialog
===================

:Status: Draft
:Version: 1.0
:Project owner: Peter Higgins
:Available: since 1.2

.. contents::
   :depth: 2

This is an extension to the `dojox.widget.DialogSimple <dojox/widget/DialogSimple>`_ providing additional sizing options, animations, and styling. 

============
Introduction
============

This widget's usage is nearly identical to the Dijit Dialog. show() and hide() change the display state, attr("title", "new title") will manipulate the title (if visible), and so on. The difference comes in the creation parameters set.

=====
Usage
=====

You will need the CSS, as well as a Theme CSS file. For instance, tundra:

.. code-block :: html
  :linenos:

    <link rel="stylesheet" href="dojotoolkit/dijit/themes/claro/claro.css" />
    <link rel="stylesheet" href="dojotoolkit/dojox/widget/Dialog/Dialog.css" />

And to require the module in:

.. code-block :: javascript
  :linenos:

  dojo.require("dojox.widget.Dialog");

========
Examples
========

``TODOC:`` show off some of the sizing options.

=====
Notes
=====

* An API change between 1.2 and 1.3 exists: the property ``fixedSized`` in 1.2 was renamed to ``sizeToViewport`` in 1.3 for clarity

========
See also
========

* `dijit.Dialog <dijit/Dialog>`_ 
* `dojox.widget.DialogSimple <dojox/widget/DialogSimple>`_
* `Nightly Test <http://archive.dojotoolkit.org/nightly/dojotoolkit/dojox/widget/tests/test_Dialog.html>`_
