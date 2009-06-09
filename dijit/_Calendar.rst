## page was renamed from dijit/Calendar
## page was renamed from 1.2/dijit/Calendar
## page was renamed from dijit/Calendar
#format dojo_rst

dijit._Calendar
===============

:Status: Contributed, Draft
:Version: beta
:Authors: ?--

.. contents::
    :depth: 2

The Calendar widget displays a localized gregorian month-view calendar, and allows the user to navigate months and years as well as select a date.  To meet the accessibility requirements of dijit which require keyboard accessibility on input controls, the Calendar must be used in conjunction with `DateTextBox <dijit/DateTextBox>`_. A read-only calendar view can easily be added to a page as seen in the demo below.

An enhanced but still experimental version of Calendar which has additional capabilities like year-only views and animation effects is under development in `dojox.widget.Calendar <dojox/widget/Calendar>`_. 

========
Examples
========

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit._Calendar");
      dojo.require("dojo.date.locale");
    </script>

  .. cv:: html

    <div dojoType="dijit._Calendar"></div>
