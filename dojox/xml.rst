#format dojo_rst

dojox.xml
=========

:Status: Draft
:Version: beta
:Authors: Tom Trenka, Jared Jurkiewicz

.. contents::
   :depth: 2


The goal of DojoX XML Utilities is provide differing XML utilities for use in various places in a consolodated package to eliminate code duplication.  Currently this includes a native JS DomParser that converts XML to a JS object tree.  It also includes several general utility XML functions, such as a function to construct new XML Doms in a browser independent fashion, produce XML text from an XML DOM, and do things such as getting all the text content under a node in a browser agnostic way.

==============================
Generic XML Text to DOM parser
==============================

One of the very useful functions is the helper function that can convert a string of XML into an actual XML dom.  This is great for restoring data returned from a variety of mechanisms into an XML dom, or just creating one quickly on the fly.  It abstracts out the browser differences in obtaining the DOM parser and thus is very easy to use.

Example 1: Generic XML DOM Parser
---------------------------------


.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.xml.parser");

      function init() {
         var xml = "<tnode><node>Some Text<node><node>Some Other Text</node></tnode> 
         var dom = dojox.xml.parser.parse(xml);

alert(dom);
  
         var ap = dojo.byId("content");
         var docNode = dom.documentElement;

         ap.appendChild(document.createTextNode("Document contains: " + docNode.childNodes.length + " elements");
         ap.appendChild(document.createElement("br");

      }
      dojo.addOnLoad(init);
    </script>

  .. cv :: html 

    <span id="content">
    </span>


  .. cv:: css
