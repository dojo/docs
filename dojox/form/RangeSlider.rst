#format dojo_rst

dojox.form.RangeSlider
======================

:Status: Draft
:Version: 1.0
:Authors: Kitson P. Kelly
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

The RangeSlider is a descendant of **dijit.form.Slider** that allows a selection of a range of values.

============
Introduction
============

The RangeSlider differs from the **dijit.form.Slider** by providing two handles that allow you to select a range of values across the scale.


=====
Usage
=====

The RangeSlider is used in the same fashion as most dijit Form Widgets.

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   dojo.require("dojox.form.RangeSlider");
   var rangeSlider = new dojox.form.HorizontalRangeSlider({
   },"myRangeSlider");
 </script>

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

========
Examples
========

Programmatic example
--------------------
.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dojox.form.RangeSlider");

      dojo.addOnLoad(function(){

        var rangeSlider = new dojox.form.HorizontalRangeSlider({
          name: "rangeSlider",
          value: [-5,5],
          minimum: -10,
          maximum: 10,
          intermediateChanges: true,
          style: "width:300px;",
          onChange: function(value){
            dojo.byId("sliderValue").value = value;
          }
        }, "rangeSlider");
      });
    </script>

  .. cv:: html

    <div id="rangeSlider"></div>
    <p><input type="text" id="sliderValue" /></p>


Declarative example
-------------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dojox.form.RangeSlider");
    </script>

  .. cv:: html

    <div id="horizontalSlider" dojoType="dijit.form.HorizontalSlider"
        value="-4,6" minimum="-10" maximum="10" discreteValues="11"
        intermediateChanges="true"
        showButtons="false" style="width:400px;">   
    </div>



========
See also
========

* TODO: links to other related articles
