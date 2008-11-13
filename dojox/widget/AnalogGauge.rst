#format dojo_rst

dojox.widget.AnalogGauge
========================

:Status: Contributed, Draft
:Version: 1.3
:Author: Benjamin Schell
:Available: since V1.3

.. contents::
  :depth: 2

========
Overview
========
The analog gauge widget provides a way to display data on a circular, or semi-circular gauge, such as a speedometer or a pressure gauge, for displaying a finite data value at a point in time.  This UI paradigm has been around for a very long time and is quite common in most devices that people are familiar with, such as the dashboard of an automobile.  

The analog gauge widget is entirely built upon the dojox.gfx package and as such, works extremely well across many browsers.  The way to conceptually understand how the analog gauge widget works is that it is effectively a layering of a background shape, a circle or semi-circle, with a series of indicators for denoting values on the gauge face.  An optional capability of the analog gauge is that the values for each indicator can be displayed beneath the gauge (and are by default).  This makes the gauge accessible-compliant.  

Examples
========

====================================================================================
Example 1:  A partial circle gauge with two indicators and a set of gradient ranges.
====================================================================================

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.widget.AnalogGauge");
    </script>

  .. cv :: html 

    <div dojoType="dojox.widget.AnalogGauge"
	id="declarativeGauge"
	width="350"
	height="275"
	cx="175"
	cy="175"
	radius="135"
	startAngle="-120"
	endAngle="120"
	useRangeStyles="0"
	hideValues="true"
	majorTicks="{length: 5, offset: 135, interval: 5}">
      <div dojoType="dojox.widget.Gradient"
	id="gradient"
	type="linear"
	x1="0"
	x2="0"
	y2="0">
        <div dojoType="dojox.widget.GradientColor"
          id="gradientColor0"
  	  offset="0"
          color="#ECECEC">
        </div>
        <div dojoType="dojox.widget.GradientColor"
          id="gradientColor1"
          offset="1"
          color="white">
        </div>
      </div>
      <div dojoType="dojox.widget.Range"
        low="0"
	high="10"
	hover="0 - 10">
        <div dojoType="dojox.widget.Gradient" type="linear">
          <div dojoType="dojox.widget.GradientColor"
            offset="0"
            color="#606060">
          </div>
          <div dojoType="dojox.widget.GradientColor"
            offset="1"
            color="#707070">
          </div>
        </div>
      </div>
      <div dojoType="dojox.widget.Range"
        id="range1"
        low="10"
        high="20"
        hover="10 - 20">
        <div dojoType="dojox.widget.Gradient"type="linear">
          <div dojoType="dojox.widget.GradientColor"
            offset="0"
            color="#707070">
          </div>
          <div dojoType="dojox.widget.GradientColor" 
            offset="1"
            color="#808080">
          </div>
        </div>
      </div>
      <div  dojoType="dojox.widget.Range"
        id="range2"
        low="20"
        high="30"
        hover="20 - 30">
        <div dojoType="dojox.widget.Gradient" type="linear">
          <div dojoType="dojox.widget.GradientColor"
            offset="0"
            color="#808080">
          </div>
          <div dojoType="dojox.widget.GradientColor"
            offset="1"
            color="#909090">
          </div>
        </div>
      </div>
      <div dojoType="dojox.widget.Range"
        id="range3"
        low="30"
        high="40"
        hover="30 - 40">
        <div dojoType="dojox.widget.Gradient" type="linear">
          <div dojoType="dojox.widget.GradientColor"
            offset="0"
            color="#909090">
          </div>
          <div dojoType="dojox.widget.GradientColor"
            offset="1"
            color="#A0A0A0">
          </div>
        </div>
      </div>
      <div dojoType="dojox.widget.Range"
         id="range4"
         low="40"
         high="50"
         hover="40 - 50">
         <div dojoType="dojox.widget.Gradient" type="linear">
           <div dojoType="dojox.widget.GradientColor"
             offset="0"
             color="#A0A0A0">
           </div>
           <div dojoType="dojox.widget.GradientColor"
             offset="1"
             color="#B0B0B0">
           </div>
        </div>
      </div>
      <div dojoType="dojox.widget.Range"
        id="range5"
        low="50"
        high="60"
        hover="50 - 60">
        <div dojoType="dojox.widget.Gradient" type="linear">
          <div dojoType="dojox.widget.GradientColor"
            offset="0"
            color="#B0B0B0">
          </div>
          <div dojoType="dojox.widget.GradientColor"
            offset="1"
            color="#C0C0C0">
          </div>
        </div>
      </div>
      <div dojoType="dojox.widget.Range" 
        id="range6"
        low="60"
        high="70"
        hover="60 - 70">
        <div dojoType="dojox.widget.Gradient" type="linear">
          <div dojoType="dojox.widget.GradientColor"
            offset="0"
            color="#C0C0C0">
          </div>
          <div dojoType="dojox.widget.GradientColor"
            offset="1"
            color="#D0D0D0">
          </div>
        </div>
      </div>
      <div dojoType="dojox.widget.Range"
        id="range7"
        low="70"
        high="75"
        hover="70 - 75">
        <div dojoType="dojox.widget.Gradient" type="linear">
          <div dojoType="dojox.widget.GradientColor"
            offset="0"
            color="#D0D0D0">
          </div>
          <div dojoType="dojox.widget.GradientColor"
            offset="1"
            color="#E0E0E0">
          </div>
        </div>
      </div>
      <div dojoType="dojox.widget.AnalogLineIndicator"
        id="target"
        value="52"
        color="#D00000"
        width="3"
        hover="Target: 52"
        title="Target">
      </div>
      <div dojoType="dojox.widget.ArrowIndicator"
        id="value"
        value="17"
        type="arrow"
        length="135"
        width="3"
        hover="Value: 17"
        title="Value">
      </div>
    </div>


