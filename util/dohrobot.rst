.. _util/dohrobot:

=========
DOH Robot
=========

.. contents ::
    :depth: 2

doh/robot provides an API that enables testers to automate their UI tests using real, cross-platform, system-level input events.
This document describes the value of doh/robot for unit and accessibility testing, and how to get started using it.

The challenge of Web UI testing
===============================

Web UI testing frameworks like Selenium and Windmill already contain browser automation elements suitable for many
different types of unit and acceptance tests of application code. But each of these frameworks has an underlying catch:
the input events they create are synthetic.
On one hand, synthetic events are great because synthetic events don't use the native input queue;
you can run your tests in parallel across multiple browsers and windows all on one machine without a fight for the mouse
and keyboard.

But the problem with synthetic events is that browsers don't trust synthetic events enough to let them execute their
default action.
For example, if you create a synthetic Tab keypress (expecting the browser to shift focus to the next element in the
tab order), the focus won't actually move, because the browser doesn't trust the synthetic keypress enough to allow it
to execute its default action.
In a worse case, if you have a widget with onmouseover and onmousedown events, you would expect that the user would not
be able to trigger the onmousedown without first triggering the onmouseover.
But with synthetic events, this sort of common sense fails; you can easily send a click to an element without
registering mouse movement over it, never mind the onmouseout from the previous element and the *hundreds* of
onmousemoves a real user would generate in between.
The result is that existing Web UI frameworks fail to support the testing of common requirements of Web applications
like keyboard accessibility, and can be frustrating to deal with when you have to manually dispatch synthetic
mouse events that would fire automatically for a human tester.

What doh/robot can do for you
=============================

We designed the doh/robot to enhance the DOH runner's ability to drive unit tests.
Like other test frameworks, doh/robot provides testers with an API that enables them to simulate user interaction.
However, we took a different approach to dispatching events:
instead of using synthetic events, we used the cross-browser and cross-platform Java applet technology to place
real events on the native event queue, as if a real person performed the action.
This means that when you use doh/robot to execute your unit tests, browsers will trust the events doh/robot creates
from your commands and will handle any and all contingent events for you.
So when you tell doh/robot to send a Tab keypress, you can fully expect the Tab to move focus to the next element in
the Tab order, as if a real user pressed Tab.
And when you tell doh/robot to click an element, you can fully expect to get the onmouseover before the onmousedown,
as well as all of those hundreds of onmousemoves a real user would generate in between.
When you use the DOH test runner in conjunction with doh/robot,
you can easily automate and report the results of numerous accessibility and UI unit tests that would otherwise require
manual, visual inspection by a real person.

The 3 robots
============

From a high level perspective, there are three incrementally more powerful versions of the doh/robot
automation suitable for different testing requirements:

  * doh/robot
  * dojo/robot
  * dojo/robotx

doh/robot
---------
Like DOH, the basic doh/robot was built to run without Dojo.
You can load it into a unit test via:

.. js ::

    require(["doh/robot"], function(doh){
        ...
    });

(The load requires and AMD loader such as, but not limited to, dojo.js)

doh/robot is perfect for automatically testing keyboard accessibility in any Web application,
even applications that don't use Dojo or simply use a version of Dojo older than 1.2.

dojo/robot
----------
dojo/robot is an extension to doh/robot.
You load it using:


.. js ::

    require(["dojo/robot"], function(doh){
        ...
    });

Using Dojo Core technology, the dojo/robot module provides all the methods of doh/robot, and also
adds mouse movement commands so test writers with access to
Dojo 1.2+ can consistently move the mouse to UI elements even across a wide variety of browser window sizes and resolutions.
It further augments the mouse handling with dojo's cross-browser automatic scrolling.

dojo/robotx
-----------
dojo/robotx provides the API of dojo/robot, plus adds the initRobot() and waitForPageLoad() methods,
allowing one test file to control another test file, or application.
See the `Separating Robot Test Code From Application Code` section below for details.


The doh/robot API
=================

Since there are 3 robots, you can find the latest APIs documented in util/doh/robot, dojo/robot, and dojo/robotx.
The commands all have certain semantics in common, so I will describe them here using ``typeKeys()`` as an example:

