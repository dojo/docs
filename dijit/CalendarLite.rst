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

      require(["dojo/parser", "dijit/CalendarLite"]);

  .. html ::

    <div data-dojo-type="dijit/CalendarLite">
        <script type="dojo/method" data-dojo-event="onChange" data-dojo-args="value">
            require(["dojo/dom", "dojo/date/locale"], function(dom, locale){
                dom.byId('formatted').innerHTML = locale.format(value, {formatLength: 'full', selector:'date'})
            });
        </script>
    </div>
    <p id="formatted"></p>


See Also
========

  * :ref:`dijit.Calendar <dijit/Calendar>` - Extends CalendarLite adding month drop down
  * :ref:`dojox.widget.Calendar <dojox/widget/Calendar>` - An enhanced but still experimental calendar widget which has additional capabilities like year-only views and animation effects.

