#format dojo_rst

dojo.setContext
===============

:Status: Draft
:Version: 1.0
:Available: since V?

.. contents::
   :depth: 2

Changes the behavior of many core Dojo functions that deal with namespace and DOM lookup.


============
Introduction
============

"dojo.setContext" allows many of Dojo's core functions to easily switch context (e.g. from the current window to an iframe) with a single function call.

For example, `dojo.query <dojo/query>`_ references the "window" global variable when performing searches by default.

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
     var dojoLinks = dojo.query('a');
     var nativeLinks = document.getElementsByTagName('a');

     // Returns true, as they're searching the same window.document
     console.log(dojoLinks.length === nativeLinks.length);
  </script>

This is because dojo stores many of the common global variables:

:window: dojo.global
:document: dojo.doc
:body: dojo.body()

By calling "dojo.setContext" (which modifies the convenience variables above), you can easily query another frame's content.


=====
Usage
=====

.. code-block :: javascript

  dojo.setContext(window, window.document);
  // or
  dojo.setContext(myIframe.contentWindow, myIframe.contentWindow.document);


========
Examples
========

Counting Links
--------------

Here is a simple example that counts the links in the current page as well as the links in an embedded iframe, via dojo.setContext.

HTML
~~~~

.. code-block :: html
  :linenos:

    <a href="#">I'm the only link on this page!</a>
    
    Number of links on this page:
        <input type="text" name="these_links" value="" id="these_links">
    
    <br />
    
    Number of links in the iframe:
        <input type="text" name="those_links" value="" id="those_links">
    
    <br />
    
    <!-- We have to count the links AFTER the iframe has loaded -->
    <iframe src="resources/links.html" id="iframe" onload="countLinks();"></iframe>


JavaScript
~~~~~~~~~~

.. code-block :: javascript
 :linenos:

  var countLinks = function() {
    var these = dojo.byId('these_links');
    var those = dojo.byId('those_links');
    var iframe = dojo.byId('iframe').contentWindow;
           
    // Count the number of links in *this* page
    these.value = dojo.query('a').length;

    // Change context from current window to iframe
    dojo.setContext(iframe.window, iframe.window.document);

    // Count the number of links in the *iframe*
    those.value = dojo.query('a').length;
  };
