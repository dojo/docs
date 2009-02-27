#format dojo_rst

dojox.encoding.crypto.SimpleAES
===============================

:Status: Draft
:Version: Dojo 1.3+
:Author: Tom Trenka, Brad Neuberg

Unlike other crypto implementations within DojoX Encoding, the SimpleAES implementation is hard-coded using
a modified version of CBC (Cipher Block Chaining) mode, along with a non-standard formatting.  The reasons
for this are because of eventual plans to use this implementation (modified from the implementation by
Brad Neuberg for `dojox.off <dojox/off>`_ (within the "private" `dojox.sql <dojox/sql>`_ project) to refactor
and replace dojox.sql.

This implementation differs from the dojox.sql in the following ways:

1. The dojox.encoding.crypto version uses Hex encoding (2 numbers for every byte in the cipher text); the
   dojox.sql version uses straight String encoding, which can be problematic for a number of reasons.
2. The dojox.encoding.crypto version uses a space (" ") to delimit each ciphertext block/word.  The dojox.sql
   version uses a dash ("-").

Both versions preserve the way the original implementation (from Chris Veness, `http://www.movable-type.co.uk/scripts/aes.html`_)
uses a nonce as a hard-coded initialization vector. This nonce is included as the first block of the resulting
ciphertext--which is why this implementation is not as useful as one might think, especially if the purpose of
using SimpleAES is for cross-platform encrypted communication.  Because of this reason, SimpleAES is generally
**only useful for purposes where the application/web page is the only consumer of the algorithm** (i.e. encrypting
and decrypting with this implementation only).
