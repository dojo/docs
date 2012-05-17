.. _dijit/form/Form:

===============
dijit/form/Form
===============

:Authors: Doug Hays, Bill Keese
:Developers: Doug Hays, Bill Keese
:since: V1.0

.. contents ::
    :depth: 2

**dijit/form/Form** is the dijit equivalent of the <form> node, and it provides various methods for serializing/deserializing form data, and checking whether or not a form is valid.


Examples
========

validate()
----------
You can use `isValid()` or `validate()` to prevent an invalid form from submitting.
The `validate()` function does some extra UI related work, including highlighting invalid dijits in the form, and scrolling the first invalid dijit into view.
Try opening this example and immediately clicking Submit, and compare the behavior to the previous example.


.. code-example ::

  .. js ::

    require(["dojo/parser", "dijit/form/Form", "dijit/form/Button", "dijit/form/ValidationTextBox", "dijit/form/DateTextBox"]);

  .. html ::

    <div data-dojo-type="dijit/form/Form" id="myForm" data-dojo-id="myForm" enctype="multipart/form-data">
        <script type="dojo/on" data-dojo-event="reset">
            return confirm('Press OK to reset widget values');
        </script>

        <script type="dojo/on" data-dojo-event="submit">
            if(this.validate()){
                return confirm('Form is valid, press OK to submit');
            }else{
                alert('Form contains invalid data.  Please correct first');
                return false;
            }
            return true;
        </script>

        <table style="border: 1px solid #9f9f9f;" cellspacing="10">
            <tr>
                <td>
                    <label for="name">Name:</label>
                </td>
                <td>
                    <input type="text" id="name" name="name" required="true" data-dojo-type="dijit/form/ValidationTextBox"/>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="dob">Date of birth:</label>
                </td>
                <td>
                    <input type="text" id="dob" name="dob" data-dojo-type="dijit/form/DateTextBox"/>
                </td>
            </tr>
        </table>

        <button data-dojo-type="dijit/form/Button" type="button" onClick="console.log(myForm.getValues())">Get Values from form!</button>
        <button data-dojo-type="dijit/form/Button" type="submit" name="submitButton" value="Submit">Submit</button>
        <button data-dojo-type="dijit/form/Button" type="reset">Reset</button>
    </div>

Note that it's using a <div> node instead of the obvious choice of a <form> node because of some `IE issues <http://bugs.dojotoolkit.org/ticket/8424>`_



Using native form elements
--------------------------

dijit/form/Form doesn't fully support native elements as children.
In particular, myForm.get("value") will return an Object listing all the values of the contained widgets,
but it won't list the values of the contained native <input> elements.

It is possible to submit a dijit/form/Form with native elements to the server, via standard (non-ajax) form submission.
Both types of values (widgets and plain <input> elements) will be submitted.
However, in that case the app has to do validation itself.
The Form widget below will validate only when you have entered both a name in the ValidationTextBox widget
AND when you have selected 1 of the native HTML radio buttons.

.. code-example ::

  .. js ::

    require(["dojo/parser", "dijit/form/Form", "dijit/form/Button", "dijit/form/ValidationTextBox"]);

  .. html ::

    <div data-dojo-type="dijit/form/Form" id="myFormThree" data-dojo-id="myFormThree" enctype="multipart/form-data">
        <script type="dojo/on" data-dojo-event="validate">
            require(["dojo/query", "dijit/form/Form"], function(query, Form){
                return query('INPUT[name=order]', 'myFormThree').filter(function(n){return n.checked;}).length > 0 &&
                Form.prototype.validate.apply(this, arguments);
            });
        </script>
        <script type="dojo/on" data-dojo-event="submit">
            require(["dojo/dom"], function(dom){
                var f = dom.byId("myFormThree");
                var s = "";
                for(var i = 0; i < f.elements.length; i++){
                    var elem = f.elements[i];
                    if(elem.name == "button"){ continue; }
                    if(elem.type == "radio" && !elem.checked){ continue; }
                    s += elem.name + ": " + elem.value + "\n";
                }
                alert("Unvalidated data that would be submitted:\n" + s);
            });
            return false;
        </script>
        <table style="border: 1px solid #9f9f9f;" cellspacing="10">
            <tr>
                <td>
                    <label for="name">Name:</label>
                </td>
                <td>
                    <input type="text" name="name" required="true" data-dojo-type="dijit/form/ValidationTextBox"/>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="dob">Order:</label>
                </td>
                <td>
                    <input type="radio" name="order" value="Food"> Food
                    <input type="radio" name="order" value="Drinks"> Drinks
                </td>
            </tr>
        </table>

        <button data-dojo-type="dijit/form/Button" onClick="alert('Form is ' + (myFormThree.validate()?'':'not ') + 'valid');return false">
            Validate form
        </button>
        <button data-dojo-type="dijit/form/Button" type="submit" name="submitButtonThree" value="Submit">Submit</button>
        <button data-dojo-type="dijit/form/Button" type="reset">Reset</button>
    </div>


Accessibility
=============

The Form widget acts as a container for other widgets and HTML elements and has no specific behaviors affecting accessibility.
