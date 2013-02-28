.. _dijit/Calendar:

===============
dijit/Calendar
===============

:Authors: Adam Peller
:Project owner: Adam Peller

.. contents ::
    :depth: 2

The Calendar widget displays a localized month-view calendar and allows the user to navigate months and years and select a date.
It is typically used as part of the :ref:`DateTextBox <dijit/form/DateTextBox>` which includes a text box and uses the Calendar as a drop-down.
Localizations for hundreds of languages and cultures are included as part of the Dojo Toolkit.
The locale will be chosen based on the dojoConfig.locale setting of your page, using navigator.language by default.

Navigating between months is possible with the arrow icons, and the next and previous year may be clicked to change to that year.
Holding the mouse down on these controls will repeat the action.
Starting with version 1.4, the month name is a drop-down control for selecting a different month.

The Calendar widget has been supported as a standalone widget since version 1.4.
Prior to that, to meet the accessibility requirements of the Dijit project which requires accessibility on all widgets,
the implementation was private and began with an underscore character: dijit._Calendar.

Non-Gregorian calendar use is possible using the datePackage attribute and experimental date classes in :ref:`dojox.date <dojox/date>`.


Examples
========

A plain Calendar widget with the formatted date below:

.. code-example::
  :type: inline
  :height: 350
  :version: 1.4

  .. js ::

    require([
        "dojo/parser",
        "dijit/Calendar"
    ]);

  .. html ::

    <div data-dojo-type="dijit/Calendar">
        <script type="dojo/method" data-dojo-event="onChange" data-dojo-args="value">
            require(["dojo/dom", "dojo/date/locale"], function(dom, locale){
                dom.byId('formatted').innerHTML = locale.format(value, {formatLength: 'full', selector:'date'});
            });
        </script>
    </div>
    <p id="formatted"></p>

With an initial selection and weekends disabled:

.. code-example::
  :height: 320
  :type: inline
  :version: 1.4

  .. js ::

    require([
        "dojo/parser",
        "dojo/date",
        "dijit/Calendar"
    ]);

  .. html ::

    <div id="mycal" data-dojo-type="dijit/Calendar" value="2009-08-07" data-dojo-props="isDisabledDate:dojo.date.locale.isWeekend"></div>
    
  .. css ::

    #mycal .dijitCalendarDisabledDate {
        background-color: #333;
        text-decoration: none;
    }

    #mycal .dijitCalendarContainer {
        margin: 25px auto;
    }

JavaScript declaration, with a restriction of +/- one week from the current date:

.. code-example::
  :height: 320
  :type: inline
  :version: 1.4

  .. js ::

    require([
        "dijit/Calendar",
        "dojo/date",
        "dojo/domReady!"
    ], function(Calendar, date){
        new Calendar({
            value: new Date(),
            isDisabledDate: function(d){
                var d = new Date(d); d.setHours(0, 0, 0, 0);
                var today = new Date(); today.setHours(0, 0, 0, 0);
                return Math.abs(date.difference(d, today, "week")) > 0;
            }
        }, "mycal");
    });

  .. html ::

    <div id="mycal"></div>
    
  .. css ::

      #mycal table.dijitCalendarContainer {
        margin: 25px auto;
        width: 200px;
      }

Custom styling:


.. code-example::
  :height: 350
  :type: inline
  :version: 1.5

  .. js ::

    require([
        "dojo/parser",
        "dijit/Calendar"
    ]);
  

  .. html ::

    <input id="calendar5" data-dojo-type="dijit/Calendar" data-dojo-props="dayWidth:'abbr'" value="2008-03-13" />
    
  .. css ::

    #calendar5 .dijitCalendarDateTemplate { height: 50px; width: 50px; border: 1px solid #ccc; vertical-align: top }
    #calendar5 .dijitCalendarDateLabel, #calendar5 .dijitCalendarDateTemplate { text-align: inherit }
    #calendar5 .dijitCalendarDayLabel { font-weight: bold }
    #calendar5 .dijitCalendarSelectedYear { font-size: 1.5em }
    #calendar5 .dijitCalendarMonthLabel { font-family: serif; letter-spacing: 0.2em; font-size: 2em }
        

[1.4+] Non-Gregorian calendars:

TODO: this example breaks on parse.

.. code-example::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

      require([
        "dijit/Calendar",
        "dijit/registry",
        "dojo/dom",
        "dojo/parser",
        "dojo/topic",
        "dojox/date/hebrew",
        "dojox/date/hebrew/Date",
        "dojox/date/hebrew/locale",
        "dojox/date/islamic",
        "dojox/date/islamic/Date",
        "dojox/date/islamic/locale",
        "dojo/domReady!"
    ], function(Calendar, registry, dom, parser, topic, hebrew){
        this.publishing = false;

        publishDate = function(d){
            if(!publishing){
                publishing = true;
                topic.publish("date", {date: d.toGregorian ? d.toGregorian() : d, id: this.id});
                publishing = false;
            }
        };

        topic.subscribe("date", function(data){
            registry.filter(function(widget){ return widget.id != data.id; }).forEach(function(widget){ widget.set('value', data.date); });
        });

        formatDate = function(d){
            // TODO: stop using dojo and dojox globals
            var datePackage = (this.id == "gregorian") ? dojo.date : dojox.date[this.id];
                dom.byId(this.id+"Formatted").innerHTML = datePackage.locale.format(arguments[0], {
                formatLength: 'long',
                selector: 'date'
            });
        };

        parser.parse();
    });

  .. html ::

    <table class="container">
        <tr>
            <td>
                <!-- TODO: stop using dojo and dojox globals -->
                <div id="hebrew" data-dojo-type="dijit/Calendar" data-dojo-props="datePackage:dojox.date.hebrew, onValueSelected:publishDate, onChange:formatDate"></div>
                <div id="hebrewFormatted"></div>
            </td>
            <td>
                <div id="islamic" data-dojo-type="dijit/Calendar" data-dojo-props="datePackage:dojox.date.islamic, onValueSelected:publishDate, onChange:formatDate"></div>
                <div id="islamicFormatted"></div>
            </td>
            <td>
                <div id="gregorian" data-dojo-type="dijit/Calendar" data-dojo-props="onValueSelected:publishDate, onChange:formatDate"></div>
                <div id="gregorianFormatted"></div>
            </td>
        </tr>
    </table>

Note
====

dijit._Calendar was upgraded to dijit.Calendar in version 1.4.
An alias is provided for backwards compatibility.


See Also
========

  * :ref:`dojox.widget.Calendar <dojox/widget/Calendar>` - An enhanced but still experimental calendar widget which has additional capabilities like year-only views and animation effects.


Accessibility
=============

As of 1.6 full keyboard support has been implemented for the Calendar.

Keyboard
--------

==========================================    =================================================
Action                                        Key
==========================================    =================================================
Navigate between date cells                   Left, Right, Up, and down arrows
Navigate to same day in next month            Page-down
Navigate to same day in previous month        Page-up
Navigate to same day in next year             Control+Page-down
Navigate to same day in previous year         Control+Page-up
Navigate to first day in month                Home
Navigate to last day in month                 End
Select the date                               Enter, Space
==========================================    =================================================

Screen Reader Issues
--------------------

The Calendar has been implemented as a table so standard table announcements and navigation work as expected with JAWS 12.
As the user arrows through the table the day number is announced.
As the user moves from column to column the weekday column headers are announced as well.
For en-us locales these are the first letters of the days of the week: S, M, T, W, T, F, S.
The month name is also included when it changes.
The current year has been assigned as the label for the Calendar table and is also announced when it changes.
