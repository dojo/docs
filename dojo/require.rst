## page was renamed from 1.2/dojo/require
#format dojo_rst

dojo.require
============

:Status: Contributed, Draft
:Version: 1.0

Loads a Dojo module, by name. 

Overview
--------

Dojo's code is split into modules which are similar to packages in Java except that in Dojo a module can contain both constructors (like classes in Java) and simple functions. For example, the "dojo.string" module contains a number of functions, such as `dojo.string.substitute() <dojo/string>`_. The "`dojo.dnd <dojo/dnd>`_" module contains a number of constructors such as dojo.dnd.Container dojo.dnd.Source in additon to top-level functions and properties on the dojo.dnd object.

Note the naming convention - functions, properties, and namespace objects start with a lowercase letter, and constructors (which are technically functions but act more like classes) start with a capital letter. Classes in Dijit preceded by an underscore typically denote a mixin, or baseClass.

It may seem painful to require all modules, but Dojo rewards by:

    * Loading any dependent scripts for you. If `dijit.form.TextBox <dijit/form/TextBox>`_ requires `dojo.math <dojo/math>`_, you still need only require dijit.form.TextBox.
    * Preventing loading Dojo packages twice. dojo.require will simply return if the package is already loaded.
    * Allowing you to build streamlined versions of dojo. If you use dijit.form.TextBox a lot, you can build a custom version of dojo that loads dijit.form.TextBox quickly. Dojo.require() knows whether the function is already loaded, and so you don't have to change any of your code. See The Build System for a discussion.

So you might wonder "So, don't I have to require the dojo module itself to use dojo.require?" Nope. Any function in the top-level package "dojo" is loaded automatically (dojo.query(), dojo.byId(), etc.). These are Dojo's Core functions, and represent the most used functions according to usage patterns in the community. This is similar to the Java package java.lang, which is automatically available to all Java programs.

Notes
-----

dojo.require works directly with `dojo.addOnLoad <dojo/addOnLoad>`_. While modules are being loaded, any addOnLoad functions will wait until all dependencies are solved before firing again.

 
