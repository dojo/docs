.. _dojo/deprecated:

===============
dojo.deprecated
===============

:since: V?

.. contents ::
   :depth: 2

This function simply throws a warning message, alerting developers a method or package has been removed, replace, or otherwise has has been changed, and they are using a "older" version of the method.

.. js ::

  // Dojo 1.7 (AMD)
  require(["dojo/_base/kernel"], function(dojo){
    dojo.deprecated("dijit.layout.SplitContainer", "User dijit.layout.BorderContainer instead", "2.0");
  });
  // Dojo < 1.7
  dojo.deprecated("dijit.layout.SplitContainer", "User dijit.layout.BorderContainer instead", "2.0");

This means the "SplitContainer" widget still works, but has been replaced by the :ref:`BorderContainer <dijit/layout/BorderContainer>` widget, and will be removed in Dojo 2.0
