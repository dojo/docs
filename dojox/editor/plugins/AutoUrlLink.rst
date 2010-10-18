#format dojo_rst

dojox.editor.plugins.AutoUrlLink (Under Construction)
=====================================================

:Authors: He Gu Yi
:Project owner: Jared Jurkiewicz
:Available: since V1.6

.. contents::
    :depth: 2

Have you ever wanted to turn the URL you entered in the document into a hyperlink automatically? This plug-in is for you.

========
Features
========

Once required in and enabled, this plugin can turn a URL like string (such as http, https and ftp) into a hyperlink.

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

Then just declare the plugin and configure it as follows. 

.. code-block :: html

  <script type="text/javascript">
    dojo.require("dijit.Editor");
    dojo.require("dojox.editor.plugins.AutoUrlLink");
    ...
  </script>
  <div dojoType="dijit.Editor" id="editor1" extraPlugins="['autourllink']>
  ...
  </div>

And that's it. The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the AutoUrlLink plugin!

==============
User Interface
==============

AutoUrlLink plugin is a plugin for dijit.Editor, which provides the users with the ability to activative all URL Links automatically. There are three ways that triggle the activation.

* The URL is terminated by a trailing space.
* The URL is terminated by an enter.
* A piece of plain text is copied and pasted into the document. In this case, all the URLs in the text will be recognized and activated.

.. image :: AutoUrlLink.png

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
