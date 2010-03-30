#format dojo_rst

dojox.form.FileUploader
=======================

:Project owner: Mike Wilcox
:Author: Mike Wilcox
:Available: since 1.1

.. contents::
  :depth: 3

Handles multiple file uploading to a server. 

=====
Usage
=====

CDN Note
--------

FileUploader does work with the Google and AOL CDNs, but because of cross domain issues, you need to run the SWF locally, and point to its location with djConfig.uploaderPath. 

Dojo Version 1.2.x
------------------

The FileUploader version 1.1 and 1.2 is no longer supported. FileUploader 1.2 programmatically called the Flash browse() method which Adobe soon after removed for security reasons.

Dojo Version 1.3
----------------

This version is supported but has limitations. It floats the SWF over the styled button, so the CSS is tricky and not always 100% accurate. And this will not work in many cases where the button is in scrolling content, specifically Windows and Linux Firefox.

Dojo Version 1.3.2
------------------

This version is a major upgrade from 1.3, makes CSS placement easier and fixes the scrolling bug. However there is an IE8 bug that was not caught at the time of release. This bug can be patched using the instructions found in the Trac ticket:

http://bugs.dojotoolkit.org/ticket/9615

Another bug found is uploading multiple files more than once causes onComplete to fire on every file. It should only fire after all files have uploaded. The fix for this is to use the SWF from the trunk (1.4) in the 1.3.2 release. 

http://bugs.dojotoolkit.org/ticket/9646

Dojo Version 1.4.0
------------------

This version has some serious upgrades, including a more robust upload system that has been tested to upload 500 files and 500 megs. This version also fixes several bugs including the ability to display the uploader in a Dialog.

Dojo Version 1.5.0
------------------

This version adds the ability to use the uploader in a TabContainer. However, see the next section.
 
===============
IMPORTANT NOTES
===============

There is a serious limitation in the Flash version for Firefox and Safari in TabContainers. When a node in those browsers is hidden (or essentially repainted which can mean other style applications) the SWF is reloaded. This means that if you browse for a file but don't upload upload it, change the tab and return, the files will no longer be in the FileUploader. This problem can be seen when tabbing between Tab 1 and Tab 2 and observing the console logs and you will see the SWF reinitializes. This problem does not exist in Internet Explorer. The HTML version of the Uploader should also work fine.

See form/tests/test_FileUploaderTabs.html for the workaround. It floats a div above the tab container and moves it on and off screen as the tab is toggled. 

While the FileUploader instantiates like a widget, it has limitations due to the fact that it has to manage a Flash plugin. Before it is built, it inspects the DOM and checks style information. Due to this process there needs to be a node to inspect, so dojo 1.4 functionality like:

*var f = new dojox.form.FileUploader(props).placeAt(anything);*

...will not work. There may also be problems with placing it in other widgets unless it displays right away, although as of 1.5 these problems have mostly been worked out.  

If you need to manually manage when an initially hidden flash-based file uploader is shown and have it created properly see this ticket: http://bugs.dojotoolkit.org/ticket/10920

Another limitation with using Flash is passing data back and forth. There is a problem with passing variable names with illegal characters, like:

*{form["my-var"]: "foo")*

Currently the only workaround is to *don't do that*.

=====================
Updating Your Release
=====================

I often suggest to people who are not able to use the 1.3.2 or trunk version of Dojo to copy over the latest uploader files. The involved files would be:

 - dojox/form/FileUploader.js
 - dojox/form/resources/uploader.swf
 - dojox/form/resources/FileUploader.css
 - dojox/embed/flashVars.js
 - dojox/embed/Flash.js

and optionally:

 - dojox/form/resources/UploadFile.php
 - dojox/form/resources/cLOG.php

Note that if you are moving these files into Dojo 1.2 or less, you will have to change some of the code in the FileUploader to not use the 1.3 html method dojo.destroy() and replace it with the previous version of dojo._destroyElement()

======================================
FileUploader Functionality 1.3.2 - 1.5
======================================

