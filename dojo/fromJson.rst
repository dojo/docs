.. _dojo/fromJson:

=============
dojo.fromJson
=============

*Deprecated*.   Use :ref:`dojo/json::parse() <dojo/json#parse>` instead.

Old syntax:

.. js ::

     dojo.fromJson("{x: 5, y: 3}")

New syntax:

.. js ::

     require(["dojo/json"], function(json){
         json.parse("{x: 5, y: 3}")
     });

