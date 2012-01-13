.. _dijit/form/Select:

=================
dijit.form.Select
=================

:Project owner: Nathan Toone
:Authors: Nathan Toone, Doug Hays
:since: V1.4

.. contents ::
   :depth: 2

A styleable drop down select box (similar to html select element)


Introduction
============

HTML Select tags are problematic when it comes to styling - they are not very styleable, not to mention nearly impossible to get a consistent cross-browser widget.
This widget aims to resolve that issue.


Usage
=====

The Select widget is designed to replace existing HTML select elements with minimal effort.
You can also create them programmatically.

You can specify the maximum height of your dropdown menu by specifying "maxHeight" attribute during widget instantiation.
If the dropdown menu would be larger than that value (in pixels), then scrollbars are added to the dropdown menu.

Examples
========

A simple declarative Select
---------------------------

This example shows a simple Select widget - converted from a select tag.

.. code-example::

  .. js ::

        require(["dojo/parser", "dijit/form/Select"]);

  .. html ::

    <select name="select1" data-dojo-type="dijit/form/Select">
        <option value="TN">Tennessee</option>
        <option value="VA" selected="selected">Virginia</option>
        <option value="WA">Washington</option>
        <option value="FL">Florida</option>
        <option value="CA">California</option>
    </select>


A simple programmatic Select
----------------------------

This example shows how you can set up the same select as the previous example, but programmatically.

.. code-example::

  .. js ::

    require(["dijit/form/Select", "dojo/_base/window"], function(selectState, win){
        new selectState({
            name: 'select2',
            options: [
                { label: 'TN', value: 'Tennessee' },
                { label: 'VA', value: 'Virginia', selected: true },
                { label: 'WA', value: 'Washington' },
                { label: 'FL', value: 'Florida' },
                { label: 'CA', value: 'California' }
            ]
        }).placeAt(win.body());
    });


A "styled" Select
-----------------

When styling the entries of a Select widget, you must use div and span tags, instead of select and option tags - as IE will strip out any HTML within the option tags.

.. code-example::

  .. js ::

      require(["dojo/parser", "dijit/form/Select"]);

  .. html ::

    <div name="select3" value="AK" data-dojo-type="dijit/form/Select">
        <span value="AL"><b>Alabama</b></span>
        <span value="AK"><font color="red">A</font><font color="orange">l</font><font color="yellow">a</font><font color="green">s</font><font color="blue">k</font><font color="purple">a</font></span>
        <span value="AZ"><i>Arizona</i></span>
        <span value="AR"><span class="ark">Arkansas</span></span>
        <span value="CA"><span style="font-size:25%">C</span><span style="font-size:50%">a</span><span style="font-size:75%">l</span><span style="font-size:90%">i</span><span style="font-size:100%">f</span><span style="font-size:125%">o</span><span style="font-size:133%">r</span><span style="font-size:150%">n</span><span style="font-size:175%">i</span><span style="font-size:200%">a</span></span>
        <span value="NM" disabled="disabled">New<br>&nbsp;&nbsp;Mexico</span>
    </div>

Setting Width
-------------

By default, the width of the select widget will be to fit the width of the selected item.
However, you can specify a width on the select to force a fixed width.

.. code-example::

  .. js ::

          require(["dojo/parser", "dijit/form/Select"]);

  .. html ::

    <select data-dojo-id="s3" name="s3" id="s3" style="width: 150px;" data-dojo-type="dijit/form/Select">
        <option value="AL">Alabama</option>
        <option value="AK">Alaska</option>
        <option type="separator"></option>
        <option value="AZ">Arizona</option>
        <option value="AR">Arkansas</option>
        <option type="separator"></option>
        <option value="CA">California</option>
    </select>

The above example also demonstrates using type="separator" to get dividing lines between groups of options.

Accessibility
=============

Keyboard
--------

+------------------------------------------------------+---------------+
| **Action**                                           | **Key**       |
+------------------------------------------------------+---------------+
| Open the menu of options                             | Down arrow    |
+------------------------------------------------------+---------------+
| Navigate through the options                         | Up/Down arrow |
+------------------------------------------------------+---------------+
| Pick an option                                       | Enter         |
+------------------------------------------------------+---------------+
| Close the menu of options without selection          | Esc           |
+------------------------------------------------------+---------------+

If the menu is open, pressing the Tab key will close the menu only.
It will not focus the next element unless you press the Tab key a second time.
