.. _dojox/form/Uploader:

=======================
dojox.form.Uploader
=======================

:Project owner: Mike Wilcox
:Author: Mike Wilcox
:since: 1.6

.. contents ::
  :depth: 3

A widget that adds functionality to a standard HTML file input which allows file uploading to a server. The widget hides the actual uploader and substitutes a dijit.form.Button, so that the file input matches the rest of the user interface. If the browser supports the HTML5 file input specification, that functionality is used. If it is not supported (IE or older browsers) plugins are available to enhance the Uploader.

**The dojox.form.Uploader is an improvement upon, and replaces the dojox.form.FileUploader**. The multiple problems created by Flash are avoided because it is not used in Mozilla and Webkit browsers. Support for FileUploader will cease as of 1.6, but the code will remain until 2.0 for backwards compatibility.

Features
========

 - The Uploader is a Dijit, and supports all the same functionality as any other form widget. FileUploader made this claim, but it still had trouble due to its late build process and dependency on the Flash plugin.
 - The Uploader may be placed in a form and will "just work". Actually, the Uploader will block the form's submit event and take over its duties of collecting the field values and uploading the data to the server using the form's action attribute, or the url property given to the Uploader.
 - The tabIndex attribute is supported.
 - An additional widget, dojox.form.uploader.FileList is provided to show the selection set and visualize the upload progress.
 - :ref:`dojox.form.uploader.FileList <dojox/form/uploader/FileList>`

Important AMD Note
------------------

When using the Uploader programmatically, you cannot use the reference argument from require() - you must use the global. This is because the plugins redefine the original Uploader class, and AMD does not allow time for this to happen. In other this will NOT work:

.. js ::
  
 require(['dojox/form/Uploader', 'dojox/form/uploader/plugins/Flash'], function(Uploader){
     myUploader = Uploader(...);
 });
 
Until 2.0, you must use:
 
.. js ::
  
 require(['dojox/form/Uploader', 'dojox/form/uploader/plugins/Flash'], function(Uploader){
     myUploader = new dojox.form.Uploader(...); // disregard reference argument
 });
 
Important Form Note
-------------------

Because the Uploader uses your existing form, you must set its *enctype* to "multipart/form-data" which is used for uploading files.

Missing Features
----------------

The Uploader mimics the functionality of HTML5 file inputs, so some features available in the FileUploader are not (yet) available in Uploader. Specifically missing is the ability to add remove files from a current selection set. There are plans to implement this functionality soon.

File mask (restricting the selection to certain file types) is in the HTML5 spec but missing from browser functionality. It is not supported.

Usage
=====

The Uploader can be used in several variations.

Uploader without Plugins
------------------------

The Uploader with no plugins is in "Form" mode. This mode will not do an Ajax upload. It is expected that you plan to handle the upload yourself, whether via Ajax or changing the entire page via a POST. Only form POSTs will work and they will navigate to the UploadFile.php page in the test files. Multiple file selection is used in browsers that support it, and in the others, multiple selections are added one at a time by adding file inputs.

Uploader with the HTML5 Plugin
------------------------------

The HTML5 Uploader plugin does not support IE, it is more of a base class for IFrame or Flash, or used in cases where IE is not a requirement. For HTML5-capable browsers, this plugin provides an Ajax upload.

Uploader with the IFrame Plugin
-------------------------------

The IFrame plugin will use the IFrame to upload in IE. All other browsers will use the HTML5 plugin unless *force="iframe"* is used.

Uploader with the Flash Plugin
------------------------------

The Flash plugin will use a SWF to upload in non-HTML5 browsers. All other browsers will use the HTML5 plugin, unless *force="flash"* is used, then Flash will be used in all browsers. *force="flash"* is provided because Flash has some features that HTML5 does not yet have. But it is still not recommended because of the many problems that Mozilla and Webkit have with the Flash plugin:

 - Changing the display style on the DOM element that holds a SWF will reset the SWF. This makes it difficult to support Flash in Dijit Tabs and Dialog boxes.
 - Initialization of a SWF is not always consistent and occasionally throws errors.
 - HTTPS support in Mozilla is problematic.
 
These problems do not occur in IE.

Setup
=====

Markup
------

To use the Uploader, simply require it and use the appropriate data-dojo-type in an input within a form:

.. js ::
  
 dojo.require("dojox.form.Uploader");
 