FileUploader is now a widget and **DOES** create a button. You do not have to pass a button in. Passing a button is still supported until version 1.5 to maintain backwards compatibility, but it is not recommended. In a majority of cases, you can create your uploader like any other widget. 

Setup
-----

The button styles are now recreated in Flash, so there is no longer an invisible Flash movie with *wmode=transparent*. This way the Flash button is actually placed inline with the DOM, not floating above it and constantly resetting its position. The "Windows Firefox clickable bug" should be fixed (and hopefully some Linux problems).

The HTML button is created in a new way and it is now inline as is the Flash button. Styling is much easier and more versatile.

The process is to create a typical HTML button, with either a button, input, div, or span tag. Button tags work the best. Style the button how you would like it to look in CSS. Then create another class that will append to the class chain to style the button in its hover state. Follow the same procedure for active state (press) and disabled state. Assign the normal class to your button and make the widget either programmtically or with markup.

A basic example follows:

.. code-block :: css
 :linenos:

 .uploadBtn{
     border:1px solid #333333;
     background:url(buttonEnabled.png) #d0d0d0 repeat-x scroll 0px top;
     font-size:14px;
     width:201px;
     height:30px;
     vertical-align:middle; /* emulates a <button> if node is not */
     text-align:center;
 }
 .uploadHover{
     background-image:url(buttonHover.png);
     cursor:pointer;
     font-weight:bold;
 }
 
 .uploadPress{
     background-image:url(buttonActive.png);
 }
 .uploadDisabled{
     background-image:none;
     background-color:#666;
     color:#999;
     border:1px solid #999;
 }
 

.. code-block :: html
 :linenos:

 <div id="btn" class="uploadBtn">Select Files</div>
  
.. code-block :: javascript
 :linenos:
 
 var uploader = new dojox.form.FileUploader({
     hoverClass:"uploadHover",
     activeClass:"uploadBtn",
     pressClass:"uploadPress",
     disabledClass:"uploadDisable",
     uploadUrl:pathToUploadServerScript
 }, "btn");
 
Or, using the same CSS, create it as markup:


.. code-block :: html
 :linenos:

 <div class="uploadBtn" dojoType="dojox.form.FileUploader" hoverClass="uploadHover" pressClas="uploadPress"
      activeClass="uploadBtn" disabledClass="uploadDisable" uploadUrl="../serverpage.php">Select Files</div>


Dependencies
------------

FileUploader no longer uses FileInput.css. It now uses FileUploader.css. See requires for JavaScript dependencies.

New Features
------------

* Disabled: Can be toggled with widget.attr("disable", true|false)
* Submit: A convenience method has been added for if the uploader is in a form. Instead of submitting the form, call uploader.submit(theForm), and the Uploader will handle all of the form values and post the data.
* Selected List: If passing the ID of a container, the Uploaders will populate it with the selected files.
* Deleting Files: You can now delete pending files.
* Progress Built in: showProgress:true will change the button to a progress bar on upload.
* Progress Attach: Passing progressWidgetId will tell the Uploader of a progress widget. If the Progress widget is initially hidden, it will change to visible and then restored after upload.
* A11Y: The Flash button can be accessed with the TAB key. (The HTML cannot due to browser limtations)
* Deferred Uploading: (Flash only) throttles the upload to one file at a time

Changed in 1.4: deferredUploading is now mandatory to prevent errors in Firefox and Safari. It accepts a number and the idea is you can upload more than one file in parallel, though my tests have shown it always does one at a time anyway. This change makes the upload a little slower, but now it is much more robust and can handle uploads of 500 files or more without crashing the browser.
 
There are two new tests added to DojoX: *test_FileUpladerCSS.html* and *test_FileUpladerForm.html*. The form test will show how to implement most of the new features. The CSS test will show different methods of styling the Uploader. 

http://mwilcox.dojotoolkit.org/dtk/dojox/form/tests/test_FileUploaderForm.html

http://mwilcox.dojotoolkit.org/dtk/dojox/form/tests/test_FileUploaderCSS.html

Continue with the 1.3 instructions for other information that still applies to implementing the FileUploader.