.. js ::

  typeKeys: function(/*String||Number*/ chars, /*Integer, optional*/ delay, /*Integer, optional*/ duration){
        // summary:
        //            Types a string of characters in order, or types a dojo.keys.* constant.
        //
        // description:
        //           Types a string of characters in order, or types a dojo.keys.* constant.
        //           Example: robot.typeKeys("dijit.ed", 500);
        //
        // chars:
        //            String of characters to type, or a dojo.keys.* constant
        //
        // delay:
        //            Delay, in milliseconds, to wait before firing.
        //            The delay is a delta with respect to the previous automation call.
        //            For example, the following code ends after 600ms:
        //                  robot.mouseClick({left:true}, 100) // first call; wait 100ms
        //                  robot.typeKeys("dij", 500) // 500ms AFTER previous call; 600ms in all
        //
        // duration:
        //            Time, in milliseconds, to spend pressing all of the keys.
        //
    }


delay
-----
Each doh/robot method takes a delay parameter.
Rather than forcing you to litter your code with setTimeouts, we call setTimeout for you behind the scenes.
We also do some additional thread synchronization on the Java side to ensure that your events fire
in the order you called them and not the order the browser feels like evaluating the setTimeouts.

As the comments show, delays are incremental.
Normally, when you write setTimeouts one after another other in a sequence,
you have to specify the exact time each one should execute.
This is fine, but when you go back to maintain your test and decide to add new actions in between the setTimeouts,
you normally have to go back and add time to each and every setTimeout.
But with doh/robot's incremental model, test maintenance is easy: you can freely insert or remove commands
and the doh/robot will adjust the timings for you automatically.
And you don't have to worry about how long it takes a command to execute;
the next doh/robot command won't happen until the current one has absolutely finished.
Still, it's a good idea to give the browser's rendering system and event dispatcher enough time to catch up
with the robot between commands; 500ms is a good delay to use for each command.

Also, if you are making AJAX requests to a remote system, such as loading data into a Grid,
keep in mind that the request might take a variable amount of time.
You could just set a really long timeout, but another practice would be to dojo/aspect into an event handler
and continue the test from there, when you are absolutely sure that the data has arrived.

duration
--------
Several doh/robot methods also take a duration parameter.
The duration tells doh/robot approximately how much time it should take to execute the command.
For example, calling robot.typeKeys("dij", 500, 1800) will instruct doh/robot to start typing dij after 500ms
and to wait (1800 ms)/(3 chars) = 600 ms/char before each keypress.
As with the delay parameter, doh/robot automatically sequences calls to account for the duration,
so you don't have to add the duration into the next command's delay; doh/robot will add it in for you at runtime.


Writing doh/robot tests
=======================

Here is a "hi again" test using the doh/robot that clicks in a textbox containing "hi" and adds " again":

.. js ::

    require(["doh/runner", "doh/robot"], function(doh, robot){
        doh.register("doh/robot",
        {
            name: "dojorobot1",
            timeout: 6900,
            setUp: function(){
                document.getElementById('textbox').value="hi";
            },
            runTest: function(){
                var d = new doh.Deferred();
                robot.mouseMove(30, 30, 500);
                robot.mouseClick({left:true}, 500);
                robot.typeKeys(" again", 500, 2500);
                robot.sequence(d.getTestCallback(function(){
                    doh.is("hi again", document.getElementById('textbox').value);
                }), 900);
                return d;
            }
        });
        doh.run();
    });


See `robot.html <http://archive.dojotoolkit.org/nightly/checkout/util/doh/tests/robot.html>`_ in action.

If you've ever written a DOH test or a JUnit test before, the structure should look very familiar.
You register tests to groups, like "doh/robot" in this case.
A test has a unique name, and a timeout where it gives up and moves on to the next test.
You drive a test using setUp, runTest, and tearDown functions.

You write doh/robot tests like deferred DOH tests.
DOh's deferred test model indirectly enables test writers to pause the test while AJAX requests happen.
doh/robot uses the deferred model to pause the test while it interacts with the page.
For the uninitiated, here is how a typical deferred DOH test flows on a high level:

  1. Instantiate a doh.Deferred object.
  2. Execute your commands.
  3. Set a timeout to check whether the test passed.
  4. Return the Deferred object to runTest immediately.

