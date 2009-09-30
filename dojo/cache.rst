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

``dojo.cache`` allows you to specify a path to a file that has the HTML, and ``dojo.cache`` will load it via a synchronous XMLHttpRequest (XHR) call. Because of this, the HTML file should live on the same domain as the web page that uses the JavaScript module that has the ``dojo.cache`` call.

The Dojo build system will inline the HTML as a string where the ``dojo.cache`` call happens, so it allows for better performance just by doing a build. Doing a build also allows the module to be used in xdomain loading scenarios.

=====
Usage
=====

``dojo.cache`` is a Dojo Core module, not part of Dojo Base so you need to *dojo.require("dojo.cache")* to load it.

``dojo.cache`` takes the following arguments:

dojo.cache(module, url, configValue)

Here is the definition of arguments:

module
  Can be a String or an Object.
  
  If a String, the module name to use for the base part of the URL, similar to module argument to `dojo.moduleUrl <dojo/moduleUrl>`_.
  
  If an Object, something that has a .toString() method that generates a valid path for the cache item. For example, a dojo._Url object.

url
  The rest of the path to append to the path derived from the module argument.
  
  If "module" is an object, then this second argument should be the "configValue" argument instead.
  
configValue
  Can be a String or an Object.
  
  If a String, it is used as the cache value for the module/url combination.

  If an Object, it can have two properties, value and sanitize:

    * value: a String that should be the value to use as the cache value for the module/url combination.
    * sanitize: Boolean: indicates if XML declarations should be removed from the value and if the HTML inside a body tag in the value should be extracted as the real value.
    
  The configValue argument or the value property on the configValue argument are usually only used by the build system as it inlines cache content.
  
  Usually your code will only specify the sanitize property to true if you want the sanitize behavior. Otherwise, you normally leave off the cacheValue argument in the call.


========
Examples
========

This is the usual, most common use of the dojo.cache call:

.. code-block :: javascript
 :linenos:

 dojo.require("dojo.cache");
 var text = dojo.cache("my.module", "template.html");
 
If my/module/template.html contained the text "<div>Hello World</div>", then the text variable will have that value.

An example using the sanitize: true option:

.. code-block :: javascript
 :linenos:

 dojo.require("dojo.cache");
 var text = dojo.cache("my.module", "template.html", {sanitize: true});

If my/module/template.html contains "<html><body><h1>Hello</h1></body></html>", the text variable will contain just "<h1>Hello</h1>".

Example using an object that has like the previous example, but uses an object whose toString() method represents a file path:

.. code-block :: javascript
 :linenos:

 dojo.require("dojo.cache");
 var text = dojo.cache(new dojo._Url("my/module/template.html"), {sanitize: true});

========
See Also
========

`dojo.moduleUrl <dojo/moduleUrl>`_
