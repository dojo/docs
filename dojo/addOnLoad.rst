.. _dojo/addOnLoad:

==============
dojo.addOnLoad
==============

dojo.addOnLoad() has been deprecated in favor of the (equivalent) :ref:`dojo.ready <dojo/ready>` function, and more recently, in favor of the :ref:`The AMD API <loader/amd>`, and the :ref:`domReady! plugin <dojo/domReady>`.

The documentation below is preserved for legacy purposes:

Old Documentation
=================
dojo.addOnLoad is a fundamental aspect of using Dojo. Passing addOnLoad a function will register the function to run when the Dom is ready. This differs slightly from document.ready and body.onload in that addOnLoad waits until all dependencies (and their recursive dependencies) have loaded before firing.

Sooner or later, every JavaScript programmer tries something like this:

.. js ::

    if(dayOfWeek == "Sunday"){
        document.musicPrefs.other.value = "Afrobeat";
    }

.. html ::

    <form name="musicPrefs">
        <input type="text" name="other">
        ...

It doesn't work because the "other" control is not defined yet. You can move the code to the bottom of the page, but that removes the linear nature of HTML. If you're reading the code, you want to zero in on a control, and see the code that influences it close by.

dojo.addOnLoad(...) defers script execution until all the HTML and modules are loaded. It is currently deprecated and replaced by dojo.ready function. When use dojo1.7, you should require 'dojo/ready' and use 'ready((...))' function instead. So this code:

.. js ::

  // Dojo 1.7 (AMD)
  function setAfrobeat(){
     document.musicPrefs.other.value="Afrobeat";
  }
  require("dojo/ready", function(ready){
       ready(function(){
           setAfrobeat();
       });
  });

.. js ::

  // Dojo < 1.7
  function setAfrobeat(){
     document.musicPrefs.other.value="Afrobeat";
  }
  dojo.addOnLoad(setAfrobeat);

conveniently replaces the one above. When the function is small, you may prefer to write it inline:

.. js ::

    // Dojo 1.7+ (AMD)
    require("dojo/ready", function(ready){
        ready(function(){
            document.musicPrefs.other.value="Afrobeat";
        });
    });

.. js ::

    // Dojo < 1.7
    dojo.addOnLoad(function(){
        document.musicPrefs.other.value="Afrobeat";
    });

This is the function literal or anonymous function construct of JavaScript. If it looks really, really weird to you, take a peek ahead at Functions as Variables for an explanation.

Another use is "embedded onLoad". We'll define an addOnLoad function (anonymous), and within that function will load more components, registering a second addOnLoad function. The first will execute very quickly (assuming you are only loading dojo.js), and the second will wait until the package dependencies are complete:

.. js ::

    // Dojo 1.7 (AMD)
    require("dojo/ready", function(ready){
        ready(function(){
            require(["dijit/Dialog", "dijit/TitlePane"], function(dialog, pane){
                ready(function(){
                    // dijit.Dialog and friends are ready, create one from a node with id="bar"
                    var dialog = new dialog({ title:"Lazy Loaded" }, "bar");
                });
            });
        });
    });

.. js ::

    // Dojo < 1.7
    dojo.addOnLoad(function(){
        dojo.require("dijit.Dialog");
        dojo.require("dijit.TitlePane");
        dojo.addOnLoad(function(){
            // dijit.Dialog and friends are ready, create one from a node with id="bar"
            var dialog = new dijit.Dialog({ title:"Lazy Loaded" }, "bar");
        });
    });

If no in-flight XHR activity is found, and all dependencies have been solved, addOnLoad functions fire immediately.

Examples
========

Let's dynamically include code on button press and fire an event once the code is included:

.. code-example ::

  The HTML markup is pretty simple, just a button to click on

  .. html ::

    <button data-dojo-type="dijit/form/Button" id="buttonOne">Click me!</button>

  The JavaScript code fires a dojo.require when you click the button.

  .. js ::

    dojo.require("dijit.form.Button");

    // connect to button
    dojo.addOnLoad(function(){
        dojo.connect(dojo.byId("buttonOne"), "onclick", "loadCode");
    });

    function loadCode(){
        alert("About to dojo.require dijit.layout.BorderContainer.");
        dojo.require("dijit.layout.BorderContainer");
      
        // add a dojo.addOnLoad
        dojo.addOnLoad(function(){
            alert("This fires after BorderContainer is included. Now it is: " + dijit.layout.BorderContainer);
        });
    }
