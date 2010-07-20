#format dojo_rst

Hosted Dojo
===============



============
Introduction
============
There are two special ways to reference a dojo resource URL within CodeGlass examples: ``{{dataUrl}}`` and ``{{baseUrl}}``.

``{{dataUrl}}`` references the instance of Dojo that is locally hosted on DojoCampus.  It should be used for resources not found in a normal build (e.g. files within ``tests`` directories), as well as for files that need to be accessed on the same domain.

``{{baseUrl}}`` should be used for resources that are available in a normal dojo build.  In cases where examples run against the CDN, this will be replaced with the CDN base URL, resulting in faster performance (and less stress on the dojocampus server).  When the examples are run against trunk, it will effectively translate to the same thing as ``{{dataUrl}}``.

Beneath each of these are the standard directories:

* dojo
* dijit
* dojox
