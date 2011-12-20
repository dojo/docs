.. _dojo/cache:

==========
dojo.cache
==========

:Project owner: James Burke
:since: V1.4

.. contents ::
   :depth: 2

A getter and setter method for storing the string content associated with the module and url arguments.
It is a generic version of the functionality provided by dijit's templatePath method.

This method's functionality has been superseded by the :ref:`dojo/text! <dojo/text>` plugin.
The documentation below is left for legacy purposes.


Introduction
============

There are many times where you will want to inject some raw HTML into the DOM. However, it can be cumbersome to write the HTML as a string literal in JavaScript.

``dojo.cache`` allows you to specify a path to a file that has the HTML, and ``dojo.cache`` will load it via a synchronous XMLHttpRequest (XHR) call. Because of this, the HTML file should live on the same domain as the web page that uses the JavaScript module that has the ``dojo.cache`` call.

The Dojo build system will inline the HTML as a string where the ``dojo.cache`` call happens, so it allows for better performance just by doing a build. Doing a build also allows the module to be used in xdomain loading scenarios.


Usage
=====

``dojo.cache`` is a Dojo Core module, To include the Dojo cache on your page, require the module `dojo.cache`. When use dojo 1.7, you should require ``dojo/text.js`` because the related functions used to define in ``dojo/cache.js`` have been moved.

.. js ::
  
  // Dojo 1.7 (AMD)
  require("dojo/text", function(){
      // write your code here
  });
  
.. js ::

  // Dojo < 1.7
  dojo.require("dojo.cache");
  

``dojo.cache`` takes the following arguments:

.. js ::

  dojo.cache(module, url, configValue);

Examples
========

This is the usual, most common use of the dojo.cache call:

.. js ::
 
  // Dojo 1.7 (AMD)
  require("dojo/text", function(){
    var text = dojo.cache("my.module", "template.html");
  });
  
.. js ::
 
 // Dojo 1.7
 dojo.require("dojo.cache");
 var text = dojo.cache("my.module", "template.html");
 
 
If my/module/template.html contained the text "<div>Hello World</div>", then the text variable will have that value.

An example using the sanitize: true option:

.. js ::
 
  // Dojo 1.7 (AMD)
  require("dojo/text", function(){
    var text = dojo.cache("my.module", "template.html", {sanitize: true});
  });

.. js ::
 
 // Dojo < 1.7
 dojo.require("dojo.cache");
 var text = dojo.cache("my.module", "template.html");


If my/module/template.html contains "<html><body><h1>Hello</h1></body></html>", the text variable will contain just "<h1>Hello</h1>".

Example using an object that has like the previous example, but uses an object whose toString() method represents a file path:

.. js ::
 
  // Dojo 1.7 (AMD)
  require("dojo/text", function(){
    var text = dojo.cache(new dojo._Url("my/module/template.html"), {sanitize: true});
  });

.. js ::
 
 // Dojo < 1.7
 dojo.require("dojo.cache");
 var text = dojo.cache(new dojo._Url("my/module/template.html"), {sanitize: true});

.. api-inline :: dojo.cache

See Also
========

* :ref:`dojo/text! <dojo/text>`
* :ref:`dojo.require <dojo/require>`
