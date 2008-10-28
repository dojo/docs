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

Since working with the DOM or JavaScript during a `window.onunload` event is not recommended, dojo.addOnUnload is triggered during `window.onbeforeunload`.  However, you need to be careful about what work you do during `window.onbeforeunload` since this event can be triggered  if the user clicks a link to download a file or a `javascript:` link.  In these cases, the `document` will not be destroyed and so any destructive operations done during a `dojo.addOnUnload` callback may be premature.


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

* TODO: links to other related articles
