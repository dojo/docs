#format dojo_rst

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

* `dojo.doc <dojo/doc>`_

  Alias for the current document

* `dojo.body <dojo/body>`_

  Return the body element of the document

* `dojo.setContext <dojo/setContext>`_

  Changes the behavior of many core Dojo functions that deal with namespace and DOM lookup

* `dojo.withGlobal <dojo/withGlobal>`_

  Call callback with globalObject as dojo.global and globalObject.document as dojo.doc

* `dojo.withDoc <dojo/withDoc>`_

  Call callback with documentObject as dojo.doc
