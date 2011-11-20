.. _dojox/xml:

dojox.xml
=========

:Status: Draft
:Version: beta
:Authors: Tom Trenka, Jared Jurkiewicz

.. contents::
   :depth: 2


The goal of DojoX XML Utilities is provide differing XML utilities for use in various places in a consolodated package to eliminate code duplication.  Currently this includes a native JS DomParser that converts XML to a JS object tree.  It also includes several general utility XML functions, such as a function to construct new XML Doms in a browser independent fashion, produce XML text from an XML DOM, and do things such as getting all the text content under a node in a browser agnostic way.

============================================================
Generic XML Text to DOM parser and XML DOM utility functions
============================================================

The dojox.xml.parser utility library contains numerous functions for working with XML text and XML dom.  The functions it provides are listed below:

* XML Text to XML DOM parser ( dojox.xml.parser.parse(someXMLText) )
* XML DOM to XML Text parser ( dojox.xml.parser.innerXML(someDOM) )
* Getting and setting text content on a node: ( dojox.xml.parser.textContent(node, "optional text to set") )



Example 1: Generic XML DOM Parser and utilities
-----------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.xml.parser");

      function init() {
         //Parse text and generate an XML DOM
         var xml = "<tnode><node>Some Text</node><node>Some Other Text</node></tnode>";
         var dom = dojox.xml.parser.parse(xml);
  
         //Walk DOM and attach into the display how many child nodes were parsed out.
         var ap = dojo.byId("xmlContent");
         var docNode = dom.documentElement;
         ap.appendChild(document.createTextNode("Document contains: " + docNode.childNodes.length + " elements"));
         ap.appendChild(document.createElement("br"));
         ap.appendChild(document.createElement("br"));

         //Write text content into the display.
         for (var i = 0; i < docNode.childNodes.length; i++) {
           ap.appendChild(document.createTextNode("Element: [" + i + "] contains text: " + dojox.xml.parser.textContent(docNode.childNodes[i])));
           ap.appendChild(document.createElement("br"));
         } 

         //Write out the XML text obtained from converting the DOM back.
         ap.appendChild(document.createElement("br"));
         ap.appendChild(document.createTextNode("Document XML: " + dojox.xml.parser.innerXML(docNode)));
         ap.appendChild(document.createElement("br"));
         ap.appendChild(document.createElement("br"));
      }
      dojo.addOnLoad(init);
    </script>

  .. cv :: html 

    <div id="xmlContent"></div>

========================================
Generic XML DOM to JS Object tree parser
========================================

The second helper class is the dojox.xml.DomParser.   This utility function will parse an XML text string into a JS Object tree that is structured similarly to the XML dom.  This is done completely with regular expressions and avoids any usage of browser parsers.  It is very efficient.

Example 2: Generic XML DOM to JS Object parser
----------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.xml.DomParser");

      function init() {
         //Parse text and generate an JS DOM
         var xml = "<tnode><node>Some Text</node><node>Some Other Text</node></tnode>";
         var jsdom = dojox.xml.DomParser.parse(xml);

         console.debug(jsdom);
      }
      dojo.addOnLoad(init);
    </script>

  .. cv :: html 
 
    Look in the console for debug statements showing the constructed JS DOM like structure.
