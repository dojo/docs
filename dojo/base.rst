## page was renamed from 1.2/dojo/base
#format dojo_rst

dojo._base
==========

:Status: Contributed, Draft
:Version: 1.0

dojo._base is a roll-up file, and is used to create the core dojo.js after a build. You should never directly dojo.require("dojo._base") as all the functionality is provided by simply including dojo.js on a page. 

.. code-block :: html

  <!-- load dojo.js from AOL CDN -->
  <script src="http://o.aolcdn.com/dojo/1.1/dojo/dojo.xd.js"></script>

If you are using an un-built Dojo, the inclusion of dojo.js will trigger the inclusion of dojo._base, fetching each of the files in the dojo/_base/ folder within the source tree. This produces additional XHR activity, and should be avoided in production. After building, these files are concatenated into dojo.js, providing a 26k "Base Dojo" (~77k without gzip enabled). 

In the above example, we are including a X-Domain version of dojo.js, which is slightly larger in filesize (29k), though allows all modules and resources to be loaded from a different domain. 

Any function or class hanging off the dojo namespace is typically provided for in dojo._base. dojo.xhrGet, dojo.animateProperty, `dojo.connect <dojo/connect>`_, and dojo.require are examples of Base functionality. 

Note that use of Dojo in non-browser environments typically requires using Dojo from source so that the package system can detect the operating environment and include the correct sub-set of the dojo._base functionality. The Browser-specific subset is the most common and typically the most feature-rich. See the documentation for `dojo.require` and `dojo.requireIf` to understand conditional loading of modules.
