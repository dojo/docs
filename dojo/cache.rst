#format dojo_rst

dojo.cache
==========

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V1.4

.. contents::
   :depth: 2

A getter and setter method for storing the string content associated with the module and url arguments. It is a generic version of the functionality provided by dijit's templatePath method.

============
Introduction
============

There are many times where you will want to inject some raw HTML into the DOM. However, it can be cumbersome to write the HTML as a string literal in JavaScript.

`dojo.cache` allows you to specify a path to a file that has the HTML, and `dojo.cache` will load it via a synchronous XMLHttpRequest (XHR) call. Because of this, the HTML file should live on the same domain as the web page that uses the JavaScript module that has the dojo.cache call.

The Dojo build system will inline the HTML as a string where the dojo.cache call happens, so it allows for better performance just by doing a build.

=====
Usage
=====

TODO: how to use the component/class/method

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // your code
 </script>



========
Examples
========

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

TODO: example


========
See also
========

* TODO: links to other related articles
