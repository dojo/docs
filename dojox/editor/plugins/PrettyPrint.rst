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

Have you ever wanted to pull your hair out because the content from dijit.Editor was formatted so badly it looked like the output from some crazed demonic minion bent on causing insanity?   Well, I know I sure have, and thus was born the PrettyPrint plugin for the dijit.Editor.  What this plugin does is format the output that comes from dijit.Editor.attr("value"), (or dijit.Editor.getValue()), and makes it human readable, with reasonably indented structure, cleaned up line wrapping, and other general cleanup to make it much more human-readable.  

This plugin is 'headless', meaning it adds no toolbar button nor does it require any work to get decent output from it.  All you do is load it and register it as an extraPlugin for your editor and you're good to go.

========
Features
========

This plugin cleans up the output from dijit.Editor in the following ways:

* Reasonable indention of tags to show nesting structure.
* Wrapping of text lines consistently and allowing the user to specify a max line length.
* Configurable encoding entity characters in the TEXT elements of the document.  
* All done automatically, no toolbar buttons, no extra user actions required.

=====
Usage
=====

Usage of this plugin is quite simple and painless.  The first thing you need to do is require into the page you're using the editor.  This is done in the same spot all your dojo.require calls are made, usually a head script tag.  For example:

.. code-block::javascript:
 
  <script type="text/javascript">
    dojo.require("dijit.Editor");
    dojo.require("dojox.editor.plugins.PrettyPrint");
  </script>


=========
Functions
=========

dojox.html.format.prettyPrint(str, indentBy, lineLength, map)
-------------------------------------------------------------

The 'prettyPrint function takes one required parameter and several optional ones.  Please see the following table below for descriptions of the parameters.


+-----------------------------------+---------------------------------------------------------------------+------------------------+
| **Parameter**                     | **Description**                                                     | **Required**           |
+-----------------------------------+---------------------------------------------------------------------+------------------------+
| str                               |The string of HTML text to format                                    | YES                    |
+-----------------------------------+---------------------------------------------------------------------+------------------------+
| indentBy                          |An integer between 1 and 10 to indicate how many spaces to indent    | NO                     |
|                                   |by when indenting.  If negative, greater than 10, or null/undefined  |                        |
|                                   |indent will be a TAB character.                                      |                        |
+-----------------------------------+---------------------------------------------------------------------+------------------------+
| lineLength                        |An integer specifying the maximum length of a TEXT line in the HTML  | NO                     |
|                                   |document.  Must be non-negative.  If negative, null, or undefined,   |                        |
|                                   |then the line has no maximum length and will not be split into       |                        |
|                                   |multiple.                                                            |                        |
+-----------------------------------+---------------------------------------------------------------------+------------------------+
| map                               |An array of entity character mappings to encode special characters to| NO                     |
|                                   |If not provided, then it uses the default set HTML and LATIN 1       |                        |
|                                   |(8859-1).                                                            |                        |
+-----------------------------------+---------------------------------------------------------------------+------------------------+


========
See Also
========

* `dojox.html.format <dojox/html/format>`_
