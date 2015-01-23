.. _dojox/date/relative:

===================
dojox.date.relative
===================

:Owner: Nathan Toone

.. contents ::
  :depth: 3

The dojox.date.relative package provides a function for parsing dates relative to a second date, and only displaying the most significant portion.  This is very helpful in a situation where space is at a premium, and there are a wide range of dates that could be displayed.  By default all dates are relative to the current time - but this can be changed via an option.

Dates are formatted according to the following logic:
 * If the day portion of the date falls within the day portion of the relativeDate, then the time will be all that is displayed (i.e. "9:32 AM")
 * If the day portion of the date falls within the week preceding the relativeDate, then the display will show day of week and time (i.e. "Mon 9:32 AM")
 * If the year portion of the date falls within the year portion of the relativeDate, then the display will show month and day (i.e. "Nov 1")
 * Otherwise, this function is equivalent to calling dojo.date.format with formatLength of "medium"

Options
-------

dojox.date.relative.format takes a JavaScript Date object, and an optional kwArgs parameter.

Possible values for the kwArgs are:
 * **locale**: Set if you want to specify a locale.  Defaults to current locale.
 * **relativeDate**: Set if you want to calculate relative to a different date.  Defaults to the current date and time.
 * **weekCheck**: Set to false if you do not want to do the week-based check (the second condition above)
