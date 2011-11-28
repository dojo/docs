.. _dojox/widget/DialogSimple:

=========================
dojox.widget.DialogSimple
=========================

:since: 1.6.0
:author: dante

This is an incredibly simple widget providing a stock :ref:`dijit.Dialog <dijit/Dialog>` with features from :ref:`dojox.layout.ContentPane <dojox/layout/ContentPane>` mixed in, such as executeScripts.

This dialog will look identical to a plain dijit.Dialog, though will optionally execute script contents and so on. No additional functionality beyond mixing the two widgets is provided. This simple dialog extension acts as the base class for the advanced :ref:`dojox.widget.Dialog <dojox/widget/Dialog>`

Usage
=====

No additional CSS is required. Remember to load the stock themeName.css file. Issue a single require statement to load the module and use it:

.. js ::

  dojo.require("dojox.widget.DialogSimple");
  dojo.ready(function(){
       var dlg = new dojox.widget.DialogSimple({ title:"Bar", executeScripts:true, href:"somefilewithscripts.html" });
       dlg.startup();
       setTimeout(function(){
           dlg.show();
       }, 2000);
  });

See Also
========

* :ref:`dijit.Dialog <dijit/Dialog>`
* :ref:`dojox.layout.ContentPane <dojox/layout/ContentPane>`
* :ref:`dojox.widget.Dialog <dojox/widget/Dialog>`
