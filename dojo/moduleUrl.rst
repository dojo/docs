.. _dojo/moduleUrl:

==============
dojo.moduleUrl
==============

*Deprecated*.   Use require.toUrl() instead.

Old code:

.. js ::

       dojo.moduleUrl("dijit", "foo.template.html")

New code:

.. js ::

       require.toUrl("dijit/foo/template.html")