Version 1.3
-----------

Version 1.3 does **NOT** create a button - it transforms an existing button into an uploader. This can be used for toolbar buttons for example. Because of this, it only works programmatically, it does not work in markup. Use the other other DojoX FileInput files for markup solutions. 

FileUploader will detect if the correct version of Flash Player is available, and if so, a transparent SWF is laid over the top of the original (referred to as the 'fake') button. If not available, a traditional fileInput button with opacity set to zero is laid over the fake button.

A basic example follows:

.. code-block :: javascript
 :linenos:
 
 var uploader = new dojox.form.FileUploader({
     button:dijit.byId("myFakeButton"), 
     uploadUrl:uploadUrl, 
 });

The example has doesn't show *selectMultipleFiles*, but it defaults to true. Setting it to false restricts the user to one file selection. Multiple files are also supported in the HTML version, although only one file can be selected at a time. But after the files are selected, they will all be uploaded at once.
 
The *uploadUrl* property is the location of the server side script. Note that this URL needs to be relative to the SWF, not to the HTML page, nor to dojo.js. It's recommended that an absolute URL is used if possible. FlashUpload will try to "normalize" relative URLs and point them to the SWF. 

Use *dojo.connect* to connect to the *onChange*, *onProgress* and *onComplete* methods:

.. code-block :: javascript
 :linenos:
 
 dojo.connect(uploader, "onChange", function(dataArray){
     dojo.forEach(dataArray, function(data){
         dojo.byId("myTextarea").value += data.name+" "+Math.ceil(data.size*.001)+"kb \n";
     });
 });
 dojo.connect(uploader, "onProgress", function(dataArray){
     dojo.forEach(dataArray, function(data){
         dojo.byId("myTextarea").value += "onProgress: ("+data.percent+"%) "+data.name+" \n";	
     });
 });
 dojo.connect(uploader, "onComplete", function(dataArray){
     dojo.forEach(dataArray, function(d){
         dojo.byId("myTextarea").value += "onComplete: "+d.file+" \n";
     });
 });

Use *upload* to initiate the upload after files have been selected. Or set *uploadOnChange* to true to initiate upload automatically after the selection.

Note that the "dataArray" param above is always an array, even if selectMultipleFiles is set to false.  

Updated: Be careful not to construct the connect so that it sends a mouse event to the upload method (as this example used to do). The upload method expects no arguments or one argument to use as postData. The mouse event will be treated as postData and throw an error. This is fixed in the trunk but exists in 1.32.

.. code-block :: javascript
 :linenos:
 
 dojo.connect(dijit.byId("myUploadButton"), "onClick", function(){
     uploader.upload();
 });


Advanced Parameters
-------------------

The FileUploader has many advanced properties to handle most situations.

**fileMask**: An array, or an array of arrays. Restrict file selection to certain file types Empty array defaults to "All Files". NOTE: MacType is not supported, as it does not work very well. fileMask will work on a Mac, but differently than Windows.

.. code-block :: javascript
 :linenos:
 
 var fileMask = ["Images", "*.jpg;*.jpeg;*.gif;*.png"]
 //	or
 var fileMask = [
     ["Jpeg File", 	"*.jpg;*.jpeg"],
     ["GIF File", 	"*.gif"],
     ["PNG File", 	"*.png"],
     ["All Images", 	"*.jpg;*.jpeg;*.gif;*.png"],
 ];
 var uploader = new dojox.form.FileUploader({
     button:dijit.byId("myFakeButton"), 
     uploadUrl:uploadUrl,
     fileMask:fileMask
 });


**force**: You can use either HTML (force="html") or Flash only, with this parameter. If force="flash" and the user does not have Flash installed, they will be prompted to install the plugin. "flash" forces Flash Uploader. Defaults to an empty string (force="") which checks for the availability of the proper Flash player (Flash 9 or higher).

**postData**: The data that will be sent via POST to the server along with the uploaded files. This data object can bet set on instantiation, and the data will be sent to the server with each file on every upload. You can also pass postData in the upload method as an object argument which can be different with each upload.

