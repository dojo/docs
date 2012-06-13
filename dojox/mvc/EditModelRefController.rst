.. _dojox/mvc/EditModelRefController:

================================
dojox/mvc/EditModelRefController
================================

:Authors: Akira Sudoh, Ed Chatelain
:Developers: Akira Sudoh, Ed Chatelain
:since: V1.8

.. contents ::
  :depth: 2

dojox/mvc/EditModelRefController is an inheritance of dojox/mvc/ModelRefController, which keeps a copy (an attribute named by this._refOriginalModelProp, default "originalModel") of given data model (an attribute named by this._refSourceModelProp, default "sourceModel") so that it can manage the data model of before/after the edit.
It has two modes:

* Directly reflect the edits to sourceModel (this.holdModelUntilCommit=false)
* Don't reflect the edits to sourceModel, until commit() is called (this.holdModelUntilCommit=true)

For the 1st case, dojo.Stateful get()/set()/watch() interfaces will work with sourceModel.
For the 2nd case, dojo.Stateful get()/set()/watch() interfaces will work with a copy of sourceModel, and sourceModel will be replaced with such copy when commit() is called.

=====
Usage
=====

In below example, the controller with "ctrlSource" ID specifies holding changes until commit() is called (by setting true to holdModelUntilCommit). As the change in the second check box is committed two seconds later from the change, the first check box is checked at then (when the change is committed).

.. html ::

  <html>
      <head>
          <script src="/path/to/dojo-toolkit/dojo/dojo.js" type="text/javascript" data-dojo-config="parseOnLoad: 0"></script>
          <script type="text/javascript">
              require([
                  "dojo/dom", "dojo/parser", "dojo/Stateful", "dijit/registry",
                  "dijit/form/CheckBox", "dojox/mvc/ModelRefController", "dojox/mvc/EditModelRefController", "dojo/domReady!"
              ], function(ddom, parser, Stateful, registry){
                  model = new Stateful({value: false});
                  setTimeout(function(){
                      ddom.byId("checkEdit").click();
                      setTimeout(function(){
                          registry.byId("ctrlEdit").commit();
                      }, 2000);
                  }, 2000);
                  parser.parse();
              });
          </script>
      </head>
      <body>
          <script type="dojo/require">at: "dojox/mvc/at"</script>
          <span id="ctrlSource" data-dojo-type="dojox/mvc/ModelRefController" data-dojo-props="model: model"></span>
          <span id="ctrlEdit" data-dojo-type="dojox/mvc/EditModelRefController"
           data-dojo-props="sourceModel: at('widget:ctrlSource', 'model'), holdModelUntilCommit: true"></span>
          Source:
          <input id="checkSource" type="checkbox" data-dojo-type="dijit/form/CheckBox"
           data-dojo-props="checked: at('widget:ctrlSource', 'value')">
          Edit:
          <input id="checkEdit" type="checkbox" data-dojo-type="dijit/form/CheckBox"
           data-dojo-props="checked: at('widget:ctrlEdit', 'value')">
      </body>
  </html>
