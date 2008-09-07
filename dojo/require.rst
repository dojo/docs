## page was renamed from 1.2/dojo/require
#format dojo_rst

dojo.require
============

:Status: Contributed, Draft
:Version: 1.0

.. contents::
  :depth: 2

============
dojo.require
============

Loads a Dojo module, by name.

========
Overview
========

In order to use a Dojo module or widget, you have to load the module with dojo.require('modulename'). If you don't do that, your scripts will throw a "dojo.some not defined" or "dojo.some.randomFunction not defined". There are a few exceptions to this rule, which are explained below.

Dojo's package concept
----------------------

Dojo's code is split into modules which are similar to packages in Java except that in Dojo a module can contain both constructors (like classes in Java) and simple functions. For example, the "dojo.string" module contains a number of functions, such as `dojo.string.substitute() <dojo/string>`_. The "`dojo.dnd <dojo/dnd>`_" module contains a number of constructors such as dojo.dnd.Container dojo.dnd.Source in additon to top-level functions and properties on the dojo.dnd object.

Naming conventions
------------------

Note the naming convention - functions, properties, and namespace objects start with a lowercase letter, and constructors (which are technically functions but act more like classes) start with a capital letter. Classes in Dijit preceded by an underscore typically denote a mixin, or baseClass.

dojo.require()'s comfort
------------------------

At first, it may seem painful to require all modules, but Dojo rewards by:

* Loading any dependent scripts for you. If `dijit.form.TextBox <dijit/form/TextBox>`_ requires `dojo.math <dojo/math>`_, you still need only require dijit.form.TextBox.
* Preventing loading Dojo packages twice. dojo.require will simply return if the package is already loaded.
* Allowing you to build streamlined versions of dojo. If you use dijit.form.TextBox a lot, you can build a custom version of dojo that loads dijit.form.TextBox quickly. Dojo.require() knows whether the function is already loaded, and so you don't have to change any of your code. See The Build System for a discussion.

So you might wonder "So, don't I have to require the dojo module itself to use dojo.require?" Nope. Any function in the top-level package "dojo" is loaded automatically (dojo.query(), dojo.byId(), etc.). These are Dojo's Core functions, and represent the most used functions according to usage patterns in the community. This is similar to the Java package java.lang, which is automatically available to all Java programs.

=====
Usage
=====

Simply pass it a string:

.. code-block :: javascript

  dojo.require("dojo.fx"); // load dojo/fx.js
  dojo.require("dojox.widget.Toaster"); // load dojox/widget/Toaster.js

========
Examples
========

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
        // The following line will load the Dijit Widget "dijit.form.Button".
        // Without this line you will get a "dijit.form.Button not defined" error.
        dojo.require("dijit.form.Button");
    </script>

  .. cv:: html

    <div dojoType="dijit.form.Button">
        Just an example button, please don't click
        <script type="dojo/method" event="onClick" args="evt">
            alert("I said, please don't click!");
        </script>
    </div>

=====
Notes
=====

dojo.require works directly with `dojo.addOnLoad <dojo/addOnLoad>`_. While modules are being loaded, any addOnLoad functions will wait until all dependencies are solved before firing again.
