#format dojo_rst

dojo.requireLocalization
========================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

Loads localized resources, according to the operating locale, or other locale if specified.

see `Translatable Resource bundles <quickstart/internationalization/resource-bundling>`_

============
Introduction
============

This method is analogous to dojo.require, which loads Javascript modules from a specified package.  requireLocalization specifies a named resource bundle within a package and loads the resources necessary to match a particular locale.  In development mode, this will trigger a series of transactions to fetch the root bundle and all locales and variants necessary to match the specified locale.  For example, fr-ca will pull in not only fr-ca, if available, but also fr and root and mix them together to form a single Javascript Object.  If there is no fr-ca variant, the correct result will be a 404, and the more general fr and root resources will be used. Note that the root, by convention is usually US-English, so there are actually no resources for either 'en' or 'en-us'.  Loading 'en-us' will result in three hits, two of which will be 404.  A Dojo build will collapse these locales into flattened resource bundles, resulting in a single server hit.

=====
Usage
=====

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
  dojo.require("dojo.i18n");
  dojo.requireLocalization("dijit.form", "validate");
 </script>


========
See also
========

* `Translatable Resource bundles <quickstart/internationalization/resource-bundling>`_
* http://www.ibm.com/developerworks/web/library/wa-dojo/index.html
