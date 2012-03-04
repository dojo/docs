.. _dojox/layout/FloatingPane:

=========================
dojox.layout.FloatingPane
=========================

:Project owner: Peter Higgins
:since: V?

.. contents ::
   :depth: 2

dojox.layout.FloatingPane is an **experimental** floating window.

Introduction
============

The dojox.layout.FloatingPane class provides flexible support for floating panes which can be resized, minimized/maximized and layered dynamically, similar to application windows within the web page. Unlike :ref:`dijit.Dialog <dijit/Dialog>`, FloatingPane is not modal and it is designed to allow multiple active windows. A special dock widget (dojox.layout.Dock) is used to provide the user interface for restoring minimized (docked) windows.


Usage
=====

As FloatingPane is an experimental widget, there are a few caveats to keep in mind if you choose to make use of it:

* You will need to import the FloatingPane.css and ResizeHandle.css files from the dojox/layout/resources directory. The styles are not included in the main Dojo/theme stylesheets because of the experimental status of the widget.
* Resizable FloatingPanes will pass resize events to their contents if it contains a single top level child widget (such as a dijit.layout.BorderContainer or other layout container class) with a defined 'resize' method. While it is possible to size the pane's inner content using percentage-based widths and heights, the default styles for FloatingPane makes use of padding and margins, so this is not recommended.
* FloatingPane overwrites the 'style' attribute of it's DOM element with the 'style' property provided in the constructor call. This only applies when creating the widget programmatically, since the two style declarations are one and the same when defining the widget declaratively.
* Always specify position:absolute in the style attribute, and always specify values for the 'top' and 'left' CSS attributes. Not doing so will cause FloatingPane to malfunction.


Examples
========

Programmatic example
--------------------

.. code-example ::
  :type: inline
  :height: 350

  .. css ::

       @import "{{baseUrl}}dojox/layout/resources/FloatingPane.css";
       @import "{{baseUrl}}dojox/layout/resources/ResizeHandle.css";

  .. js ::

     dojo.require("dojox.layout.FloatingPane");
     dojo.require("dijit.form.Button");

     var pFloatingPane;

     dojo.ready(function(){
       pFloatingPane = new dojox.layout.FloatingPane({
          title: "A floating pane",
          resizable: true, dockable: true,
          style: "position:absolute;top:0;left:0;width:100px;height:100px;visibility:hidden;",
          id: "pFloatingPane"
       }, dojo.byId("pFloatingPane"));

       pFloatingPane.startup();
     });

  .. html ::

        <div id="pFloatingPane">This is the content of the pane!</div>
        <div data-dojo-type="dijit.form.Button" data-dojo-props="label:'Show me', onClick:function(){pFloatingPane.show();}"></div>
        <br/><br/><br/><br/>


Declarative example
-------------------

.. code-example ::
  :type: inline
  :height: 350

  .. css ::

       @import "{{baseUrl}}dojox/layout/resources/FloatingPane.css";
       @import "{{baseUrl}}dojox/layout/resources/ResizeHandle.css";

  .. js ::

     dojo.require("dojox.layout.FloatingPane");
     dojo.require("dijit.form.Button");

  .. html ::

     <div data-dojo-type="dojox.layout.FloatingPane" id="dFloatingPane"
        title="A floating pane" data-dojo-props="resizable:true, dockable:true, title:'A floating pane'"
        style="position:absolute;top:0;left:0;width:100px;height:100px;visibility:hidden;">
     This is the content of the pane!
     </div>
     
     <div data-dojo-type="dijit.form.Button" data-dojo-props="label:'Show me', onClick:function(){dijit.byId('dFloatingPane').show();}"></div>
     <!-- makes example preview div big enough: --><div style="height:280px;width:100%;"></div>

Troubleshooting
===============

* Width of FloatingPane is equal to the browser view (or the parent DOM node): Make sure to set 'position:absolute' in the 'style' property of the widget (if making the widget programmatically, make sure CSS styles are set in the constructor, not the DOM node 'style' property)
* Cannot move the FloatingPane: Always specify values for the 'top' and 'left' CSS styles (it doesn't matter what values, just that they are defined). Once again, programmatic FloatingPanes should have their CSS styles set using the constructor 'style' property, NOT the DOM node's 'style' property.
* Cannot resize FloatingPane using resize handle: This happens when startup() isn't called. When creating widgets programmatically, always call the startup() method after constructing.
* When the widget is closed via the close button, it can no longer be shown: FloatingPane destroys itself when the close button is pressed. You must create a subclass of FloatingPane to override this behavior.

See also
========

* :ref:`dijit.Dialog <dijit/Dialog>`
