#format dojo_rst

dojox.form.FileUploader
=========================

:Status: Contributed, Complete
:Version: 1.0

Basic Description
-----------------

Handles file uploading to a server. It does **NOT** create a button - it transforms an existing button into an uploader. This can be used for toolbar buttons for example. Because of this, it only works programmatically, it does not work in markup. Use the other other DojoX FileInput files for markup solutions. 

FileUploader is a wrapper class. If the correct version of Flash Player is available, dojox.form.FileInputFlash is used. If the **degradable** property is true, and Flash Player is not installed or is outdated, dojox.form.FileInputOverlay is used. Either of those two sub-classes could be directly, but it's easiest and best to use dojox.form.FileUploader.

Example
-------

.. cv-compound::
 
  The JavaScript:

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dojox.form.FileUploader");
    dojo.require("dijit.form.Button"); 
    var fileUploader;
    dojo.addOnLoad(function(){
        fileUploader = new dojox.form.FileUploader({
        button:dijit.byId("btn0"), 
        degradable:true,
        uploadUrl:"http://docs.dojocampus.org/moin_static163/js/dojo/trunk/demos/uploader/UploadFile.php", 
        uploadOnChange:false, 
        selectMultipleFiles:true,
        fileMask:["All Images", "*.jpg;*.jpeg;*.gif;*.png"],
        isDebug:false
    });
    

    dojo.connect(fileUploader, "onChange", function(data){
    console.log("change", data)
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

    dojo.connect(fileUploader, "onComplete", function(data){
        dojo.forEach(data, function(d){
            dojo.byId("uploadedFiles").value += d.file+" \n";
        });
    });
    });
    </script>

  The HTML:

  .. cv:: html
    
    <div id="btn0" class="browse" dojoType="dijit.form.Button">Select Images...</div><br/>
    Files to upload:<br/>
    <textarea cols="50" rows="2" id="fileToUpload"></textarea><br/>
    <div id="uploadBtn" class="uploadBtn" onClick="fileUploader.upload();" dojoType="dijit.form.Button">Upload</div><br/>
    Uploaded Files:<br/>
    <textarea cols="50" rows="2" id="uploadedFiles"></textarea><br/>

Use *dojo.connect* to connect to the *onChange*, *onProgress* and *onComplete* methods. Use *upload* to initiate the upload after files have been selected. Or set *uploadOnChange* to true to initiate upload after the selection.
