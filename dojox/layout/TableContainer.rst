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


=====
Usage
=====

The following attributes are available on the TableContainer

+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|**cols**        | The number of child widgets to layout horizontally per row of the table.  If horizontal labels are enabled, the actual           |
|                | number of cells per row in the table will be double this number.                                                                 |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|**labelWidth**  | Defines the width of a label.  This can take either a pixel (numeric, e.g. 40) or percentage value (a string, e.g. "50%")        |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|**showLabels**  | Set to **true** if labels should be displayed, **false** otherwise                                                               |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|**orientation** | This defines the position of the labels relative to the child widgets.  It accepts two values, "horiz" and "vert", which place   |
|                | the labels to the left and above the child widget respectively.                                                                  |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|**spacing**     | The cell spacing which to apply to the table. Defaults to 1.                                                                     |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|**customClass** | The custom CSS class that should be applied to the TABLE element.  This allows the developer to customize every element of the   |
|                | table.  Given the example CSS class "myClass", the following classes are applied to the table elements.                          |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|                | ***myClass-table*** - Applied to the outer TABLE element.                                                                        |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|                | ***myClass-table-horiz*** - Applied to the outer TABLE element if the label alignment is horizontal.                             |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|                | ***myClass-table-vert*** - Applied to the outer TABLE element if the label alignment is vertical.                                |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|                | ***myClass-labelCell*** - Applied to the all cells that contain a label.                                                         |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|                | ***myClass-valueCell*** - Applied to the all cells containing a child widget.                                                    |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|                | ***myClass-valueCell-(idx)*** - Applied to the all cells containing a child widget.  The index is the position  of the child     |
|                |   widget, so the first value cell will have the class **myClass-valueCell-0*** set, the second will have **myClass-valueCell-1** |
|                |   and so on.                                                                                                                     |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+


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
