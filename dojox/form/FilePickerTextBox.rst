.. _dojox/form/FilePickerTextBox:

============================
dojox.form.FilePickerTextBox
============================

:Project owner: Nathan Toone
:since: V1.3

.. contents ::
   :depth: 2

A dijit._FormWidget that adds a dojox.widget.FilePicker to a text box as a dropdown


Introduction
============

The file picker text box allows for easy selecting of a file from the server - and makes it embeddable into a form


Usage
=====

Creating a file picker is similar to creating a rolling list. In addition to the options for rolling list, you can specify the following:

* **pathSeparator** The path separator to use - it will be guessed if not provided

* **topDir** the top-level directory to provide access to - it will be guessed if not provided

* **pathAttr** the attribute to read for getting the full path of the file

* ``New in 1.3`` **selectDirectories** whether or not you want to allow selecting of directories

* ``New in 1.3`` **selectFiles** whether or not you want to allow selecting of files

* ``New in 1.3`` **numPanes** The number of panes to display across the width of the picker. Only used if you do not specify a minPaneWidth in the constraints for the picker. Defaults to 2.25.

Additional attr value
---------------------

You can call widget.get("pathValue") or widget.set("pathValue", ...) to get or set the value of the widget -
using "string" format (ie. "/path/to/file.txt") instead of using the item.
Items in the "constraints" parameter will be passed in to the file picker as creation parameters.


Examples
========

A simple file picker
--------------------

This example shows a simple file picker text box pulling data from a dojox.data.FileStore

.. code-example ::

  .. js ::

      dojo.require("dojox.data.FileStore");
      dojo.require("dojox.form.FilePickerTextBox");

  .. html ::

    <div data-dojo-type="dojox.data.FileStore" data-dojo-props="pathAsQueryParam:true, url:'{{dataUrl}}dojox/data/demos/stores/filestore_dojotree.php'"
         data-dojo-id="fileStore"></div>
    <input require="true" name="fileName" type="text" data-dojo-type="dojox.form.FilePickerTextBox"
         data-dojo-props="constraints:{store:fileStore, query:{}}" />

  .. css ::

      @import "{{baseUrl}}dojox/form/resources/FilePickerTextBox.css";
