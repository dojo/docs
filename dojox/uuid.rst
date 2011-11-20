.. _dojox/uuid:

dojox.uuid
==========

:Status: Draft
:Version: beta
:Authors: Brian Douglas Skinner

DojoX UUID is the port of the original Dojo 0.4.x UUID classes.  The UUID 
classes can be used to represent Universally Unique IDentifiers (UUIDs), as
described in the IETF's RFC 4122: 

http://tools.ietf.org/html/rfc4122

The DojoX UUID classes provide support for generating both "time-based" UUIDs
and lightweight "random" UUIDs.  DojoX UUID does not yet have support for 
generating new "name-based" UUIDs, but the dojo.uuid.Uuid class can represent
existing name-based UUIDs, such as UUIDs read from a file or from a server. 
