.. _dojo/_base/window:

dojo._base.window
=================

:Available: since V?

.. contents::
    :depth: 2

**dojo._base.window** contains functions for dealing with the document-wide DOM and context related stuff.

As with all dojo._base components, these functions are included within Dojo Base. You get this functionality by just including dojo.js or dojo.xd.js in your page.


========
Features
========

* :ref:`dojo.doc <dojo/doc>`

  Alias for the current document

* :ref:`dojo.body <dojo/body>`

  Return the body element of the document

* :ref:`dojo.setContext <dojo/setContext>`

  Changes the behavior of many core Dojo functions that deal with namespace and DOM lookup

* :ref:`dojo.withGlobal <dojo/withGlobal>`

  Call callback with globalObject as dojo.global and globalObject.document as dojo.doc

* :ref:`dojo.withDoc <dojo/withDoc>`

  Call callback with documentObject as dojo.doc