You can see what the concrete implementation of this flow looks like in the runTest function above.
  1. You store the doh.Deferred in a variable called d.
  2. Next, you write the robot commands themselves: the mouse moves to 30,30 on the screen, clicks the left mouse button,
and types " again".
  3. Between each command, the robot waits 500ms.
  4. After about another second has elapsed, the test asserts that everything worked.
  5. It uses typical doh.is(), doh.f() etc. functions to test that everything worked, but wraps them in a d.getTestCallback()
so that failures/errors are reported to the caller even though they are detected asynchronously.
  6. Finally, you return the doh.Deferred object to the runTest function, signaling the DOH runner to wait for this test to finish.


dojo/robot's value-add
======================

The above test uses the basic doh/robot, and as such has two issues that could pose a problem in more sophisticated
unit tests: first, it has to manually indicate that the test passed.
If you either ran the test in the DOH runner, or ran the test standalone with Dojo available,
you would be able to better see the results either in the runner's log or in the console at the bottom of the page.
Second, it assumes that you have an absolutely positioned text element to click.
For unit tests that rely on the browser's layout manager, or percent or em measurements, to lay out the page,
pixel mouse movement isn't the ideal way to move the mouse.
Fortunately Dojo 1.2 fills in this gap by adding a ``mouseMoveAt()`` method to the doh/robot module:

.. js ::

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
        //            Approximate time Robot will spend moving the mouse.
        //            The default is 100ms.
        //

Where as the simple mouseMove needs to know ahead of time where to move on the page,
mouseMoveAt can compute the position of elements on the fly even for elements not on the DOM
or off the screen at the start of the test!
So if we were to rewrite the above DOH test using dojo/robot, it would look like:

.. js ::

    require(["doh/runner", "dojo/robot"], function(doh, robot){
        doh.register("doh/robot",
        {
            name: "dojorobot1",
            timeout: 6900,
            setUp: function(){
                document.getElementById('textbox').value="hi";
            },
            runTest: function(){
                var d = new doh.Deferred();
                robot.mouseMoveAt(document.getElementById('textbox'), 500);
                robot.mouseClick({left:true}, 500);
                robot.typeKeys(" again", 500, 2500);
                robot.sequence(d.getTestCallback(function(){
                    doh.is("hi again", document.getElementById('textbox').value);
                }), 900);
                return d;
            }
        });
        doh.run();
    });

This would cause the mouse to click the middle of the textbox before it starts typing.
The dojo/robot tries to scroll the element into view using the browser's native scrollIntoView function
so that no matter where the element is, even if it is presently off the screen,
the dojo/robot can scroll it in and click it.
Native scrollIntoView does not work consistently across all browsers, so dojo/robot has code
making scrollIntoView view consistent across all browsers.

dojox/robot/recorder
====================

doh/robot includes a powerful record feature, called dojox/robot/recorder, that can track your interactions
with a unit test and play them back.
Record features of other frameworks do a good job tracking user interaction with native widgets,
but have some trouble recording interactions with Dojo-enabled widgets and drag and drop in general.
Fortunately, dojox/robot/recorder is specifically designed to record user interaction with both native and
Dojo-style widgets in mind.
The recorder even generates code for drag and drop, which can be a useful guideline for writing tests that work across
the different browsers you test.

To use dojox/robot/recorder
---------------------------

  1. Add require([..., "dojox/robot/recorder", ...]) to your unit test.
  2. Load the unit test and click the body of the page.
  3. Press Ctrl+Alt+Enter. You will get an alert verifying that the recording process started.
  4. Interact with the unit test. Note: it's easiest to debug test failures when you break them up into only a few actions each.
  5. When you are finished, click the body again and press Ctrl+Alt+Enter. Autogenerated code will appear on the page for you to copy into a dojo.ready in the unit test.
  6. Fill in the test passed condition (it is a /*comment*/ in the if) and make any tweaks you would like to the auto-generated code.
  7. When you have recorded all of your tests, remember to add a doh.run() call after all of the tests. Otherwise, the tests will not start!

Examples
--------

