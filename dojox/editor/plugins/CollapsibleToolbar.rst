#format dojo_rst

dojox.editor.plugins.CollapsibleToolbar
=======================================

:Status: Draft
:Version: 1.0
:Authors: Jared Jurkiewicz
:Developers: Jared Jurkiewicz
:Available: since V1.4

.. contents::
    :depth: 2

Have you ever wanted to collapse the editor toolbar out of the way?  This is desirable in cases where the editor occupies a small section of a page and the toolbar has wrapped, limiting the editing area.  If this is a situation your users encounter, then this plugin is for you.

========
Features
========

Once required in and enabled, this plugin provides the following features to dijit.Editor.

* A nicely styled minimize/maximize button on the editor toolbar.
* Full a11y support.  The button is properly read by screen-readers and works in keyboard tab order.
* The button works perfectly in high-contrast mode,
* Styles for Tundra, Nihilo, and soria themes.

===========
Limitations
===========

* This plugin should be instantiated as the first plugin in the plugins list to ensure that it adapts the toolbar before other plugins modify it (such as FindReplace does).


=====
Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.  The first thing you need to do is require into the page you're using the editor.  This is done in the same spot all your dojo.require calls are made, usually a head script tag.  For example:

.. code-block :: javascript
 
    dojo.require("dijit.Editor");
    dojo.require("dojox.editor.plugins.CollapsibleToolbat");


Once it has been required in, all you have to do is include it in the list of extraPlugins as the first plugin (or the first plugin of the plugins property if you're reorganizing the toolbar) to enable it in your editor instance.  For example:

.. code-block :: html

  <div dojoType="dijit.Editor" id="editor" extraPlugins="['collapsibletoolbar']"></div>


You also need to include the CSS for it.  For example:

.. code-block :: html

  <style>
    @import "dojox/editor/plugins/resources/css/CollapsibleToolbar.css";
  </style>


And that's it.  The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the CollaspibleToolbar plugin!  You can click the collapse icon to collapse the toolbar, and the expand icon to bring it back

========
Examples
========

Basic Usage
-----------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.5

  .. javascript::

    <script>
      dojo.require("dijit.Editor");
      dojo.require("dojox.editor.plugins.CollapsibleToolbar");
    </script>

  .. css::

    <style>
      @import "{{baseUrl}}dojox/editor/plugins/resources/css/CollapsibleToolbar.css";
    </style>
    
  .. html::

    <br>
    <div dojoType="dijit.Editor" height="250px"id="input" extraPlugins="['collapsibletoolbar']">
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
