#format dojo_rst


DOH Robot
=========

doh.robot adds an API to the Dojo Object Harness (DOH) unit test framework that enables testers to automate their UI tests using real, cross-platform, system-level input events.   This document describes the value of doh.robot for unit and accessibility testing, and how to get started using it.

===============================
The challenge of Web UI testing
===============================

Web UI testing frameworks like Selenium and Windmill already contain browser automation elements suitable for many different types of unit and acceptance tests of application code. But each of these frameworks has an underlying catch: the input events they create are synthetic. On one hand, synthetic events are great because synthetic events don't use the native input queue; you can run your tests in parallel across multiple browsers and windows all on one machine without a fight for the mouse and keyboard.

But the problem with synthetic events is that browsers don't trust synthetic events enough to let them execute their default action. For example, if you create a synthetic Tab keypress (expecting the browser to shift focus to the next element in the tab order), the focus won't actually move, because the browser doesn't trust the synthetic keypress enough to allow it to execute its default action. In a worse case, if you have a widget with onmouseover and onmousedown events, you would expect that the user would not be able to trigger the onmousedown without first triggering the onmouseover. But with synthetic events, this sort of common sense fails; you can easily send a click to an element without registering mouse movement over it, never mind the onmouseout from the previous element and the *hundreds* of onmousemoves a real user would generate in between. The result is that existing Web UI frameworks fail to support the testing of common requirements of Web applications like keyboard accessibility, and can be frustrating to deal with when you have to manually dispatch synthetic mouse events that would fire automatically for a human tester.

=============================
What doh.robot can do for you
=============================

We designed the doh.robot to enhance the DOH runner's ability to drive unit tests. Like other test frameworks, doh.robot provides testers with an API that enables them to simulate user interaction. However, we took a different approach to dispatching events: instead of using synthetic events, we used the cross-browser and cross-platform Java applet technology to place real events on the native event queue, as if a real person performed the action. This means that when you use doh.robot to execute your unit tests, browsers will trust the events doh.robot creates from your commands and will handle any and all contingent events for you. So when you tell doh.robot to send a Tab keypress, you can fully expect the Tab to move focus to the next element in the Tab order, as if a real user pressed Tab. And when you tell doh.robot to click an element, you can fully expect to get the onmouseover before the onmousedown, as well as all of those hundreds of onmousemoves a real user would generate in between. When you use the DOH test runner in conjunction with doh.robot, you can easily automate and report the results of numerous accessibility and UI unit tests that would otherwise require manual, visual inspection by a real person.

============
The 3 robots
============

From a high level perspective, DOH comes with three incrementally more powerful versions of the doh.robot automation suitable for different testing requirements:

  * doh.robot
  * dojo.robot
  * dijit.robot

doh.robot
---------
Like DOH, the basic doh.robot was built to run without Dojo. You can load it into a unit test by adding a script tag pointing to util/doh/robot.js. doh.robot is perfect for automatically testing keyboard accessibility in any Web application, even applications that don't use Dojo or simply use a version of Dojo older than 1.2.

dojo.robot
----------
dojo.robot is an extension to the doh.robot. You load it using dojo.require("dojo.robot"). Using Dojo Core technology, the dojo.robot adds mouse movement commands to the DOH API so test writers with access to Dojo 1.2 can consistently move the mouse to UI elements even across a wide variety of browser window sizes and resolutions.

dijit.robot
-----------
dijit.robot is the final extension to the doh.robot packaged with dijit. You load it using dojo.require("dijit.robot"). It further augments the dojo.robot's mouse handling with Dijit's cross-browser automatic scrolling. If you are concerned about writing tests that involve scrolling a lot of elements into view, dijit.robot is the best way to ensure that elements are always in view for the mouse to click them.


=================
The doh.robot API
=================

Since there are 3 robots, you can find the latest APIs documented in util/doh/robot.js, dojo/robot.js, and dijit/robot.js. The commands all have certain semantics in common, so I will describe them here using doh.robot.typeKeys as an example:

.. code-block:: javascript

  typeKeys: function(/*String||Number*/ chars, /*Integer, optional*/ delay, /*Integer, optional*/ duration){
        // summary:
        //            Types a string of characters in order, or types a dojo.keys.* constant.
        //
        // description:
        //           Types a string of characters in order, or types a dojo.keys.* constant.
        //           Example: doh.robot.typeKeys("dijit.ed", 500);
        //
        // chars:
        //            String of characters to type, or a dojo.keys.* constant
        //
        // delay:
        //            Delay, in milliseconds, to wait before firing.
        //            The delay is a delta with respect to the previous automation call.
        //            For example, the following code ends after 600ms:
        //                  doh.robot.mouseClick({left:true}, 100) // first call; wait 100ms
        //                  doh.robot.typeKeys("dij", 500) // 500ms AFTER previous call; 600ms in all
        //
        // duration:
        //            Time, in milliseconds, to spend pressing all of the keys.
        //
    }


delay:
------
Each doh.robot method takes a delay parameter. Rather than forcing you to litter your code with setTimeouts, we call setTimeout for you behind the scenes. We also do some additional thread synchronization on the Java side to ensure that your events fire in the order you called them and not the order the browser feels like evaluating the setTimeouts.

