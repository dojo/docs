## page was copied from dojo/addOnLoad
## page was renamed from 1.2/dojo/addOnLoad
#format dojo_rst

dojo.addOnUnload
================

:Status: Draft
:Version: 1.0
:Available: since V?

.. contents::
   :depth: 2

dojo.addOnUnload registers a function to be called when the page unloads.


============
Introduction
============

Since working with the DOM or JavaScript during a `window.onunload` event is not recommended, dojo.addOnUnload is triggered during `window.onbeforeunload`.  However, you need to be careful about what work you do during `dojo.addOnUnload/window.onbeforeunload` since this event can be triggered  if the user clicks a link to download a file or a `javascript:` link.  In these cases, the `document` will not be destroyed and so any destructive operations done during a `dojo.addOnUnload` callback may be premature.  If you need to run code during `window.onunload` then you can register a function using `dojo.addOnWindowUnload <dojo/addOnWindowUnload>`_.


=====
Usage
=====

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // declare a function to do the unload work
   var unLoad = function() {
     // do some unload stuff
     alert("unloading...");
   }
   // pass a function pointer
   dojo.addOnUnload(unLoad);

   // call a method of an object
   dojo.addOnUnload(window, "unLoad");

   // pass an object and an anonymous function
   dojo.addOnUnload(window, function() {alert("we're out of here!");});
 </script>



========
Examples
========

This example demonstrates how a `javascript:` link will trigger a `dojo.addOnUnload`.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      // declare a function to do the unload work
      var unLoad = function() {
        // do some unload stuff
        alert("unloading...");
      }
      // pass a function pointer
      dojo.addOnUnload(unLoad);
    </script>

  .. cv:: html

    This <a href="javascript:unLoad()">link</a> has an <pre>href="javascript:unLoad()"</pre> which fires dojo.addOnUnload but won't destroy the page.

========
See also
========

* `dojo.addOnWindowUnload <dojo/addOnWindowUnload>`_
