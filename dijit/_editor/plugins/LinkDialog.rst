.. _dijit/_editor/plugins/LinkDialog:

================================
dijit/_editor/plugins/LinkDialog
================================

:Authors: Jared Jurkiewicz
:Developers: Jared Jurkiewicz
:since: V1.4

.. contents ::
    :depth: 2

Have you ever wanted to insert a hyperlink into a document you are editing in :ref:`dijit.Editor <dijit/Editor>`?
Have you wanted to insert images as well?
If so, then this plugin provides you a basic set of dropdown dialogs to allow you to do just that.
The dialogs are not complex and are intended as example implementations so that users can implement dialogs of their own, but they still work fairly well as is.

Features
========

Once required in and enabled, this plugin provides the following features to dijit.Editor.

* Button with icon in toolbar for inserting a hyperlink.
* Button with icon in toolbar for inserting an image
* Auto-population of input fields when a hyperlink or image is selected in the document and the appropriate button in the toolbar is pressed.
* URL input is validated.  The preferred input are full urls, such as http://example.com/somepage.html, but it will 'permit' local urls so long as they are prefixed accordingly, such as /mydir/myfile.html or ./mydir/myfile.html.   The same validation is done for both image inserts and hyperlink inserts.
* Description text for hyperlinks is validated.  It cannot be empty.
* Descriptions (alt text) for images are optional, but highly recommended for accessibility reasons.
* Double-Clicking on a link should activate the Link Properties dialog dropdown on the button.
* Double-Clicking on an image should activate the Image Properties dialog dropdown on the button.
* Single-clicking an image should select the image.  This makes it easy to select, then edit, an image in the page


Limitations
===========

* You can't create a hyperlink that has no description and just wraps an image

Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.
The first thing you need to do is require into the page you're using the editor.
This is done in the same spot as your require() call is made, usually the head script tag.
For example:

.. js ::
 
    require(["dojo/parser", "dijit/Editor", "dijit/_editor/plugins/LinkDialog"]);


Once it has been required in, all you have to do is include it in the list of extraPlugins (or the plugins property if you're reorganizing the toolbar) for you want to load into the editor.
For example:

.. html ::

  <div data-dojo-type="dijit/Editor" id="editor" data-dojo-props="extraPlugins:['createLink', 'unlink', 'insertImage']"></div>



And that's it.
The editor instance you can reference by 'dijit.byId("editor")' is now enabled with all the toolbar actions provided by the LinkDialog plugin.


A11Y Considerations
===================

* When using the dialog to insert images, please be sure to provide a description.  This gets put as the alt text of the image tag and is used by screen readers to read the image information to the page viewer.

Examples
========

Basic Usage
-----------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4

  .. js ::

    require(["dojo/parser", "dijit/Editor", "dijit/_editor/plugins/LinkDialog"]);

    
  .. html ::

    <b>Select any of the links or images below and click the appropriate button to change their properties.  Or, click where on the page you want to insert an image or a link, then click the appropriate button and create the image or link.</b>
    <br />
    <div data-dojo-type="dijit/Editor" height="250px" id="input" data-dojo-props="extraPlugins:['createLink', 'unlink', 'insertImage']">
        <br />
        <br />
        <a href="http://www.dojotoolkit.org">The best Ajax Toolkit there is, Dojo!</a>
        <br />
        <br />
        <br />
        <br />
        It even has a cool logo: <img src="http://jaredj.dojotoolkit.org/images/dojo.logo.png" alt="The Dojo Toolkit" />
        <br>
    </div>


See Also
========

* :ref:`dijit/Editor <dijit/Editor>`
* :ref:`dijit/_editor.plugins <dijit/_editor/plugins>`
* :ref:`dojox/editor/plugins <dojox/editor/plugins>`
