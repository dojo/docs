.. _dojox/form/RangeSlider:

======================
dojox.form.RangeSlider
======================

:Authors: ?--
:Project owner: ?--
:since: V?

.. contents ::
   :depth: 2

The RangeSlider is a descendant of :ref:`dijit/form/HorizontalSlider <dijit/form/HorizontalSlider>` and :ref:`dijit/form/VerticalSlider <dijit/form/VerticalSlider>` that allows a selection of a range of values.

Introduction
============

The RangeSlider differs from the :ref:`dijit.form.Slider <dijit/form/Slider>` by providing two handles that allow you to select a range of values across the scale.  There is the **dojox.form.HorizontalRangeSlider** and the **dojox.form.VerticalRangeSlider** which provide a horizontal and vertical version respectively.


Usage
=====

The RangeSlider is used in the same fashion as most dijit Form Widgets.

.. js ::

   dojo.require("dojox.form.RangeSlider");
   var rangeSlider = new dojox.form.HorizontalRangeSlider({
   }, "myRangeSlider");

Here are some of the constructor parameters:

===================  ====================  =============================================================================
Parameter            Type                  Description
===================  ====================  =============================================================================
value                array                 Initial values of the slider (``[0,100]``)
showButtons          boolean               Whether to show or not buttons at each end of the slider (``true``)
minimum              integer               Minimum value of the slider (``0``)
maximum              integer               Maximum value of the slider (``100``)
intermediateChanges  boolean               If fractional parts between steps are reported (``false``)
discreteValues       integer               Number of "steps" in the slider. For example if ``discreteValues`` is ``3``, you'll have 3 steps: ``minimum``, ``maximum`` and a value in the middle
===================  ====================  =============================================================================

Examples
========

Programmatic horizontal example
-------------------------------
.. code-example ::

  .. js ::

      dojo.require("dojox.form.RangeSlider");

      dojo.ready(function(){

        var rangeSlider = new dojox.form.HorizontalRangeSlider({
          name: "rangeSlider",
          value: [2,6],
          minimum: -10,
          maximum: 10,
          intermediateChanges: true,
          style: "width:300px;",
          onChange: function(value){
            dojo.byId("sliderValue").value = value;
          }
        }, "rangeSlider");
      });

  .. html ::

    <div id="rangeSlider"></div>
    <p><input type="text" id="sliderValue" /></p>

  .. css ::

      @import url({{baseUrl}}dojox/form/resources/RangeSlider.css);

Programmatic vertical example with rulers
-----------------------------------------
.. code-example ::

  .. js ::

      dojo.require("dojox.form.RangeSlider");
      dojo.require("dijit.form.VerticalRule");

      dojo.ready(function(){
        var vertical = dojo.byId("vertical");
        var rulesNode = document.createElement("div");
        vertical.appendChild(rulesNode);
        var sliderRules = new dijit.form.VerticalRule({
            count:11,
            style:"width:5px;"
        }, rulesNode);
        var slider = new dojox.form.VerticalRangeSlider({
          name: "vertical",
          value: [2,6],
          minimum: -10,
          maximum: 10,
          intermediateChanges: true,
          style: "height:300px;"
        }, vertical);
      });

  .. html ::

    <div id="vertical"></div>

  .. css ::

      @import url({{baseUrl}}dojox/form/resources/RangeSlider.css);

Declarative horizontal example
------------------------------

.. code-example ::

  .. js ::

      dojo.require("dojox.form.RangeSlider");

  .. html ::

    <div id="rangeSlider" data-dojo-type="dojox.form.HorizontalRangeSlider"
        data-dojo-props="value:[2,6], minimum:-10, maximum:10, intermediateChanges:true,
        showButtons:false" style="width:300px;">
        <script type="dojo/method" data-dojo-event="onChange" data-dojo-args="value">
            dojo.byId("sliderValue").value = value;
        </script>
    </div>
    <p><input type="text" id="sliderValue" /></p>

  .. css ::

      @import url({{baseUrl}}dojox/form/resources/RangeSlider.css);

**NOTE** In declarative mode, the value of the attribute ``value`` is specified as a comma delimited string and not as an array (e.g. ``value="2,6"`` and not ``value="[2,6]"``.

Accessibility
=============

TODO: provide accessibility information

See also
========

* See :ref:`dijit/form/HorizontalSlider <dijit/form/HorizontalSlider>` for more information.
* See :ref:`dijit/form/VerticalSlider <dijit/form/VerticalSlider>` for more information.
