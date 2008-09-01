#format dojo_rst

dojo.animateProperty
====================

:Status: Draft
:Version: 1.2

.. contents::
  :depth: 3

dojo.animateProperty is a very useful method for animating CSS properties. Usecases are for example fading a background color from red to green to indicate status changes.

Examples
--------

How can I change the framerate of an animation?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
By default dojo runs its animations with 100 frames/second. This can be too fast in certain use scenarios and you want the whole animation to run lots slower. 
To change the framerate you use the rate attribute which defines the pause between each frame. So if you want 5 frames per second you need a rate of 200 (miliseconds between each frame)

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button"); // we require the button to make our demo look fancy
    
    function animateSlow(){
      dojo.animateProperty({
        node: dojo.byId("animateProperty"), duration: 10000,
        properties: {
          fontSize: { start: "12", end: "30" }
        },
        rate: 1000
      }).play();
    }

    function animateDefault(){
      dojo.animateProperty({
        node: dojo.byId("animateProperty"), duration: 10000,
        properties: {
          fontSize: { start: "12", end: "30" }
        }
      }).play();
    }
    </script>

  .. cv:: html

    <p><button dojoType="dijit.form.Button" onClick="animateDefault()">Animate (default fps)</button> <button dojoType="dijit.form.Button" onClick="animateSlow()">Animate (1 fps)</button></p>
    <div id="animateProperty">This will be animated</div>
