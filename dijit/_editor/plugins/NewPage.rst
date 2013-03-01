.. _dijit/_editor/plugins/NewPage:

=============================
dijit/_editor/plugins/NewPage
=============================

:Authors: Jared Jurkiewicz
:Developers: Jared Jurkiewicz
:since: V1.4

.. contents ::
    :depth: 2

Have you ever wanted to be able to with the click of a button clear the editor and set it with some default content, be it an empty line of some template HTML?
If so, then this plugin is for you.
It's a simple plugin that adds 'NewPage' support to the editor toolbar.

Features
========

Once required in and enabled, this plugin provides the following features to dijit.Editor.

* Button with icon in toolbar for clearing the current editor contents and inserting pre-defined 'new page' content.
* Configurable 'New Page' content via the 'content' parameter of the plugin

Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.
The first thing you need to do is require into the page you're using the editor.
This is done in the same spot as your require() call is made, usually the head script tag.
For example:

.. js ::
 
    require(["dojo/parser", "dijit/Editor", "dijit/_editor/plugins/NewPage"]);


Once it has been required in, all you have to do is include it in the list of extraPlugins (or the plugins property if you're reorganizing the toolbar) for you want to load into the editor.
For example:

.. html ::

  <div data-dojo-type="dijit/Editor" id="editor" data-dojo-props="extraPlugins:['newpage']"></div>



And that's it.
The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the NewPage plugin!
You can use the button to set the editor content to a 'new page'.

Custom New Content
------------------

To initialize the plugin with custom new page content, it is just a matter of passing a content parameter to the new page instantiation.
For example:

.. html ::

  <div data-dojo-type="dijit/Editor" height="250px" id="input" data-dojo-props="extraPlugins:[{name: 'newpage', content: 'This is some &lt;b&gt;custom&lt;/b&gt; content!'}]">

Or programmatically:

.. js ::

   var editor = new dijit.Editor({extraPlugins: [{name: 'newpage', content: 'This is some <b>custom</b> content!'}]}

Examples
========

Basic Usage
-----------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4

  .. js ::

    require(["dojo/parser", "dijit/Editor", "dijit/_editor/plugins/NewPage"]);

    
  .. html ::

    <b>Enter some text then press the New Page button.  The editor content will then clear.</b>
    <br />
    <div data-dojo-type="dijit/Editor" height="250px" id="input" data-dojo-props="extraPlugins:['newpage']">
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

Custom New Page Content
-----------------------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4

  .. js ::

    require(["dojo/parser", "dijit/Editor", "dijit/_editor/plugins/NewPage"]);

    
  .. html ::

    <b>Enter some text then press the New Page button.  The editor content will then be replaced with the custom new page content.</b>
    <br />
    <div data-dojo-type="dijit/Editor" height="250px" id="input" data-dojo-props="extraPlugins:[{name: 'newpage', content: 'This is some &lt;b&gt;custom&lt;/b&gt; content!'}]">
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