Here are some example tests modeling common UI interactions. These tests were generated by the dojox.robot.recorder and then tweaked to work across all browsers. View each page's source to see the test code.

 * http://archive.dojotoolkit.org/nightly/dojotoolkit/dijit/tests/form/robot/ComboBox_a11y.html (Pressing Tab to cycle focus, clicking elements, typing text)
 * http://archive.dojotoolkit.org/nightly/dojotoolkit/dijit/tests/form/robot/Slider_mouse.html (drag and drop of percent width Slider)
 * http://archive.dojotoolkit.org/nightly/dojotoolkit/dijit/tests/form/robot/Spinner_a11y.html (holding a key down to test a typematic widget, mouse wheel support in doh/robot)
 * http://archive.dojotoolkit.org/nightly/dojotoolkit/dojo/tests/dnd/robot/test_dnd.html (drag and drop of elements into containers)


Separating Robot Test Code From Application Code
================================================

The previous sections describe methods for unit testing:
they assume that you are perfectly ok with modifying the test page to contain DOH test code.
But what if you are testing application code, say during an acceptance test phase,
and you absolutely can't modify your application code?
Or what if you are using doh/robot for accessibility testing and you want to test the tab order of your *application*
and not the tab order of some insignificant unit test?
The methods described in the previous post just won't work for you:
you would also have to insert test code into your application logic, which is bad.
What you really want is a test framework that can run in the background and won't interfere with your application code.

Clicking links
--------------
The previous sections also assumed that your tests are constrained to one page.
What if you need to write a test that clicks a link or a form submit button?
This is a very common requirement for testing Web applications: your customer gives you user stories,
scenarios an end-user might face while visiting your Web site.
The user is naturally going to click links that change the page.
But all of the examples you have seen so far of the DOH test framework
assume that the DOH framework lives in the Web page and is destroyed when the page changes.
You might wonder how to keep the DOH test framework running
even as the robot navigates away from the page that DOH first loaded.

What dojo/robotx can do for you
--------------------------------
dojo/robotx can load an arbitrary application and run automated doh/robot test scripts on the application environment.
This serves two purposes:

 1. It enables you to execute automated tests on release candidate builds of your applications, with no modifications to your application.
 2. It enables you to write long-lived tests that can smartly cross page boundaries and continue execution.

This is huge. Whereas with the plain doh/robot you had to insert test code into your application code, now with dijit.robotx you can keep your test code somewhere else. And whereas with doh/robot you had to embed test code into every page that the user story visited to ensure that the robot kept moving, now with dijit.robotx you can write the entire user story into just one file that spans any number of page changes in the user story. And whereas with doh/robot you had to upgrade your application to Dojo 1.2 to take full advantage of the robot's features, with dijit.robotx you can test any Web application with zero modifications, irrespective of the AJAX framework the application uses.

The dojo/robotx API
--------------------
The dojo/robotx module mixes in two functions to the doh/robot module: initRobot() and waitForPageToLoad(),
which exactly map to the two features listed above.

initRobot()
~~~~~~~~~~~~~~~~~~~~~
You use initRobot() to load an application for testing. Here is the syntax:

.. js ::

    initRobot: function(/*String*/ url){
        // summary:
        //    Opens the application at the specified URL for testing, redirecting dojo to point to the
        //    application environment instead of the test environment.
        //
        // url:
        //    URL to open. Any of the test's dojo.doc calls (e.g. dojo.byId()) will point to elements
        //    inside this application.
        //
    }

When you call initRobot(), the browser loads the application into a frame and points the test's Dojo context to the
frame's content. This means:

- The module export variable robot.doc will point to your application's document, and likewise
  robot.window will point to the window of the application's document.
- Functions part of Dojo, like dom.byId(), will fetch elements from your application's context.
- Robot functions like mouseMoveAt("foo") will refer to elements in the application's document.
- global variables and modules in the application can be accessed via robot.window, ex:
  robot.window.require("dijit/registry") (assuming that the applicaiton is AMD and has already loaded dijit/registry).

Standard global variables, like window and document, will point to the test script's environment, not the application environment.

You will only be able to assign variables their values once the tests execute.
I stress the last point. initRobot returns immediately, before your application is finished loading.
If you create variables outside of the scope of a test block and try to assign them values or DOM elements from your
application, they will all be invalid, because the application hasn't loaded yet.

