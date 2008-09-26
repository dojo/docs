## page was renamed from 1.2/dojo/Deferred
#format dojo_rst

dojo.Deferred
=============

:Status: Draft
:Version: 1.2
:Authors: ?--
:Developers: James Burke, Peter Higgins, Dustin Machi, Neil Roberts, Alex Russell, Dylan Schiemann
:Available: since V?

.. contents::
    :depth: 2

dojo.Deferred manages the communication between asynchronous threads (Callbacks). dojo.Deferred encapsulates a sequence of callbacks in response to a value that may not yet be available.

============
Introduction
============

TODO: introduce the component/class/method


=====
Usage
=====

TODO: how to use the component/class/method

.. code-block :: javascript
  :linenos:

  <script type="text/javascript">
    var deferred = new dojo.Deferred();
    setTimeout(function(){deferred.callback({success: true}); }, 1000);
    return deferred;
  </script>


========
Examples
========


TODO: short header
------------------

TODO: example
