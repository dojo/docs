#format dojo_rst

dojox.atom.io.model
===================

:Status: Draft
:Version: 1.0
:Project owner: Benjamin Schell
:Available: since V1.3

.. contents::
   :depth: 2

The *dojox.atom.io.model* module is a JavaScript model of an ATOM feed.  

============
Introduction
============

This module handles the parsing of the ATOM XML into a JavaScript structure that can be easily modified and then serialized out as XML.  This set of classes handles browser idiosyncrasies when parsing the XML, making it very cross-browser compatible and is far simpler to work with than using DOM apis to walk the ATOM XML document.

============================
Classes defined in the model
============================

When the model file is loaded, several classes are defined that represent ATOM tags.  Please refer to the following table for the class names and a description of what they represent.  Each entry in the class name table also acts as a link to specific documentation about that class and what core functions it provides.

+-------------------------------------------------------------------+--------------------------------------------------------------------------+
| **Class Name**                                                    | **Description**                                                          |
+-------------------------------------------------------------------+--------------------------------------------------------------------------+
| `dojox.atom.io.model.AtomItem <dojox/atom/io/model/AtomItem>`_    | A generic superclass used to represent specific ATOM details that are    |
|                                                                   | common for many ATOM tags                                                | 
+-------------------------------------------------------------------+--------------------------------------------------------------------------+
| `dojox.atom.io.model.Category <dojox/atom/io/model/Category>`_    | Model to represent the Category tag of an ATOM document.  Contains all   |
|                                                                   | Category properties and a toString function for serializing it back to   |
|                                                                   | XML                                                                      |
+-------------------------------------------------------------------+--------------------------------------------------------------------------+
| `dojox.atom.io.model.Content <dojox/atom/io/model/Content>`_      | Model to represent the Content style tags in an ATOM document.  This is  |
|                                                                   | used to represent Summary, Content, Title, and Subtitle elements in an   |
|                                                                   | ATOM feed.  In other words, it represents any element that can contain   |
|                                                                   | Text, HTML, XHTML, etc as content format.  It also has a toString        |
|                                                                   | function used to generate the corresponding XML tag                      |
+-------------------------------------------------------------------+--------------------------------------------------------------------------+
| `dojox.atom.io.model.Link <dojox/atom/io/model/Link>`_            | Atom link element.  Used for representing link attributes.  Handles      |
|                                                                   | multiple link types (edit, alt, etc.)                                    |     
+-------------------------------------------------------------------+--------------------------------------------------------------------------+
| `dojox.atom.io.model.Person  <dojox/atom/io/model/Person>`_       | Atom person element. Used to represent authors and contributors.         |
+-------------------------------------------------------------------+--------------------------------------------------------------------------+
| `dojox.atom.io.model.Entry <dojox/atom/io/model/Entry>`_          | Atom entry element. Represents an Atom entry, including storing the      |
|                                                                   | authors, contributors, title, content, and so on.                        |
+-------------------------------------------------------------------+--------------------------------------------------------------------------+
| `dojox.atom.io.model.Feed <dojox/atom/io/model/Feed>`_            | Atom feed element. Represents an Atom Feed, including the feed elements  |
|                                                                   | such as the title and author, and also represents the entry list.        |
+-------------------------------------------------------------------+--------------------------------------------------------------------------+
| `dojox.atom.io.model.Generator <dojox/atom/io/model/Generator>`_  | Atom generator element                                                   |
+-------------------------------------------------------------------+--------------------------------------------------------------------------+
| `dojox.atom.io.model.Service <dojox/atom/io/model/Service>`_      | Atom service element                                                     |
+-------------------------------------------------------------------+--------------------------------------------------------------------------+
| `dojox.atom.io.model.Workspace <dojox/atom/io/model/Workspace>`_  | Atom workspace element                                                   |
+-------------------------------------------------------------------+--------------------------------------------------------------------------+
| `dojox.atom.io.model.Collection <dojox/atom/io/model/Collection>`_| Atom collection element                                                  |
+-------------------------------------------------------------------+--------------------------------------------------------------------------+

=================
Utility Functions
=================

There are also several utility functions defined by the model.  These functions are used by all of the subclasses and can be useful in standalone cases as well.  Please refer to the following table for function name and description:

+-----------------------------------------------------+----------------------------------------------------------------------------------------+
| **Function**                                        | **Description**                                                                        |
+-----------------------------------------------------+----------------------------------------------------------------------------------------+
| dojox.atom.io.model.util.createDate(DOMNode)        | A function for parsing the text content of a DOM node and creating a Date object from  |
|                                                     | it.                                                                                    |
+-----------------------------------------------------+----------------------------------------------------------------------------------------+
| dojox.atom.io.model.util.escapeHtml(String)         | A function for escaping HTML control and entity characters in a string so that it can  |
|                                                     | be handled as text without the markup affecting the XML document.                      |
+-----------------------------------------------------+----------------------------------------------------------------------------------------+
| dojox.atom.io.model.util.unEscapeHtml(String)       | A function for restoring the HTML control and tag characters to a string.  Useful when |
|                                                     | you wish to unEscape the content of an entry and display it in a Content Pane.         |
+-----------------------------------------------------+----------------------------------------------------------------------------------------+
| dojox.atom.io.model.util.getNodename(Node)          | A function for getting the node name of an XML node.  This function exists to handle   |
|                                                     | browser quirks.  Specifically things such as Internet Explorer's poor namespace        |
|                                                     | handling.                                                                              |
+-----------------------------------------------------+----------------------------------------------------------------------------------------+


=====
Usage
=====

The model is intended for creating, parsing, and working with ATOM feeds in Javascript and being able to easily serialize them out.  Generally to create a Feed you would use dojo.xhrGet() to load an XML document into a DOM, then pass that dom Object to buildFromDom() of a newly instantiated Atom Feed model class.  It will then construct all its subclasses and set its attributes correctly.  For specific usage, please refer to the examples section.

========
Examples
========

Example 1: Create an ATOM Feed model from an existing ATOM document
-------------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.atom.io.model");

      //This function performs some basic dojo initialization and will do the fetch calling for this example
      function initSimpleAtom () {
        var xhrArgs = { 
           url: "/moin_static163/js/dojo/trunk/release/dojo/dojox/atom/tests/widget/samplefeedEdit.xml",
           preventCache: true,
           handleAs: "xml"
        }
 
        var deferred = dojo.xhrGet(xhrArgs);
       
        //Okay, on success we'll process the ATOM doc and generate the JavaScript model
        deferred.addCallback(function(xmlDoc, ioargs){
           console.debug(xmlDoc);
           console.debug("Here.");
           var feedRoot = xmlDoc.getElementsByTagName("feed");
           console.debug("Now Here.");
           try{
 
           var feed = new dojox.atom.io.Feed();
           feed.buildFromDom(feedRoot[0]);
           var display = dojo.byId("simpleAtom");
           console.debug(feed);
           console.debug(display);
        });
 
        deferred.addErrback(function(error){
           console.debug(e);
        });
      }
      //Set the init function to run when dojo loading and page parsing has completed.
      dojo.addOnLoad(initSimpleAtom);
    </script>

  .. cv :: html 

    <button dojoType="dijit.form.Button" id="simpleFetchButton">Click me to load an ATOM document and parse it into a model</button >
    <br>
    <br>
    <span>
      <pre id="simpleAtom">
      </pre>
    </span>



========
See Also
========

* `dojox.data.AppStore <dojox/data/AppStore>`_: A datastore built upon the *io* modules and provides full APP support.
