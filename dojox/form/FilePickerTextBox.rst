#format dojo_rst

dojox.form.FilePickerTextBox
============================

:Status: Draft
:Version: 1.2
:Project owner: Nathan Toone
:Available: since V1.3

.. contents::
   :depth: 2

A dijit._FormWidget that adds a dojox.widget.FilePicker to a text box as a dropdown


============
Introduction
============

The file picker text box allows for easy selecting of a file from the server - and makes it embeddable into a form


=====
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

You can call widget.attr("pathValue") to get (or set) the value of the widget - using "string" format (ie. "/path/to/file.txt") instead of using the item. Items in the "constraints" parameter will be passed in to the file picker as creation parameters.


========
Examples
========

A simple file picker
--------------------

This example shows a simple file picker text box pulling data from a dojox.data.FileStore

.. cv-compound ::

  .. cv :: javascript

    <script>
      dojo.require("dojox.data.FileStore");
      dojo.require("dojox.form.FilePickerTextBox");
    </script>

  .. cv :: html

    <div dojoType="dojox.data.FileStore" jsId="fileStore" pathAsQueryParam="true"
        url="{{dataUrl}}dojox/data/demos/stores/filestore_dojotree.php"></div>
    <input require="true" name="fileName" type="text" dojoType="dojox.form.FilePickerTextBox"
        constraints="{store:fileStore, query:{}}" />

  .. cv:: css

    <style type="text/css">
      @import "{{baseUrl}}dojox/form/resources/FilePickerTextBox.css";
    </style>
