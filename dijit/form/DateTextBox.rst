.. _dijit/form/DateTextBox:

======================
dijit/form/DateTextBox
======================

:Authors: Becky Gibson, Doug Hays, Craig Riecke, Adam Peller
:Developers: Doug Hays, Bill Keese
:since: V0.9

.. contents ::
    :depth: 2

DateTextBox widgets are easy-to-use date entry controls that allow either typing or choosing a date from any calendar widget.


Introduction
============

``dijit/form/DateTextBox``:

* is a :ref:`mapped form control <dijit/form>`
* validates against locale-specific :ref:`i18n <quickstart/internationalization/index>` rules
* also validates against developer-provided ``constraints`` like ``min``, ``max``, valid days of the week, etc.

:ref:`Options defined by the dojo.date package <quickstart/numbersDates>` to alter the way dates are formatted and parsed can be specified in the DateTextBox ``constraints`` object.

Standard Date Format
--------------------

One universal problem with specifying dates as text strings is they can be written so many different ways.
In Great Britain, "5/8/2008" means August 5th where in the U.S. it means May 8th.
Fortunately, Dojo respects the cultural conventions so that the date will be properly parsed when interacting with the user.
Routines in the :ref:`dojo.date.locale <dojo/date/locale>` package are used against the setting of dojoConfig.locale
or the locale of the user's browser to determine the appropriate behavior.

Another problem is that your application may interact with various users in different locales,
and the same server interaction is expected to work for all of them.
If your widget markup specifies the attribute ``value='5/8/2008'``, how does DateTextBox know what you mean?
You could write your application to assume US-English conventions, as JavaScript often does,
but that programming practice will not be well understood in other parts of the world
and may cause problems interacting with other software.
To prevent this ambiguity, DateTextBox uses ISO8601/RFC3339 format ``yyyy-MM-dd`` to specify dates
when communicating outside the JavaScript realm.
This format is both neutral to cultural formatting conventions as well as to time zones.
For example:

* 2007-12-25 means December 25, 2007.

ISO formatted date values sort properly as strings and are lighter-weight than JavaScript Date objects, which make them convenient for programming.

The DateTextBox widget uses a hidden form element with the *NAME* of the original tag to submit the ISO data;
the form element provided for user interaction is an additional form element instantiated only for this purpose.
When you access the DateTextBox value attribute programmatically from the widget using JavaScript,
you must use a native JavaScript Date object, e.g. new Date(2007, 11, 25).
The time portion of the Date object is ignored.


Examples
========

Declarative example
-------------------

.. code-example ::

  .. js ::

     require(["dojo/parser", "dijit/form/DateTextBox"]);

  .. html ::

    <label for="date1">Drop down Date box:</label>
    <input type="text" name="date1" id="date1" value="2005-12-30"
        data-dojo-type="dijit/form/DateTextBox"
        required="true">



Alternate Date Format to/from a Server
--------------------------------------

Ideally, your server application will send and receive dates in the ISO standard format.
Dojo recommends it as a best practice, but your data may not conform.
For example when Oracle database processes dates, by default it insists on dd-MMM-yyyy format in English, as in 01-APR-2006.
Perhaps you do not control the database or cannot write a shim to convert the dates server side.
How do you get around it?

To accept dates from the server in this format (but continue to work with dates on the client using local conventions),
you can create your own widget class which overrides the postMixInProperties and serialize methods of DateTextBox.
(See :ref:`Dijit <dijit/index>` for details on creating your own widgets.)
Here's an example:

