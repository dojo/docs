.. _dijit/form/HorizontalRule:

=========================
dijit/form/HorizontalRule
=========================

.. contents ::
    :depth: 3

This widget is used primarily for creating Hash marks for the :ref:`dijit/form/HorizontalSlider <dijit/form/HorizontalSlider>` widget.
The rule can be displayed either above or below the slider by specifying the value of the container as
"topDecoration" or "bottomDecoration" respectively.
The number of hash marks to be displayed is to be specified through the 'count' attribute.

For examples of using this widget along with the HorizontalSlider refer :ref:`dijit/form/HorizontalSlider <dijit/form/HorizontalSlider>` .


Examples
========

Standalone Ruler
----------------

.. code-example ::

  .. js ::

    require(["dojo/parser", "dijit/form/HorizontalRule", "dijit/form/HorizontalRuleLabels"]);

  .. html ::

    <div style="width:2in;border-top:1px solid black;">
        <div data-dojo-type="dijit/form/HorizontalRule" data-dojo-props="count:17" style="height:.4em;"></div>
        <div data-dojo-type="dijit/form/HorizontalRule" data-dojo-props="count:9" style="height:.4em;"></div>
        <div data-dojo-type="dijit/form/HorizontalRule" data-dojo-props="count:5" style="height:.4em;"></div>
        <div data-dojo-type="dijit/form/HorizontalRule" data-dojo-props="count:3" style="height:.4em;"></div>
        <ol data-dojo-type="dijit/form/HorizontalRuleLabels" data-dojo-props="labelStyle:'font-style:monospace;font-size:.7em;margin:-1em 0px 0px -.35em;'">
           <li>0</li>
           <li>1</li>
           <li>2</li>
        </ol>
    </div>


See Also
========

* :ref:`dijit/form/HorizontalSlider <dijit/form/HorizontalSlider>`.