====================================================================
Example 2:  A half circle gauge with two indicators overlay graphic.
====================================================================

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.widget.AnalogGauge");
    </script>

  .. cv :: html 

    <div dojoType="dojox.widget.AnalogGauge"
      width="350"
      height="225"
      cx="175"
      cy="175"
      radius="125"
      startAngle="-90"
      endAngle="90"
      useRangeStyles="0"
      hideValues="true"
      majorTicks="{length: 5, offset: 125, interval: 5}"
      image="{url:'dojox/widget/tests/images/gaugeOverlay.png', width: 280, height: 155,x: 35, y: 38,overlay: true}">
      <div dojoType="dojox.widget.Gradient"
	type="linear"
	x1="0"
	x2="0"
	y2="0">
        <div dojoType="dojox.widget.GradientColor"
  	  offset="0"
          color="#ECECEC">
        </div>
        <div dojoType="dojox.widget.GradientColor"
          offset="1"
          color="white">
        </div>
      </div>
      <div dojoType="dojox.widget.Range"
        low="0"
	high="10"
	hover="0 - 10">
        <div dojoType="dojox.widget.Gradient" type="linear">
          <div dojoType="dojox.widget.GradientColor"
            offset="0"
            color="#606060">
          </div>
          <div dojoType="dojox.widget.GradientColor"
            offset="1"
            color="#707070">
          </div>
        </div>
      </div>
      <div dojoType="dojox.widget.Range"
        low="10"
        high="20"
        hover="10 - 20">
        <div dojoType="dojox.widget.Gradient"type="linear">
          <div dojoType="dojox.widget.GradientColor"
            offset="0"
            color="#707070">
          </div>
          <div dojoType="dojox.widget.GradientColor" 
            offset="1"
            color="#808080">
          </div>
        </div>
      </div>
      <div  dojoType="dojox.widget.Range"
        low="20"
        high="30"
        hover="20 - 30">
        <div dojoType="dojox.widget.Gradient" type="linear">
          <div dojoType="dojox.widget.GradientColor"
            offset="0"
            color="#808080">
          </div>
          <div dojoType="dojox.widget.GradientColor"
            offset="1"
            color="#909090">
          </div>
        </div>
      </div>
      <div dojoType="dojox.widget.Range"
        low="30"
        high="40"
        hover="30 - 40">
        <div dojoType="dojox.widget.Gradient" type="linear">
          <div dojoType="dojox.widget.GradientColor"
            offset="0"
            color="#909090">
          </div>
          <div dojoType="dojox.widget.GradientColor"
            offset="1"
            color="#A0A0A0">
          </div>
        </div>
      </div>
      <div dojoType="dojox.widget.Range"
         low="40"
         high="50"
         hover="40 - 50">
         <div dojoType="dojox.widget.Gradient" type="linear">
           <div dojoType="dojox.widget.GradientColor"
             offset="0"
             color="#A0A0A0">
           </div>
           <div dojoType="dojox.widget.GradientColor"
             offset="1"
             color="#B0B0B0">
           </div>
        </div>
      </div>
      <div dojoType="dojox.widget.Range"
        low="50"
        high="60"
        hover="50 - 60">
        <div dojoType="dojox.widget.Gradient" type="linear">
          <div dojoType="dojox.widget.GradientColor"
            offset="0"
            color="#B0B0B0">
          </div>
          <div dojoType="dojox.widget.GradientColor"
            offset="1"
            color="#C0C0C0">
          </div>
        </div>
      </div>
      <div dojoType="dojox.widget.Range" 
        low="60"
        high="70"
        hover="60 - 70">
        <div dojoType="dojox.widget.Gradient" type="linear">
          <div dojoType="dojox.widget.GradientColor"
            offset="0"
            color="#C0C0C0">
          </div>
          <div dojoType="dojox.widget.GradientColor"
            offset="1"
            color="#D0D0D0">
          </div>
        </div>
      </div>
      <div dojoType="dojox.widget.Range"
        low="70"
        high="75"
        hover="70 - 75">
        <div dojoType="dojox.widget.Gradient" type="linear">
          <div dojoType="dojox.widget.GradientColor"
            offset="0"
            color="#D0D0D0">
          </div>
          <div dojoType="dojox.widget.GradientColor"
            offset="1"
            color="#E0E0E0">
          </div>
        </div>
      </div>
      <div dojoType="dojox.widget.AnalogLineIndicator"
        value="52"
        color="#D00000"
        width="3"
        hover="Target: 52"
        title="Target">
      </div>
      <div dojoType="dojox.widget.ArrowIndicator"
        value="17"
        type="arrow"
        length="125"
        width="3"
        hover="Value: 17"
        title="Value">
      </div>
    </div>
