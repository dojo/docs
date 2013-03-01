.. _dijit/_editor/plugins/Print:

===========================
dijit/_editor/plugins/Print
===========================

:Authors: Jared Jurkiewicz
:Developers: Jared Jurkiewicz
:since: V1.4

.. contents ::
    :depth: 2

Have you ever wanted to print the contents contained within the editor?
If so, then this plugin is for you.
It's a simple plugin that adds 'Print' support to the editor toolbar.

Features
========

Once required in and enabled, this plugin provides the following features to dijit.Editor.

* Button with icon in toolbar for Printing the contents of the RTE only

Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.
The first thing you need to do is require into the page you're using the editor.
This is done in the same spot as your require() call is made, usually the head script tag.
For example:

.. js ::

    require(["dojo/parser", "dijit/Editor", "dijit/_editor/plugins/Print"]);


Once it has been required in, all you have to do is include it in the list of extraPlugins (or the plugins property if you're reorganizing the toolbar) for you want to load into the editor.
For example:

.. html ::

  <div data-dojo-type="dijit/Editor" id="editor" data-dojo-props="extraPlugins:['print']"></div>



And that's it.
The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the Print plugin!
You can use the button to print the editor contents when you wish.

Examples
========

Basic Usage
-----------

.. code-example::
  :djConfig: parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/Editor", "dijit/_editor/plugins/Print"]);

    
  .. html ::

    <b>Enter some text then press the print button.  The browser print dialog should open and allow you to print the editor content</b>
    <br />
    <div data-dojo-type="dijit/Editor" height="250px" id="input" data-dojo-props="extraPlugins:['print']">
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
