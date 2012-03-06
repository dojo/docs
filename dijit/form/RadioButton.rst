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

**Note:** To use the RadioButton widget, you currently have to call dojo.require("dijit.form.CheckBox") (Dojo <1.7)


Examples
========

Programmatic and declarative example
------------------------------------

Let's create 2 RadioButton widgets, 1 programmatically and 1 declaratively.
We'll wrap both inside a FORM to illustrate what happens on submit.

-   Dojo <1.7

.. code-example ::

  .. js ::
 
      dojo.require("dijit.form.CheckBox");

      dojo.ready(function(){
        var radioOne = new dijit.form.RadioButton({
          checked: true,
          value: "tea",
          name: "drink",
        }, "radioOne");
      });

  .. html ::

    <form id="myform">
        <input type="radio" name="drink" id="radioOne" checked value="tea"/> <label for="radioOne">Tea</label> <br />
        <input type="radio" data-dojo-type="dijit.form.RadioButton" name="drink" id="radioTwo" value="coffee"/> <label for="radioTwo">Coffee</label> <br />
    </form>
    <button onclick="with(dojo.byId('myform'))with(elements[0])with(elements[checked?0:1])alert(name+'='+value);return false">Show form submit value</button>


This example creates both radio buttons programmatically and uses the query module to obtain the value of the selected button.


-   Dojo 1.7 

.. code-example ::

  .. js ::

        require(["dojo/query", "dojo/dom", "dojo/on", "dojo/parser", "dijit/form/RadioButton", "dijit/form/Form", "dojo/domReady!"],
            function(query, dom, on, parser, RadioButton){
                parser.parse();
        
                var radioOne = new dijit.form.RadioButton({
                    checked: true,
                    value: "tea",
                    name: "drink",
                });
                radioOne.placeAt('rad');
                var radioTwo = new dijit.form.RadioButton({
                    checked: false,
                    value: "coffee",
                    name: "drink",
                });
                radioTwo.placeAt('rad1');
                on(dom.byId('sub'),'click',function(e){
                    dojo.stopEvent(e);
                    var checkedButtons =  query("[name=drink]:checked");
                    console.dir(checkedButtons);
                    if(checkedButtons.length) {
                        alert("Selected "+checkedButtons[0].value);
                    }
                    return false;
                });
            });
 
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
