## page was renamed from 1.2/dojo/addOnLoad
#format dojo_rst

dojo.addOnLoad
==============

dojo.addOnLoad is a fundamental aspect of using Dojo. Passing addOnLoad a function will register the function to run when the Dom is ready. This differs slightly from document.ready and body.onload in that addOnLoad waits until all dojo.require() (and their recursive dependencies) have loaded before firing. 

Sooner or later, every Javascript programmer tries something like this:

.. code-block :: javascript
  :linenos:

  <script>
    if(dayOfWeek == "Sunday"){
       document.musicPrefs.other.value = "Afrobeat";
    }
  </script>
  <form name="musicPrefs">
    <input type="text" name="other">
  ...

It doesn't work because the "other" control is not defined yet. You can move the code to the bottom of the page, but that removes the linear nature of HTML. If you're reading the code, you want to zero in on a control, and see the code that influences it close by.

dojo.addOnLoad(...) defers script execution until all the HTML and modules are loaded. So this code:

.. code-block :: javascript
  :linenos:

  function setAfrobeat(){
     document.musicPrefs.other.value="Afrobeat";
  }
  dojo.addOnLoad(setAfrobeat);

conveniently replaces the one above. When the function is small, you may prefer to write it inline:

.. code-block :: javascript
  :linenos:

  dojo.addOnLoad(
    function(){
      document.musicPrefs.other.value="Afrobeat";
    }
  );

This is the function literal or anonymous function construct of JavaScript. If it looks really, really wierd to you, take a peek ahead at Functions as Variables for an explanation.

Another use is "embedded onLoad". We'll define an addOnLoad function (anonymous), and within that function call dojo.require() to load more components, registering a second addOnLoad function. The first will execute very quickly (assuming you are only loading dojo.js), and the second will wait until the package dependencies are complete:

.. code-block :: javascript
  :linenos:

  dojo.addOnLoad(function(){
    dojo.require("dijit.Dialog");
    dojo.require("dijit.TitlePane");
    dojo.addOnLoad(function(){
        // dijit.Dialog and friends are ready, create one from a node with id="bar"
        var dialog = new dijit.Dialog({ title:"Lazy Loaded" }, "bar"); 
    });
  });

If no in-flight XHR activity is found, and all dependencies have been solved, addOnLoad functions fire immediately. 

========
Examples
========

Lets dynamically include code on button press and fire an event once the code is included

.. cv-compound::

  The HTML markup is pretty simple, just a button to click on

  .. cv:: html
    :label: A dijit button

    <button dojoType="dijit.form.Button" id="buttonOne">Click me!</button>

  The JavaScript code fires a dojo.require when you click the button.

  .. cv:: javascript
    :label: The javascript code

    <script type="text/javascript">
    dojo.require("dijit.form.Button");

    // connect to button
    dojo.addOnLoad(function(){
      dojo.connect(dojo.byId("buttonOne"), "onclick", "loadCode");
    });

    function loadCode(){
      alert("About to dojo.require dijit.layout.BorderContainer. Currently is is: "+dijit.layout.BorderContainer);
      dojo.require("dijit.layout.BorderContainer");
      
      // add a dojo.adOnLoad
      dojo.addOnLoad(function(){
        alert("This fires after BorderContainer is included. Now it is: "+dijit.layout.BorderContainer);
      });
    }

    </script>
