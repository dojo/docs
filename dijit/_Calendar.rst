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

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit._Calendar");
      dojo.require("dojo.date.locale");
    </script>

  .. cv:: html

    <div dojoType="dijit._Calendar"></div>

========
See Also
========

  * `dojox.widget.Calendar <dojox/widget/Calendar>`_ - An enhanced but still experimental version of Calendar which has additional capabilities like year-only views and animation effects.
