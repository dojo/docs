#format dojo_rst

dojox.editor.plugins.PrettyPrint
================================

:Status: Draft
:Version: 1.0
:Authors: Jared Jurkiewicz
:Developers: Jared Jurkiewicz
:Available: since V1.4

.. contents::
    :depth: 2

Have you ever wanted to pull your hair out because the content from dijit.Editor was formatted so badly it looked like the output from some crazed demonic minion bent on causing insanity?   Well, I know I sure have, and thus was born the PrettyPrint plugin for the dijit.Editor.  What this plugin does is format the output that comes from dijit.Editor.attr("value"), (or dijit.Editor.getValue()), and reformats it with reasonably indented structure, cleaned up line wrapping, and other general structural cleanup to make it much more human-readable.  

This plugin is 'headless', meaning it adds no toolbar button nor does it require any work to get decent output from it.  All you do is load it and register it as an extraPlugin for your editor and you're good to go.

========
Features
========

This plugin cleans up the output from dijit.Editor in the following ways:

* Reasonable indention of tags to show nesting structure.
* Sorts node attributes alphabetically.
* Normalizes CSS names, quotes, and semi-colons.
* Sorts CSS 'style' names alphabetically.
* Wrapping of text lines consistently and allowing the user to specify a max line length.
* Configurable encoding entity characters in the TEXT elements of the document.  
* All done automatically, no toolbar buttons, no extra user actions required.

=====
Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.  The first thing you need to do is require into the page you're using the editor.  This is done in the same spot all your dojo.require calls are made, usually a head script tag.  For example:

.. code-block :: javascript
 
    dojo.require("dijit.Editor");
    dojo.require("dojox.editor.plugins.PrettyPrint");


Once it has been required in, all you have to do is include it in the list of extraPlugins you want to load into the editor.  For example:

.. code-block :: html

  <div dojoType="dijit.Editor" id="editor" extraPlugins="['prettyprint']"></div>

And that's it.  The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the PrettyPrint plugin!

Configuring PrettyPrint Options
-------------------------------

The PrettyPrint plugin supports three options that control how it formats the text.  The options are defined below:

+-----------------------------------+---------------------------------------------------------------------+------------------------+
| **option**                        | **Description**                                                     | **Required**           |
+-----------------------------------+---------------------------------------------------------------------+------------------------+
| indentBy                          |Integer defining how many spaces to indent by.  Must be a value from |NO                      |
|                                   |1 to 9.  Anything negative, undefined, or greater than 10 will       |                        |
|                                   |instruct the plugin to use the default indent, the TAB character     |                        |
+-----------------------------------+---------------------------------------------------------------------+------------------------+
| lineLength                        |An integer specifying the maximum length of a TEXT line in the HTML  | NO                     |
|                                   |document.  Must be non-negative.  If negative, null, or undefined,   |                        |
|                                   |then the line has no maximum length and will not be split into       |                        |
|                                   |multiple lines.                                                      |                        |
+-----------------------------------+---------------------------------------------------------------------+------------------------+
| entityMap                         |An array of entity character mappings to encode special characters to| NO                     |
|                                   |If not provided, then it uses the the following encodings for        |                        |
|                                   |entities: HTML (dojox.html.entities.html), and the following extras  |                        |
|                                   |pound, cent, yen, ellipsis, copyright, registered trademark, section |                        |
|                                   |and euro.  Those are the most common ones used in HTML documents.    |                        |
|                                   |                                                                     |                        |
|                                   |                                                                     |                        |
|                                   |Note: The more entities you list, the longer it will take PrettyPrint|                        |
|                                   |to render your content.  The entity encoding function is fast, but   |                        |
|                                   |there is still cost to use it.                                       |                        |
+-----------------------------------+---------------------------------------------------------------------+------------------------+
| xhtml                             |An optional boolean parameter to tell the plugin to try to generate  | NO                     |
|                                   |xhtml compliant markup.  The default is false.                       |                        |
+-----------------------------------+---------------------------------------------------------------------+------------------------+

How do I configure the options?  Glad you asked.  You do it where you declare the plugin.  See the following example, which configures an editor with 3 space indent, 80 character line length, a map that only encodes < and >, and XHTML mode true.

.. code-block :: html

  <div dojoType="dijit.Editor" 
       id="editor" extraPlugins="[{name: 'prettyprint', indentBy: 3, lineLength: 80, entityMap: [['<', 'lt'],['>', 'gt']], xhtml: true}]">
  </div>


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
      dojo.require("dojox.editor.plugins.PrettyPrint");
      dojo.addOnLoad(function(){
         dojo.connect(dijit.byId("eFormat"), "onClick", function(){
           output.value = dijit.byId("input").attr("value");
         });
      });
    </script>

  .. html::

    <b>Enter some text, then press the button to see it in encoded format</b>
    <br>
    <div dojoType="dijit.Editor" height="100px"id="input" extraPlugins="['prettyprint']">
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
    <button id="eFormat" dojoType="dijit.form.Button">Press me to format!</button>
    <br>
    <textarea style="width: 100%; height: 100px;" id="output" readonly="true">
    </textarea>


Configured indent and line length
---------------------------------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4

  .. javascript::

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dijit.Editor");
      dojo.require("dojox.editor.plugins.PrettyPrint");
      dojo.addOnLoad(function(){
         dojo.connect(dijit.byId("eFormat"), "onClick", function(){
           output.value = dijit.byId("input").attr("value");
         });
      });
    </script>

  .. html::

    <b>Enter some text, then press the button to see it in encoded format</b>
    <br>
    <div dojoType="dijit.Editor" height="100px"id="input" extraPlugins="[{name:'prettyprint', indentBy: 3, lineLength: 20}]">
    <div>
    <br>
    blah blah & blah!  This is a line longer than <b>twenty</b> characters, so it should wrap!
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
    <button id="eFormat" dojoType="dijit.form.Button">Press me to format!</button>
    <br>
    <textarea style="width: 100%; height: 100px;" id="output" readonly="true">
    </textarea>




========
See Also
========

* `dijit.Editor <dijit/Editor>`_
* `dojox.editor.plugins <dojox/editor/plugins>`_
* `dojox.html.format <dojox/html/format>`_
