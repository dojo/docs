#format dojo_rst

dijit.form.VerticalRule
=======================

.. contents::
    :depth: 3

:Status:
:Version:
:Authors: 

This widget is used primarily for creating Hash marks for the `dijit.form.VerticalSlider <dijit/form/VerticalSlider>`_ widget. The rule is currently displayed to the right of the slider, if present. The number of hash marks to be displayed is to be specified through the 'count' attribute.

For examples of using this widget along with the VerticalSlider refer `dijit.form.VerticalSlider <dijit/form/VerticalSlider>`_ .

Standalone Ruler
----------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
            dojo.require("dijit.form.VerticalRule");  
            dojo.require("dijit.form.VerticalRuleLabels");
    </script>

  .. cv:: html
              <p>
               <div style="height:2in;border-left:1px solid black;">
			<div dojoType="dijit.form.VerticalRule" count=17 style="width:.4em;"></div>
			<div dojoType="dijit.form.VerticalRule" count=9 style="width:.4em;"></div>
			<div dojoType="dijit.form.VerticalRule" count=5 style="width:.4em;"></div>
			<div dojoType="dijit.form.VerticalRule" count=3 style="width:.4em;"></div>
			<ol dojoType="dijit.form.VerticalRuleLabels" labelStyle="font-style:monospace;font-size:.7em;margin:0px -1em -.35em 0px;">
				<li>1</li>
				<li>2</li>
				<li>3</li>
			</ol>
		</div>



See Also
====================

`dijit.form.VerticalSlider <dijit/form/VerticalSlider>`_.
