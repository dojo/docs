#format dojo_rst

dojox.html
==========

:Status: Draft
:Version: 1.0
:Authors: Marcus Reimann
:Developers: Bryan Forbes, Sam Foster, Mike Wilcox, Nathan Toone
:Available: since V1.2

.. contents::
    :depth: 2

**dojox.html** offers additional HTML helper functions.


========
Features
========

* `dojox.html.set <dojox/html/set>`_

  A generic content setter, including adding new stylesheets and evaluating scripts (was part of ContentPane loaders, now separated for generic usage)

* `dojox.html.metrics <dojox/html/metrics>`_

  Translate CSS values to pixel values, calculate scrollbar sizes and font resizes

  * Formerly private to dojox.gfx, now available in dojox.html
  * Includes translation of relative CSS values (such as medium, small, x-small, etc.) to actual pixel values
  * Translate other CSS units (such as em, pt) to pixel values
  * Scrollbar sizes (width and height)
  * Ability to detect font resizing

* `dojox.html.styles <dojox/html/styles>`_

  Insert, remove and toggle CSS rules as well as search document for style sheets

  * Insert and remove CSS rules.
  * Search document for style sheets.
  * Toggle sheets on and off (based on the W3C spec).

* ``New in 1.4`` `dojox.html.ellipsis <dojox/html/ellipsis>`_

  Adds cross-browser support for a "dojoxEllipsis" class.

  * To use, include the ellipsis.css file and dojo.require("dojox.html.ellipsis");
  * To function properly - the *parent* node of the desired ellipsis-ized node should have a defined width
  * ``NOTE:`` When using the dojoxEllipsis class within tables, the table needs to have the `table-layout: fixed` style
  * ``NOTE:`` The dojoxEllipsis class should be placed on a block element (such as a div) and will not work on td elements 

* ``New in 1.4`` `dojox.html.entities <dojox/html/entities>`_

  Adds support for encoding and unencoding HTML/XML entity characters in text. Also provides basic mappings of character to entity encoding for HTML and LATIN (8859-1), special characters.  For information on entities see:  `Entity Reference <http://www.w3schools.com/HTML/html_entities.asp>`_ and `Latin (8859-1) Entities <http://www.w3schools.com/tags/ref_entities.asp>`_

  * To use dojo.require("dojox.html.entities");
  * you now have access to entity array mappings for HTML (dojox.html.entities.html) and LATIN-1 (dojox.html.entities.latin)
  * To encode a string with default encodings (HTML and LATIN-1) you do:  str = dojox.html.entities.encode(str);
  * To decode a string with default encodings (HTML and LATIN-1) you do:  str = dojox.html.entities.decode(str);
  * For more information, please see the entities documentation.


========
See also
========

* `dojo.html <dojo/html>`_

  Inserting contents in HTML nodes

* `dojo._base.html <dojo/_base/html>`__

  Basic DOM handling functions, included in Dojo Base
