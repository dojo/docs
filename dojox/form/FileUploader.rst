#format dojo_rst

dojox.form.FileUploader
=========================

:Status: Contributed, Draft
:Version: 1.0

Basic Description
-----------------

Handles file uploading to a server. It does ***NOT*** create a button - it transforms an existing button into an uploader. This can be used for toolbar buttons for example. Because of this, it only works programmatically, it does not work in markup. Use the other other DojoX FileInput files for markup solutions. 

FileUploader is a wrapper class. If the correct version of Flash Player is available, dojox.form.FileInputFlash is used. If the **degradable** property is true, and Flash Player is not installed or is outdated, dojox.form.FileInputOverlay is used. Either of those two sub-classes could be directly, but it's easiest and best to use dojox.form.FileUploader.

Basic Examples
--------------

.. cv-compound::
 
  As a simple example, we'll use `dojo.query <dojo/query>`_ to find and create the ContentPanes used in the TabContainer

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    dojo.addOnLoad(function(){
        dojo.query(".tc1cp").forEach(function(n){
            new dijit.layout.ContentPane({
                // just pass a title: attribute, this, we're stealing from the node
                title: dojo.attr(n,"title") 
            }, n);
        });
        var tc = new dijit.layout.TabContainer({
            style: dojo.attr("tc1-prog", "style") 
        },"tc1-prog");
        tc.startup(); 
    });
    </script>

That's it.
