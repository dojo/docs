#format dojo_rst

dijit.form.HorizontalRule
=========================

.. contents::
    :depth: 3

:Status: Draft
:Version:
:Authors: 

This widget is used primarily for creating Hash marks for the `dijit.form.HorizontalSlider` widget. The rule can be dispalyed either above or below the slider by specifying the value of the container as "topDecoration" or "bottomDecoration" respectively. The number of hash marks to be displayed is to be specified through the 'count' attribute.

The Label widget is used for specifying labels for the `dijit.form.HorizontalSlider`. The labels can be specified through a custom defined array of String labels. To get numeric labels,the minimum and maximum attributes need to be specified.The labels can also be specified directly as children of the <li> tag.

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

See `dijit.form.HorizontalSlider <dijit/form/HorizontalSlider>`_.
