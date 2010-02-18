#format dojo_rst

dijit.form.Slider
=================

:Authors: Becky Gibson, Doug Hays, Nikolai Onken
:Developers: ?-
:Available: since V?


.. contents::
    :depth: 2

============
Introduction
============

A **dijit.form.HorizontalSlider** or **dijit.form.VerticalSlider** is a scale with a handle you can drag left/right or up/down to select a value. 

=====
Usage
=====


.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
  dojo.require("dijit.form.Slider");
  var slider = new dijit.form.HorizontalSlider({
  }, "mySlider");
 </script>

Here are some of the constructor parameters:

==============  ====================  =============================================================================
Parameter       Type                       Description
==============  ====================  =============================================================================
value           integer               Initial value of the slider (``0``)
showButtons     boolean               Whether to show or not buttons at each end of the slider (``true``)
minimum         integer               Minimum value of the slider (``0``)
maximum         integer               Maximum value of the slider (``100``)
discreteValues  integer               Number of "steps" in the slider. For exemple if ``discreteValues`` is ``3``, you'll have 3 steps: ``minimum``, ``maximum`` and a value in the middle
==============  ====================  =============================================================================

========
Examples
========

Programmatic example of a horizontal slider
-------------------------------------------

One way you could show the user the value of your Slider is to create a textbox that the Slider fills when the user moves the Slider. The following code fills in a simple textbox called horizontalSliderValue.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.Slider");
      dojo.require("dijit.form.TextBox"); // this we only include to make the textinput look prettier

      dojo.addOnLoad(function(){

        var slider = new dijit.form.HorizontalSlider({
          name: "slider",
          value: 5,
          minimum: -10,
          maximum: 10,
          intermediateChanges: true,
          style: "width:300px;",
          onChange: function(value){
            dojo.byId("sliderValue").value = value;
          }
        }, "slider");
      });
    </script>

  .. cv:: html

    <div id="slider"></div>
    <p><input type="text" id="sliderValue" dojoType="dijit.form.TextBox" /></p>


Programmatic example of a vertical slider
-----------------------------------------

The similar example but with a vertical slider and a simple rule (tick marks) created programmatically.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.Slider");
      dojo.require("dijit.form.TextBox"); // this we only include to make the textinput look prettier

      dojo.addOnLoad(function(){
        var vertical = dojo.byId("vertical");
        var rulesNode = document.createElement('div');
        vertical.appendChild(rulesNode);
        var sliderRules = new dijit.form.VerticalRule({
            count:11,
            style:"width:5px;"
        }, rulesNode);
        var slider = new dijit.form.VerticalSlider({
          name: "vertical",
          value: 6,
          minimum: -10,
          maximum: 10,
          intermediateChanges: true,
          style: "height:300px;"
        }, vertical);
      });
    </script>

  .. cv:: html

    <div id="vertical"></div>


Declarative markup example with discrete values
-----------------------------------------------

And here we create a slider declaratively. Note that we set the value of the "discreteValues" attribute to 11, meaning that the slider will have 11 focus points.  This example also shows the end buttons removed.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.Slider");
    </script>

  .. cv:: html

    <div id="horizontalSlider" dojoType="dijit.form.HorizontalSlider"
        value="6" minimum="-10" maximum="10" discreteValues="11"
        intermediateChanges="true"
        showButtons="false" style="width:400px;">   
      <ol dojoType="dijit.form.HorizontalRuleLabels" container="topDecoration"
          style="height:1.5em;font-size:75%;color:gray;">
        <li> </li>
        <li>20%</li>
        <li>40%</li>
        <li>60%</li>
        <li>80%</li>
        <li> </li>
      </ol>
      <div dojoType="dijit.form.HorizontalRule" container="bottomDecoration"
        count=11 style="height:5px;"></div>
      <ol dojoType="dijit.form.HorizontalRuleLabels" container="bottomDecoration"
          style="height:1em;font-size:75%;color:gray;">
        <li>0%</li>
        <li>50%</li>
        <li>100%</li>
      </ol>
    </div>


=============
Accessibility
=============

Keyboard
--------

+----------------------------------------------+-----------------------------------------------------------+
| **Action**                                   | **Key**                                                   |
+----------------------------------------------+-----------------------------------------------------------+
| Interact with the slider                     | The slider handle is in the tab order of the page.        | 
|                                              | Press tab key to set focus to the slider handle.          |
+----------------------------------------------+-----------------------------------------------------------+
| Increase slider value by single increment    | With focus on slider handle press right or up arrow.      |
+----------------------------------------------+-----------------------------------------------------------+
| Decrease slider value by single increment    | With focus on slider handle press left or down arrow.     |
+----------------------------------------------+-----------------------------------------------------------+
| Increase slider value by multiple increments | With focus on slider handle press PageUp. The amount of   |
|                                              | increment is determined by the pageIncrement parameter.   |
+----------------------------------------------+-----------------------------------------------------------+
| Decrease slider value by multiple increments | With focus on slider handle press PageDown. The amount    |
|                                              | of decrement is determined by the pageIncrement parameter.|
+----------------------------------------------+-----------------------------------------------------------+
| Set slider to minimum value                  | With focus on slider handle press Home.                   |
+----------------------------------------------+-----------------------------------------------------------+
| Set slider to mmaximum value                 | With focus on slider handle press End.                    |
+----------------------------------------------+-----------------------------------------------------------+

Known Issues
------------

Currently the text labels of a slider are not spoken by screen readers. Firefox 3 provides the infrastructure necessary for spoken text labels so the slider will be updated to support them in a future Dojo release. Developers should take care when using text labels since a screen reader user will hear only a numeric interpretation.
