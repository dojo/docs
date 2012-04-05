.. _dijit/_editor/plugins/TextColor:

===============================
dijit/_editor/plugins/TextColor
===============================

:Authors: Jared Jurkiewicz
:Developers: Bill Keese, Jared Jurkiewicz
:since: V1.1

.. contents ::
    :depth: 2

Have you ever wanted to change the color of the font,
or the background color of the text in the document you're editing in dijit.Editor?
If so, then this plugin is for you.
The dijit._editor.plugins.TextColor plugin provides two action buttons on the editor toolbar for changing those items.
Each makes use of the dijit ColorPicker, so they are simple to use.

Features
========

Once required and enabled, this plugin provides the following features to dijit.Editor.

* Button with icon in toolbar for changing the color of the selected text.
* Button with icon in toolbar for changing the background color of the selected text.
* Use of dijit.ColorPicker for easy color selection.
* The plugins are registrable in the editor via the following commands:

    foreColor - Enable the text color plugin.

    hiliteColor - Enable the text background color plugin.


Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.
The first thing you need to do is require into the page you're using the editor.
This is done in the same spot all your dojo.require calls are made, usually a head script tag.
For example:

.. js ::
 
    require(["dojo/parser", "dijit/Editor", "dijit/_editor/plugins/TextColor"]);


Once it has been required in, all you have to do is include it in the list of extraPlugins (or the plugins property if you're reorganizing the toolbar) for you want to load into the editor.
For example:

.. html ::

  <div data-dojo-type="dijit/Editor" id="editor" data-dojo-props="extraPlugins:['foreColor', 'hiliteColor']"></div>


And that's it.
The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the TextColor plugin!
You can use the buttons to alter the colors of selected text.

Examples
========

Basic Usage: foreColor (Text Color)
-----------------------------------

.. code-example::
  :djConfig: parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/Editor", "dijit/_editor/plugins/TextColor"]);
    
  .. html ::

    <b>Enter some text and select it, or select existing text, then push the TextColor button to select a new color for it.</b>
    <br />
    <div data-dojo-type="dijit/Editor" height="250px" id="input" data-dojo-props="extraPlugins:['foreColor']">
        <div>
            <br />
            blah blah & blah!
            <br />
        </div>
        <br />
        <table>
            <tbody>
            <tr>
                <td style="border-style:solid; border-width: 2px; border-color: gray;">One cell</td>
                <td style="border-style:solid; border-width: 2px; border-color: gray;">Two cell</td>
            </tr>
            </tbody>
        </table>
        <ul>
            <li>item one</li>
            <li>item two</li>
        </ul>
    </div>


Basic Usage: hiliteColor (Text Background Color)
------------------------------------------------

.. code-example::
  :djConfig: parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/Editor", "dijit/_editor/plugins/TextColor"]);

  .. html ::

    <b>Enter some text and select it, or select existing text, then push the Text Background Color button to select a new background color for it.</b>
    <br />
    <div data-dojo-type="dijit/Editor" height="250px" id="input" data-dojo-props="extraPlugins:['hiliteColor']">
        <div>
            <br />
            blah blah & blah!
            <br>
        </div>
        <br />
        <table>
            <tbody>
                <tr>
                    <td style="border-style:solid; border-width: 2px; border-color: gray;">One cell</td>
                    <td style="border-style:solid; border-width: 2px; border-color: gray;">Two cell</td>
                </tr>
            </tbody>
        </table>
        <ul>
            <li>item one</li>
            <li>item two</li>
        </ul>
    </div>


Basic Usage: Both foreground and background color buttons together
------------------------------------------------------------------

.. code-example::
  :djConfig: parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/Editor", "dijit/_editor/plugins/TextColor"]);

  .. html ::

    <b>Enter some text and select it, or select existing text, then change its colors via the text color and text background color buttons.</b>
    <br />
    <div data-dojo-type="dijit/Editor" height="250px" id="input" data-dojo-props="extraPlugins:['foreColor', 'hiliteColor']">
        <div>
            <br />
            blah blah & blah!
            <br />
        </div>
        <br />
        <table>
            <tbody>
                <tr>
                    <td style="border-style:solid; border-width: 2px; border-color: gray;">One cell</td>
                    <td style="border-style:solid; border-width: 2px; border-color: gray;">Two cell</td>
                </tr>
            </tbody>
        </table>
        <ul>
            <li>item one</li>
            <li>item two</li>
        </ul>
    </div>

See Also
========

* :ref:`dijit/Editor <dijit/Editor>`
* :ref:`dijit/_editor/plugins <dijit/_editor/plugins>`
* :ref:`dojox/editor/plugins <dojox/editor/plugins>`
