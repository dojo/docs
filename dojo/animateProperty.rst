#format dojo_rst

dojo.animateProperty
====================

:Status: Draft
:Version: 1.2

.. contents::
  :depth: 3

Examples
--------

How can I change the framerate of an animation?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
By default dojo runs its animations with 100 frames/second. This can be too fast in certain use scenarios and you want the whole animation to run lots slower:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button"); // we require the button to make our demo look fancy
    
    function animateSlow(){
      dojo.animateProperty({
        node: "animateProperty", duration: 10000,
        properties: {
          fontSize: { start: "12px", end: "30px" }
        },
        rate: 10
      }).play();
    }

    function animateDefault(){
      dojo.animateProperty({
        node: "animateProperty", duration: 10000,
        properties: {
          fontSize: { start: "12px", end: "30px" }
        }
      }).play();
    }
    </script>

  .. cv:: html

    <p><button dojoType="dijit.form.Button" onClick="animateDefault()">Animate (default fps)</button> <button dojoType="dijit.form.Button" onClick="animateSlow()">Animate (5 fps)</button></p>
    <div id="animateProperty">This will be animated</div>
