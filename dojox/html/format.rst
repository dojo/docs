#format dojo_rst

dojox.html.format
=================

:Status: Draft
:Version: 1.0
:Authors: Jared Jurkiewicz
:Developers: Jared Jurkiewicz
:Available: since V1.4

.. contents::
    :depth: 2

Have you ever wanted to format some HTML that came out of a textarea?  Or the dijit.Editor?  Or any other markup editor, for that matter, so it can be easily read by people?  If so, then this package is for you!

**dojox.html.format** package offers additional HTML helper functions for formatting HTML text.

========
Features
========

This package was created as a general purpose helper library for formatting HTML text markup.  It currently contains one function, 'prettyPrint', which is intended to take a fragment of HTML text (usually the innerHTML of a document body)  and format it so it is human readable.  

===========
Usage Notes
===========

* You should not pass it a complete HTML document (one that includes <html><head></head></html> tags, as the formatter makes use of the browser DOM parser to format the input.  The problem with the HTML head and such tags is that most browsers will strip them out if they're included under any subtag, even ones that are not attached to the document.  So to get the most consistent behaviors, only provide it document fragments, such as the innerHTML of a <body> tag.

* Browsers return attributes in different orders on tags.  Therefore the output will not have attribute ordering the same across browsers.  The content will work the same, though.

* Browsers do not always return the same output for input.  For example in a style attribute, you may specify something like: 'background-color: #fefefe'.  On Firefox, you will get back: 'background-color: rgb(...)'  The same value just represented differently.  Again, these will all work fine when rendered in other browsers, it's just a point of note to not expect the *exact* same output.

* Internet Explorer does not consistently keep comment nodes (<!-- -->).   Sometimes they will be in a rendered doc and thus format-able, sometimes not.  I wish this were not true, but alas it is.  Internet explorer has a tendency to just delete nodes from documents if it thinks they're in the wrong spot, which then makes it impossible to serialize out in a nice format (when using the browser renderer to give you the tree structure).

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
Examples
========

Format some HTML markup
-----------------------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4

  .. javascript::

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dojox.html.format");

      dojo.addOnLoad(function(){
         //Make sure the default input is actually unformatted!
         var lines = dojo.byId("input").value.split("\n");
         var i;
         for(i=0; i < lines.length; i++){
            lines[i] = dojo.trim(lines[i]) + "\n";
         }
         dojo.byId("input").value = lines.join("");
         dojo.connect(dijit.byId("bFormat"), "onClick", function(){
           var input = dojo.byId("input");
           var output = dojo.byId("output");
           output.value = dojox.html.format.prettyPrint(input.value);
         });
      });
    </script>

  .. html::

    <b>Enter some text, then press the button to see it in encoded format</b>
    <br>
    <textarea style="width: 100%; height: 100px;" id="input">
    <div>
    <br>
    blah blah & blah!
    <br>
    </div>
    <br>
    <table>
    <tbody>
    <tr>
    <td>One cell</td>
    <td>
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
    </textarea>
    <button id="bFormat" dojoType="dijit.form.Button">Press me to format!</button>
    <br>
    <textarea style="width: 100%; height: 100px;" id="output" readonly="true">
    </textarea>
