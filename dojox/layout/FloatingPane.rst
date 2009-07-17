#format dojo_rst

dojox.layout.FloatingPane
=========================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

dojox.layout.FloatingPane is an experimental floating window.


============
Introduction
============

The dojox.layout.FloatingPane class provides flexible support for floating panes which can be resized, minimized/maximized and layered dynamically, similar to application windows within the web page. Unlike `dijit.Dialog <dijit/Dialog>`_, FloatingPane is not modal and it is designed to allow multiple active windows. A special dock widget (dojox.layout.Dock) is used to provide the user interface for restoring minimized (docked) windows.


=====
Usage
=====

As FloatingPane is an experimental widget, there are a few caveats to keep in mind if you choose to make use of it:

* You will need to import the FloatingPane.css and ResizeHandle.css files from the dojox/layout/resources directory. The styles are not included in the main Dojo/theme stylesheets because of the experimental status of the widget.
* Resizable FloatingPanes will pass resize events to their contents if it contains a single top level child widget (such as a dijit.layout.BorderContainer or other layout container class) with a defined 'resize' method. While it is possible to size the pane's inner content using percentage-based widths and heights, the default styles for FloatingPane makes use of padding and margins, so this is not recommended.
* FloatingPane overwrites the 'style' attribute of it's DOM element with the 'style' property provided in the constructor call. This only applies when creating the widget programmatically, since the two style declarations are one and the same when defining the widget declaratively.
* Always specify position:absolute in the style attribute, and always specify values for the 'top' and 'left' CSS attributes. Not doing so will cause FloatingPane to malfunction.


========
Examples
========

Programmatic example
--------------------

.. cv-compound::
  .. cv:: css

     <style type="text/css">
       @import "/moin_static163/js/dojo/trunk/dojox/layout/resources/FloatingPane.css";
       @import "/moin_static163/js/dojo/trunk/dojox/layout/resources/ResizeHandle.css";
     </style>

  .. cv:: javascript

     <script type="text/javascript">
     dojo.require("dojox.layout.FloatingPane");
     dojo.require("dijit.form.Button");
     dojo.addOnLoad(function() {
       new dojox.layout.FloatingPane({
          title: "A floating pane",
          resizable: true, dockable: true,
          style: "position:absolute;top:0;left:0;width:100px;height:100px;display:none;",
          id: "pFloatingPane"
       }, dojo.byId("pFloatingPane")).startup();
     });
     </script>

  .. cv:: html

        <div id="pFloatingPane">This is the content of the pane!</div>
        <div dojoType="dijit.form.Button" label="Show me" onClick="dijit.byId('pFloatingPane').show();"></div>
        <br/><br/><br/><br/>


Declarative example
-------------------

.. cv-compound::
  .. cv:: css

     <style type="text/css">
       @import "/moin_static163/js/dojo/trunk/dojox/layout/resources/FloatingPane.css";
       @import "/moin_static163/js/dojo/trunk/dojox/layout/resources/ResizeHandle.css";
     </style>

  .. cv:: javascript

     <script type="text/javascript">
     dojo.require("dojox.layout.FloatingPane");
     dojo.require("dijit.form.Button");
     </script>

  .. cv:: html

     <div dojoType="dojox.layout.FloatingPane" id="dFloatingPane"
        title="A floating pane" resizable="true" dockable="true"
        style="position:absolute;top:0;left:0;width:100px;height:100px;visibility:hidden;">
     This is the content of the pane!
     </div>
     
     <div dojoType="dijit.form.Button" label="Show me" onClick="dijit.byId('dFloatingPane').show();"></div>
     <!-- make campus preview div big enough: --><div style="height:280px;width:100%;"></div>

===============
Troubleshooting
===============

* Width of FloatingPane is equal to the browser view (or the parent DOM node): Make sure to set 'position:absolute' in the 'style' property of the widget (if making the widget programmatically, make sure CSS styles are set in the constructor, not the DOM node 'style' property)
* Cannot move the FloatingPane: Always specify values for the 'top' and 'left' CSS styles (it doesn't matter what values, just that they are defined). Once again, programmatic FloatingPanes should have their CSS styles set using the constructor 'style' property, NOT the DOM node's 'style' property.
* Cannot resize FloatingPane using resize handle: This happens when startup() isn't called. When creating widgets programmatically, always call the startup() method after constructing.
* When the widget is closed via the close button, it can no longer be shown: FloatingPane destroys itself when the close button is pressed. You must create a subclass of FloatingPane to override this behavior.

========
See also
========

* `dijit.Dialog <dijit/Dialog>`_
