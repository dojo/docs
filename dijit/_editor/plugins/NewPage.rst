#format dojo_rst

dijit._editor.plugins.Print
===========================

:Status: Draft
:Version: 1.0
:Authors: Jared Jurkiewicz
:Developers: Jared Jurkiewicz
:Available: since V1.4

.. contents::
    :depth: 2

Have you ever wanted to be able to with the click of a button clear the editor and set it with some default content, be it an empty line of some template HTML?  If so, then this plugin is for you.  It's a simple plugin that adds 'NewPage' support to the editor toolbar..

========
Features
========

Once required in and enabled, this plugin provides the following features to dijit.Editor.

* Button with icon in toolbar for clearing the current editor contents and inserting pre-defined 'new page' content.
* Configurable 'New Page' content via the 'content' parameter of the plugin

=====
Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.  The first thing you need to do is require into the page you're using the editor.  This is done in the same spot all your dojo.require calls are made, usually a head script tag.  For example:

.. code-block :: javascript
 
    dojo.require("dijit.Editor");
    dojo.require("dijit._editor.plugins.NewPage");


Once it has been required in, all you have to do is include it in the list of extraPlugins (or the plugins property if you're reorganizing the toolbar) for you want to load into the editor.  For example:

.. code-block :: html

  <div dojoType="dijit.Editor" id="editor" extraPlugins="['newpage']"></div>



And that's it.  The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the Printplugin!  You can use the button to set the editor content to a 'new page'.

Note, to initialize the plugin with cusom new page content, it is just a matter of passing a content parameter to the new page instantiation.  For example:

.. code-block :: html

  <div dojoType="dijit.Editor" height="250px"id="input" extraPlugins="[{name: 'newpage', content='This is some &lt;b&gt;custom&lt;/b&gt; content!'}]">

========
Examples
========

Basic Usage
-----------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4

  .. javascript::

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dijit.Editor");
      dojo.require("dijit._editor.plugins.NewPage");
    </script>

    
  .. html::

    <b>Enter some text then press the New Page button.  The editor content will then clear.</b>
    <br>
    <div dojoType="dijit.Editor" height="250px"id="input" extraPlugins="['newpage']">
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

Custom New Page Content
-----------------------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4

  .. javascript::

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dijit.Editor");
      dojo.require("dijit._editor.plugins.NewPage");
    </script>

    
  .. html::

    <b>Enter some text then press the New Page button.  The editor content will then be replaced with the custom new page content.</b>
    <br>
    <div dojoType="dijit.Editor" height="250px"id="input" extraPlugins="[{name: 'newpage', content='This is some &lt;b&gt;custom&lt;/b&gt; content!'}]">
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
