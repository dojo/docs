#format dojo_rst

dijit._editor.plugins.FullScreen
================================

:Status: Draft
:Version: 1.0
:Authors: Jared Jurkiewicz
:Developers: Jared Jurkiewicz
:Available: since V1.4

.. contents::
    :depth: 2

Have you ever been on a website where you were able to edit some document to post, for example a blog site, and found that all they give you for an editong 'window' in some nearly postage stamp sized box to edit content in?   Doesn't that make it nearly impossible to edit the document effectively?  It's time to put an end to such behaviors and this pkugin's goal is to do exactly that for the dijit.Editor.  No more postage stamp sized editors!

========
Features
========

Once required in and enabled, this plugin provides the following features to dijit.Editor.

* Button with icon in toolbar for toggling a dijit.Editorto take over the entire viewport of its current 'window' (normally the entire browser window.)
* HotKey enabled for CTRL-SHIFT-F11.  When this combination is pressed in the viewport, the editor will toggle between fullscreen and normal modes.

===========
Limitations
===========

* The FullScreen plugin can only expand the editor to the size of its current 'window' object.  so if you have dojo embedded in an iframe in your page, the maximum it can make the editor is the size of the iframe containing it.

=====
Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.  The first thing you need to do is require into the page you're using the editor.  This is done in the same spot all your dojo.require calls are made, usually a head script tag.  For example:

.. code-block :: javascript
 
    dojo.require("dijit.Editor");
    dojo.require("dijit._editor.plugins.FullScreen");


Once it has been required in, all you have to do is include it in the list of extraPlugins (or the plugins property if you're reorganizing the toolbar) for you want to load into the editor.  For example:

.. code-block :: html

  <div dojoType="dijit.Editor" id="editor" extraPlugins="['fullscreen']"></div>



And that's it.  The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the FullScreen plugin!  You can use the button or hotkey command to toggle the editor mode.

========
Examples
========

Basic Usage
-----------

**Note:** The Demo Viewer runs in an iframe, so it can only maximize ot the size of the demo viewer.

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4

  .. javascript::

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dijit.Editor");
      dojo.require("dijit._editor.plugins.FullScreen");
    </script>

    
  .. html::

    <b>Press the FullScreen button or use the hotkey CTRL-SHIFT-F11 while in the editing pane and the editor will go into full screen mode</b>
    <br>
    <div dojoType="dijit.Editor" height="250px"id="input" extraPlugins="['fullscreen']">
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
