.. _dojox/widget/Standby:

====================
dojox.widget.Standby
====================

:Project owner: Jared Jurkiewicz
:since: v1.3

.. contents ::
   :depth: 2

Marks a widget as "busy".

Introduction
============

Ever want to mark a widget as busy? Ever have a time it was taking a grid a bit to fetch data? Ever want to overlay some
progress information on top of a login widget? Well, this little widget solves all those scenarios! The
``dojox.widget.Standby`` widget is designed as a 'overlay' style widget that will position a translucent overlay in a
color of your choice with a graphic of your choice on top of of any visible DOM node in your page. The widget overlay
blocks access to the underlying DOM node and will even track the DOM node's position so that if it moves, the overlay
will shift its position to match. It's very simple and easy to use!

**Note:** There have been several examples of this style of widget around, though they do not handle all the cases this
one does. It will mirror over any CSS applied curved borders in any CSS3 compliant browser, it will track position and
update if the target node moves. It will also rescale itself should the target rescale as well as try to adapt for any
margins applied to the target.

Usage
=====

Using the widget is simple. At its most basic form, all you have to provide the widget on construction is a value for
'target', the id of a DOM node or widget, or a direct reference to the DOM node you want to overlay. When you want it to
appear, you invoke the 'show' function of the widget. When you want it to hide, you invoke the 'hide' function. That's
all there is to it.

For more custom control, you can also set the ``color`` attribute on the widget to a color to use for the overlay as
well as an 'image' attribute with the location/url of an image to center in the middle of the widget. Its default image
is the same one that :ref:`dojox.image.Lightbox <dojox/image/Lightbox>` uses, a basic spinner/busy animated gif.

**Note:** For Dojo 1.3, the ``dojox/widget/Standby/Standby.css into your page``. The CSS contains specific positioning
details for the divs in the template that are needed for it to display properly. Dojo 1.4 and later users do not need a
CSS import, the CSS was inlined into the template.

Constructor params/attributes
-----------------------------

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
|                        |text provided in the 'text' attribute                                     |                    |
+------------------------+--------------------------------------------------------------------------+--------------------+
|zIndex                  |A specific zIndex value to position the overlay at.  Defaults to 'auto'   | 1.4                |
|                        |which means the widget will try to figure out what to use.  For usage in  |                    |
|                        |overlaying dijit.Dialog contained widgets, or other containers that modify|                    |
|                        |zIndex, , then you will need to set this                                  |                    |
|                        |value to something like '1000'                                            |                    |
+------------------------+--------------------------------------------------------------------------+--------------------+
|duration                |The time, in milliseconds, that the fadein or fadeout should take.        | 1.4                |
|                        |The default is 500ms.                                                     |                    |
+------------------------+--------------------------------------------------------------------------+--------------------+

Useful functions
----------------

The following functions are useful for controlling the state of the Standby widget:

* **show** - This function triggers the fadeIn effect of the widget. It will do nothing if the widget is already
  displaying. 
* **hide** - This function triggers the fadeOut effect of the widget. It will do nothing if the widget is already
  hidden.

Events
------

The Standby widget has added events that you can listen to via dojo.connect. These events allow you to track the state
and do things when it is shown or hidden. The events are denoted below:

* **onShow** - This event is triggered when the fadeIn show animation has completed. *New to 1.4*
* **onHide** - This event is triggered when the fadeOut hide animation has completed. *New to 1.4*

Examples
========

Basic Declarative Usage
-----------------------

.. code-example ::
  
  .. js ::

      require(["dojox/widget/Standby", "dijit/form/Button", "dijit/registry"]);

  .. html ::

    <button id="b1" data-dojo-type="dijit.form.Button">
      <span>Show Standby widget</span>
      <script type="dojo/on" data-dojo-event="click">
        var registry = require("dijit/registry");
        registry.byId("basicStandby1").show();
      </script>
    </button>
    <button id="b2" data-dojo-type="dijit.form.Button">
      <span>Hide Standby widget</span>
      <script type="dojo/on" data-dojo-event="click">
        var registry = require("dijit/registry");
        registry.byId("basicStandby1").hide();
      </script>
    </button>
    <div id="basic" style="width: 300px; height: 150px; background-color: yellow; border-style: solid; border-width: 2px;"></div>
    <div id="basicStandby1" data-dojo-type="dojox.widget.Standby" data-dojo-props="target:'basic'"></div>


Basic Programmatic Usage
------------------------

.. code-example ::
  
  .. js ::

      require(["dojox/widget/Standby", "dijit/form/Button", "dojo/domReady!"],
      function(Standby, Button){
         var standby = new Standby({target: "basic2"});
         document.body.appendChild(standby.domNode);
         standby.startup();
         var b3 = new Button({
           label: "Show Standby widget",
           onClick: function(){ standby.show(); }
         }, "b3");
         var b4 = new Button({
           label: "Hide Standby widget",
           onClick: function(){ standby.hide(); }
         }, "b4");
      });

  .. html ::

    <button id="b3">Show Standby widget</button>
    <button id="b4">Hide Standby widget</button>
    <div id="basic2" style="width: 300px; height: 150px; background-color: yellow; border-style: solid; border-width: 2px;"></div>


