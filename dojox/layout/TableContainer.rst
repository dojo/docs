#format dojo_rst

dojox.layout.TableContainer
===========================

:Status: Draft
:Version: 1.4
:Project owner: Shane O'Sullivan
:Available: since V1.4

.. contents::
   :depth: 2

The TableContainer is a simple layout widget that displays the contained child widgets in a Table element.

============
Introduction
============

The dojox.layout.TableContainer is a simple layout widget that displays the contained child widgets in a Table element.  It provides a number of useful features.

 * It can be configured to use any number of columns, using the "cols" attribute.

 * It is fully stylable.  A custom class can be set on it, using the "customClass" attribute, which makes it easy to style every row and cell.

 * A label can be displayed for each child widget, either above or to the left of the widget.  Widgets can also be shown without any label.  

  * To specify that labels should or should not be shown, set the "showLabels" attribute to true or false respectively.  

  * To specify the label for a child widget, set that widgets' "label" or "title" attribute.

  * Label width can be set using the "labelWidth" attribute of the TableContainer.

  * The orientation of labels can be set to be either beside or above widgets can be achieved by setting the "orientation" attribute of the TableContainer to "horiz" or "vert" respectively.

 * Cell spacing can be customized by setting the "spacing" attribute.

Todo: complete this

=====
Usage
=====

TODO: how to use the component/class/method

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // your code
 </script>



========
Examples
========

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

TODO: example


========
See also
========

* TODO: links to other related articles
