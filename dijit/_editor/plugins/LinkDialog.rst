#format dojo_rst

dijit._editor.plugins.LinkDialog
================================

:Status: Draft
:Version: 1.0
:Authors: Jared Jurkiewicz
:Developers: Jared Jurkiewicz
:Available: since V1.4

.. contents::
    :depth: 2

Have you ever wanted to insert a hyperlink into a document you are editing in the Dojo RTE (`dijit.Editor <dijit/Editor>`_)?  Have you wanted to insert images as well?  If so, then this plugin provides you a basic set of dropdown dialogs to allow you to do just that.  The dialogs are not complex and are indended as example implementations so that users can implement dialogs of their own, but they still work fairly well as is.

========
Features
========

Once required in and enabled, this plugin provides the following features to dijit.Editor.

* Button with icon in toolbar for inserting a hyperlink.
* Button with icon in toolbar for inserting an image
* auto-population of input fields when the a hyperlink or image is selcted in the document and the appropriate button in the toolbar is pressed.
* URL input is validated.  The preferred input are full urls, such as http://example.com/somepage.html, but it will 'permit' local urls so long as they are prefixed accordingly, such as /mydir/myfile.html or ./mydir/myfile.html.   The same validation is done for both image inserts and hyperlink inserts.
* Description text for hyperlinks is validated.  It cannot be empty.
* Descriptions (alt text) for images is optional, but highly recommended for accessibility reasons.
 
===========
Limitations
===========

* You can't create a hyperlink that has no description and just wraps an image

=====
Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.  The first thing you need to do is require into the page you're using the editor.  This is done in the same spot all your dojo.require calls are made, usually a head script tag.  For example:

.. code-block :: javascript
 
    dojo.require("dijit.Editor");
    dojo.require("dijit._editor.plugins.LinkDialog");


Once it has been required in, all you have to do is include it in the list of extraPlugins (or the plugins property if you're reorganizing the toolbar) for you want to load into the editor.  For example:

.. code-block :: html

  <div dojoType="dijit.Editor" id="editor" extraPlugins="['createLink', 'unlink', 'insertImage']"></div>



And that's it.  The editor instance you can reference by 'dijit.byId("editor")' is now enabled with all the toolbar actions provided by the LinkDialog plugin.


===================
A11Y Considerations
===================

* When using the dialog to insert images, please be sure to provide a description.  This gets put as the alt text of the image tag and is used by screen readers to read the image information to the page viewer.

========
Examples
========

Basic Usage
-----------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4

  .. javascript::

    <script>
      dojo.require("dijit.Editor");
      dojo.require("dijit._editor.plugins.LinkDialog");
    </script>

    
  .. html::

    <b>Select any of the links or images below and click the appropriate button to change their properties.  Or, click where on the page you want to insert an image or a link, then click the appropriate button and create the image or link.</b>
    <br>
    <div dojoType="dijit.Editor" height="250px"id="input" extraPlugins="['createLink', 'unlink', 'insertImage']">
      <br>
      <br>
      <a href="http://www.dojotoolkit.org">The best Ajax Toolkit there is, Dojo!</a>
      <br>
      <br>
      <br>
      <br>
      It even has a cool logo: <img src="http://jaredj.dojotoolkit.org/images/dojo.logo.png" alt="The Dojo Toolkit" />
      <br>
    </div>


========
See Also
========

* `dijit.Editor <dijit/Editor>`_
* `dijit._editor.plugins <dijit/_editor/plugins>`_
* `dojox.editor.plugins <dojox/editor/plugins>`_
