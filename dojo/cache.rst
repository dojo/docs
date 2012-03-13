.. _dojo/cache:

==========
dojo.cache
==========

*Deprecated.*   Use the :ref:`dojo/text! <dojo/text>` plugin instead.

Old syntax:

.. js ::
 
    var text = dojo.cache("my.module", "template.html");
    ...

New syntax:

.. js ::

    require("dojo/text!my/module/template.html", function(text){
        ...
    });