So what do you do? Declare your variable names like you normally would, but don't assign them values yet.
Instead, make your first test assign the values. That way, you are guaranteed that your application's environment is available.

Example
~~~~~~~
Here is an example of a test that uses initRobot. The test is interacting with a completely separate page
`_Widget-ondijitclick.html <http://archive.dojotoolkit.org/nightly/checkout/dijit/tests/_Widget-ondijitclick.html>`_.
Notice that there is no robot code in the page that the robot is testing.
Now here is the separate test script that is automating that page:

.. js ::

		require([
			"doh/runner", "dojo/robotx",
			"dojo/_base/array", "dojo/aspect", "dojo/dom", "dojo/keys", "dojo/on", "dojo/domReady!"
		], function(doh, robot, array, aspect, dom, keys, on){

			robot.initRobot('../_Widget-ondijitclick.html');

			// Event monitoring
			var widgetClicks = 0, buttonClicks = 0;
			var w;

			doh.register("ondijitclick w/mouse", {
				timeout:5000,
				runTest:function(){
					var d = new doh.Deferred();

					// get pointer to registry in the iframe
					registry = robot.window.require("dijit/registry");

					robot.sequence(function(){
						w = registry.byId("first");
						aspect.after(w, "_onClick", function(){
							widgetClicks++;
						}, true);
						on(dom.byId("plainbutton", robot.doc), "click", function(){
							buttonClicks++;
						});
						w.domNode.focus();
					}, 100);

					// click the widget
					robot.mouseMoveAt("first", 500);
					robot.mouseClick({left: true}, 500);

					robot.sequence(d.getTestCallback(function(){
						doh.is(1, widgetClicks, "ondijitclick handler fired once");
					}), 1000);

					return d;
				}
			});

			...

			doh.run();
		});


See the real test
`_Widget-ondijitclick_mouse.html <http://archive.dojotoolkit.org/nightly/checkout/dijit/tests/robot/_Widget-ondijitclick_mouse.html>`_
in action or view the source code.

The test consists of 5 steps:
  1. The test declares variables spin1-3, to store convenient references to the Spinner widgets when the application loads.
  2. The test calls initRobot(), passing the URL of the page it wants to test.
  3. The test registers a setUp test to assign the variables spin1-3 their values. Note that you are not required to have a test named setUp; this is just a sensible name for a test whose purpose is to assign variables their values.
  4. The test registers any number of DOH tests, such as the "spinner1_invalid" test here, as usual. The test assumes that it is executing in the context of the application.
  5. The test calls doh.run() to tell DOH that all tests are registered.

When your external application loads and DOH receives the doh.run() call from the test script,
DOH begins executing your tests on the application.

Digression: cross-domain security
---------------------------------
The initRobot() call in the above example loads an application that resides on the same server.
If your testing requirements enable you to stash your tests on the same server as your application,
then this works just fine for you.
But what if you absolutely have to test an application residing on a different domain?
If you just throw the URL at initRobot(), initRobot() will faithfully load the application at the URL,
but the browser will deny DOH access to the application's content.

In this scenario, you have two options:
  - Run the browser in trusted mode (firefox -chrome command line flag, mshta instead of IE)
  - Trick the browser into thinking that the application and test script are running on the same server

One possible implementation of to the second solution is to create a simple reverse-proxy Web server.
The reverse-proxy is an ordinary Web server than joins local files and remote servers.
To browsers connecting to the reverse-proxy, the application files and test files appear to be on the same server!

This is easy to implement.
Suppose you have an application server running an application called Application at http://192.168.0.6:8080/Application/.
Your test files sit on an Apache Web server at http://192.168.0.7/tests/Application/.
To fix the cross-domain problem, you want requests by the test to the application to ask for
http://192.168.0.7/Application/ instead of http://192.168.0.6:8080/Application/.
In your httpd.conf, you add:

.. code-block:: text

  LoadModule proxy_module modules/mod_proxy.so
  LoadModule proxy_http_module modules/mod_proxy_http.so
  LoadModule rewrite_module modules/mod_rewrite.so
  <IfModule mod_rewrite.c>
  RewriteEngine on
  RewriteRule     /Application/(.*)    http://192.168.0.6:8080/Application/$1 [P]
  </IfModule>