.. html ::
  
 <form method="post" action="UploadFile.php" id="myForm" enctype="multipart/form-data" >
    <input name="uploadedfile" multiple="true" type="file" data-dojo-type="dojox.form.Uploader" label="Select Some Files" id="uploader" />
    <input type="submit" label="Submit" data-dojo-type="dijit.form.Button" />
 </form>
 

Plugins will self initialize, so to use one, all that is needed is to require it. The following example uses the IFrame plugin, which inherits from the HTML5 plugin. So HTML5 file inputs are used when available and the IFrame technique used elsewhere (the HTML is exactly the same as the previous example):

.. js ::
  
 dojo.require("dojox.form.Uploader");
 dojo.require("dojox.form.uploader.plugins.IFrame");
 
.. html ::
  
 <form method="post" action="UploadFile.php" id="myForm" enctype="multipart/form-data" >
    <input name="uploadedfile" multiple="true" type="file" data-dojo-type="dojox.form.Uploader" label="Select Some Files" id="uploader" />
    <input type="submit" label="Submit" data-dojo-type="dijit.form.Button" />
 </form>
 
 
Programmatic
------------

Programmatic creation is also supported as shown in the following example that includes the Flash plugin:

.. js ::
  
 dojo.require("dojox.form.Uploader");
 dojo.require("dojox.form.uploader.plugins.Flash");
 
 var u = new dojox.form.Uploader({label:"Programmatic Uploader", multiple:true, uploadOnSelect:true, url:"UploadFile.php"});
 dojo.byId("myDiv").appendChild(u.domNode);


The "name" Property
-------------------

A key property to the Uploader is "name", which is subsequently used as the name attribute on the file input that is created, or as the field name that Flash assigns to each file. The default name is "uploadedfile" which works with the provided *UploadFile.php*. The HTML5 spec specifies that attributes that are array-like should use square brackets at the end of the field name. If a HTMl5-capable browser is used, the Uploader appends these brackets. It also appends an "s" at the end to help the server script determine the file data. If the Flash plugin is in use, the Uploader appends "Flash" to the end of the name, or whatever the "flashFieldName" property is set to. If a standard file input is in use (in "Form" mode or IFrame), the name is left as-is.

The variations of the *name* attribute is necessary so that the server page knows what is being sent and can handle it appropriately.

Other Properties
----------------

 - **flashFieldName** Is the text appended to the *name* property. This is necessary so the server can tell what type of file data it is dealing with.
 - **multiple** Whether multiple files can or cannot be selected.
 - **url** If you don't supply an *action* in your form, supply an *url* to upload to.
 - **label** The text used in the button.
 - **tabIndex** Defaults to "0". You change this to change the tab order on the page.
 
The Flash plugin has other properties specific to that file.

Methods
-------

Because the Uploader without plugins doesn't upload, there are only the following methods:

 - **reset** Clears the list of selected files.
 - **getFileList** Returns an array of objects representing the file data.

When using a plugin, the following methods will be available:

 - **upload** This method uploads the files and any data passed as an argument.
 - **submit** This method uploads the files and if a form element is passed as an argument, it is converted into a JavaScript object.

Server Side
===========

The file data is uploaded to a temp folder on the server. It's a misconception that your server side language has something to do with this. Receiving an uploaded file is handled by your server, meaning Apache or IIS. Typically the file is placed in a temp folder and it is your job to move it from there to the upload destination. Whether HTML or Flash, the payload is done with a multipart transfer. After the upload is complete, the server script is called.

During a Flash multi-file upload, the images are uploaded in parallel (unless deferredUploading=true), however, the server script only receives one file at a time. So if five files are uploaded, the server script will be called five times.

During an HTML multi-file upload, the files are all uploaded at once, and after all five are completely uploaded to the temp folder, the server script is called just once. For traditional HTML (Form mode or IFrame plugin) each file will be referenced as numerically sequenced fields: uploadedfile0, uploadedfile1, uploadedfile2, etc. For HTML5 uploads, the server script looks for "uploadedfiles" (with an "s"). the Uploader also added square brackets to the name ("uploadedfiles[]") to match the spec. The result is the files are given to the server script as an actual array.

With a multipart request the POST data is the contents for the first part and the uploaded files is an array (or an object) of each additional part. Refer to your particular server documentation for how to reference the files (PHP is used as an example in the next section).

The return data needs to be formatted very specifically, and there are different formats for Flash and HTML. See **Server Side Return Data** below.

Server Side Code PHP
--------------------

