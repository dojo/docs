#format dojo_rst

dojox.form.FileUploader
=========================

:Status: Contributed, Far from finished
:Version: 0.1

Basic Description
-----------------

Handles file uploading to a server. It does **NOT** create a button - it transforms an existing button into an uploader. This can be used for toolbar buttons for example. Because of this, it only works programmatically, it does not work in markup. Use the other other DojoX FileInput files for markup solutions. 

FileUploader is a wrapper class. If the correct version of Flash Player is available, dojox.form.FileInputFlash is used. If the **degradable** property is true, and Flash Player is not installed or is outdated, dojox.form.FileInputOverlay is used. Either of those two sub-classes could be directly, but it's easiest and best to use dojox.form.FileUploader.

Basic Examples
--------------

.. cv-compound::
 
  The JavaScript:

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dojox.form.FileUploader");
    dojo.require("dijit.form.Button"); 
    dojo.addOnLoad(function(){
        var fileUploader = new dojox.form.FileUploader({
        button:dijit.byId("btn0"), 
        degradable:true,
        uploadUrl:"../resources/UploadFile.php", 
        uploadOnChange:false, 
        selectMultipleFiles:true,
        fileMask:["All Images", "*.jpg;*.jpeg;*.gif;*.png"],
        isDebug:false
    });
    });

    dojo.connect(fileUploader, "onChange", function(data){
        dojo.forEach(data, function(d){
            dojo.byId("fileToUpload").value += d.name+" "+Math.ceil(d.size*.001)+"kb \n";
        });
    });

    dojo.connect(fileUploader, "onProgress", function(data){
        dojo.byId("fileToUpload").value = "";
        dojo.forEach(data, function(d){
            dojo.byId("fileToUpload").value += "("+d.percent+"%) "+d.name+" \n";
            
        });
    });

    dojo.connect(f0, "onComplete", function(data){
        dojo.forEach(data, function(d){
            dojo.byId("uploadedFiles").value += d.file+" \n";
        });
    });
    </script>

  The HTML:

  .. cv:: html
    
    <div id="btn0" class="browse" dojoType="dijit.form.Button">Select Images...</div>
    Files to upload:
    <textarea cols="50" rows="6" id="fileToUpload"></textarea>
    Uploaded Files:
    <textarea cols="50" rows="4" id="uploadedFiles"></textarea>

That's it.
