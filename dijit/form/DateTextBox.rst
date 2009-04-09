#format dojo_rst

dijit.form.DateTextBox
======================

:Status: Draft
:Version: 1.3
:Authors: Becky Gibson, Doug Hays, Craig Riecke, Adam Peller
:Developers: Doug Hays, Bill Keese
:Available: since 0.9

.. contents::
    :depth: 2

DateTextBox widgets are easy-to-use date entry controls that allow either typing or choosing a date from any calendar widget.


============
Introduction
============

``dijit.form.DateTextBox``:

* is a `mapped form control <dijit/form#mapped>`_
* validates against locale-specific `i18n <dojo/i18n>`_ rules
* also validates against developer-provided ``constraints`` like ``min``, ``max``, valid days of the week, etc.

Standard Date Format
--------------------

One universal problem with specifying dates as text strings is they can be written so many different ways. In Great Britain, "5/8/2008" means August 5th where in the U.S. it means May 8th. Fortunately, Dojo respects the cultural conventions so that the date will be properly parsed when interacting with the user.  Routines in the `dojo.date.locale <dojo/date/locale>`_ package are used against the setting of djConfig.locale or the locale of the user's browser to determine the appropriate behavior. 

Another problem is that your application may interact with various users in different locales, and the same server interaction is expected to work for all of them. If your widget markup specifies the attribute ``value='5/8/2008'``, how does DateTextBox know what you mean? You could write your application to assume US-English conventions, as Javascript often does, but that programming practice will not be well understood in other parts of the world and may cause problems interacting with other software.  To prevent this ambiguity, DateTextBox uses ISO8601/RFC3339 format ``yyyy-mm-dd`` to specify dates when communicating outside the Javascript realm.  This format is both neutral to cultural formatting conventions as well as to time zones. For example:

* 2007-12-25 means December 25, 2007.

ISO formatted date values sort properly as strings and are lighter-weight than Javascript Date objects, which make them convenient for programming.

The DateTextBox widget uses a hidden form element with the *NAME* of the original tag to submit the ISO data; the form element provided for user interaction is an additional form element instantiated only for this purpose.  When you access the DateTextBox value attribute programmatically from the widget using JavaScript, you must use a native Javascript Date object, e.g. new Date(2007, 11, 25) The time portion of the Date object is ignored.

========
Examples
========

Declarative example
-------------------

.. cv-compound::

  .. cv:: javascript

     <script type="text/javascript">
     dojo.require("dijit.form.DateTextBox");
     </script>

  .. cv:: html

	<input type="text" name="date1" id="date1" value="2005-12-30"
		dojoType="dijit.form.DateTextBox"
		required="true" />
        <label for="date1">Drop down Date box. Click inside to display the calendar.</label>



Alternate Date Format to/from a Server
--------------------------------------

Ideally, your server application will send and receive dates in the ISO standard format.  Dojo recommends it as a best practice, but your data may not conform.  For example when Oracle database processes dates, by default it insists on dd-MMM-yyyy format in English, as in 01-APR-2006.  Perhaps you do not control the database or cannot write a shim to convert the dates server side.  How do you get around it?  

To accept dates from the server in this format (but continue to work with dates on the client using local conventions), you can create your own widget class which overrides the postMixInProperties and serialize methods of DateTextBox. (See `dijit <dijit>`_ for details on creating your own widgets). Here's an example:

.. cv-compound::

  .. cv:: javascript

	<script type="text/javascript">
		dojo.require("dijit.form.DateTextBox");
		dojo.addOnLoad(function(){
			dojo.declare("OracleDateTextBox", dijit.form.DateTextBox, {
				oracleFormat: {selector: 'date', datePattern: 'dd-MMM-yyyy', locale: 'en-us'},
				value: "", // prevent parser from trying to convert to Date object
				postMixInProperties: function() { // change value string to Date object
					this.inherited(arguments);
					// convert value to Date object
					this.value = dojo.date.locale.parse(this.value, this.oracleFormat); 
				},
				// To write back to the server in Oracle format, override the serialize method:
				serialize: function(dateObject, options) {
					return dojo.date.locale.format(dateObject, this.oracleFormat).toUpperCase();
				}
			});
			function showServerValue(){
				dojo.byId('toServerValue').value=document.getElementsByName('oracle')[0].value;
			}
			new OracleDateTextBox({
				value: "31-DEC-2009", 
				name: "oracle", 
				onChange: function(v){ setTimeout(showServerValue, 0)}
			}, "oracle");
			showServerValue();
		});
	</script>

  .. cv:: html

	<label for"fromServerValue">Oracle date coming from server:</label>
	<input id="fromServerValue" readOnly disabled value="31-DEC-2009"/>
	<label for="oracle">Client date:</label>
	<input id="oracle" />
	<label for"toServerValue">Oracle date going back to server:</label>
	<input id="toServerValue" readOnly disabled/>


Changing Constraints on the Fly
-------------------------------
The DateTextBox widget obeys the ``constraints`` you give, much like `dijit.form.NumberTextBox <dijit/form/NumberTextBox>`_  Sometimes you may need to change this attribute's `min` and `max` values at runtime. To do this, you can set new ``constraints`` on the widget, but the catch is you must use JavaScript dates.  In this example, the first DateTextBox widget sets the `max` constraint of the second widget, and the second widget sets the `min` constraint of the first widget.

.. cv-compound::

  .. cv:: javascript

	<script type="text/javascript">
		dojo.require("dijit.form.DateTextBox");
	</script>

  .. cv:: html

	<label for="fromDate">From:</label>
	<input id="fromDate" type="text" name="fromDate" dojoType="dijit.form.DateTextBox" required="true"
		onChange="dijit.byId('toDate').constraints.min = arguments[0];" />
	<label for="toDate">To:</label>
	<input id="toDate" type="text" name="toDate" dojoType="dijit.form.DateTextBox" required="true"
		onChange="dijit.byId('fromDate').constraints.max = arguments[0];" />


Working with Two-Digit Years
----------------------------

Sometimes you may want to input and display years in a format with only 2-digit years.  Note the server still needs the full 4-digit year sent on form submit so that it's not ambiguous.  There is a ``constraints`` property `fullYear` (boolean) that controls the presentation of the year as 2 digits or 4.  The catch is that this can only be set after the widget has been created.

.. cv-compound::

  .. cv:: javascript

	<script type="text/javascript">
		dojo.require("dijit.form.DateTextBox");
		function setShortYear(){
			var w = dijit.byId('shortYear');
			w.constraints.fullYear = false;
			w.attr('value', w.attr('value')); // reformat display to short year
		}
		dojo.addOnLoad(setShortYear);
	</script>

  .. cv:: html

	<label for="shortYear">From:</label>
	<input id="shortYear" type="text" name="shortYear" dojoType="dijit.form.DateTextBox" value="1999-12-31" required="true"/>

=============
Accessibility
=============

See the Accessibility Section in `dijit.form.ValidationTextBox <dijit/form/ValidationTextBox>`_

The calendar popup associated with the DateTextBox is not yet keyboard accessible.  However, the DateTextBox will still meet accessibility requirments as long as the developer provides the validation parameters promptMessage and invalidMessage when creating the DateTextBox.  [TODO: there are default messages; this should not be required]  These messages are implemented in a format that is accessible to all users.   
