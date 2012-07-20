.. _dojo/_base/json:

===============
dojo/_base/json
===============

.. contents ::
  :depth: 2

**dojo._base.json** is *deprecated* and included in Dojo Base for backwards compatability reasons.  The 
:ref:`dojo/json <dojo/json>` module should be used instead.

Usage
=====

As with the rest of ``dojo/_base`` modules, if you are running the Dojo loader in legacy mode (``async: false``) this 
module is automatically loaded.  Even if it is automatically loaded, you should require it in to have access to its 
features:

.. js ::

  require(["dojo/_base/json"], function(json){
    // json contains the features of the module
  });

Features
========

======================= =================================================== ===========================================
dojo/_base/json Feature dojo/json Feature                                   Description
======================= =================================================== ===========================================
``fromJson()``          :ref:`dojo/json::parse() <dojo/json#parse>`         Convert a JSON string to a JavaScript 
                                                                            object.
``toJson()``            :ref:`dojo/json::stringify() <dojo/json#stringify>` Convert a JavaScript object to a JSON 
                                                                            string.
======================= =================================================== ===========================================

See Also
========

* :ref:`dojo/json <dojo/json>` - Utilities for handling JSON
