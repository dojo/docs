.. _dijit/CalendarLite:

==================
dijit.CalendarLite
==================

.. contents ::
    :depth: 2

The CalendarLite widget is like the :ref:`dijit.Calendar <dijit/Calendar>` widget, but streamlined for size.
In particular it's missing the drop down to display the list of months, and the _CSSStateMixin needed
for getting hover CSS effects on older versions of IE.

Examples
========

A plain Calendar widget with the formatted date below

.. code-example::
  :type: inline
  :height: 350
  :version: 1.4

  .. js ::

      dojo.require("dijit.CalendarLite");

  .. html ::

    <div data-dojo-type="dijit.CalendarLite" data-dojo-props="onChange:function(){dojo.byId('formatted').innerHTML=dojo.date.locale.format(arguments[0], {formatLength: 'full', selector:'date'})}"></div>
    <p id="formatted"></p>


See Also
========

  * :ref:`dijit.Calendar <dijit/Calendar>` - Extends CalendarLite adding month drop down
  * :ref:`dojox.widget.Calendar <dojox/widget/Calendar>` - An enhanced but still experimental calendar widget which has additional capabilities like year-only views and animation effects.

