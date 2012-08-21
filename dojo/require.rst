.. _dojo/require:

============
dojo.require
============

:since: V?

.. contents ::
    :depth: 2

Loads a Dojo module, by name.


Introduction
============

In order to use a Dojo module or widget, you have to load the module with dojo.require('modulename'). If you don't do that, your scripts will throw a "dojo.some not defined" or "dojo.some.randomFunction not defined". There are a few exceptions to this rule, which are explained below.

Dojo's package concept
----------------------

Dojo's code is split into modules which are similar to packages in Java except that in Dojo a module can contain both constructors (like classes in Java) and simple functions. For example, the "dojo.string" module contains a number of functions, such as :ref:`dojo.string.substitute() <dojo/string>`. The ":ref:`dojo.dnd <dojo/dnd>`" module contains a number of constructors such as dojo.dnd.Container dojo.dnd.Source in addition to top-level functions and properties on the dojo.dnd object.

Naming conventions
------------------

Note the naming convention - functions, properties, and namespace objects start with a lowercase letter, and constructors (which are technically functions but act more like classes) start with a capital letter. Classes in Dijit preceded by an underscore typically denote a mixin, or baseClass.

dojo.require()'s comfort
------------------------

At first, it may seem painful to require all modules, but Dojo rewards by:

* Loading any dependent scripts for you.

  If :ref:`dijit.form.NumberTextBox <dijit/form/NumberTextBox>` requires :ref:`dojo.number <dojo/number>`, you still need only require dijit.form.NumberTextBox.

* Preventing loading Dojo packages twice.

  dojo.require will simply return if the package is already loaded.

* Allowing you to build streamlined versions of dojo.

  If you use dijit.form.TextBox a lot, you can build a custom version of dojo that loads dijit.form.TextBox quickly. Dojo.require() knows whether the function is already loaded, and so you don't have to change any of your code. See The Build System for a discussion.

So you might wonder "So, don't I have to require the dojo module itself to use dojo.require?" Nope. Any function in the top-level package "dojo" is loaded automatically (dojo.query(), dojo.byId(), etc.). These are Dojo's Core functions, and represent the most used functions according to usage patterns in the community. This is similar to the Java package java.lang, which is automatically available to all Java programs.

Cooperation with addOnLoad
---------------------------

dojo.require works directly with :ref:`dojo.addOnLoad <dojo/addOnLoad>`. While modules are being loaded, any addOnLoad functions will wait until all dependencies are solved before firing again.

Additionally, you can re-call addOnLoad anytime you immediately call dojo.require, in order to ensure the modules and dependencies are ready. Even after page load!

.. js ::
  
  // Dojo 1.7 (AMD)
  require(["dojo/ready", "dojo/fx"], function(ready, fx){
       ready(function(){
             require(["dijit/form/Button", "dojo/_base/window"], function(Button, win){
                  ready(function(){
                        new Button({}).placeAt(win.body());
                  });
             });
       });
  });


.. js ::
  
  // Dojo < 1.7
  dojo.require("dojo.fx");
  dojo.addOnLoad(function(){
      dojo.require("dijit.form.Button");
      dojo.addOnLoad(function(){
           new dijit.form.Button({}).placeAt(dojo.body());
      });
  });

Usage
=====

Simply pass it a string:

.. js ::
    
    // Dojo 1.7 (AMD)
    // load dojo/fx.js:
    require(["dojo/fx"], function(fx){
        // Write your code here
    });
    
    // load dojox/widget/Toaster.js:
    require(["dojo/widget/Toaster"], function(Toaster){
        // Write your code here
    });

.. js ::

  // Dojo <1.7
  // load dojo/fx.js:
  dojo.require("dojo.fx");

  // load dojox/widget/Toaster.js:
  dojo.require("dojox.widget.Toaster");

Throughout Dojo, the pattern above remains consistent. However, by using ``paths`` Dojo configuration flag in your code, you are able to redefine the meaning of parts of namespaces.

Examples
========

.. code-example ::

  .. js ::

        // The following line will load the Dijit Widget "dijit.form.Button".
        // Without this line you will get a "dijit.form.Button not defined" error.
        dojo.require("dijit.form.Button");

  .. html ::

    <div data-dojo-type="dijit.form.Button">
        Just an example button, please don't click
        <script type="dojo/on" data-dojo-event="click" data-dojo-args="evt">
            alert("I said, please don't click!");
        </script>
    </div>


See Also
========

* :ref:`The Dojo Loader <loader/amd>` - Further information on the loading process
