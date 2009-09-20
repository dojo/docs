#format dojo_rst

dojox.layout.GridContainer
==========================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V1.3

.. contents::
   :depth: 2

dojox.layout.GridContainer is an **experimental** panel-like layout mechanism, allowing Drag and Drop between regions.


=====
Usage
=====

In order to use the GridContainer, you must issue the require statement:

.. code-block :: javascript
  :linenos:
  
  dojo.require("dojox.layout.GridContainer");

The project requires some Dijit functionality, and a custom DnD handler provided in the dojox.layout package.

Additionally, the required CSS files must be included in your page for proper operation. Two are needed:

  * dojox/layout/resources/GridContainer.css
  * dojox/layout/resources/DndGridContainer.css


TODOC, params, examples, adding/removing regions, columns.
