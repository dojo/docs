.. _dojox/editor/plugins/FindReplace:

================================
dojox.editor.plugins.FindReplace
================================

:Authors: Jared Jurkiewicz, He Gu Yi
:Project owner: Jared Jurkiewicz
:since: V1.4

.. contents ::
    :depth: 2

Have you ever wanted to know how node you were in while editing some rich text?  Have you ever wanted to be sure the entire element was deleted, not just its content?  If so, then this plugin is for you.

Features
========

Once required in and enabled, this plugin provides the following features to dijit.Editor.

* The ability to find text with modifiers of matching case and searching backwards from current position.
* The ability to replace text, with a modifier to replace all occurrences in the document past the current position.

Limitations
===========

* This plugin does not work in Opera.

Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.

First include the CSS for it:

.. css ::

    @import "dojox/editor/plugins/resources/css/FindReplace.css";

Then require it into the page where you're using the editor:

.. js ::
 
    dojo.require("dijit.Editor");
    dojo.require("dojox.editor.plugins.FindReplace");


Once it has been required in, all you have to do is include it in the list of extraPlugins (or the plugins property if you're reorganizing the toolbar) for you want to load into the editor.  For example:

.. html ::

  <div data-dojo-type="dijit/Editor" id="editor" data-dojo-props="extraPlugins:['findreplace']"></div>



And that's it.  The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the FindReplace plugin!  To display the find/replace toolbar, click the find/replace toggle button in the main toolbar.  The find/replace toolbar will then appear beneath the main toolbar.

User Interface
==============

This updated plugin provides the user with some basic find and replace functions. Click the Find and Replace button to open the toolbar.

.. image :: FindReplace.png

Find
----

Enter the text in **Find** text field and click **Find** button or press **ENTER** key to perform a search.

* The first found text will be highlighted.
* When the last occurrence is found, a tooltip dialog is displayed to indicate the end of the search.
* Regular expression is **NOT** supported.
* Select **Match case** to search the text with case.
* Select **Backwards** to search the text from the current focus toward the beginning.

.. image :: Find.png

Replace
-------

Enter the text to be replaced in **Find** text field and enter the replacement text in **Replace with** text field. Click **Replace** button or press **ENTER** key to perform a replacement.

* If current selection matches the text to be replaced, replace the current selection and move to the next found text.
* If current selection does not match the text to be replaced, move to the next match.
* When the last occurrence is found, a tooltip dialog is displayed to indicate the end of the replacement.
* Regular expression is **NOT** supported.
* Select **Match** case to search the text with case.
* Select **Backwards** to search the text from the current focus to the beginning.

.. image :: ReplaceWord.png

Replace All
-----------

Enter the text to be replaced in **Find** text field and enter the replacement text in the **Replace** with text field. Click **Replace All** button to perform a full text replacement.

* All the matching text will be replaced and a tooltip dialog will be displayed to indicate the number of replacements.
* Regular expression is **NOT** supported.
* Select **Match case** to search the text with case.
* Select **Backwards** to search the text from the end to the beginning.

.. image :: ReplaceAll.png

A11Y Considerations
===================

All fields within the **FindReplace** toolbar can be accessed with the keyboard.

Examples
========

Basic Usage
-----------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4

  .. js ::

      dojo.require("dijit.Editor");
      dojo.require("dojox.editor.plugins.FindReplace");

  .. css ::

      @import "{{baseUrl}}dojox/editor/plugins/resources/css/FindReplace.css";
    
  .. html ::

    <b>Toggle the find/replace toolbar by clicking its menu bar button.</b>
    <br>
    <div data-dojo-type="dijit/Editor" height="250px" id="input" data-dojo-props="extraPlugins:['findreplace']">
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
