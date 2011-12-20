.. _dojox/widget/FilePicker:

========================
dojox.widget.FilePicker
========================

:Project owner: Nathan Toone
:since: V1.3

.. contents ::
   :depth: 1

A specialized version of RollingList that handles file information


Introduction
============

The file picker extends the rolling list to add file-specific styling (folder/file icons), as well as the concept of file system hierarchy.

Usage
=====

Creating a file picker is similar to creating a rolling list.  In addition to the options for rolling list, you can specify the following:
 * **pathSeparator** The path separator to use - it will be guessed if not provided
 * **topDir** the top-level directory to provide access to - it will be guessed if not provided
 * **pathAttr** the attribute to read for getting the full path of the file
 * ``New in 1.3`` **selectDirectories** whether or not you want to allow selecting of directories
 * ``New in 1.3`` **selectFiles** whether or not you want to allow selecting of files

Additional attr value
=====================

You can call widget.get("pathValue") or widget.set("pathValue", ...) to get or set the value of the widget - using "string" format (ie. "/path/to/file.txt") instead of using the item

Examples
========

A simple file picker pulling data from a dojox.data.FileStore
-------------------------------------------------------------

.. code-example ::

  .. js ::

      dojo.require("dojox.data.FileStore");
      dojo.require("dojox.widget.FilePicker");

  .. html ::
  
    <div data-dojo-type="dojox.data.FileStore" data-dojo-id="fileStore" data-dojo-props="pathAsQueryParam:true,
        url:'{{dataUrl}}dojox/data/demos/stores/filestore_dojotree.php'"></div>
    <div data-dojo-type="dojox.widget.FilePicker" data-dojo-props="store:fileStore, query:{}" style="height:150px;width:50%"></div>

  .. css ::

      @import "{{baseUrl}}dojox/widget/FilePicker/FilePicker.css";