.. code-example ::

  .. js ::

    require(["dojo/_base/declare", "dijit/form/DateTextBox", "dojo/date/locale", "dojo/dom", "dojo/domReady!"],
            function(declare, DateTextBox, locale, dom){
        declare("OracleDateTextBox", DateTextBox, {
            oracleFormat: {selector: 'date', datePattern: 'dd-MMM-yyyy', locale: 'en-us'},
            value: "", // prevent parser from trying to convert to Date object
            postMixInProperties: function(){ // change value string to Date object
                this.inherited(arguments);
                // convert value to Date object
                this.value = locale.parse(this.value, this.oracleFormat);
            },
            // To write back to the server in Oracle format, override the serialize method:
            serialize: function(dateObject, options){
                return locale.format(dateObject, this.oracleFormat).toUpperCase();
            }
        });
        function showServerValue(){
            dom.byId('toServerValue').value = document.getElementsByName('oracle')[0].value;
        }
        var oracleDateTextBox = new OracleDateTextBox({
            value: "31-DEC-2009",
            name: "oracle",
            onChange: function(v){ setTimeout(showServerValue, 0)}
        }, "oracle");
        oracleDateTextBox.startup();
        showServerValue();
    });

  .. html ::

    <label for="fromServerValue">Oracle date coming from server:</label>
    <input id="fromServerValue" readonly="readonly" disabled="disabled" value="31-DEC-2009"><br>
    <label for="oracle">Client date:</label>
    <input id="oracle"><br>
    <label for="toServerValue">Oracle date going back to server:</label>
    <input id="toServerValue" readonly="readonly" disabled="disabled">


Changing Constraints on the Fly
-------------------------------
The DateTextBox widget obeys the ``constraints`` you give, much like :ref:`dijit.form.NumberTextBox <dijit/form/NumberTextBox>`.
Sometimes you may need to change this attribute's `min` and `max` values at runtime.
To do this, you can set new ``constraints`` on the widget, but the catch is you must use JavaScript dates.
In this example, the first DateTextBox widget sets the `max` constraint of the second widget,
and the second widget sets the `min` constraint of the first widget.

.. code-example ::

  .. js ::

    require(["dojo/parser", "dijit/form/DateTextBox"]);

  .. html ::

    <label for="fromDate">From:</label>
    <input data-dojo-id="myFromDate" type="text" name="fromDate" data-dojo-type="dijit/form/DateTextBox" required="true"
        onChange="myToDate.constraints.min = arguments[0];">
    <label for="toDate">To:</label>
    <input data-dojo-id="myToDate" type="text" name="toDate" data-dojo-type="dijit/form/DateTextBox" required="true"
        onChange="myFromDate.constraints.max = arguments[0];">


Working with Two-Digit Years
----------------------------

Sometimes you may want to input and display years in a format with only 2-digit years.
Note the server still needs the full 4-digit year sent on form submit so that it's not ambiguous.
There is a ``constraints`` property `fullYear` (boolean) that controls the presentation of the year as 2 digits or 4.
The catch is that this can only be set after the widget has been created.

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/parser", "dijit/form/DateTextBox", "dojo/domReady!"], function(parser){
        parser.parse();
        myShortYear.constraints.fullYear = false;
        myShortYear.set('value', myShortYear.get('value')); // reformat display to short year
    });

  .. html ::

    <label for="myShortYear">From:</label>
    <input data-dojo-id="myShortYear" type="text" name="shortYear" data-dojo-type="dijit/form/DateTextBox" data-dojo-props="constraints:{fullYear: false}" value="1999-12-31" required="true">

Accessibility
=============

Version 1.6
-----------
As of 1.6, full keyboard support has been added to the Calendar dropdown used by the DateTextBox.
See the Accessibility Section in :ref:`dijit.Calendar <dijit/Calendar>` for the keyboard commands to navigate the Calendar drop down.
To navigate the DateTextBox with the JAWS 12 screen reader, JAWS must be in virtual cursor off mode.
With focus on the DateTextBox field JAWS will announce the DateTextBox as an edit combo.
The user presses the down arrow key to open the Calendar and set focus onto the date specified in the text box.
Use table navigation to navigate through the Calendar.


Previous to 1.6
---------------

See the Accessibility Section in :ref:`dijit.form.ValidationTextBox <dijit/form/ValidationTextBox>`

The calendar popup associated with the DateTextBox is not yet keyboard accessible.
However, the DateTextBox will still meet accessibility requirements as long as the developer provides the validation parameters promptMessage and invalidMessage when creating the DateTextBox (note that there is a default invalidMessage but not a promptMessage).
These messages are implemented in a format that is accessible to all users.