Now the reverse-proxy will silently route requests from http://192.168.0.7/Application/ to
http://192.168.0.8:8080/Application/.
You can write your initRobot() call to load your application with this relative URL:
robot.initRobot('/Application/');
To load your tests, you still use the URL to your test server: http://192.168.0.7/tests/Application/,
and the browser will think that your application resides on the same server, so doh/robot will work.

By all means though, if your testing requirements enable you to physically put your test files on the same server
as your application, go for it.

waitForPageToLoad()
-------------------
You can load an external application, so now you want to click links and open new pages within that application.
Here is the syntax for waitForPageToLoad():

.. js ::

    waitForPageToLoad: function(/*Function*/ submitActions){
        // summary:
        //    Notifies DOH that the doh/robot is about to make a page change in the application it is driving,
        //    returning a doh.Deferred object the user should return in their runTest function as part of a DOH test.
        //
        // description:
        //    Notifies DOH that the doh/robot is about to make a page change in the application it is driving,
        //    returning a doh.Deferred object the user should return in their runTest function as part of a DOH test.
        //    Example:
        //         runTest:function(){
        //             return waitForPageToLoad(function(){ robot.keyPress(dojo.keys.ENTER, 500); });
        //         }
        //
        // submitActions:
        //    The robot will execute the actions the test passes into the submitActions argument (like clicking the submit button),
        //    expecting these actions to create a page change (like a form submit).
        //    After these actions execute and the resulting page loads, the next test will start.
    }

waitForPageToLoad takes a function called submitActions.
The robot expects submitActions to contain the final instructions you want to execute on this page.
For example, if you want to navigate away from the page by clicking a link,
your submitActions function should contain doh/robot instructions that click the link.
The DOH runner will wait while the robot is executing code in this block until it receives a page load event.
When that happens, DOH loads the next test you registered and proceeds from there.

waitForPageToLoad returns a Deferred object.
The idea is that you can, in turn, return this Deferred object to DOH so that it knows to halt execution of further
tests until the next page loads.

Example
~~~~~~~
The following sample uses waitForPageToLoad to test a user story for PlantsByWebSphereAjax,
an application available in IBM WebSphere Application Server Feature Pack for Web 2.0. The user story flows like this:

The user is looking to buy flowers on PlantsByWebSphereAjax.
The user adds two flowers to the shopping cart.
The user clicks checkout.
When the next page loads (a login screen), the user logs onto the website.
When the next page loads (a shipping info page), the user fills in the shipping info and credit card information to finalize the sale.
PlantsByWebSphereAjax contains a shopping cart built on Dojo DnD. Users literally drag images of products into the shopping cart to select them for purchase. When the user is ready to check the items out, the user clicks the checkout button and the contents of the DnD container are submitted to the server-side logic for processing.

In the following sample, the robot uses initRobot() to load the application. In the test, the robot acts just like a user and drags an item into the shopping cart. The robot uses waitForPageToLoad to click the checkout button, triggering a page to a login page. After the login page appears, the robot fills in its credentials. The robot again uses waitForPageToLoad to click login. The robot fills in its address and credit card information and the test concludes.

