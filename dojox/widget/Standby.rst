#format dojo_rst

dojox.widget.Standby
====================

:Status: Draft
:Version: 1.4
:Project owner: Jared Jurkiewicz
:Available: since V1.3

.. contents::
   :depth: 2

Ever want to mark a widget as busy?  Ever have a time it was taking a grid a bit to fetch data?  Ever want to overlay some progress information on top of a login widget?  Well, this little widget solves all those scenarios!  The dojox.widget.Standby widget is designed as a 'overlay' style widget that will position a translucent overlay in a color of your choice with a graphic of your choice on top of of any visible DOM node in your page.  The widget overlay blocks access to the underlying DOM node and will even track the DOM node's position so that if it moves, the overlay will shift its position to match.  It's very simple and easy to use!  

**Note:** There have been several examples of this style of widget around, including one done by Peter Higgins as an example of writing a dojo widget.  None of them, though, handle all the cases this one does.  It will mirror over any CSS applied curved borders in Firefox and Safari, as well as any CSS3 compliant broswer, it will track position and update if the target node moves.  It will also rescale itself should the target rescale as well as try to adapt for any margins applied to the target.

============
Known issues
============

* When creating the widget programmatically, make sure to either have its parent node rooted as a direct child of document.body, or assign the domNode into the tree before calling startup().  The widget will reparent itself to document.body if it detects it isn't there.  The reason for this is that if the widget gets attached under nodes with relative position, the overlay does not position correctly.  The simplest method to deal with that was to always put the widget domNode onto the document.body, where it will not have to deal with relative versus absolute issues.

* RTL mode does not work perfectly across all browsers, particularly when the target div is contained within a div/section that is scrollable.

=============================
Constructor params/attributes
=============================

+------------------------+--------------------------------------------------------------------------+--------------------+
|**Parameter**           |**Description**                                                           |**Available Since** |
+------------------------+--------------------------------------------------------------------------+--------------------+
|target                  |The target DOMNode id, DOMNode reference, or Widget ID to overlay when    | 1.3                |
|                        |show() is called.                                                         |                    |
+------------------------+--------------------------------------------------------------------------+--------------------+
|image                   |The URL of the image to center in the blocking div overlay                | 1.3                |
+------------------------+--------------------------------------------------------------------------+--------------------+
|imageText               |The ALT tag text for the centered image.                                  | 1.3                |
+------------------------+--------------------------------------------------------------------------+--------------------+
|color                   |The background color of the translucent DIV overlay                       | 1.3                |
+------------------------+--------------------------------------------------------------------------+--------------------+
|text                    |The text to display in the center of the div overlay (alternate to image) | 1.4                |
|                        |This is used in cases where you don't want to center an image, but just   |                    |
|                        |display text.  Defaults to 'Please wait...'                               |                    |
+------------------------+--------------------------------------------------------------------------+--------------------+
|centerIndicator         |Which center indicator to use, the image (with its alt text), or just the | 1.4                |
|                        |text provided in the 'ext' attribute                                      |                    |
+------------------------+--------------------------------------------------------------------------+--------------------+
|zIndex                  |A specific zIndex value to position the overlay at.  Defaults to 'auto'   | 1.4                |
|                        |which means the widget will try to figure out what to use.  For usage in  |                    |
|                        |overlaying dijit.Dialog contained widgets, then you will need to set this |                    |
|                        |value to something like '1000'                                            |                    |
+------------------------+--------------------------------------------------------------------------+--------------------+
|duration                |The time, in milliseconds, that the fadein or fadeout should take.        | 1.4                |
|                        |The default is 500ms.                                                     |                    |
+------------------------+--------------------------------------------------------------------------+--------------------+

================
Useful functions
================

The following functions are useful for controlling the state of the Standby widget:

* **show** - This function triggers the fadeIn effect of the widget.  It will do nothing if the widget is already displaying.
* **hide** - This function triggers the fadeOut effect of the widget.  It will do nothing if the widget is already hidden.

======
Events
======

As of the Dojo Toolkit 1.4, the Standby widget has added events that you can listen to via dojo.connect.  These events allow you to track the state and do things when it is shown or hidden.  The events are denoted below:

* **onShow** - This event is triggered when the fadeIn show animation has completed. *New to 1.4*
* **onHide** - This event is triggered when the fadeOut hide animation has completed. *New to 1.4*


=====
Usage
=====

Using the widget is simple.  At its most basic form, all you have to provide the widget on construction is a value for 'target', the id of a DOM node or widget, or a direct reference to the dom node you want to overlay.  When you want it to appear, you invoke the 'show' function of the widget.  When you want it to hide, you invoke the 'hide' function.  That's all there is to it.

For more custom control, you can also set the 'color' attribute on the widget to a color to use for the overlay as well as an 'image' attribute with the location/url of an image to center in the middle of the widget.  Its default image is the same one that dojox.image.Lightbox uses, a basic spinner/busy animated gif.

Also, for Dojo 1.3 users ... please remember to import the dojox/widget/Standby/Standby.css into your page.  The CSS contains specific positioning details for the divs in the template that are needed for it to display properly.   Dojo 1.4 users do not need a CSS import, the CSS was inlined into the template.

Example 1: Basic usage
----------------------

.. code-example ::
  
  .. javascript::

    <script type="text/javascript">
      dojo.require("dojox.widget.Standby");
      dojo.require("dijit.form.Button");

      function init(){
         document.body.appendChild(basicStandby1.domNode);
         dojo.connect(b1, "onClick", function(){basicStandby1.show();});
         dojo.connect(b2, "onClick", function(){basicStandby1.hide();});
      }
      dojo.addOnLoad(init);
    </script>

  .. html::

    <button jsId="b1" dojoType="dijit.form.Button">Show Standby widget</button>
    <button jsId="b2" dojoType="dijit.form.Button">Hide Standby widget</button>
    <div id="basic" style="width: 300px; height: 150px; background-color: yellow; border-style: solid; border-width: 2px;"></div>
    <div jsId="basicStandby1" dojoType="dojox.widget.Standby" target="basic"></div>

  .. css::

    <style type="text/css">
      @import "{{ baseUrl }}dojox/widget/Standby/Standby.css";
    </style>
