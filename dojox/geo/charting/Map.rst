#format dojo_rst


dojox.geo.charting.Map
======================

:Status: Draft
:Version: Experimental
:Project owner: Dean Williams
:Author: Qi Ruan
:Available: since V.1.5

.. contents::
   :depth: 2

Overview
--------

A dojo widget to render map information map "shapefile" data. 

.. code-block :: javascript
 :linenos:
    
 dojo.require("dojox.geo.charting.Map");

 dojo.addOnLoad(function(){
	var USStates = new dojox.geo.charting.Map("USStates", "../resources/data/USStates.json");
	USStates.setMarkerData("../resources/markers/USStates.json");
 });
 

.. code-block :: html
 :linenos:
 
 <h1>Simple Maps,support zoom in and zoom out.</h1>
 <div class="mapContainer" style="display:block;" id="USStates"></div>









fig 1.

.. cv-compound::
  :type: inline
  :height: 430
  :version: 1.4

  .. cv:: html

    <iframe width='100%'  height='330px' src="http://dleadt.torolab.ibm.com/dl/dojo_1_5/dojox/geo/charting/tests/test1.html"></iframe>


   
