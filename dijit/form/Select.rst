.. _dijit/form/Select:

=================
dijit.form.Select
=================

:Project owner: Nathan Toone
:Authors: Nathan Toone, Doug Hays
:since: V1.4

.. contents ::
   :depth: 2

A styleable, searchable drop down select box (similar to html select element).


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
  :djConfig: async: true, parseOnLoad: true

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
  :djConfig: async: true

  .. js ::

    require(["dijit/form/Select", "dojo/_base/window", "dojo/domReady!"], function(Select, win){
        var select = new Select({
            name: "select2",
            options: [
                { label: "TN", value: "Tennessee" },
                { label: "VA", value: "Virginia", selected: true },
                { label: "WA", value: "Washington" },
                { label: "FL", value: "Florida" },
                { label: "CA", value: "California" }
            ]
        });
        select.placeAt(win.body());
        select.startup();
    });

A Select Fed By A Store
-----------------------

A Select can take its data from a data store, which must currently conform to the dojo.data.Read API.  `Selects Using Stores <http://dojotoolkit.org/documentation/tutorials/1.6/selects_using_stores>`_ may help.  One gotcha to look out for is that, at least in this example, the data from the store must have ``id`` and ``label`` attributes, not ``value`` and ``label`` attributes.


.. code-example::
  :djConfig: async: true

  .. js ::

    require(["dijit/form/Select",
      "dojo/data/ObjectStore",
      "dojo/store/Memory",
      "dojo/domReady!"
    ], function(Select, ObjectStore, Memory){
  
      var store = new Memory({
        data: [
          { id: "foo", label: "Foo" },
          { id: "bar", label: "Bar" }
        ]
      });
  
      var os = new ObjectStore({ objectStore: store });
  
      var s = new Select({
        store: os
      }, "target");
      s.startup();
    
      s.on("change", function(){
          console.log("my value: ", this.get("value"))
      });
    })
  
  .. html ::
  
    <div id="target"></div>

A "styled" Select
-----------------

When styling the entries of a Select widget, you must use div and span tags, instead of select and option tags - as IE will strip out any HTML within the option tags.

.. code-example::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/form/Select"]);

  .. html ::

    <div name="select3" value="AK" data-dojo-type="dijit/form/Select">
        <span value="AL"><b>Alabama</b></span>
        <span value="AK"><font color="red">A</font><font color="orange">l</font><font color="yellow">a</font><font color="green">s</font><font color="blue">k</font><font color="purple">a</font></span>
        <span value="AZ"><i>Arizona</i></span>
        <span value="AR"><span class="ark">Arkansas</span></span>
        <span value="CA"><span style="font-size:25%">C</span><span style="font-size:50%">a</span><span style="font-size:75%">l</span><span style="font-size:90%">i</span><span style="font-size:100%">f</span><span style="font-size:125%">o</span><span style="font-size:133%">r</span><span style="font-size:150%">n</span><span style="font-size:175%">i</span><span style="font-size:200%">a</span></span>
        <span value="NM" disabled="disabled">New<br>  Mexico</span>
    </div>

Setting Width
-------------

By default, the width of the select widget will be to fit the width of the selected option.
However, you can specify a width on the select to force a fixed width.
Note that the width specified should be as large or larger than the width of the biggest option.
Otherwise, it will function as a minimum width setting, and the size of the Select will still
change when the user picks certain long options.

.. code-example::
  :djConfig: async: true, parseOnLoad: true

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

Note also that there are some inconsistencies between setting inline styles vs. styles via CSS for this widget for its arrow icon. When setting an inline style, the Select changes the 'baseClass' from 'dijitSelect' to 'dijitSelectFixedWidth', which sets 'width:100%' on the '.dijitButtonContents'. So you may want to set style as follows (with the width being whatever value you want for the overall Select:

.. css ::

   .select {
           width : 8.8em; 
   }
   
   .select .dijitButtonContents {
   	width: 100%;
   }


Setting Height
--------------

A ``maxHeight`` (integer) attribute is available to define maximum height of select popup. ``0`` means no max height. Starting with dojo 1.6.0 you can set it to ``-1`` to specify that height should be automatically computed based on available space available between the select and the bottom of the screen.

Note about validation
=====================

If you mark a select as ``required`` (boolean), user will be forced to select a value. However, you often want to have a dummy "prompt" as first select value (eg. ``-- SELECT --`` or ``-- CITY --``). If you set its value to "", validation will reject form when nothing is select *but* the prompt will appear as a separator in the options list. To have a prompt option and still use default validation, set its value to " " (or any number of spaces). Validation rejects any blank value (zero, one or more spaces) but only false values (false, "", 0) appear as separator so all will be right.

Accessibility
=============

Keyboard
--------

+-------------------------------------------------------+---------------+
| **Action**                                           | **Key**        |
+------------------------------------------------------+----------------+
| Open the menu of options                             | Down arrow     |
+------------------------------------------------------+----------------+
| Navigate through the options                         | Up/Down arrow  |
+------------------------------------------------------+----------------+
| Select the first option                              | Home           |
+------------------------------------------------------+----------------+
| Select the last option                               | End            |
+------------------------------------------------------+----------------+
| Pick an option                                       | Enter          |
+------------------------------------------------------+----------------+
| Close the menu of options without selection          | Esc            |
+------------------------------------------------------+----------------+
| Option searching                                     | printable keys |
+------------------------------------------------------+----------------+

If the menu is open, pressing the Tab key will close the menu only.
It will not focus the next element unless you press the Tab key a second time.

You can search for specific options by typing the first letter(s) of a matching option.  For example, typing the letter 'k'
will find the next option that begins with the letter 'k', starting with the current option.  If typed without pauses, multiple
letters can also be used to search.  Typing the 2 letters 'a' and 'b' within 1 second of each other will search for an option that begins
with 'ab'.  However, pausing between letters would result in searching for an option that begins with 'a', and then subsequently an option
that begins with 'b'.  While usually not necessary, the pause timing can be controlled via the ``multiCharSearchDuration`` (integer)
attribute which defaults to 1000 (milliseconds).

Label
-----
To label a Select, rather than using the `<label>` tag you should use the `aria-labelledby` property, like:

.. js ::

   <span id="foo_label">My Select:</span>
   <select id="foo" data-dojo-type="dijit/form/Select" aria-labelledby="foo_label">
      ...
   </select>

Although `<label>` works with the JAWS screen reader, it doesn't work with iOS VoiceOver, and further,
it violates the HTML spec which says that `<label>` should only be used with true form elements (whereas
Select is implemented as a `<table>`).
