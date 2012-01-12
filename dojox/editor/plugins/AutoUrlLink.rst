.. _dojox/editor/plugins/AutoUrlLink:

=====================================================
dojox.editor.plugins.AutoUrlLink (Under Construction)
=====================================================

:Authors: He Gu Yi
:Project owner: Jared Jurkiewicz
:since: V1.6

.. contents ::
    :depth: 2

Have you ever wanted to turn the URL you entered in the document into a hyperlink automatically? This plug-in is for you.

Features
========

Once required in and enabled, this plugin can turn a URL like string (such as http, https and ftp) into a hyperlink.

Usage
=====

Basic Usage
-----------
Usage of this plugin is simple and painless.
The first thing you need to do is require the editor and into the page.

.. js ::

    dojo.require("dijit.Editor");
    dojo.require("dojox.editor.plugins.AutoUrlLink");

Once it has been required in, all you have to do is include it in the list of extraPlugins (or the plugins property if you're reorganizing the toolbar) for you want to load into the editor.  For example:

.. html ::

    <div data-dojo-type="dijit/Editor" id="editor1" data-dojo-props="extraPlugins:['autourllink']">
      ...
    </div>

And that's it. The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the AutoUrlLink plugin!

User Interface
==============

AutoUrlLink plugin is a plugin for dijit.Editor, which provides the users with the ability to activate all URL Links automatically. There are three ways that trigger the activation.

* The URL is terminated by a trailing space.
* The URL is terminated by an enter.
* A piece of plain text is copied and pasted into the document. In this case, all the URLs in the text will be recognized and activated.

.. image :: AutoUrlLink.png

Limitations
===========

None.

Examples
========

Basic Usage
-----------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.6

  .. js ::

      dojo.require("dijit.Editor");
      dojo.require("dojox.editor.plugins.AutoUrlLink");

  .. html ::

    <div data-dojo-type="dijit/Editor" id="editor1" data-dojo-props="extraPlugins:['autourllink']">
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
