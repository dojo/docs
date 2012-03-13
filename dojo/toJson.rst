.. _dojo/toJson:

===========
dojo.toJson
===========

*Deprecated*.   Use :ref:`dojo/json::stringify() <dojo/json#stringify>` instead.

Old syntax:

.. js ::

     dojo.toJson({x: 5, y: 3})

New syntax:

.. js ::

     require(["dojo/json"], function(json){
         json.stringify({x: 5, y: 3})
     });

