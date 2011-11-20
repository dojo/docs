.. _dojox/form/MultiComboBox:

dojox.form.MultiComboBox
========================

:Status: Draft
:Available: since 1.2

.. contents::
   :depth: 2

============
Introduction
============

This widget is an experimental extension to :ref:`ComboBox <dijit/form/ComboBox>` to allow "tag" style input using a datastore using a delimeter. 

=====
Usage
=====

The MultiComboBox behaves the same as a plain ComboBox. Pass it a store and searchAttr:

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
    var memberTagStore = new dojo.data.ItemFileReadStore({ url:"countries.json" });
    var widget = new dojox.form.MultiComboBox({
	store:memberTagStore,
	searchAttr:"tag"
    },"frogin3");
    widget.startup();
 </script>			
		
No additional CSS is required.

A `delimiter` variable can be set to indicate which key triggers a new value. It defaults to "," (comma) but can be any character.


========
See also
========

  * :ref:`dojox.form <dojox/form>`
  * :ref:`dijit.form <dijit/form>`