Note: as of 1.4.0 there is a bug: http://bugs.dojotoolkit.org/ticket/10559 where postData is not being sent for flash based uploaders where uploadOnChange is also true. This is fixed in 1.5.

**Returned postData**: Post data is regurgitated to the uploader in the tests. Your case may be different. The SWF returns postdata in an *additionalParams* object, and it is in this object in which the postdata can be found in the onComplete object. The reason for this was originally to get around AS3 issues, but it turns out to be a good system, as it prevents post data variables from overwriting standard variables such as 'name' or 'file'.

**htmlFieldName**: The name of the field of the fileInput that the server is expecting. See "Server Side Code" below.

**flashFieldName**: The name of the field of the flash uploaded files that the server is expecting. See "Server Side Code" below.

Dependencies
------------

dojox.html.styles to create dynamic CSS for an IE workaround.
dojo.io.iframe for the HTML POST upload.
dojox.embed.Flash for embedding the SWF in the page.
dojox/form/resources/FileInput.css for some fileInput styling.

Debugging
---------

Because of the complex nature of the FileUploader code (or more accurately, the hack!). It's often necessary to do some debugging to test if something is working properly. The following parameters assist with this:

**isDebug**: Unlike most Dojo code, the logging has been left in the FileUploader, but is disabled by default. isDebug=true will turn on the log messages for inspection. This also passes to the SWF which will output messages of what's happening in there.

**devMode**: Changing this parameter to true will set the opacity of the HTML upload button to 100% and remove transparency from the Flash upload button. This helps to determine of the button is being positioned correctly.

===========
Server Side
===========

The transfer of data happens through Flash and so the you will not be able to inspect the data in Firebug. It's recommended to use Charles or Fiddler if you wish to inspect the transfer.

http://www.charlesproxy.com/

http://www.fiddler2.com/fiddler2/

The following transfer example is taken from:

http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/net/FileReference.html

It includes examples two post parameters, api_sig and api_key. The name for the field where the file can be found is set to "photo" (Adobe default is "FileData" and FileUploader changes this default to "flashUploadFiles").