Uploader comes with a working PHP file, *dojox/form/tests/UploadFile.php*, to use as a reference for how your server side code should work. UploadFile.php has two dependencies, *dojo/tests/resources/JSON.php*, which is used for converting the return data to a JSON string, and *dojox/form/tests/cLog.php* which is used to log message to a text file, placed relative to the PHP file.

UploadFile.php is expecting one of four things:

1) A file or files from Flash (uploadedfilesFlash)
2) A file from HTML    (uploadedfiles0)
3) Multiple files from HTML (uploadedfiles0, uploadedfiles1, etc)
4) A file array from HTML5 (uploadedfiles[])

The PHP file is inspecting the header and looking for the parameters set in Uploader. Whatever you set these parameters to, they must match on the server.

The field name for the HTML uploader works much the same way. The only difference is if you do multi-file upload with HTML, this essentially continues to add fileInputs to the form, and in doing so, appends numbers to the fileInput field names, starting with '0'. That's why one file fieldname will look like "myFieldName" but two files will look like [ "myFieldName0", "myFieldName1" ] to the server side code.

Server Side Return Data
-----------------------

How the data is returned from the server is not difficult, but it is very important. If not done correctly, it can be the cause of reported errors that the "onComplete" is not firing in Uploader.

**NOTE** The Flash uploader and the HTML uploader need differently formatted return data. You will need to inspect the post data to determine which type to return.

If *uploadedfilesFlash* is found in the post data and Flash is being used on the client side, all that is needed for return data is a key-value string, and it can simply be returned, as at the end of a function. Flash will parse these key-value pairs into an object and pass it to javaScript. You may also want to insert *exit* or whatever necessary to cease execution of the remainder of the code. Example:

.. html ::
  
 $data .='file='.$file.',name='.$name.',width='.$width.',height='.$height.',type='.$type;
 echo($data);
 exit;
 
For non-PHP developers this translates to:

.. code-block :: text
  
 $name = name of the file, such as "PIC01.jpg"
 $file = name of the file and the path, such as "uploaded/PIC01.jpg"
 $width, $height = the dimensions (if you are working with images)
 $type = the extension of the file - JPG, GIF, PNG, etc.


The return to Flash should look like:

.. code-block :: text
 
 "file=uploaded/PIC01.jpg,name=PIC01.jpg,width=320,height=240,type=jpg"
 

This string should be returned, or printed, or echoed.

You can add an error key if one file was in error; say if it was not of the correct type. This error code or message will be returned in the onComplete dataArray. It's important to note that as far as the Uploader is concerned, everything was a success. It's up to your custom code to test for this error.

The return string with an error might look like:

.. code-block :: text
 
 "file=uploaded/PIC01.jpg,name=PIC01.jpg,width=320,height=240,type=jpg,error=Not recognized file type"

You can also send back arbitrary parameters from your server-side script using this comma-delimited format.  For example, adding variables foo and abc:

.. code-block :: text
 
 "file=uploaded/PIC01.jpg,name=PIC01.jpg,width=320,height=240,type=jpg,foo=bar,abc=123"

Then you can access these variables in the client-side functions using dataArray[i].additionalParams.foo and dataArray[i].additionalParams.abc.

If IFrame plugin is used, the code on the client side gets tricky, as reading back from an iframe presents problems. In order to read the iframe return data accurately cross browser, the code needs to be wrapped in a *<textarea>*. You can see the code for this on the very last line of UploadFiles.php. Note that the textarea needs to be outside of the PHP. Example:

.. html ::
  
 <?php
     ....code....
 ?>
 <textarea><?php print $json->encode($dataObject); ?></textarea>
 
For non-PHP devs, this translates into a JSON string, wrapped in a textarea, returned as HTML. I know it's screwy, but that's how it works.

If you are having problems getting *onComplete* to fire, look at this code first. Often the problem is the server side code is not catching the field name for whatever reason (perhaps the client and server names don't match) and the code is falling to the end of the page and returning a textarea when it shouldn't.

Examples
========

This example shows how to use Flash and IFrame plugins for both cases (browsers with and without flash).

.. js ::
 
   dojo.require("dojox.form.Uploader");
   dojo.require("dojox.embed.Flash");
   if(dojox.embed.Flash.available){
     dojo.require("dojox.form.uploader.plugins.Flash");
   }else{
     dojo.require("dojox.form.uploader.plugins.IFrame");
   }
   dojo.ready(function(){
     var u = new dojox.form.Uploader({
       label: "Select files",
       multiple: true,
       uploadOnSelect: true,
       url: "UploadFile.php",
     }, "uploader");
   });

.. html ::

 <div id="uploader"></div>
