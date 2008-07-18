#format dojo_rst

:Status: Contributed, Draft
:Version: 1.0

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

dojo.addOnLoad(...) defers script execution until all the HTML is loaded. So this code:

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

Examples
--------

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