As the comments show, delays are incremental. Normally, when you write setTimeouts one after another other in a sequence, you have to specify the exact time each one should execute. This is fine, but when you go back to maintain your test and decide to add new actions in between the setTimeouts, you normally have to go back and add time to each and every setTimeout. But with doh.robot's incremental model, test maintenence is easy: you can freely insert or remove commands and the doh.robot will adjust the timings for you automatically. And you don't have to worry about how long it takes a command to execute; the next doh.robot command won't happen until the current one has absolutely finished. Still, it's a good idea to give the browser's rendering system and event dispatcher enough time to catch up with the robot between commands; 500ms is a good delay to use for each command.

Also, if you are making AJAX requests to a remote system, such as loading data into a Grid, keep in mind that the request might take a variable amount of time. You could just set a really long timeout, but another practice would be to dojo.connect into an event handler and continue the test from there, when you are absolutely sure that the data has arrived.

duration:
---------
Several doh.robot methods also take a duration parameter. The duration tells doh.robot approximately how much time it should take to execute the command. For example, calling doh.robot.typeKeys("dij", 500, 1800) will instruct doh.robot to start typing dij after 500ms and to wait (1800 ms)/(3 chars) = 600 ms/char before each keypress. As with the delay parameter, doh.robot automatically sequences calls to account for the duration, so you don't have to add the duration into the next command's delay; doh.robot will add it in for you at runtime.


=======================
Writing doh.robot tests
=======================

Here is a "hi again" test using the doh.robot that clicks in a textbox containing "hi" and adds " again":

.. code-block :: javascript

    doh.register("doh.robot",
    {
        name:"dojorobot1",
        timeout:6900,
        setUp:function(){
                document.getElementById('textbox').value="hi";
        },
        runTest:function(){
                var d=new doh.Deferred();
                doh.robot.mouseMove(30, 30, 500);
                doh.robot.mouseClick({left:true}, 500);
                doh.robot.typeKeys(" again", 500, 2500);
                doh.robot.sequence(function(){
                        if(document.getElementById('textbox').value=="hi again"){
                                document.getElementById('textbox').value += ": passed";
                                d.callback(true);
                        }else{
                                document.getElementById('textbox').value += ": failed";
                                d.errback(new Error("Expected value 'hi again', got "+document.getElementById('textbox').value));
                        }
                }, 900);
                return d;
        }
    });
    doh.run();


See it in action:
http://archive.dojotoolkit.org/nightly/checkout/util/doh/tests/robot.html.

If you've ever written a DOH test or a JUnit test before, the structure should look very familiar. You register tests to groups, like "doh.robot" in this case. A test has a unique name, and a timeout where it gives up and moves on to the next test. You drive a test using setUp, runTest, and tearDown functions.

You write doh.robot tests like deferred DOH tests. DOh's deferred test model indirectly enables test writers to pause the test while AJAX requests happen. doh.robot uses the deferred model to pause the test while it interacts with the page. For the uninitiated, here is how a typical deferred DOH test flows on a high level:

  1. Instantiate a doh.Deferred object.
  2. Execute your commands.
  3. Set a timeout to check whether the test passed.
  4. Return the Deferred object to runTest immediately.

You can see what the concrete implementation of this flow looks like in the runTest function above. You store the doh.Deferred in a variable called d. Next, you write the robot commands themselves: the mouse moves to 30,30 on the screen, clicks the left mouse button, and types " again". Between each command, the robot waits 500ms. After about another second has elapsed, the test asserts that everything worked. You tell DOH a test passed in the Deferred model by calling d.callback(true). You tell DOH that something bad happened by calling d.errback and pass a new Error with the problem description. You can also do some visual formatting to indicate whether the test passed, for users running the test standalone (like you). Finally, you return the doh.Deferred object to the runTest function, signaling the DOH runner to wait for this test to finish.


======================================
dojo.robot and dijit.robot's value-add
======================================

The above test uses the basic doh.robot, and as such has two issues that could pose a problem in more sophisticated unit tests: first, it has to manually indicate that the test passed. If you either ran the test in the DOH runner, or ran the test standalone with Dojo available, you would be able to better see the results either in the runner's log or in the console at the bottom of the page. Second, it assumes that you have an absolutely positioned text element to click. For unit tests that rely on the browser's layout manager, or percent or em measurements, to lay out the page, pixel mouse movement isn't the ideal way to move the mouse. Fortunately Dojo 1.2 fills in this gap by adding a doh.robot.mouseMoveAt command:

