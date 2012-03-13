.. _dojo/getLocalization:

========================
dojo.getLocalization
========================

*Deprecated*.    Use :ref:`dojo/i18n! plugin <dojo/i18n>` plugin instead.

Old syntax:

.. js ::

    dojo.require("dojo.i18n");
    dojo.requireLocalization("dijit.form", "validate");
    var validate = dojo.i18n.getLocalization("dijit.form", "validate");
    console.log(validate.invalidMessage);

New syntax:

.. js ::

    require(["dojo/i18n!dijit/form/nls/validate"], function(i18n){
        console.log(i18n.invalidMessage);
    });