Changing overlay color
----------------------

.. code-example ::

  .. js ::

      dojo.require("dojox.widget.Standby");
      dojo.require("dijit.form.Button");

      dojo.ready(function(){
         document.body.appendChild(basicStandby3.domNode);
         dojo.connect(b5, "onClick", function(){basicStandby3.show();});
         dojo.connect(b6, "onClick", function(){basicStandby3.hide();});
      });

  .. html ::

    <button data-dojo-id="b5" data-dojo-type="dijit.form.Button">Show Standby widget</button>
    <button data-dojo-id="b6" data-dojo-type="dijit.form.Button">Hide Standby widget</button>
    <div id="basic3" style="width: 300px; height: 150px; background-color: yellow; border-style: solid; border-width: 2px;"></div>
    <div data-dojo-id="basicStandby3" data-dojo-type="dojox.widget.Standby" data-dojo-props="target:'basic3', color:'red'"></div>


Changing overlay color and image
--------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dojox.widget.Standby");
      dojo.require("dijit.form.Button");

      dojo.ready(function(){
         document.body.appendChild(basicStandby4.domNode);
         dojo.connect(b7, "onClick", function(){basicStandby4.show();});
         dojo.connect(b8, "onClick", function(){basicStandby4.hide();});
      });

  .. html ::

    <button data-dojo-id="b7" data-dojo-type="dijit.form.Button">Show Standby widget</button>
    <button data-dojo-id="b8" data-dojo-type="dijit.form.Button">Hide Standby widget</button>
    <div id="basic4" style="width: 400px; height: 400px; background-color: yellow; border-style: solid; border-width: 2px;"></div>
    <div data-dojo-id="basicStandby4" data-dojo-type="dojox.widget.Standby" data-dojo-props="target:'basic4', color:'lightgray', image:'{{baseUrl}}dojox/widget/tests/images/busy.gif'"></div>

Showing curved border cloning
-----------------------------

This example does not work in Internet Explorer 8 and earlier.

.. code-example ::
  
  .. js ::

      dojo.require("dojox.widget.Standby");
      dojo.require("dijit.form.Button");

      dojo.ready(function(){
         document.body.appendChild(basicStandby5.domNode);
         dojo.connect(b9, "onClick", function(){basicStandby5.show();});
         dojo.connect(b10, "onClick", function(){basicStandby5.hide();});
      });

  .. html ::

    <button data-dojo-id="b9" data-dojo-type="dijit.form.Button">Show Standby widget</button>
    <button data-dojo-id="b10" data-dojo-type="dijit.form.Button">Hide Standby widget</button>
    <div id="basic5" style="width: 200px; height: 200px; background-color: yellow; border-style: solid; border-width: 2px; -moz-border-radius: 20px; -webkit-border-radius: 20px;"></div>
    <div data-dojo-id="basicStandby5" data-dojo-type="dojox.widget.Standby" data-dojo-props="target:'basic5', color:'lightgray'"></div>


Overlaying a dijit.form.TextBox
-------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dojox.widget.Standby");
      dojo.require("dijit.form.Button");
      dojo.require("dijit.form.TextBox");

      dojo.ready(function(){
         document.body.appendChild(basicStandby6.domNode);
         dojo.connect(b11, "onClick", function(){basicStandby6.show();});
         dojo.connect(b12, "onClick", function(){basicStandby6.hide();});
      });

  .. html ::

    <button data-dojo-id="b11" data-dojo-type="dijit.form.Button">Show Standby widget</button>
    <button data-dojo-id="b12" data-dojo-type="dijit.form.Button">Hide Standby widget</button>
    <br><br>
    <input type="text" data-dojo-type="dijit.form.TextBox" id="dijitWidget"></input>
    <div data-dojo-id="basicStandby6" data-dojo-type="dojox.widget.Standby" data-dojo-props="target:'dijitWidget'"></div>


Known issues
============

* When creating the widget programmatically, make sure to either have its parent node rooted as a direct child of
  document.body, or assign the ``domNode`` into the tree before calling ``startup()``. The widget will reparent itself
  to document.body if it detects it isn't there. The reason for this is that if the widget gets attached under nodes
  with relative position, the overlay does not position correctly. The simplest method to deal with that was to always
  put the widget ``domNode`` onto the document.body, where it will not have to deal with relative versus absolute
  issues.

* RTL mode does not work perfectly across all browsers, particularly when the target div is contained within a
  div/section that is scrollable.
