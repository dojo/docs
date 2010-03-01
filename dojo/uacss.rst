#format dojo_rst

dojo.uacss
============

:Status: Draft
:Version: 1.0
:Available: since V1.4

.. contents::
    :depth: 2

============
Introduction
============

By doing a dojo.require("dojo.uacss" CSS classes will be added to your document's <html> tag.   The classes include:

1. Browser and browser version

   - dj_ie: Internet explorer
   - dj_ie6: Internet explorer version 6
   - dj_ie7: Internet explorer version 7
   - dj_ie8: Internet explorer version 8
   - dj_opera: Opera
   - dj_khtml: KHTML
   - dj_safari: Safari
   - dj_chrome: Google Chrome
   - dj_ff3: Firefox verion 3.x (including 3.5 and 3.6)

2. browser category

   - dj_webkit: Any webkit based browser (notably Google Chrome and Safari)
   - dj_gecko: Mozilla based browser (notably Firefox)

3. browser functionality

   - dj_iequirks: Internet explorer is running in quirks mode rather than standards mode
   - dj_contentBox: standard sizing, where style="..." tag refers to size of the content box
   - dj_borderBox: behavior of IE6 and IE in quirks mode where style="..." refers to the size including padding and border

4. BIDI
If the document is in right-to-left mode (for Arabic and Hebrew text), then it has the

   - dj_rtl: RTL mode

flag.   In addition, the classes from above are repeated with -rtl appended.  For example, running on IE6 in RTL mode will produce the following classes on <html>:

.. code-block :: css

   dj_ie dj_ie7 dj_iequirks dj_borderBox
   dj_rtl dj_ie-rtl dj_ie7-rtl dj_iequirks-rtl dj_borderBox-rtl


=====
Usage
=====

Simply require the module:

.. code-block :: javascript

  dojo.require("dojo.uacss");

And then reference the class names from CSS rules, etc:


.. code-block :: css

  .dj_iequirks .foo {
       zoom: 1;
   }
