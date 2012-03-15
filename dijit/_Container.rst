.. _dijit/_Container:

================
dijit/_Container
================

.. contents ::
    :depth: 2

Introduction
============

Use this mixin for widgets that needs to know about and keep track of their widget children.
Suitable for widgets like :ref:`dijit/layout/BorderContainer <dijit/layout/BorderContainer>`
and  :ref:`dijit/layout/TabContainer <dijit/layout/TabContainer>` which contain (only) a set of child widgets.

It's not suitable for widgets like  :ref:`dijit/layout/ContentPane <dijit/layout/ContentPane>`
which contains mixed HTML (plain DOM nodes in addition to widgets),
and where contained widgets are not necessarily directly below
this.containerNode.   In that case calls like addChild(node, position)
wouldn't make sense.


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


.. api-link :: dijit._Container


See also
========
* :ref:`dijit/_Contained <dijit/_Contained>`
