## page was renamed from dijit/Calendar
## page was renamed from 1.2/dijit/Calendar
## page was renamed from dijit/Calendar
#format dojo_rst

dijit._Calendar
===============

:Status: Contributed, Draft
:Version: 1.3
:Authors: Adam Peller

.. contents::
    :depth: 2

The Calendar widget displays a localized month-view calendar and allows the user to navigate months and years as well as select a date.  Non-Gregorian calendar use is possible experimental date classes in `dojox.date <dojox/date>`_.  To meet the accessibility requirements of dijit which require keyboard accessibility on input controls, the Calendar must be used in conjunction with `DateTextBox <dijit/DateTextBox>`_. For this reason, the _Calendar widget is not supported standalone and is prefixed with an underscore ("_").  A calendar view can easily be added to a page as seen in the demo below.


========
Examples
========

A plain Calendar widget

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit._Calendar");
    </script>

  .. cv:: html

    <div dojoType="dijit._Calendar"></div>


With a custom template to change the look and feel

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit._Calendar");

			dojo.addOnLoad(function(){
				//Need to declare BigCalendar here in an addOnLoad block so that it works
				//with xdomain loading, where the dojo.require for dijit._Calendar 
				//may load asynchronously. This also means we cannot have HTML
				//markup in the body tag for BigCalendar, but instead inject it in this
				//onload handler after BigCalendar is defined.
				dojo.declare("BigCalendar", dijit._Calendar, {
					templatePath: "../../dijit/tests/_altCalendar.html",
					templateString: null,  /* need this for builds */
					isDisabledDate: dojo.date.locale.isWeekend,
					getClassForDate: function(date){
						if(!(date.getDate() % 10)){ return "blue"; } // apply special style to all days divisible by 10
					}
				});
				
				var bigCalendar = dojo.byId("calendar5");
				bigCalendar.setAttribute("dojoType", "BigCalendar");
				dojo.parser.parse(bigCalendar.parentNode);
			});
    </script>

  .. cv:: css

		<style>
			#calendar5 .dijitCalendarDateTemplate { height: 50px; width: 50px; border: 1px solid #ccc; vertical-align: top }
			#calendar5 .dijitCalendarDateLabel, #calendar5 .dijitCalendarDateTemplate { text-align: inherit }
			#calendar5 .dijitCalendarDayLabel { font-weight: bold }
			#calendar5 .dijitCalendarSelectedYear { font-size: 1.5em }
			#calendar5 .dijitCalendarMonth { font-family: serif; letter-spacing: 0.2em; font-size: 2em }
			.blue { color: blue }
		</style>

  .. cv:: html

			<input id="calendar5" dayWidth="abbr" value="2008-03-15">


[experimental: 1.4+ and trunk only] Using a non-Gregorian calendar, the Hebrew calendar

.. cv-compound::
 :djConfig: extraLocale: ['he']

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit._Calendar");
      dojo.require("dojox.date.hebrew");
      dojo.require("dojox.date.hebrew.Date");
      dojo.require("dojox.date.hebrew.locale");
    </script>

  .. cv:: html

    <div dojoType="dijit._Calendar" datePackage = "dojox.date.hebrew"></div>
    <div dojoType="dijit._Calendar" lang="he" datePackage = "dojox.date.hebrew"></div>


========
See Also
========

  * `dojox.widget.Calendar <dojox/widget/Calendar>`_ - An enhanced but still experimental version of Calendar which has additional capabilities like year-only views and animation effects.
