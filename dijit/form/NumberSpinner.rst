.. _dijit/form/NumberSpinner:

========================
dijit.form.NumberSpinner
========================

:Authors: Becky Gibson, Bill Keese, Nikolai Onken, Craig Riecke
:Developers: ?-
:since: V?

.. contents ::
    :depth: 2

The NumberSpinner is similar to :ref:`dijit.form.NumberTextBox <dijit/form/NumberTextBox>`, but makes integer entry easier when small adjustments are required.


Usage
=====

* The down and up arrow buttons "spin" the number up and down.
* Furthermore, when you hold down the buttons, the spinning accelerates to make coarser adjustments easier.


Examples
========

The Basic Version
-----------------

This number spinner starts at 1000, and holds a number from 9 to 1550.
Each up or down button click adjusts the number by 10.
Note here the constraints attribute.
You have all the options available in the :ref:`Dojo constraint language <quickstart/numbersDates>`, shared by :ref:`dijit.form.ValidationTextBox <dijit/form/ValidationTextBox>` and other widgets.

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/form/NumberSpinner"]);

  .. html ::

    <input data-dojo-type="dijit/form/NumberSpinner"
        id="integerspinner2"
        value="1000"
        data-dojo-props="smallDelta:10, constraints:{min:9,max:1550,places:0}"
        name="someNumber"
    >


Sizing the Box
--------------

The default NumberSpinner looks a bit large for numbers 9-1550.
You can set the size of the enclosing box by setting the style attribute, like most Dijit form controls can.
Here, we'll use a programmatically-created NumberSpinner:

.. code-example ::
  :djConfig: async: true

  .. js ::

    require(["dijit/form/NumberSpinner", "dojo/domReady!"], function(NumberSpinner){
        var mySpinner = new NumberSpinner({
            value: 1000,
            smallDelta: 10,
            constraints: { min:9, max:1550, places:0 },
            id: "integerspinner3",
            style: "width:100px"
        }, "spinnerId");
        mySpinner.startup();
    });

  .. html ::

    <div id="spinnerId"></div>

**Note:** Safari 3 appears to render the NumberSpinner as 177px, no matter what. You can workaround this by surrounding the NumberSpinner with a <div> of size 100px.

Change Events
-------------

Like regular <input> boxes, the onChange event fires only when the box loses focus.
Just clicking on an up or down button changes the value, but the changes doesn't "stick" until you leave the box.

If you'd like onChange to fire after every button click, set the attribute intermediateChanges, as in this example:

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/form/NumberSpinner"]);

    var cutoffPoints = [
        {over:35, color:"darkred"},
        {over:30, color:"lightred"},
        {over:25, color:"green"},
        {over:15, color:"lightblue"},
        {over:-1, color:"darkblue"}
    ];

  .. html ::

    <label for="temperatureCelsius">Temperature in Celsius:</label>
    <div data-dojo-type="dijit/form/NumberSpinner"
        data-dojo-props="intermediateChanges:true, constraints:{min:0,max:40}, value:15"
        id="temperatureCelsius">
        <script type="dojo/on" data-dojo-event="change">
            // dojo.filter() applies a boolean function to each array element
            // and returns an array of matches.  In our case, the over:
            // attributes are sorted downwards, so the first return element
            // will be the lowest
            var self=this;  // So widget is referencable in function
            require(["dojo/_base/array", "dojo/dom-style", "dojo/dom"], function(array, domStyle, dom){
                var tempColor = array.filter(cutoffPoints, function(temp){
                    return self.getValue() > temp.over;
                })[0].color;
                // Lastly set the background color of the indicator box
                domStyle.set(dom.byId("tempBox"), "backgroundColor", tempColor);
            });
        </script>
    </div>
    <span id="tempBox" >   </span>

Accessibility
=============

Keyboard
--------

+-------------------------------------------------------+----------------------------------------------+
| **Action**                                            | **Key**                                      |
+-------------------------------------------------------+----------------------------------------------+
| Interact with the number spinner                      | The textbox for the number spinner is in the |
|                                                       | tab order of the page                        |
+-------------------------------------------------------+----------------------------------------------+
| Increase the number spinner value by single increment | With focus in the number spinner textbox     |
|                                                       | press the up arrow key                       |
+-------------------------------------------------------+----------------------------------------------+
| Decrease the number spinner value by single increment | With focus in the number spinner textbox     |
|                                                       | press the down arrow key                     |
+-------------------------------------------------------+----------------------------------------------+
| Increase number spinner value by the large increment  | With focus in the number spinner textbox     |
| specified by largeDelta parameter (default = 10)      | press page up key                            |
+-------------------------------------------------------+----------------------------------------------+
| Decrease number spinner value by the large increment  | With focus in the number spinner textbox     |
| specified by largeDelta parameter (default = 10)      | press page down key                          |
+-------------------------------------------------------+----------------------------------------------+
| Set the minimum value (min parameter must have been   | With focus in the number spinner textbox     |
| provided)                                             | press the Home key                           |
+-------------------------------------------------------+----------------------------------------------+
| Set the maximum value (max parameter must have been   | With focus in the number spinner textbox     |
| provided)                                             | press the End key                            |
+-------------------------------------------------------+----------------------------------------------+

Note: Page up, page down, Home and End keys were implemented as of Dojo Release 1.2.
