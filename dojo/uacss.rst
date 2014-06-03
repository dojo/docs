.. _dojo/uacss:

==========
dojo/uacss
==========

:since: v1.4

.. contents ::
    :depth: 2

**dojo/uacss** adds browser "centric" CSS classes to a the document's ``<html>`` tag.  This is mainly used to be able 
to easily apply browser specific CSS styles, working around browser limitations and quirks.

Usage
=====

In order to have the appropriate classes added to your document, just load the module:

.. js ::

  require(["dojo/uacss"], function(){
    // do something...
  });

Then provide CSS rules that leverage the classes:

.. css ::

  .dj_ie6 h1 {
    font-size: 24px;
  }

*Note* If you are relying on the styles to be set before running code, just using the 
:ref:`dojo/domReady! <dojo/domReady>` loader plugin is not necessarily sufficient and you should wrap any code that
relies upon the styles in a :ref:`dojo/ready <dojo/ready>` callback.  This is because ``dojo/uacss`` also has to load 
after the DOM is ready and registers itself to load before other ``dojo/ready`` callbacks.  For example:

.. js ::

  require(["dojo/ready", "dojo/uacss"], function(ready){
    ready(function(){
      // do something reliant upon dojo/uacss
    });
  });

There is no need to provide a variable in the callback function for ``dojo/uacss``.  The module will return an alias 
to ``dojo/has``.

There are several different features that are detected and classes that are added to the document:

===================== ================ ================================================================================
Category              CSS Class        Notes
===================== ================ ================================================================================
Browser and Version   dj_ie            Internet Explorer

                      dj_ie6           Internet Explorer v6

                      dj_ie7           Internet Explorer v7

                      dj_ie8           Internet Explorer v8

                      dj_ie9           Internet Explorer v9

                      dj_opera         Opera

                      dj_khtml         KHTML

                      dj_safari        Safari

                      dj_chrome        Chrome

                      dj_ff3           Firefox version 3.X (incuding 3.5 and 3.6)
Browser Category      dj_webkit        Any webkit based browser (notably Google Chrome and Safari)

                      dj_gecko         Any Mozilla based browser (notably Firefox)
Broswer Functionality dj_quirks        Browser is running in quirks mode rather than standards mode
                      
                      dj_iequirks      Internet Explorer is running in quirks mode
                      
                      dj_contentBox    Standard Sizing (where style size refers to content box)
                      
                      dj_borderBox     Where style sizing includes the size of padding and border
BIDI                  dj_rtl           If the document is in the right-to-left mode, the ``dj_rtl`` class is added, 
                                       plus other classes with a ``-rtl`` added on to them will also be added.
                      dj_ie-rtl
                      
                      dj_borderBox-rtl
===================== ================ ================================================================================

See Also
========

* :ref:`dojo/sniff <dojo/sniff>` - Browser feature detection module.

* :ref:`dojo/has <dojo/has>` - Dojo's feature detection API.

* :ref:`dojo/dom-class <dojo/dom-class>` - DOM Class manipulation routines.
