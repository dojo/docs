.. _dijit/form/VerticalRule:

=======================
dijit/form/VerticalRule
=======================

.. contents ::
    :depth: 3

This widget is used primarily for creating Hash marks for the :ref:`dijit/form/VerticalSlider <dijit/form/VerticalSlider>` widget.
The rule is currently displayed to the right of the slider, if present.
The number of hash marks to be displayed is to be specified through the 'count' attribute.

For examples of using this widget along with the VerticalSlider refer :ref:`dijit/form/VerticalSlider <dijit/form/VerticalSlider>` .

Examples
========

Standalone Ruler
----------------

.. code-example ::

  .. js ::

    require(["dojo/parser", "dijit/form/VerticalRule", "dijit/form/VerticalRuleLabels"]);

  .. html ::

    <div style="height:2in;border-left:1px solid black;">
        <div data-dojo-type="dijit/form/VerticalRule" data-dojo-props="count:17" style="width:.4em;"></div>
        <div data-dojo-type="dijit/form/VerticalRule" data-dojo-props="count:9" style="width:.4em;"></div>
        <div data-dojo-type="dijit/form/VerticalRule" data-dojo-props="count:5" style="width:.4em;"></div>
        <div data-dojo-type="dijit/form/VerticalRule" data-dojo-props="count:3" style="width:.4em;"></div>
        <ol data-dojo-type="dijit/form/VerticalRuleLabels" data-dojo-props="labelStyle:'font-style:monospace;font-size:.7em;margin:0px -1em -.35em 0px;'">
            <li>1</li>
            <li>2</li>
            <li>3</li>
        </ol>
    </div>



See Also
========

* :ref:`dijit/form/VerticalSlider <dijit/form/VerticalSlider>`
