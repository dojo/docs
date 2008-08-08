#format dojo_rst

dojox.form.FileUploader
=========================

:Status: Contributed, Draft
:Version: 1.0

Basic Description
-----------------

Handles file uploading to a server. It does ***NOT*** create a button - it transforms an existing button into an uploader. This can be used for toolbar buttons for example. Because of this, it only works programmatically, it does not work in markup. Use the other other DojoX FileInput files for markup solutions. 

FileUploader is a wrapper class. If the correct version of Flash Player is available, dojox.form.FileInputFlash is used. If the **degradable** property is true, and Flash Player is not installed or is outdated, dojox.form.FileInputOverlay is used. Either of those two sub-classes could be directly, but it's easiest and best to use dojox.form.FileUploader.

Properties
----------

***degradable***:**Boolean**<br/>
If true, will check if user has the correct version of the Flash Player installed, and if not, will cancel FileInputFlash and install FileInputOverlay instead. If false and user does not have the correct version of Flash, (or if user has Opera) FileInputFlash will install regardless, hopefully triggering the browser update mechanism.
