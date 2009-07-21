#format dojo_rst

dojox.form.FileUploader
=========================

:Status: Up to date
:Version: 1.4
:Project owner: Mike Wilcox
:Author: Mike Wilcox
:Available: since 1.1

Basic Description
-----------------

Handles file uploading to a server. 

Version 1.4
-----------

FileUploader is now a widget and **DOES** create a button. You do not have to pass a button in. Passing a button is still supported until version 1.5 to maintain backwards compatibility, but it is not reccomended. Just create your uploader like any other widget.

The button styles are now recreated in Flash, so there is no longer an invisible Flash movie with *wmode=transparent*. This way the Flash button is actually placed inline with the DOM, not floating above it and contstantly resetting its position. The "Windows Firefox clickable bug" should be fixed (and hopefully some Linux problems).

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

 <div id="btn" class="btnNormal">Select Files</div>
  
.. code-block :: javascript
 :linenos:
 
 var uploader = new dojox.form.FileUploader(
     hoverClass:"btnHover",
     activeClass:"btnActive",
     disabledClass:"btnDisable",
     uploadUrl:pathToUploadServerScript
 }, "myDiv");
 
Or, using the same CSS, create it as markup:


.. code-block :: html
 :linenos:

 <div class="btnNormal" dojoType="dojox.form.FileUploader" hoverClass="btnHover"
      activeClass="btnActive" disabledClass="btnDisabled" uploadUrl="../serverpage.php">Select Files</div>


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

Server Side Code
----------------

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

If *flashFieldName* is found in the headers and Flash is being used on the client side, all that is needed for return data is an object, and it can simply be returned, as at the end of a function: *return $data;*. You may also want to insert *exit* or whatever necessary to cease execution of the remainder of the code.

If *htmlFieldName* is used, the code on the client side gets pretty tricky, as an iframe is necessary for the file-post, and reading back from that iframe presents problems. In order to read the iframe return data accurately cross browser, the code needs to be wrapped in a *<textarea>*. You can see the code for this on the very last line of UploadFiles.php. 

If you are having problems getting onComplete to fire, look at this code first. Often the problem is the server side code is not catching the flash field name for whatever reason (perhaps the client and server names don't match) and the code is falling to the end of the page and returning a textarea to Flash. Recently Code has been added in the SWF that checks for this, so if that is the problem, you should be notified with a console message.


Demos
-----

http://mwilcox.dojotoolkit.org/dtk/dojox/form/tests/test_FileUploader.html

http://mwilcox.dojotoolkit.org/dtk/demos/uploader/demo.html

http://mwilcox.dojotoolkit.org/dtk/dojox/form/tests/test_FileUploaderForm.html

http://mwilcox.dojotoolkit.org/dtk/dojox/form/tests/test_FileUploaderCSS.html