.. js ::

        robot.initRobot('/PlantsByWebSphereAjax/');
        
        doh.register('user_story1',{
            name: 'selectitems',
            timeout: 60000,
            runTest: function(){
                var d = new doh.Deferred();

                // select a flower
                robot.mouseMoveAt('dijit_layout__TabButton_1', 500, 1000, 47, 6);
                robot.mouseClick({left:true, middle:false, right:false}, 1000);
                robot.mouseMoveAt(function(){ return dojo.doc.getElementsByTagName('IMG')[15]; }, 8000, 1500, 58, 45);
                robot.mouseClick({left:true, middle:false, right:false}, 1000);

                // add selected flower to cart
                robot.mouseMoveAt(function(){ return dojo.doc.getElementsByTagName('BUTTON')[0]; }, 5000, 2000, 36, 15);
                robot.mouseClick({left:true, middle:false, right:false}, 1000);

                // next page
                robot.mouseMoveAt(function(){ return dojo.doc.getElementsByTagName('A')[15]; }, 1000, 2000, 12, 10);
                robot.mouseClick({left:true, middle:false, right:false}, 1000);

                // drag flower into shopping cart
                robot.mouseMoveAt(function(){ return dojo.doc.getElementsByTagName('IMG')[14]; }, 5000, 1000, 63, 75);
                robot.mousePress({left:true, middle:false, right:false}, 1000);
                robot.mouseMoveAt(function(){ return dojo.byId('shoppingCart'); }, 5000, 1000);
                robot.mouseRelease({left:true, middle:false, right:false}, 1000);

                // assert price==$16
                robot.sequence(d.getTestCallback(function(){
                    doh.t(/\$16/.test(registry.byId('ibm_widget_HtmlShoppingCart_0').cartTotalPrice.innerHTML);
                }), 1000);
                return d;
            }
        });
        
        // use waitForPageToLoad to click the checkout button
        // tests will wait for the next page to load
        doh.register('user_story2',{
            name: 'selectitems_pagechange',
            timeout: 60000,
            runTest: function(){
                return robot.waitForPageToLoad(function(){
                    // click submit
                    robot.mouseMoveAt(function(){
                        return dom.byId('checkout_button');
                    }, 1623, 801);
                    robot.mouseClick({left:true, middle:false, right:false}, 992);
                });
            }
        });
        
        // next page has loaded; continue executing tests
        // in this case, the next page of the user story is a login page
        doh.register('user_story3',{
            name: 'login',
            timeout: 60000,
            runTest: function(){
                // log user in
                var d = new doh.Deferred();
                robot.mouseMoveAt(function(){ return dojo.byId('email'); }, 500, 1000);
                robot.mouseClick({left:true, middle:false, right:false}, 500);
                robot.typeKeys("username", 500, 5000);
                robot.keyPress(dojo.keys.TAB, 500);
                robot.typeKeys("password", 500, 5000);
                robot.sequence(function(){
                    d.resolve(true);
                }, 1000);
                return d;
            }
        });
        
        // use waitForPageToLoad to click the login button
        doh.register('user_story4',{
            name: 'login_pagechange',
            timeout: 60000,
            runTest: function(){
                return robot.waitForPageToLoad(function(){
                    // click login
                    robot.mouseMoveAt(function(){ return dojo.doc.getElementsByTagName('input')[2]; }, 1623, 801);
                    robot.mouseClick({left:true, middle:false, right:false}, 992);
                });
            }
        });
        
        doh.register('user_story5',{
            name: 'shippinginfo',
            timeout: 60000,
            runTest: function(){
                var d = new doh.Deferred();
                // fill out the shipping info form
                // you get the idea
                return d;
            }
        });
        doh.run();

The above code uses waitForPageToLoad twice: once to click the checkout button, and once to click the login button.
In each waitForPageToLoad call, you pass a function containing commands that will change the page.
Let's examine the first waitForPageToLoad call more closely:

.. js ::

        // use waitForPageToLoad to click the checkout button
        // tests will wait for the next page to load
        doh.register('user_story2',{
            name: 'selectitems_pagechange',
            timeout: 60000,
            runTest: function(){
                return robot.waitForPageToLoad(function(){
                    // click submit
                    robot.mouseMoveAt(function(){
                        return dojo.byId('checkout_button');
                    }, 1623, 801);
                    robot.mouseClick({left:true, middle:false, right:false}, 992);
                });
            }
        });
        
        // next page has loaded; continue executing tests

As you can see from the above snippet, you use a waitForPageToLoad() call as the return value of a test.
No, the test doesn't actually test anything, but it is a convenient pattern to halt DOH while the page is changing.
You give the test a long timeout so the page has sufficient time to load the next page.
This is the *maximum* wait; test execution will resume immediately when the next page loads.

You pass waitForPageToLoad() a function containing robot commands that will do something to change the page.
In this example, the robot moves the mouse to the checkout button.
Then, the robot clicks the left mouse button on top of the checkout button,
causing the application to submit the form and go to the login page.
When the login page loads, DOH resumes test execution and executes the next test;
in this case, the next test is named 'login' and so it executes.
You can execute any number of tests after that, and can use waitForPageToLoad() any number of times
to navigate to more pages as your test requires.

Using waitForPageToLoad() in conjunction with initRobot() in this way enables you to write long-running tests
that can navigate across links and form submits within your application.

