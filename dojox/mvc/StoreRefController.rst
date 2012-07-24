.. _dojox/mvc/EditModelRefController:

================================
dojox/mvc/EditModelRefController
================================

:Authors: Akira Sudoh, Ed Chatelain
:Developers: Akira Sudoh, Ed Chatelain
:since: V1.8

.. contents ::
  :depth: 2

``dojox/mvc/EditModelRefController`` is an inheritance of :ref:`dojox/mvc/ModelRefController <dojox/mvc/ModelRefController>`, which keeps a copy (an attribute named by ``this._refOriginalModelProp``, default ``originalModel``) of given data model (an attribute named by ``this._refSourceModelProp``, default ``sourceModel``) so that it can manage the data model of before/after the edit.
It has two modes:

* Directly reflect the edits to sourceModel (``this.holdModelUntilCommit=false``)
* Don't reflect the edits to sourceModel, until ``commit()`` is called (``this.holdModelUntilCommit=true``)

For the 1st case, :ref:`dojo/Stateful <dojo/Stateful>` ``get()``/``set()``/``watch()`` interfaces will work with ``sourceModel``.
For the 2nd case, :ref:`dojo/Stateful <dojo/Stateful>` ``get()``/``set()``/``watch()`` interfaces will work with a copy of ``sourceModel``, and ``sourceModel`` will be replaced with such copy when ``commit()`` is called.

=====
Usage
=====

In below example, the controller with ``ctrlSource`` ID specifies holding changes until ``commit()`` is called (by setting ``true`` to ``holdModelUntilCommit``). As the change in the second check box is committed two seconds later from the change, the first check box is checked at then (when the change is committed).

.. code-example::
  :djConfig: parseOnLoad: true, async: true, mvc: {debugBindings: true}
  :version: local
  :toolbar: versions, themes
  :width: 320
  :height: 60

  .. js ::

    require([
        "dojo/dom", "dojo/when", "dojo/parser", "dijit/registry", "dojo/domReady!"
    ], function(ddom, when, parser, registry){
        when(parser.parse(), function(){
            setTimeout(function(){
                ddom.byId("checkEdit").click();
                setTimeout(function(){
                    registry.byId("ctrlEdit").commit();
                }, 2000);
            }, 2000);
        });
    });

  .. html ::

    <script type="dojo/require">at: "dojox/mvc/at"</script>
    <span data-dojo-id="model"
     data-dojo-type="dojo/Stateful"
     data-dojo-props="value: false"></span>
    <span id="ctrlSource"
     data-dojo-type="dojox/mvc/ModelRefController"
     data-dojo-props="model: model"></span>
    <span id="ctrlEdit"
     data-dojo-type="dojox/mvc/EditModelRefController"
     data-dojo-props="sourceModel: at('widget:ctrlSource', 'model'), holdModelUntilCommit: true"></span>
    Source:
    <input id="checkSource" type="checkbox"
     data-dojo-type="dijit/form/CheckBox"
     data-dojo-props="checked: at('widget:ctrlSource', 'value')">
    Edit:
    <input id="checkEdit" type="checkbox"
     data-dojo-type="dijit/form/CheckBox"
     data-dojo-props="checked: at('widget:ctrlEdit', 'value')">
