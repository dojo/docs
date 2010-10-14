#format dojo_rst

dojox.editor.plugins.AutoSave (Under Construction)
====================================================

:Authors: He Gu Yi
:Project owner: Jared Jurkiewicz
:Available: since V1.6

.. contents::
    :depth: 2

Have you ever wanted to save your editing content at intervals so that you won't lost it by accident? This plug-in is for you.

========
Features
========

Once required in and enabled, this plugin provides the following features to dijit.Editor

* Save the content immediately with one click.
* Set the save interval and save the content at intervals.

=====
Usage
=====

Basic Usage
-----------
Usage of this plugin is simple and painless. The first thing you need to do is require the editor into the page. This is done in the same spot all your dojo.require called are made, usually a head script tag. For example:

.. code-block :: html

  <script type="text/javascript">
    dojo.require("dijit.Editor");
    ...
  </script>
  ...
  <div dojoType="dijit.Editor" id="editor1">
  ...
  </div>

Then just declare the plugin and configure it as follows. Note that the location of AutoSave.css may be changed according to the actual environment.

.. code-block :: html

  <style type="text/css">
    @import "../plugins/resources/css/AutoSave.css";
    ...
  </style>
  <script type="text/javascript">
    dojo.require("dijit.Editor");
  
    dojo.require("dojox.editor.plugins.AutoSave");
    ...
  </script>
  <div dojoType="dijit.Editor" id="editor1" extraPlugins="[{name:'autosave', url:'dummySave.php', interval:5}]">
  ...
  </div>

And that's it. The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the AutoSave plugin!

Configurable Options
--------------------

========================  =================  ============  =======================  =============================================================================
Argument Name             Data Type          Optional      Default Value            Description
========================  =================  ============  =======================  =============================================================================
name                      String             False         autosave                 The name of this plugin. It should always be "autosave".
url                       String             False         <empty string>           The service url which the content of the editor is submitted to.
interval                  Number             True          5                        Specify the interval to perform the save action.
                                                                                    If it is not specified, the default value is 5 ( minutes).
========================  =================  ============  =======================  =============================================================================
