#format dojo_rst

dojox.editor.plugins.NormalizeIndentOutdent
===========================================

:Status: Draft
:Version: 1.0
:Authors: Jared Jurkiewicz
:Developers: Jared Jurkiewicz
:Available: since V1.4

.. contents::
    :depth: 2

Have you ever wanted to pull your hair out because the the way browsers handle the native indent and outdent commands is inconsistent and in some cases downright wrong?  If so, then this plugin may help you!  This plugin attempts to control how indenting and outdenting of content is handled and do it consistently across all browsers.  It uses margin-left styling to handle indenting of block nodes, it will wrap and indent body-level text, and it will indent and outdent lists correctly.  It even attempts to fix malformed lists.   

This plugin is new in 1.4, and is still being worked on, so it is considered experimental.  Any feedback you can provide on issues you encounter would be appreciated.

This plugin is 'headless', meaning it adds no toolbar button nor does it require any work to get it to handle indenting and outdenting.  All you do is load it and register it as an extraPlugin for your editor and you're good to go.

========
Features
========

This plugin cleans up the output from dijit.Editor in the following ways:

* Uses margin styling for indenting instead of inconsistent behaviors like <blockquote> and the like.
* Will wrap body-level text in indentable containts when indenting said text.  
* Handles multi-node selection indenting
* Indents and outdents list elements correctly.  All known browsers (FireFox, Internet Explorer, WebKit), actually generate invalid HTML for lists when the native indent/outdent are used, so this plugin fixes that.  
* Makes use of the customUndo capability of editor.  This may impact performance on large documents, but is necessary as fixing the indent behavior requires DOM level manipulation, which the native undo/redo doesn't handle.

=====
Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.  The first thing you need to do is require into the page you're using the editor.  This is done in the same spot all your dojo.require calls are made, usually a head script tag.  For example:

.. code-block :: javascript
 
    dojo.require("dijit.Editor");
    dojo.require("dojox.editor.plugins.NormalizeIndentOutdent");


Once it has been required in, all you have to do is include it in the list of extraPlugins you want to load into the editor.  For example:

.. code-block :: html

  <div dojoType="dijit.Editor" id="editor" extraPlugins="['normalizeindentoutdent']"></div>

And that's it.  The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the NormalizeIndentOutdent plugin!

Configuring PrettyPrint Options
-------------------------------

The NormalizeIndentOutdent plugin supports a coupleoptions that control how it indents.  The options are defined below:

+-----------------------------------+---------------------------------------------------------------------+------------------------+
| **option**                        | **Description**                                                     | **Required**           |
+-----------------------------------+---------------------------------------------------------------------+------------------------+
| indentBy                          |Integer defining how many spaces to indent by.  Must be a positive   | NO                     |
|                                   |value.  The default is 40 (px)                                       |                        |
+-----------------------------------+---------------------------------------------------------------------+------------------------+
| indentUnits                       |The units used for the indenting style.  Either px or em.  The       | NO                     |
|                                   |default is px.                                                       |                        |
+-----------------------------------+---------------------------------------------------------------------+------------------------+

How do I configure the options?  Glad you asked.  You do it where you declare the plugin.  See the following example, which configures an editor with 3 em indent

.. code-block :: html

  <div dojoType="dijit.Editor" 
       id="editor" extraPlugins="[{name: 'normalizeindentoutdent', indentBy: 3, indentUnits: "em"}]">
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
      dojo.require("dijit._editor.plugins.ViewSource");
      dojo.require("dojox.editor.plugins.NormalizeIndentOutdent");
      dojo.addOnLoad(function(){
         dojo.connect(dijit.byId("eFormat"), "onClick", function(){
           output.value = dijit.byId("input").attr("value");
         });
      });
    </script>

  .. html::

    <b>Enter some text, then press the button to see it in encoded format</b>
    <br>
    <div dojoType="dijit.Editor" height="100px"id="input" extraPlugins="['normaliseindentoutdent', 'viewsource', 'prettyprint']">
    blah blah & blah!
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
    <button id="eFormat" dojoType="dijit.form.Button">Press me to see the indents applied!</button>
    <br>
    <textarea style="width: 100%; height: 100px;" id="output" readonly="true">
    </textarea>


Configured indent to be ems
---------------------------

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
    <div dojoType="dijit.Editor" height="100px"id="input" extraPlugins="[{name:'normalizeindentoutdent', indentBy: 3, indentUnits: "em"}, 'prettyprint', 'viewsource']">
    blah blah & <b>blah</b>!
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
* `dijit._editor.plugins <dijit/_editor/plugins>`_
* `dojox.editor.plugins <dojox/editor/plugins>`_
