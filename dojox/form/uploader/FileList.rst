.. _dojox/form/uploader/FileList:

============================
dojox.form.uploader.FileList
============================

:Project owner: Mike Wilcox
:Author: Mike Wilcox
:since: 1.6

.. contents ::
  :depth: 3

FileList automatically connects to an Uploader and detects when files are added, removed, or uploaded. The fields are added or removed from the list, and a progress bar shows during the upload. It is a simple widget that provides a list of the files currently selected by dojox.form.Uploader. It is a very simple widget, and not beautifully styled. It is mainly for test cases, but could very easily be used, extended, modified, or copied.

There is a required CSS file: *resources/UploaderFileList.css.*

Setup
=====

Markup
------

To use the FileList, simply require it and use the appropriate data-dojo-type in an element inside or outside of a form (it is not a form element so will not affect the form action). A key property to be used is *uploaderId* which is the ID of the Uploader that FileList will connect to.

.. js ::
  
 dojo.require("dojox.form.Uploader");
 dojo.require("dojox.form.uploader.FileList");
 
.. html ::
  
 <form method="post" action="UploadFile.php" id="myForm" enctype="multipart/form-data" >
    <fieldset>
        <legend>Form Post Test</legend>
        <input class="browseButton" name="uploadedfile" multiple="true" type="file" force="iframe" data-dojo-type="dojox.form.Uploader" label="Select Some Files" id="uploader">
        <input type="text" name="album" value="Summer Vacation" />
        <input type="text" name="year" value="2011" />
        <input type="button" id="remBtn" label="Clear" data-dojo-type="dijit.form.Button" />
        <input type="submit" label="Submit" data-dojo-type="dijit.form.Button" />
        <div id="files" data-dojo-type="dojox.form.uploader.FileList" uploaderId="uploader"></div>
    </fieldset>
 </form>
  
Programmatic
------------

Programmatic creation is also supported. Here the *uploader* property is used instead of *uploaderId*:

.. js ::
  
 dojo.require("dojox.form.Uploader");
 dojo.require("dojox.form.uploader.FileList");
 
 var myUploader = new dojox.form.Uploader({label:"Programmatic Uploader", multiple:true, uploadOnSelect:true, url:"UploadFile.php"});
 dojo.byId("myDiv").appendChild(myUploader.domNode);
 
 var list = new dojox.form.uploader.FileList({uploader:myUploader});
 dojo.byId("myDiv").appendChild(list.domNode);
 
