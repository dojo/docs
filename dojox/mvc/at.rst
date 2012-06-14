.. _dojox/mvc/at:

============
dojox/mvc/at
============

:Authors: Akira Sudoh, Ed Chatelain
:Developers: Akira Sudoh, Ed Chatelain
:since: V1.8

.. contents ::
  :depth: 2

================
dojox/mvc/at API
================

The module's value is an at function that can be directly called to create a pointer (called at handle) to a dojo.Stateful property.
The at function is in below form, which returns an at handle:

.. js ::

  at(target, targetProp);

The following parameters should be provided to the at function:

* target - This is the dojo.Stateful to point to, or a string either in “rel:target” or in “widget:widgetid” format. “rel:target” format looks for a particular property in parent widget (see `Relative data binding`_ for more details). “widget:widgetid” format looks for a widget with widgetid ID.
* targetProp - This is the dojo.Stateful property name in target, or "*". Using "*" means "all properties". (See :ref:`dojox/mvc/sync:Wildcard syntax <dojox/mvc/sync#wildcard-syntax>` for more details)

-------------------------------
at function syntax with widgets
-------------------------------

at function is typically used as a mixin property of a widget (data-dojo-props or the first parameter of widget's constructor), in below forms, where in both cases the value property in above TextBox is synchronized with target.targetProp:

.. html ::

  <script type="dojo/require">at: "dojox/mvc/at"</script>
  <input data-dojo-type="dijit/form/TextBox" 
   data-dojo-props="value: at(target, 'targetProp')">

.. js ::

  require(["dojo/Stateful", "dijit/form/TextBox", "dojox/mvc/at"], function(Stateful, TextBox, at){
    var target = new Stateful({targetProp: "foo"});
    var textbox = new TextBox({
      value: at(target, targetProp)
    }, srcNodeRef);
    textbox.startup();
  });

----------------------
Data binding direction
----------------------

By default, at function used with widget watches for changes both at target.targetProp and the property (attribute) in widget and reflects one change to another. at function allows to specify the direction via direction function of at handle, which takes one of the following at its first argument:

* at.from - Only reflect changes in target.targetProp to the property (attribute) in widget
* at.to - Only reflect changes in the property (attribute) in widget to target.targetProp
* at.both - Reflect changes in each other (Default)

The basic usage of direction function is in below form, where change in target.targetProp will be reflected to value in TextBox, but not in the opposite direction:

.. html ::

  <script type="dojo/require">at: "dojox/mvc/at"</script>
  <input data-dojo-type="dijit/form/TextBox" 
   data-dojo-props="value: at(target, 'targetProp').direction(at.from)">

See :ref:`dojox/mvc/sync:Data binding direction <dojox/mvc/sync#data-binding-direction>` for more details.

--------------
Data converter
--------------

at function used with widget allows target.targetProp and property (attribute) in widget to have different format as they are synchronized, for example, target.targetProp to have Number 2 and property (attribute) in widget to have String "2". It's done via transform function of at handle, in below form:

.. html ::

  <script type="dojo/require">at: "dojox/mvc/at"</script>
  <input data-dojo-type="dijit/form/TextBox" 
   data-dojo-props="value: at(target, 'targetProp').transform({
                      format: function(value){
                        return '' + value;
                      },
                      parse: function(value){
                        return value - 0;
                      }
                    })">

See :ref:`dojox/mvc/sync:Data converter <dojox/mvc/sync#data-converter>` for more details.

---------------------
Relative data binding
---------------------

When “rel:propInParent” format (propInParent can be omitted here) is specified in the first argument of at function, it goes up DOM hierarchy to find a widget meeting the following criteria: The property in widget pointed by widget[widget._relTargetProp] (or widget.target as the default) exists, or such property is defined in the widget.
Then widget[widget._relTargetProp || “target”].propInParent (or simply widget[widget._relTargetProp || “target”] if propInParent is omitted) will be used as data binding target, which the property in widget specified in data binding syntax will be in sync with. When binding target changes, data binding will be reestablished with the newer target.