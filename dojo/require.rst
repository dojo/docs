#format dojo_rst

If you've followed through the previous sections, you already know how important dojo.require is. In general if you use a function
dojo.someModule.someFunction();

You need to include
dojo.require("dojo.someModule");

If you don't, your scripts will throw a "dojo.someModule not defined" or "dojo.someModule.someFunction not defined..

Dojo's code is split into modules which are similar to packages in Java except that in Dojo a module can contain both constructors (like classes in Java) and simple functions. For example, the "dojo.string" module contains a number of functions, such as dojo.string.substitute(). The "dojo.dnd" module contains a number of constructors such as dojo.dnd.Container dojo.dnd.Source in additon to top-level functions and properties on the dojo.dnd object. We'll learn a lot more about this in Modules

Note the naming convention - functions, properties, and namespace objects start with a lowercase letter, and constructors (which are technically functions but act more like classes) start with a capital letter.

It may seem painful to require all modules, but dojo rewards by:

    * Loading any dependent scripts for you. If dijit.form.TextBox requires dojo.math, you still need only require dijit.form.TextBox.
    * Preventing loading dojo packages twice. dojo.require will simply return if the package is already loaded.
    * Allowing you to build streamlined versions of dojo. If you use dijit.form.TextBox a lot, you can build a custom version of dojo that loads dijit.form.TextBox quickly. Dojo.require() knows whether the function is already loaded, and so you don't have to change any of your code. See The Build System for a discussion.

So you might wonder "So, don't I have to require the dojo module itself to use dojo.require?" Nope. Any function in the top-level package "dojo" is loaded automatically (dojo.query(), dojo.byId(), etc.). These are dojo's Core functions, and represent the most used functions according to usage patterns in the community. This is similar to the Java package java.lang, which is automatically available to all Java programs.
