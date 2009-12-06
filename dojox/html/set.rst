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

dojox.html.set and its helper dojox.html._ContentSetter extend the content-setting available in their `dojo.html <dojo/html>`_ counterparts, by adding support for executing scripts, adding style. The _ContentSetter provides this functionality to the dojox `ContentPane <dojox.layout.ContentPane>`_.

Be careful: Loading content with script and style blocks is often a questionable practice. A more secure and recommended solution is, to load just pure data with the help of the available Dojo datastores. But beside this general principle, there are also valid use cases, and times when loading content with scripts is the only option available. In such cases, dojox.html.set() can help you.


=====
Usage
=====

.. code-block :: javascript
 :linenos:

  dojox.html.set(node, htmlString {
      executeScripts: true, 
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

* `Quickstart Tutorial: Using Dojo Data <quickstart/data/usingdatastores>`_
