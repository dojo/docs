#format dojo_rst

dijit.form.HorizontalRule
=========================

.. contents::
    :depth: 3

:Status: 
:Version:
:Authors: 

This widget is used primarily for creating Hash marks for the `dijit.form.HorizontalSlider <dijit/form/Slider>`_ widget. The rule can be dispalyed either above or below the slider by specifying the value of the container as "topDecoration" or "bottomDecoration" respectively. The number of hash marks to be displayed is to be specified through the 'count' attribute.

For examples of using this widget along with the HorizontalSlider refer `dijit.form.HorizontalSlider <dijit/form/Slider>`_ .

Standalone Ruler
----------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
	dojo.require("dijit.form.HorizontalRule");
	dojo.require("dijit.form.HorizontalRuleLabels");
    </script>

  .. cv:: html

	<div style="width:2in;border-top:1px solid black;">
	    <div dojoType="dijit.form.HorizontalRule" count=17 style="height:.4em;"></div>
	    <div dojoType="dijit.form.HorizontalRule" count=9 style="height:.4em;"></div>
	    <div dojoType="dijit.form.HorizontalRule" count=5 style="height:.4em;"></div>
            <div dojoType="dijit.form.HorizontalRule" count=3 style="height:.4em;"></div>
	    <ol dojoType="dijit.form.HorizontalRuleLabels" labelStyle="font-style:monospace;font-size:.7em;margin:-1em 0px 0px -.35em;">
               <li>0</li>
	       <li>1</li>
	       <li>2</li>
	    </ol>
	</div>



See Also
====================

See `dijit.form.HorizontalSlider <dijit/form/Slider>`_.
