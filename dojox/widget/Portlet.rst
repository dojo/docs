#format dojo_rst

dojox.widget.Portlet
====================

:Status: Draft
:Version: 1.0
:Project owner: Shane O'Sullivan
:Available: since 1.3.2

.. contents::
   :depth: 2

The dojox.widget.Portlet is an enhanced version of the dijit.TitlePane widget, designed to be used in the dojox.layout.GridContainer.


============
Introduction
============

The Portlet widget adds enhanced features to the dijit.TitlePane widget. It adds the ability to close (remove) the widget from a GridContainer, and also to have configurable settings.

The settings types included are
 * dojox.widget.PortletSettings
   The base settings widget. Places the settings at the top of the Portlet, which slide into view when the settings icon is pressed.
 * dojox.widget.PortletDialogSettings
   Displays the settings is a pop up modal dialog.
 * dojox.widget.PortletFeedSettings
   The settings widget to be used with the dojox.widget.FeedPortlet.  It can be a simple text input displaying the URL to an Atom or RSS feed, or a select node displaying multiple feeds to load.

=====
Usage
=====

TODO: how to use the component/class/method

.. code-block :: javascript
 :linenos:

 <div dojoType="dojox.widget.Portlet" title="My Flickr">

   <div dojoType="dojox.widget.PortletSettings">
     <div dojoType="dojox.layout.TableContainer" cols="1">
       <div dojoType="dijit.form.TextBox" title="Option 3"></div>
       <div dojoType="dijit.form.TextBox" title="Option 4"></div>
     </div>
   </div>

   <div>
     The Contents of the portlet go here  
   </div>
 </div>




========
Examples
========

Basic Portlet
--------------------

.. code-example::
  :version: 1.3.2-2.0

  Load the Portlet JavaScript.

  .. javascript::

    <script type="text/javascript">
      dojo.require("dojox.widget.Portlet");
    </script>

  .. html::
   
      <div dojoType="dojox.widget.Portlet" title="A Simple Portlet">
	<div dojoType="dojox.widget.PortletSettings">
          This is a simple settings widget.
          Put whatever you like in here       
	</div>

	<div style="height: 100px;">
	  The contents of the portlet go in here.
          Try clicking the settings icon in the title bar to see the settings. 
            
	</div>
    </div>

Declarative example
-------------------

TODO: example


========
See also
========

* TODO: links to other related articles
