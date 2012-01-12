.. _dojox/editor/plugins/SafePaste:

==================================
dojox.editor.plugins.SafePaste
==================================

:Project owner: Jared Jurkiewicz
:Authors: Jared Jurkiewicz
:since: V1.5

.. contents ::
    :depth: 2

Have you ever worried about users pasting in script tags or the like into editor content without any sanitation?  Have you ever wanted to strip specific tag names from a paste? Is so, then this plugin is intended for you.

This plugin extends the 'PasteFromWord' plugin.  This one adds paste interception and halts native paste events.   A dialog is presented where the user must paste the content.   The content is processed and then injected into the main editor body.  The dialog is required because browser security does not allow JavaScript to access clipboard contents directly, it has to be browser-native inserted into the dialog first.  The dialog scripts out script tags, any user-requested tags, and removes all the app-specific stuff, such as classes, styles, and such from Microsoft Word.

Features
========

This plugin provides the following

* Headless, no button required.  Dialog is triggered by paste event.
* An input dialog for pasting content from the clip board for processing before being injected into the dijit Editor.
* It makes use of dojox.html.format to also try to clean up and normalize the HTML as much as possible.
* If this plugin is used, the PasteFromWord plugin is not required.

Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.
First import its CSS.  This is done by just adding a link tag to the header.  Something like:

.. css ::

    @import "dojox/editor/plugins/resources/css/SafePaste.css";

Then require it into the page where you're using the editor:

.. js ::
 
    dojo.require("dijit.Editor");
    dojo.require("dojox.editor.plugins.SafePaste");


Once it has been required in, all you have to do is include it in the list of extraPlugins you want to load into the editor.  For example:

.. html ::

  <div data-dojo-type="dijit/Editor" id="editor" data-dojo-props="extraPlugins:['safepaste']"></div>

And that's it.  The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the SafePaste plugin!

Configuring SafePaste
---------------------

The SafePaste plugin supports three options, the width and height to use for the input area in the dialog.  This allows users to customize how large an area is used for content input.

+-----------------------------------+---------------------------------------------------------------------+------------------------+
| **option**                        | **Description**                                                     | **Required**           |
+-----------------------------------+---------------------------------------------------------------------+------------------------+
| width                             |String defining how wide to make the input.   The default is 400px.  | No                     |
+-----------------------------------+---------------------------------------------------------------------+------------------------+
| height                            |String defining how tall to make the input.   The default is 300px.  | No                     |
+-----------------------------------+---------------------------------------------------------------------+------------------------+
| scripTags                         |Array of tag names to remove.  It only removes the tags, it will     | No                     |
|                                   |leave the content within the tag in the page.                        |                        |
+-----------------------------------+---------------------------------------------------------------------+------------------------+

How do I configure the options?  Glad you asked.  You do it where you declare the plugin.  See the following example, the input area is configured to be 200px wide and 200px tall, and remove all bold and italic tags.

.. html ::

  <div data-dojo-type="dijit/Editor"
       id="editor" data-dojo-props="extraPlugins:[{name: 'safepaste', width: "200px", height: "200px", stripTags: ["b", "i"]}]">
  </div>


Examples
========

Basic Usage
-----------

.. code-example::
  :djConfig: parseOnLoad: true

  .. js ::

      dojo.require("dijit.Editor");
      dojo.require("dojox.editor.plugins.SafePaste");

  .. css ::

      @import "{{baseUrl}}dojox/editor/plugins/resources/css/safepaste.css";
    
  .. html ::


  .. html ::

    <b>Clear the editor, click paste from word, then paste in content you want!</b>
    <br>
    <div data-dojo-type="dijit/Editor" height="100px" id="input" data-dojo-props="extraPlugins:['safepaste']">
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


See Also
========

* :ref:`dijit.Editor <dijit/Editor>`
* :ref:`dijit._editor.plugins <dijit/_editor/plugins>`
* :ref:`dojox.editor.plugins <dojox/editor/plugins>`
