.. _dijit/_OnDijitClickMixin:

========================
dijit._OnDijitClickMixin
========================

:Authors: Bill Keese
:Project owner: Bill Keese
:since: V1.7

.. contents ::
   :depth: 2


Introduction
============

`dijit._OnDijitClickMixin <http://dojotoolkit.org/api/dijit/_OnDijitClickMixin>`_ is a useful mixin
for widgets that need to be accessible, that require nodes to be "clicked" via the keyboard
in addition to via the mouse(or a touch event).

For example, in the code below the user can tab to the <span> node and press either the ENTER or SPACE key,
and it will have the same effect as clicking the span with the mouse:

.. code-example::
  :djConfig: parseOnLoad: false
  :width: 400
  :height: 250
  :toolbar: versions, dir

  .. js ::

        dojo.require("dijit._WidgetBase");
        dojo.require("dijit._TemplatedMixin");
        dojo.require("dijit._OnDijitClickMixin");
        dojo.require("dojo.parser");

        dojo.ready(function(){
            var MyButton = dojo.declare([dijit._WidgetBase, dijit._TemplatedMixin, dijit._OnDijitClickMixin], {
                templateString: "<span tabIndex=0 data-dojo-attach-event='ondijitclick: onClick'>click me</span>",
                onClick: function(evt){
                        alert("Awesome!!");
                }
            });
            new MyButton({}, dojo.byId("myButton"));
        });

  .. html ::

    <div id="myButton">this will be replaced by the widget</div>
