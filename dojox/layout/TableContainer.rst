.. _dojox/layout/TableContainer:

===========================
dojox/layout/TableContainer
===========================

:Project owner: Shane O'Sullivan
:since: V1.4

.. contents ::
   :depth: 2

The TableContainer is a simple layout widget that displays the contained child widgets in a Table element.


Introduction
============

The dojox/layout/TableContainer is a simple layout widget that displays the contained child widgets in a Table element. It provides a number of useful features.

* It can be configured to use any number of columns, using the "cols" attribute.
* It is fully stylable. A custom class can be set on it, using the "customClass" attribute, which makes it easy to style every row and cell.
* A label can be displayed for each child widget, either above or to the left of the widget. Widgets can also be shown without any label.

  * To specify that labels should or should not be shown, set the "showLabels" attribute to true or false respectively.
  * To specify the label for a child widget, set that widgets' "label" or "title" attribute.
  * Label width can be set using the "labelWidth" attribute of the TableContainer.
  * The orientation of labels can be set to be either beside or above widgets can be achieved by setting the "orientation" attribute of the TableContainer to "horiz" or "vert" respectively.
* Cell spacing can be customized by setting the "spacing" attribute.


Usage
=====

The following attributes are available on the TableContainer

+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|**cols**        | The number of child widgets to layout horizontally per row of the table. If horizontal labels are enabled, the actual            |
|                | number of cells per row in the table will be double this number.                                                                 |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|**labelWidth**  | Defines the width of a label. This can take either a pixel (numeric, e.g. 40) or percentage value (a string, e.g. "50%")         |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|**showLabels**  | Set to **true** if labels should be displayed, **false** otherwise                                                               |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|**orientation** | This defines the position of the labels relative to the child widgets. It accepts two values, "horiz" and "vert", which place    |
|                | the labels to the left and above the child widget respectively.                                                                  |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|**spacing**     | The cell spacing which to apply to the table. Defaults to 1.                                                                     |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|**customClass** | The custom CSS class that should be applied to the TABLE element. This allows the developer to customize every element of the    |
|                | table.  Given the example CSS class "myClass", the following classes are applied to the table elements.                          |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|                | **myClass-table** - Applied to the outer TABLE element.                                                                          |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|                | **myClass-table-horiz** - Applied to the outer TABLE element if the label alignment is horizontal.                               |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|                | **myClass-table-vert** - Applied to the outer TABLE element if the label alignment is vertical.                                  |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|                | **myClass-labelCell** - Applied to the all cells that contain a label.                                                           |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|                | **myClass-valueCell** - Applied to the all cells containing a child widget.                                                      |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+
|                | **myClass-valueCell-(idx)** - Applied to the all cells containing a child widget. The index is the position  of the child        |
|                |   widget, so the first value cell will have the class **myClass-valueCell-0** set, the second will have **myClass-valueCell-1**  |
|                |   and so on.                                                                                                                     |
+----------------+----------------------------------------------------------------------------------------------------------------------------------+


Examples
========

Simple Example, one column and no styling
-----------------------------------------

.. code-example::

  Load the required JavaScript files. These include the TableContainer itself, along with the three other widgets that it contains.

  .. js ::

    require(["dojo/parser",
        "dojox/layout/TableContainer",
        "dijit/form/TextBox",
        "dijit/form/CheckBox",
        "dijit/form/NumberSpinner"
    ], require(parser) {
        parser.parse();
    });

  Declare the required HTML. Note that each contained widget is given a 'title' attribute.  This is the simplest type of TableContainer, with just one column, and no special CSS added

  .. html ::

    <div data-dojo-type="dojox/layout/TableContainer" data-dojo-props="cols:1" id="tc1">
      <div data-dojo-type="dijit/form/TextBox" title="First Name:" value="Michael"></div>
      <div data-dojo-type="dijit/form/TextBox" title="Last Name:" value="Collins"></div>
      <div data-dojo-type="dijit/form/CheckBox" title="Employed"></div>
      <div data-dojo-type="dijit/form/NumberSpinner" title="Age" value="25"></div>
    </div>

