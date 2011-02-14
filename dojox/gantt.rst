#format dojo_rst

dojox.gantt
===========

:Available: since V1.6

``dojox.gantt`` gives the capability of project management.

.. contents::
   :depth: 2

============
Introduction
============

GanttChart(dojox.gantt.GanttChart) is an integrated widget for project and resource management. It includes a set of feature as follows.

  * **Toolbar** - Providing general time line control and save/load button.
  * **Project Tree** - Listing projects and their tasks.
  * **Task Cascade View** - A task view with dependency, that can be modified visually.
  * **Resource View** - A read-only view shows people resource occupation.

=====
Usage
=====

The following step shows how to create a typical gantt chart in dojo.

Step 1: Add related CSS file and required javacript:

.. code-block :: javascript
  :linenos:

  <link type="text/css" rel="stylesheet" href="{baseUrl}/dijit/themes/claro/claro.css">
  <link type="text/css" rel="stylesheet" href="{baseUrl}/dojox/gantt/resources/gantt.css">
  ...
  <script type="text/javascript">
    dojo.require("dojox.gantt.GanttChart");
    ...
  </script>

Step 2: Declare gantt chart

.. code-block :: javascript
  :linenos:

  var ganttChart = new dojox.gantt.GanttChart({
    readOnly: false,			//optional: determine if gantt chart is editable
    dataFilePath: "gantt_defalut.json",	//optional: json data file path for load and save, default is "gantt_default.json"
    height: 400,			//optional: chart height in pixel, default is 400px
    width: 1200,			//optional: chart width in pixel, default is 600px
    withResource: true			//optional: display the resource chart or not
  }, "gantt"); 				//"gantt" is the node container id of gantt chart widget

Step 3: 
