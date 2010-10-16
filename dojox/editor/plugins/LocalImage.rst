#format dojo_rst

dojox.editor.plugins.LocalImage (Under Construction)
====================================================

:Authors: He Gu Yi
:Project owner: Jared Jurkiewicz
:Available: since V1.6

.. contents::
    :depth: 2

Have you ever wanted to insert not only online images but also images on your computer? This plug-in is for you.

========
Features
========

Once required in and enabled, this plugin provides the following features to dijit.Editor

* Insert an online image.
* Insert a local image on the computer into the document with one click.
* Edit the image when it is selected.


=====
Usage
=====

Basic Usage
-----------
Usage of this plugin is simple and painless. The first thing you need to do is require the editor into the page. This is done in the same spot all your dojo.require called are made, usually a head script tag. For example:

.. code-block :: html

  <script type="text/javascript">
    dojo.require("dijit.Editor");
    ...
  </script>
  ...
  <div dojoType="dijit.Editor" id="editor1">
  ...
  </div>

Then just declare the plugin and configure it as follows. Note that the location of LocalImage.css may be changed according to the actual environment.

.. code-block :: html

  <style type="text/css">
    @import "../../form/resources/FileUploader.css";
    @import "../plugins/resources/css/LocalImagePlugin.css";
    ...
  </style>
  <script type="text/javascript">
    dojo.require("dijit.Editor");
    dojo.require("dojox.editor.plugins.LocalImagePlugin");
    ...
  </script>
  <div dojoType="dijit.Editor" id="editor1" extraPlugins="[{name: 'LocalImage', uploadable: true, uploadUrl: '../../form/tests/UploadFile.php', baseImageUrl: '../../form/tests/', fileMask: '*.jpg;*.jpeg;*.gif;*.png;*.bmp'}]>
  ...
  </div>

If you are running the demo in Dojo SDK, configure the server-side php files as follows.

* Rename dojox\form\tests\cLOG.php.disable to dojox\form\tests\cLOG.php
* Rename dojox\form\tests\UploadFile.php.disable to dojox\form\tests\UploadFile.php

And that's it. The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the LocalImage plugin!

Configurable Options
--------------------

========================  =================  ============  =======================  ===================================================================================
Argument Name             Data Type          Optional      Default Value            Description
========================  =================  ============  =======================  ===================================================================================
name                      String             False         localimage               The name of this plugin. It should always be "localimage".
uploadable                Boolean            True          False                    Indicate if the plugin supports insert an image from the local file.
uploadUrl                 String             True          <empty string>           Specify the url that the image is uploaded to.
                                                                                    If the argument uploadable is false or not specified, this argument is ignored.
baseImageUrl              String             True          <empty string>           The prefix of the image url on the server.
                                                                                    For example, an image is uploaded and stored at the following
                                                                                    location http://www.myhost.com/images/uploads/test.jpg.
                                                                                    When the image is uploaded, the server returns "uploads/test.jpg" as
                                                                                    the relative path. So the baseImageUrl should be set to
                                                                                    "http://www.myhost.com/images/" so that the client can retrieve the image from
                                                                                    the server. If the image file is located on the same domain as that of the current
                                                                                    web page, baseImageUrl can be a relative path. For example:
                                                                                    baseImageUrl = "images/" and the server returns "uploads/test.jpg".
                                                                                    The complete URL of the image file is "images/upload/test.jpg".
                                                                                    If the argument uploadable is false or not specified, this argument is ignored.
fileMask                  String             True          "*.jpg;*.jpeg;*.gif;     Specify the acceptable image type.
                                                           *.png;*.bmp"             The default value is "*.jpg;*.jpeg;*.gif;*.png;*.bmp".                       
========================  =================  ============  =======================  ===================================================================================

==============
User Interface
==============

LocalImagePlugin is a plugin for dijit.Editor, which provides the user with the ability to insert images from both network and local files. Click Insert Image to open the tooltip dialog,

.. image :: LocalImage.png

Insert a local image file
-------------------------

Click Browse... to select a local file and describe it in the Description which will be displayed when the image can't be displayed. Then click Insert to insert the image.

.. image :: BrowseLocal.png

If the image type is not acceptable, a warning icon will be displayed and the Insert button is disabled.

.. image :: Warning.png

Insert an online image
----------------------

Enter the url of the file in the Image field and enter its alternative description in the Description filed which will show when the image can't be displayed. Then click Insert to insert the online image.

.. image :: InsertOnline.png

Edit the image
--------------

There are two ways to edit the inserted image.

* Double click the image
* Or click on the image and then click Insert Image.

The dialog will be displayed with Image field and Description field poplulated if available. Click Insert to confirm the modification to the image.

.. image :: EditImage.png

===================
A11Y Considerations
===================

All fields within the LocalImage dialog can be accessed with the keyboard.

===========
Limitations
===========

None.

========
Examples
========

Basic Usage
-----------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.6

  .. javascript::

    <script>
      dojo.require("dijit.Editor");
      dojo.require("dojox.editor.plugins.AutoSave");
    </script>

  .. css::

    <style>
      @import "{{baseUrl}}dojox/editor/plugins/resources/css/AutoSave.css";
    </style>
    
  .. html::

    <b>Click the down arrow and select Set Auto-Save Interval... to save at intervals</b>
    <br>
    <div dojoType="dijit.Editor" height="250px"id="input" extraPlugins="['autosave']">
    <div>
    <br>
    blah blah & blah!
    <br>
    </div>
    <br>
    <table>
    <tbody>
    <tr>
    <td style="border-style:solid; border-width: 2px; border-color: gray;">One cell</td>
    <td style="border-style:solid; border-width: 2px; border-color: gray;">
    Two cell
    </td>
    </tr>
    </tbody>
    </table>
    <ul> 
    <li>item one</li>
    <li>
    item two
    </li>
    </ul>
    </div>

========
See Also
========

* `dijit.Editor <dijit/Editor>`_
* `dijit._editor.plugins <dijit/_editor/plugins>`_
* `dojox.editor.plugins <dojox/editor/plugins>`_