Two Columns, Label Styling
--------------------------

.. code-example::
  :version: local

  Load the required JavaScript files. These include the TableContainer itself, along with the three other widgets that it contains.

  .. js ::

    require(["dojo/parser",
        "dojox/layout/TableContainer",
        "dijit/form/TextBox",
        "dijit/form/CheckBox",
        "dijit/form/NumberSpinner"
    ], function(parser) {
        parser.parse();
    });


  Declare the required HTML. Note that each contained widget is given a 'title' attribute.  Note the 'customClass' attribute added to the TableContainer.  This is used in the CSS declaration to add a style to all label cells.

  .. html ::

    <div data-dojo-type="dojox/layout/TableContainer" data-dojo-props="cols:2, customClass:'justLabels'" id="tc1">
      <div data-dojo-type="dijit/form/TextBox" title="First Name:" value="Eamonn"></div>
      <div data-dojo-type="dijit/form/TextBox" title="Last Name:" value="De Valera"></div>
      <div data-dojo-type="dijit/form/CheckBox" title="Employed"></div>
      <div data-dojo-type="dijit/form/NumberSpinner" title="Age" value="40"></div>
    </div>

  Apply a custom class that colors the labels.

  .. css ::

      .justLabels-labelCell {
        background-color: lightgrey;
        padding-left: 5px;
      }


Two Columns, Label and Value cell Styling
-----------------------------------------

.. code-example::
  :version: local

  Load the required JavaScript files. These include the TableContainer itself, along with the three other widgets that it contains.

  .. js ::

    require(["dojo/parser",
        "dojox/layout/TableContainer",
        "dijit/form/TextBox",
        "dijit/form/CheckBox",
        "dijit/form/NumberSpinner"
    ], function(parser) {
        parser.parse();
    });

  Declare the required HTML. Note that each contained widget is given a 'title' attribute.  Note the 'customClass' attribute added to the TableContainer.  This is used in the CSS declaration to add a style to all label and value cells.

  .. html ::

    <div data-dojo-type="dojox/layout/TableContainer" data-dojo-props="cols:2, customClass:'labelsAndValues'" id="tc1">
      <div data-dojo-type="dijit/form/TextBox" title="First Name:" value="Patrick"></div>
      <div data-dojo-type="dijit/form/TextBox" title="Last Name:" value="Pearse"></div>
      <div data-dojo-type="dijit/form/CheckBox" title="Employed"></div>
      <div data-dojo-type="dijit/form/NumberSpinner" title="Age" value="30"></div>
    </div>

  Apply a custom class that styles both the label and value cells.

  .. css ::

      .labelsAndValues-labelCell {

        background-color: lightgrey;
        padding-left: 5px;
      }

      .labelsAndValues-valueCell {

        padding-left: 20px;
        background-color: lightblue;
      }

Using Colspan
-------------

.. code-example::
  :version: local

  Load the required JavaScript files. These include the TableContainer itself, along with the three other widgets that it contains.

  .. js ::

    require(["dojo/parser",
        "dojox/layout/TableContainer",
        "dijit/form/TextBox",
        "dijit/form/CheckBox",
        "dijit/form/Textarea"
    ], function(parser) {
        parser.parse();
    });

  Declare the required HTML. Note that each contained widget is given a 'title' attribute.  Note that the first three widgets are given a 'colspan' attribute, which makes them take up multiple columns. To accommodate these extra columns, the TableContainer is given the attribute cols='4'. This is useful when you have a widget that requires more room. Since the CheckBox widgets along the bottom have no 'colspan' attribute, they each occupy a single column

  .. html ::

    <div data-dojo-type="dojox/layout/TableContainer" data-dojo-props="cols:4, customClass:'labelsAndValues'" id="tc1">
      <div data-dojo-type="dijit/form/TextBox" title="First Name:" colspan="2" value="Tom"></div>
      <div data-dojo-type="dijit/form/TextBox" title="Last Name:" colspan="2" value="Clarke"></div>
      <textarea data-dojo-type="dijit/form/Textarea" id="texteditor" style="width:100%;" colspan="4" title="Personal Details">Hi, I'm a hacker, I have no  personal details to speak of, but I can write a widget in under a minute!
      </textarea>
     <div data-dojo-type="dijit/form/CheckBox" title="Employed"></div>
     <div data-dojo-type="dijit/form/CheckBox" title="Is Married"></div>
     <div data-dojo-type="dijit/form/CheckBox" title="Has Children"></div>
     <div data-dojo-type="dijit/form/CheckBox" title="Loves Dojo" checked="true"></div>
      
    </div>

  Apply a custom class that styles both the label and value cells.

  .. css ::

      .labelsAndValues-labelCell {

        background-color: lightgrey;
        padding-left: 5px;
      }

      .labelsAndValues-valueCell {

        padding-left: 20px;
        background-color: lightblue;
      }

