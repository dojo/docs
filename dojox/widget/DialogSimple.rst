#format dojo_rst

dojox.widget.DialogSimple
=========================

:since: 1.6.0
:author: dante

This is an incredibly simple widget providing a stock `dijit.Dialog <dijit/Dialog>`_ with features from `dojox.layout.ContentPane <dojox/layout/ContentPane>`_ mixed in, such as executeScripts.

This dialog will look identical to a plain dijit.Dialog, though will optionally execute script contents and so on. No additional functionality beyond mixing the two widgets is provide. This simple dialog extension acts as the base class for the advanced `dojox.widget.Dialog <dojox/widget/Dialog>`_ 

Usage:
======

No additional CSS is required. Remember to load the stock themeName.css file. Issue a single require statement to load the module and use it:

.. code-block:: javascript

  dojo.require("dojox.widget.DialogSimple");
  dojo.ready(function(){
       var dlg = new dojox.widget.DialogSimple({ title:"Bar", executeScripts:true, href:"somefilewithscripts.html" });
       dlg.startup(); 
       setTimeout(function(){
           dlg.show();
       }, 2000);
  });

See Also:
=========

* `dijit.Dialog <dijit/Dialog>`_
* `dojox.layout.Contentpane <dojox/layout/ContentPane>`_
* `dojox.widget.Dialog <dojox/widget/Dialog>`_
