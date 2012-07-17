.. _dijit/_Container:

================
dijit/_Container
================

.. contents ::
    :depth: 2

Introduction
============

Use this mixin for widgets that contain (or sometimes contain) a list of child widgets,
in order to be able to adjust the list of child widgets via addChild() and removeChild().

_Container can be used as a superclass for any widget with this.containerNode defined, but it's especially useful
for widgets like :ref:`dijit/layout/BorderContainer <dijit/layout/BorderContainer>`
and  :ref:`dijit/layout/TabContainer <dijit/layout/TabContainer>` which contain (only) a set of child widgets.

When a widget that extends _Container contains nothing but a set of child widgets (or contains nothing at all),
you can use the addChild() and removeChild() API to adjust the list of widget children.

Example
========

.. code-example ::

    .. js ::

        require([
            "dojo/_base/declare", "dojo/dom-construct", "dojo/ready", "dojo/_base/window",
            "dijit/_WidgetBase", "dijit/_Container", "dijit/form/Button"
        ], function(declare, domConstruct, ready, win, _WidgetBase, _Container, Button){
            ready(function(){
                var MyToolbar = declare([_WidgetBase, _Container], { });

                var toolbar = new MyToolbar();
                toolbar.placeAt(win.body());
                toolbar.addChild(new Button({label: "click me"}));
                toolbar.addChild(new Button({label: "click me"}));
                domConstruct.place("<p>Widgets in toolbar: " + toolbar.getChildren().length + "</p>", win.body());
            });
        });


See also
========
* :ref:`dijit/_Contained <dijit/_Contained>`