.. code-block :: text
 :linenos:

 POST /handler.cfm HTTP/1.1 
   Accept: text/*
   Content-Type: multipart/form-data; 
   boundary=----------Ij5ae0ae0KM7GI3KM7ei4cH2ei4gL6 
   User-Agent: Shockwave Flash 
   Host: www.example.com 
   Content-Length: 421 
   Connection: Keep-Alive 
   Cache-Control: no-cache
  
   ------------Ij5GI3GI3ei4GI3ei4KM7GI3KM7KM7
   Content-Disposition: form-data; name="Filename"
  
   MyFile.jpg
   ------------Ij5GI3GI3ei4GI3ei4KM7GI3KM7KM7
   Content-Disposition: form-data; name="api_sig"
  
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   ------------Ij5GI3GI3ei4GI3ei4KM7GI3KM7KM7
   Content-Disposition: form-data; name="api_key"
  
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   ------------Ij5GI3GI3ei4GI3ei4KM7GI3KM7KM7
   Content-Disposition: form-data; name="auth_token"
  
   XXXXXXXXXXXXXXXXXXXXXX
   ------------Ij5GI3GI3ei4GI3ei4KM7GI3KM7KM7
   Content-Disposition: form-data; name="photo"; filename="MyFile.jpg"
   Content-Type: application/octet-stream
  
   FileDataHere
   ------------Ij5GI3GI3ei4GI3ei4KM7GI3KM7KM7
   Content-Disposition: form-data; name="Upload"
   
   Submit Query
   ------------Ij5GI3GI3ei4GI3ei4KM7GI3KM7KM7--

Whether HTML or Flash, the payload is done with a multipart transfer. The file data is uploaded to a temp folder on the server. After the upload is complete, the server script is called. It is the job of the server script to know where this temp folder is and access the file (to move it to the destination, and or perform tasks upon it).

During a Flash multi-file upload, the images are uploaded in parallel (unless FileUploader.deferredUploading=true), however, the server script only receives one file at a time. So if five files are uploaded, the server script will be called five times.

During an HTML multi-file upload, the files are all uploaded at once, and after all five are completely uploaded to the temp folder, the server script is called just once. Each file will be referenced as numerically sequenced fields: uploadedfile0, uploadedfile1, uploadedfile2, etc. Single file uploads will of course call the server script once.

With a multipart request the POST data is the contents for the first part and the uploaded files is an array (or an object) of each additional part. Refer to your particular server documentation for how to reference the files (PHP is used as an example in the next section).

The return data needs to be formatted very specifically, ad there are different formats for Flash and HTML. See **Server Side Return Data** below. 

Server Side Code PHP
--------------------

FlashUploader comes with a working PHP file, *dojox/form/resources/UploadFile.php*, to use as a reference for how your server side code should work. UploadFile.php has two dependencies, *dojo/tests/resources/JSON.php*, which is used for converting the return data to a JSO string, and *dojox/form/resources/cLog.php* which is used to log message to a text file, placed relative to the PHP file.

UploadFile.php is expecting one of three things: 

1) A file or files from Flash
2) A file from HTML
3) Multiple files from HTML

The PHP file is inspecting the header and looking for the parameters set in FileUploader: *htmlFieldName* or *flashFieldName*. Whatever you set these parameters to, they must match on the server. The current code uses "flashUploadFiles" as the default Flash field name. (The default field name in Flash is "Filedata", which is over written to show that you can do custom field names). Therefore the server must be made aware of this parameter, as it is set on line 69: *$fieldName = "flashUploadFiles";*

The field name for the HTML uploader works much the same way. The only difference is if you do multi-file upload with HTML, this essentially continues to add fileInputs to the form, and in doing so, appends numbers to the fileInput field names, starting with '0'. That's why one file fieldname will look like "myFieldName" but two files will look like [ "myFieldName0", "myFieldName1" ] to the server side code. 

Server Side Return Data
-----------------------

How the data is returned from the server is not difficult, but it is very important. If not done correctly, it can be the cause of reported errors that the "onComplete" is not firing in FileUploader.

**NOTE** The Flash uploader and the HTML uploader need differently formatted return data. You will need to inspect the post data to determine which type to return.

If *flashFieldName* is found in the post data and Flash is being used on the client side, all that is needed for return data is a key-value string, and it can simply be returned, as at the end of a function. You may also want to insert *exit* or whatever necessary to cease execution of the remainder of the code. Example:

.. code-block :: html
 :linenos:
 
 $data .='file='.$file.',name='.$name.',width='.$width.',height='.$height.',type='.$type;
 echo($data);
 exit;
 
For non-PHP devs this translates to:

.. code-block :: text
 :linenos:
 
 $name = name of the file, such as "PIC01.jpg"
 $file = name of the file and the path, such as "uploaded/PIC01.jpg"
 $width, $height = the dimensions (if you are working with images)
 $type = the extension of the file - JPG, GIF, PNG, etc.


The return to Flash should look like:

.. code-block :: text
 :linenos:

 "file=uploaded/PIC01.jpg,name=PIC01.jpg,width=320,height=240,type=jpg"
 

This string should be returned, or printed, or echoed.

New in 1.4, you can add an error key if one file was in error; say if it was not of the correct type. This error code or message will be returned in the onComplete dataArray. It's important to note that as far as the FileUploader is concerned, everything was a success. It's up to your custom code to test for this error.

The return string with an error might look like:

.. code-block :: text
 :linenos:

 "file=uploaded/PIC01.jpg,name=PIC01.jpg,width=320,height=240,type=jpg,error=Not recognized file type"

You can also send back arbitrary parameters from your server-side script using this comma-delimitted format.  For example, adding variables foo and abc:

.. code-block :: text
 :linenos:

 "file=uploaded/PIC01.jpg,name=PIC01.jpg,width=320,height=240,type=jpg,foo=bar,abc=123"

Then you can access these variables in the client-side functions using dataArray[i].additionalParams.foo and dataArray[i].additionalParams.abc.

Note: there is an open ticket http://bugs.dojotoolkit.org/ticket/10576 - when the uploader is set/forced to HTML mode, additionalParams is not created on the client side.  In the situation above dataArray[i].foo would exist though.

If *htmlFieldName* is used, the code on the client side gets pretty tricky, as an iframe is necessary for the file-post, and reading back from that iframe presents problems. In order to read the iframe return data accurately cross browser, the code needs to be wrapped in a *<textarea>*. You can see the code for this on the very last line of UploadFiles.php. Note that the textarea needs to be outside of the PHP. Example:

.. code-block :: html
 :linenos:
 
 <?php
     ....code....
 ?>
 <textarea><?php print $json->encode($dataObject); ?></textarea>
 
For non-PHP devs, this translates into a JSON string, wrapped in a textarea, returned as HTML. I know it's screwy, but that's how it works.

If you are having problems getting onComplete to fire, look at this code first. Often the problem is the server side code is not catching the flash field name for whatever reason (perhaps the client and server names don't match) and the code is falling to the end of the page and returning a textarea to Flash. Recently Code has been added in the SWF that checks for this, so if that is the problem, you should be notified with a console message.

HTTPS Issues
------------

Attempting to upload to an HTTPS server can be very difficult in Firefox and Safari due to the fact that they do not share the same session as the browser page. IE has much fewer issues. Potential workarounds (mostly unverified as I do not have an HTTPS server to test with):

 - Here is the official Adobe bug report on the issue: https://bugs.adobe.com/jira/browse/FP-226

 - Firefox does not like self signed security certificates. It has been said that an official signed cert will work.

 - It was brought to my attention that an .htaccess files on the server will work with the following content:

.. code-block :: text
 :linenos:
 
 <IfModule mod_security.c>
   SecFilterEngine Off
   SecFilterScanPOST Off
 </IfModule>
 

HOWEVER, this site says that opens you up to SQL injection attacks. He offers other solutions:
http://pumastudios.com/2009/05/file-uploads-and-mod_security-vs-wordpress-wp-adminadmin-ajaxphp

The original poster responds:

    This is not only a https issue. It's also on simple http connections. Ist a bug of adobe flash player in conjunction with the web application firewall (modsecurity). If i understand that correctly the flash player sends one "\\n\\r" instead but the http protocol requires "\\n\\r\\n\\r". For modsecutiry this is a rule break so it delivers 403 rejected.

    And yes if you disable modsecurity sql injections can be done on all post vars that are later processed by the database an not escaped within the application. So another safer way - until adobe fixed this problem and all flash players are updated - is the following but may not work on all servers: 

.. code-block :: text
 :linenos:
 
 <IfModule mod_security.c>
  SetEnvIfNoCase Content-Type "^multipart/form-data;" "MODSEC_NOPOSTBUFFERING=Do not buffer file uploads"
 </IfModule>
 
(Thanks to minobun for all the great info on this thorny issue)
 
The other, less desirable solutions, are: 
 - Have an HTTP server to handle the uploads and use a crossdomain.xml file to handle the different protocol. 
 - You may need to resort to force the HTML uploader.
 
More references to this issue:
 - http://bugs.dojotoolkit.org/ticket/8911
 - http://bugs.dojotoolkit.org/ticket/10306
 - http://wiki.modxcms.com/index.php/What_is_mod_security_and_how_does_it_affect_me
 - http://www.modsecurity.org/documentation/modsecurity-apache/1.9.3/html-multipage/06-special_features.html

=====
Demos
=====

 - http://mwilcox.dojotoolkit.org/dtk/dojox/form/tests/test_FileUploader.html
 - http://mwilcox.dojotoolkit.org/dtk/demos/uploader/demo.html
 - http://mwilcox.dojotoolkit.org/dtk/dojox/form/tests/test_FileUploaderForm.html
 - http://mwilcox.dojotoolkit.org/dtk/dojox/form/tests/test_FileUploaderCSS.html
