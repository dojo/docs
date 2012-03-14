.. _dijit/form/RadioButton:

======================
dijit.form.RadioButton
======================

:Authors: Becky Gibson, Doug Hays, Nikolai Onken
:Developers: ?-
:since: V?

.. contents ::
    :depth: 2

RadioButton widgets capture binary user-choices unlike buttons which normally perform some action when clicked.

Usage
=====

Normally, there are multiple RadioButton widgets assigned to a single group defined by widgets sharing the same *name* attribute.
Upon FORM submission, the 1 checked RadioButton *value* is submitted using this shared *name*.

Examples
========

Programmatic example
------------------------------------

This example creates both radio buttons programmatically and uses the query module to obtain the value of the selected button.

.. code-example ::

  .. js ::

    require(["dojo/_base/event", "dojo/query", "dojo/dom", "dojo/on", "dojo/parser", "dijit/form/RadioButton", "dijit/form/Form", "dojo/domReady!"],
      function(event, query, dom, on, parser, RadioButton){
        parser.parse();
    
        var radioOne = new RadioButton({
          checked: true,
          value: "tea",
          name: "drink"
        });
  
        radioOne.placeAt('rad');
        var radioTwo = new RadioButton({
          checked: false,
          value: "coffee",
          name: "drink"
        });
        radioTwo.placeAt('rad1');
        on(dom.byId('sub'),'click',function(e){
          event.stop(e);
          var checkedButtons =  query("[name=drink]:checked");
          if(checkedButtons.length) {
            alert("Selected "+checkedButtons[0].value);
          }
          return false;
        });
      }
    );

  .. html ::

            <div data-dojo-type="dijit.form.Form" id="myForm" data-dojo-id="myForm"
                encType="multipart/form-data" action="" method="">

                <div id="rad" style="padding: 10px;">Tea&nbsp;</div>
                <div id="rad1" style="padding: 10px;">Coffee&nbsp;</div>
                <button id='sub'>Test</button>
            </div>

Accessibility
=============

Keyboard
--------

+-----------------------------+---------------------+
| **Action**                  | **Key**             |
+-----------------------------+---------------------+
| Toggle checked state        | Spacebar            |
+-----------------------------+---------------------+
| Focus previous radio button | up or left arrow    |
+-----------------------------+---------------------+
| Focus next radio button     | down or right arrow |
+-----------------------------+---------------------+

**Note:**
Using the TAB key to focus a radio group will only focus the selected RadioButton in a group.

Radio buttons are implemented using the standard input type=checkbox and type=radio elements respectively.
CSS is used to overlay the unique theme over the actual input elements.
Thus, the keyboard behavior of checkboxes and radio buttons mimics the behavior in the browser.
