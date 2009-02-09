#format dojo_rst

dojox.form.PasswordValidator
============================

:Status: Draft
:Version: 1.2
:Project owner: Nathan Toone
:Available: since V1.2

.. contents::
   :depth: 2

A dijit._FormWidget that simplifies the "Old/New/Validate" password mechanism found on many web pages.


============
Introduction
============

Many web page use a 3-input mechanism for changing/updating passwords, where the user enters in their old password, their new password, and then validates their new password.  This widget is intended as a way to simplify that process - and provide the user with feedback along the way.


=====
Usage
=====

To use the PasswordValidator, you wrap 2 or 3 html input widgets with the validator:

.. code-block :: html

  <div dojoType="dojox.form.PasswordValidator" name="pwValidate">
    <input type="password" pwType="old" />
    <input type="password" pwType="new" />
    <input type="password" pwType="verify" />
  </div>

These input widgets must have a **pwType** attribute, which is one of the following values:

* **old** the input used for the old (current) password - this input is optional

* **new** the input used for the new password

* **verify** the input used to validate the new password

You can also specify the following options to the PasswordValidator widget:

* **name** This value will be passed to the form on submit - similar to other form widgets

* **oldName** This is the name of the "old" input - if you want it to be passed to the form as well.  If missing, then the original password will not be sent to the form when submitted

* **pwCheck** This function will be called, and passed in the old password for checking for real-time validation and user feedback.  Please be aware of security implications of doing this.  If you use a callback to your server, it will need to be synchronous.  Return true if the password passes the check, false otherwise.

pwCheck Security
----------------

The pwCheck function of this widget will be called to validate the old (current) password.  Please do not put this check in the actual javascript code (or HTML page) - as this is horribly insecure.


========
Examples
========

A simple Password Validator - with no "old" password
----------------------------------------------------

This example shows a password validator, prompting the user to enter and validate their password

.. cv-compound ::

  .. cv :: javascript

    <script>
      dojo.require("dojox.form.PasswordValidator");
    </script>

  .. cv :: html

    <div dojoType="dojox.form.PasswordValidator" name="password">
        <label>Password: <input type="password" pwType="new" /></label><br>
        <label>Validate: <input type="password" pwType="verify" /></label><br>
    </div>

A simple Password Validator - with "old" password
-------------------------------------------------

This example shows a password validator, and prompts the for the current password as well (it has a hard-coded original password of "password")

.. cv-compound ::

  .. cv :: javascript

    <script>
      dojo.require("dojox.form.PasswordValidator");
    </script>

  .. cv :: html

    <div dojoType="dojox.form.PasswordValidator" name="password">
        <script type="dojo/method" event="pwCheck" args="password">
            /* NOTE: DO NOT EVER EVER EVER DO THIS - ONLY AN EXAMPLE */
            return password == "password"
        </script>
        <label>Old Password: <input type="password" pwType="old" /></label><br>
        <label>Password: <input type="password" pwType="new" /></label><br>
        <label>Validate: <input type="password" pwType="verify" /></label><br>
    </div>
