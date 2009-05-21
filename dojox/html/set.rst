#format dojo_rst

dojox.html.set
===============

:Status: Draft
:Version: 1.0
:Authors: Sam Foster, Bill Keese, Frederic ?
:Available: since 1.2

.. contents::
   :depth: 2

Extensions to content setting utilities in dojo.html

============
Introduction
============

dojox.html.set and its helper dojox.html._ContentSetter extend the content-setting available in their `dojo.html <dojo.html>`_ counterparts, by adding support for executing scripts, adding style. The _ContentSetter provides this functionality to the dojox `ContentPane <dojox.layout.ContentPane>`_.

While loading content with script and style blocks is perhaps a questionable practice, there are valid use cases, and times when this is the only option available.  

=====
Usage
=====

.. code-block :: javascript
 :linenos:

  dojox.html.set(node, htmlString {
      executeScripts: 1, 
      scriptHasHooks: false,
      renderStyles: true
  });

========
Examples
========

Programmatic example
--------------------

TODO: example



========
See also
========

* TODO: links to other related articles
