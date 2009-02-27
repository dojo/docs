#format dojo_rst

dojox.encoding.base64
=====================

:Status: Draft
:Version: Dojo Toolkit 1.0+
:Author: Tom Trenka

The base64 encoder is a simple mechanism to translate strings encoded using the base 64 specification
defined within `RFC 4648 <http://tools.ietf.org/html/rfc4648>`_.  It is designed to operate either on
a string (``decode``) or an array of bytes (``encode``), and includes the default "=" as padding.

Byte arrays encoded with the base64 algorithm will always be 33% larger than the original array.

To encode an array of bytes using dojox.encoding.base64:

.. code-block :: javascript
  :linenos:

  var str = dojox.encoding.base64.encode(myByteArray);

To decode a base64-encoded string:

.. code-block :: javascript
  :linenos:

  var bytes = dojox.encoding.base64.decode(str);

Note that this is a slightly inefficient implementation, based on the need to operate solely on byte arrays.
If you are operating on arrays of words (32-bit numbers as opposed to 8-bit), including any of the
`dojox.encoding.digests <dojox/encoding/digests>`_ will also make the method ``dojox.encoding.digests.wordToBase64``
available for use, which is a much more efficient implementation.
