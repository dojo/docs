#format dojo_rst

dojox.encoding.digests
======================

:Status: Draft
:Version: 1.0+
:Author: Tom Trenka

.. contents::
  :depth: 2

DojoX Encoding includes a set of *hashing* algorithms, also known as digests, to aid with common hashing tasks
(such as CRC checks, password validation, etc.).  All hashing algorithms (MD5 and SHA1 at the time of writing,
with plans for the SHA2 family of digests) follow the same API, so that you can swap out algorithms with 
relative ease.

Each digest exposes a single function, with a private HMAC function as well, such as the following:

.. code-block :: javascript
  :linenos:
  
  dojo.require("dojox.encoding.digests.SHA1");
  var d = dojox.encoding.digests.SHA1(someString);
  var h = dojox.encoding.digests.SHA1._hmac(someString, someKey);

The digests in DojoX Encoding were designed to be as easy to use as possible, with some flexibility in terms of output.
This output takes the form of a keyword arguments object, that looks like so:

.. code-block :: javascript
  :linenos:

  var args = {
      outputType: dojox.encoding.digests.outputTypes.Base64
  };

The following output types are supported by ``dojox.encoding.digests.outputTypes`` (with the value of the enumeration):

* ``Base64`` (0)
* ``Hex`` (1)
* ``String`` (2)
* ``Raw`` (3)

At the time of writing (Dojo Toolkit 1.3 release), the following digests are available:

* ``dojox.encoding.digests.MD5``
* ``dojox.encoding.digests.SHA1``

More digest implementations (specificially the SHA2 family of digests) are planned for a future release.