.. code-block:: javascript

    mouseMoveAt : function(/*String||DOMNode||Function*/ node, /*Integer, optional*/ delay, /*Number, optional*/ offsetX, /*Number, optional*/ offsetY, /*Integer, optional*/ duration){
        // summary:
        //            Moves the mouse over the specified node at the specified relative x,y offset.
        //
        // description:
        //           Moves the mouse over the specified node at the specified relative x,y offset.
        //           You should manually scroll off-screen nodes into view; use dijit.robot for automatic scrolling support.
        //           If you do not specify an offset, mouseMove will default to move to the middle of the node.
        //           Example: to move the mouse over a ComboBox's down arrow node, call doh.mouseMoveAt(dijit.byId('setvaluetest').downArrowNode);
        //
        // node:
        //            The id of the node, or the node itself, to move the mouse to.
        //            If you pass an id or a function that returns a node, the node will not be evaluated until the movement executes.
        //            This is useful if you need to move the mouse to an node that is not yet present.
        //
        // delay:
        //            Delay, in milliseconds, to wait before firing.
        //            The delay is a delta with respect to the previous automation call.
        //            For example, the following code ends after 600ms:
        //                  doh.mouseClick({left:true}, 100) // first call; wait 100ms
        //                  doh.typeKeys("dij", 500) // 500ms AFTER previous call; 600ms in all
        //
        // offsetX:
        //            x offset relative to the node, in pixels, to move the mouse. The default is half the node's width.
        //
        // offsetY:
        //            y offset relative to the node, in pixels, to move the mouse. The default is half the node's height.
        //
        // duration:
        //            Approximate time Robot will spend moving the mouse
        //            The default is 100ms.
        //

Where as the simple mouseMove needs to know ahead of time where to move on the page, mouseMoveAt can compute the position of elements on the fly even for elements not on the DOM or off the screen at the start of the test! So if we were to rewrite the above DOH test using dojo.robot, it would look like:

.. code-block:: javascript

  dojo.require("dojo.robot");
    
  dojo.addOnLoad(function(){
    doh.register("doh.robot",
    {
        name:"dojorobot1",
        timeout:6900,
        setUp:function(){
                document.getElementById('textbox').value="hi";
        },
        runTest:function(){
                var d=new doh.Deferred();
                doh.robot.mouseMoveAt(document.getElementById('textbox'),500);
                doh.robot.mouseClick({left:true}, 500);
                doh.robot.typeKeys(" again", 500, 2500);
                doh.robot.sequence(function(){
                        if(document.getElementById('textbox').value=="hi again"){
                                document.getElementById('textbox').value += ": passed";
                                d.callback(true);
                        }else{
                                document.getElementById('textbox').value += ": failed";
                                d.errback(new Error("Expected value 'hi again', got "+document.getElementById('textbox').value));
                        }
                }, 900);
                return d;
        }
    });
    doh.run();
  });

This would cause the mouse to click the middle of the textbox before it starts typing. The dojo.robot tries to scroll the element into view using the browser's native scrollIntoView function so that no matter where the element is, even if it is presently off the screen, the dojo.robot can scroll it in and click it. But this approach still has one problem: native scrollIntoView does not work consistently across all browsers. Enter dijit.robot: dijit.robot enhances the dojo.robot with dijit's scrollIntoView algorithm, making scrollIntoView view consistent across all browsers. It's trivial to use this feature: just swap dojo.require("dojo.robot") with dojo.require("dijit.robot") and everything will start scrolling correctly automatically.

====================
dojox.robot.recorder
====================

doh.robot includes a powerful record feature, called dojox.robot.recorder, that can track your interactions with a unit test and play them back. Record features of other frameworks do a good job tracking user interaction with native widgets, but have some trouble recording interactions with Dojo-enabled widgets and drag and drop in general. Fortunately, dojox.robot.recorder is specifically designed to record user interaction with both native and Dojo-style widgets in mind. The recorder even generates code for drag and drop, which can be a useful guideline for writing tests that work across the different browsers you test.

To use dojox.robot.recorder:
----------------------------

  1. Add dojo.require("dojox.robot.recorder") to your unit test.
  2. Load the unit test and click the body of the page.
  3. Press Ctrl+Alt+Enter. You will get an alert verifying that the recording process started.
  4. Interact with the unit test. Note: it's easiest to debug test failures when you break them up into only a few actions each.
  5. When you are finished, click the body again and press Ctrl+Alt+Enter. Autogenerated code will appear on the page for you to copy into a dojo.addOnLoad in the unit test.
  6. Fill in the test passed condition (it is a /*comment*/ in the if) and make any tweaks you would like to the autogenerated code.
  7. When you have recorded all of your tests, remember to add a doh.run() call after all of the tests. Otherwise, the tests will not start!

Examples
--------

Here are some example tests modeling common UI interactions. These tests were generated by the dojox.robot.recorder and then tweaked to work across all browsers. View each page's source to see the test code.

 * http://archive.dojotoolkit.org/nightly/dojotoolkit/dijit/tests/form/robot/test_ComboBox.html (Pressing Tab to cycle focus, clicking elements, typing text)
 * http://archive.dojotoolkit.org/nightly/dojotoolkit/dijit/tests/form/robot/test_Slider.html (drag and drop of percent width Slider)
 * http://archive.dojotoolkit.org/nightly/dojotoolkit/dijit/tests/form/robot/test_Spinner.html (holding a key down to test a typematic widget, mouse wheel support in doh.robot)
 * http://archive.dojotoolkit.org/nightly/dojotoolkit/dojo/tests/dnd/robot/test_dnd.html (drag and drop of elements into containers)
