#format dojo_rst

dijit._editor.plugins.FontChoice
================================

:Status: Draft
:Version: 1.0
:Authors: Jared Jurkiewicz
:Developers: Bill Keese, Jared Jurkiewicz
:Available: since V1.1

.. contents::
    :depth: 2

Have you ever wanted to change the font size, font face, or block type containing the text in your document?  If so, then this plugin is for you!  It provides three drop down menu items for manipulating those aspects of your document.

========
Features
========

Once required in and enabled, this plugin provides the following features to dijit.Editor.

* Drop-Down select of Font names to style text with.  The font names by default are basic ones supported by all browsers.  Users can customize this list to include other font names.  
* Drop-Down select of Font sizes (xx-small to xx large) to style text with.  The font sizes are the basic HTML named font sizes (1 through 7), that all browsers support natively through the fontSize command.
* Drop-Down select of text container types, such as <p>, <pre>, <h1>, <h2> ... and so on.  
* Preview mode in the dropdowns to show what the size or style type would appear like in the document.
* Auto-updating of view of the current style, size, and name settings as the user moves through the document to sections with different styles.

=====
Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.  The first thing you need to do is require into the page you're using the editor.  This is done in the same spot all your dojo.require calls are made, usually a head script tag.  For example:

.. code-block :: javascript
 
    dojo.require("dijit.Editor");
    dojo.require("dijit._editor.plugins.FontChoice");


Once it has been required in, all you have to do is include the control names in the list of extraPlugins (or the plugins property if you're reorganizing the toolbar) for you want to load into the editor.  For example:

.. code-block :: html

  <div dojoType="dijit.Editor" id="editor" extraPlugins="['fontName', 'fontSize', 'formatBlock']"></div>



And that's it.  The editor instance you can reference by 'dijit.byId("editor")' is now enabled with all the toolbar actions provided by the FontChoice plugin.

==============
Plugin Options
==============

The FontChoice plugin allows certain options to control how the plugin displays state to the user.  This is primarily to enable or disable the style 'preview' in the button.  The default mode for style preview is enabled for backwards compatibility.  An example of disabling it is below:

.. code-block :: html

  <div dojoType="dijit.Editor" id="editor" extraPlugins="[{name: 'fontName', plainText: true}, {name: 'fontSize', plainText: true}, {name: 'formatBlock', plainText: true}]"></div>

With the preview disabled, the selects show basic text only.

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
