#format dojo_rst

dojox.io.OAuth
===============

:Status: Draft
:Version: 1.0
:Project owner: Tom Trenka
:Available: since V1.3

.. contents::
   :depth: 2

dojox.io.OAuth is a helper class that allows you to "sign" any kwArgs object you might use with any of the dojo Ajax methods. It was designed to be as simple to use as possible, without exposing the user to the overhead and specification of OAuth.


============
Introduction
============

dojox.io.OAuth, a singleton (i.e. you never instantiate it), enables OAuth-signed Ajax requests to be made as if they were native to the Dojo Toolkit.

The main method to be used is the "sign" method; what this method does is to create an OAuth-compatible signature for any URL-based request. It includes everything needed to accomplish this signature--which includes attaching all of the tokens required, the signature method used, a nonce (random number), and the signature check/hash.


=====
Usage
=====

TODO: how to use the component/class/method

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // your code
 </script>


========
Examples
========

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

TODO: example


========
See also
========

* TODO: links to other related articles