Programmatic example
--------------------

.. code-example::
  :version: local

  Load the required JavaScript files. These include the TableContainer itself, and the dijit.TextBox widget that it contains.
  A TableContainer widget is created programmatically, and four text box widgets are added to it.

  .. js ::

    require(["dojo/parser",
        "dojox/layout/TableContainer",
        "dijit/form/TextBox"
    ], function(parser) {
        parser.parse();
    });


      // Create the TableContainer, and insert it into the DOM node with id "putWidgetHere".
      // Add the custom class "labelsAndValues"
      var programmatic = new TableContainer(
      {
        cols: 2,
        customClass:"labelsAndValues",
        "labelWidth": "150"
      }, dojo.byId("putWidgetHere"));

      // Create four text boxes
      var text1 = new TextBox({label: "ProgText 1"});
      var text2 = new TextBox({label: "ProgText 2"});
      var text3 = new TextBox({label: "ProgText 3"});
      var text4 = new TextBox({label: "ProgText 4"});

      // Add the four text boxes to the TableContainer
      programmatic.addChild(text1);
      programmatic.addChild(text2);
      programmatic.addChild(text3);
      programmatic.addChild(text4);

      // Start the table container. This initializes it and places
      // the child widgets in the correct place.
      programmatic.startup();


  No HTML is required here, as it is a purely programmatic example

  .. html ::

    <div id="putWidgetHere" ></div>

  Apply a custom class that styles both the label and value cells.

  .. css ::

      .labelsAndValues-labelCell {

        background-color: lightgrey;
        padding-left: 5px;
      }

      .labelsAndValues-valueCell {

        padding-left: 20px;
        background-color: lightblue;
      }

Setting the Label Width
-----------------------

.. code-example::
  :version: local

  Load the required JavaScript files. These include the TableContainer itself, along with the three other widgets that it contains.

  .. js ::

    require(["dojo/parser",
        "dojox/layout/TableContainer",
        "dijit/form/TextBox"
    ], function(parser) {
        parser.parse();
    });

  Declare the required HTML. Note the 'labelWidth' attribute on the TableContainer, which specifies the width of the labels in pixels.

  .. html ::

    <div data-dojo-type="dojox/layout/TableContainer" data-dojo-props="cols:2, customClass:'labelsAndValues', labelWidth:10" id="tc1">
      <div data-dojo-type="dijit/form/TextBox" title="1" value="United States"></div>
      <div data-dojo-type="dijit/form/TextBox" title="2" value="Ireland"></div>
      <div data-dojo-type="dijit/form/TextBox" title="3" value="Italy"></div>
      <div data-dojo-type="dijit/form/TextBox" title="4" value="Faroe Islands"></div>
      
    </div>

  Apply a custom class that styles both the label and value cells.

  .. css ::

      .labelsAndValues-labelCell {

        background-color: lightgrey;
        padding-left: 5px;
      }

      .labelsAndValues-valueCell {

        padding-left: 20px;
        background-color: lightblue;
      }
