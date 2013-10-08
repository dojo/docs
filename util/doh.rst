.. _util/doh:

==============================
D.O.H.: Dojo Objective Harness
==============================

:Authors: Alex Russell, Pete Higgins, Dustin Machi, Jared Jurkiewicz, Andy Balaam

.. contents ::
  :depth: 3

Overview
========

Usually when people think of a scripting language, it's often in the context of ease of use, simple syntax,
and something those without traditional computer science educations can grasp and use.
JavaScript unfortunately falls into this category.
For a scripting language, though, is difficult to fully master.
Making it worse are the environments that execute JavaScript; the infamous Web Browser.
For example, Safari works similar to, but not quite the same as Mozilla FireFox, Opera, and even Google Chrome.
When Internet Explorer enters the picture, it gets even more complicated as many JavaScript constructs
(and DOM functions) that work in all the other browsers will not work in Internet Explorer.
This becomes a *Testing Nightmare*.
In fact, I'm sure the frustration of testing JavaScript has caused many an utterance of 'doh!'
and other less ahem, *polite* phrases.
So ... what can be done about this?

Enter D.O.H. The Dojo Objective Harness
---------------------------------------

Just to get it out of the way ...
D.O.H. is both an acronym of Dojo Objective Harness *and* a play on the now commonplace expression of frustration 'DOH!'.
But aside from the very silly name it is a unit test framework developed by the Dojo Toolkit Community
(primarily by Alex Russell), in an attempt to solve the complexities of testing JavaScript.
For example, in JavaScript, the use of XHR to request remote data asynchronously is commonplace ...
and yet few Unit Test frameworks provided any mechanism by which to actually be able test asynchronous functions.
Furthermore, most Unit Test Frameworks end up with specific dependencies on certain browsers or runtime environments.
Again, D.O.H. tries not to limit itself in this manner, it's both flexible, extendable,
and runs in many environments from browsers to JS runtime environments such as Rhino.

Its main purpose is a framework for developers (both dojo committers and others),
to unit test out JavaScript functions and custom widgets.
Its goal isn't so much as a way to test a full-blown web application as it is to test the parts
that make up the applications in a cross-browser (and even non-browser), compatible manner.
By having a good set of unit tests, developers can feel confident that code changes they later make
do not cause regressions in existing functions.


For a quick list of the features of D.O.H. see below:

* Support for many browsers:

 * Firefox 3.6+
 * Safari 4.x+
 * Internet Explorer 6+
 * Google Chrome All versions
 * Opera 9.x and 10.x
 * <and others!>

* Support for Non-Browser environments, such as Rhino and node.js.
* Modular loading of unit test files.
* Asynchronous test support (such as testing functions that ultimately use XHR)
* A simple browser-based graphical front end and runner file.
* Standard Unit Test Support (assertTrue, assertFalse, assertEqual, timeouts, etc.)
* Performance tests with basic statistical computations.
* Java Applet (D.O.H. Robot), for simulating user interaction to test browser input events.
* If present, will use the Dojo Module Loader to load test files.
* The ability to load separate HTML pages into an iframe, where the iframe contains a D.O.H. instance and register tests.
  This allows D.O.H. to test HTML widgets in a separate frame from the D.O.H. framework, which avoids cross-contamination.


Running tests
=============

Before you start writing your own tests you should confirm you can run some existing tests.  We'll be using the tests that come as part of Dojo, confirming that Dojo itself works as it should, and then looking at how to run your own tests.

In a browser
------------

There are several ways to run DOH tests, but the simplest way is inside a web browser.

Testing parts of Dojo
~~~~~~~~~~~~~~~~~~~~~

The easiest tests to get running in DOH are those that are built into Dojo itself, so let's start there.

Ensure your web server or equivalent is running [*]_, so you can see the dojo files in your web browser, and navigate to the URL "util/doh/runner.html".  You should type the full URL into your browser's address bar, which might be something like:

``http://localhost/dojo/util/doh/runner.html``

or 

``http://localhost:8181/dojo/util/doh/runner.html``


.. [*] If you don't yet have a web server running, but you do have Python installed, you can get the tests running in a browser by ensuring you are in the directory that contains the dojo directory, then running:

   ``python -m SimpleHTTPServer &``

   or if you have Python 3:

   ``python3 -m http.server &``

   This starts a temporary web server, serving all the files in the current directory.

   You can then launch your browser to http://localhost:8000/util/doh/runner.html to see the tests running.

   Note, however, that some tests will fail because they rely on PHP scripts, which are not supported in this simple web server.

What runner.html does is load the DOH test registration and assertion functions, and run some tests.
If no module URL was provided for it to load tests from,
the runner.html will automatically load the file: *dojo/tests/module.js*.
All that file does is use the dojo module loading system to load in all the test files for core dojo.
It then just executes all the currently registered tests and displays the results in the browser.

When you navigate to this page you should see lots of tests running, and eventually a green bar across the whole screen indicating that they all passed.  If this doesn't happen, you may have a version of Dojo that doesn't contain DOH, or doesn't contain the tests - download a "-src.zip" version from http://download.dojotoolkit.org/ and you should be fine.

To run one or more individual tests, rather than all of the Dojo core tests at once, you need an extra URL parameter, like this:

``util/doh/runner.html?test=dojo/tests/date``

This instructs the runner to look in dojo/tests and run the tests inside the file date.js.

Testing your own code
~~~~~~~~~~~~~~~~~~~~~

If you want to run your own tests, one option is to put them inside dojo's own directory, and run them as in the previous section, but a more normal approach is to put them somewhere else.

If your tests are accessible via a url such as mycode/org/myorg/mymodule/tests/alltests.js on your web browser, you can run them in the DOH runner by navigating to a URL like this:

``util/doh/runner.html?paths=org/myorg,../../../mycode/org/myorg&test=org/myorg/mymodule/tests/alltests``

The *paths* argument tells Dojo to look in "../../../mycode/org/myorg" whenever it seems a reference to a module starting with "org/myorg".  The *test* argument gives the module name (not the URL) of the test file you want to run.  Note that there is no ".js" at the end.

If your code consists of several modules in different locations you can provide all of them within *paths* by separating them with semi-colons, for example:

``util/doh/runner.html?paths=org/myorg,../../../mycode/org/myorg;com/mycom,../../../x/com/mycom&test=com/mycom/tests``

On the command line (with Rhino)
--------------------------------

Rhino is a JavaScript interpreter, written in Java, that is included with Dojo's source distribution.

To run DOH unit tests with Rhino, create a config file something like this:

.. code-block :: javascript

  require({
      paths: {
          "org/myorg" : "../../../mycode/org/myorg",
          "com/mycom" : "../../../x/com/mycom"
      }
  });

And use a script something like this:

.. code-block :: bash

  java -jar util/shrinksafe/js.jar dojo/dojo.js baseUrl=file:///full/path/to/dojo/dojo load=file://full/path/to/config.js load=doh test=com/mycom/tests

And cd into the directory containing the "dijit", "dojo", "dojox" and "util" directories before you run it.  You can modify the paths to js.jar and dojo.js to make them absolute if you want to run from elsewhere.

baseUrl should be a URL (not relative path) to the directory that contains dojo.js.

You can also use a module-style path to your config module such as "load=org/myorg/config" if it is accessible that way.

Creating tests
==============

Okay, whee!
The runner.html can be told what test module to load.
So ... what the heck is a test module!?
A test module is nothing more than a file that requires in more test files, calls doh.register() to register tests,
or a combination of both.
Basically a module is nothing more than the file that calls the doh functions to register tests
before D.O.H. executes the test run.
For example, the following code snippet is a test module:

Example Test Module: Simple test registration
---------------------------------------------

.. js ::

  define(["doh/runner"], function(doh){

      doh.register("MyTests", [
        function assertTrueTest(){
          doh.assertTrue(true);
          doh.assertTrue(1);
          doh.assertTrue(!false);
        },
        {
          name: "thingerTest",
          setUp: function(){
            this.thingerToTest = new Thinger();
            this.thingerToTest.doStuffToInit();
          },
          runTest: function(){
            doh.assertEqual("blah", this.thingerToTest.blahProp);
            doh.assertFalse(this.thingerToTest.falseProp);
            // ...
          },
          tearDown: function(){
          }
        },
        // ...
      ]);

  });

Example Test Module: Module that loads other modules
----------------------------------------------------

.. js ::

  define([
      "my/test/widget/Foo0",
      "my/test/widget/Foo1",
      "my/test/widget/Foo2"
  ]);

Notes on Registering Tests
--------------------------

* Names of functions or of test fixtures must be unique per test group.
  D.O.H. records results by using the name as a hash key on the results objects.

Performance Tests
=================

(Dojo 1.4 and higher)

Unit tests are excellent for testing code behavior and verifying the code works as expected across browsers.
But it's not always what you want to do.
There are times where code may work across browsers, but the code doesn't work fast on all browsers.
It would be great if there was a way to do performance analysis of a function
instead of just doing true/false unit test style testing.

The great news is that as of Dojo 1.4, D.O.H.
has been updated to understand a different type of test fixture (or test registration), the performance test.
Tests registered in this manner work a little differently.
Instead of a single execution of 'runTest' or of the test function,
it will execute that test function many times and then calculate the average cost for a single function run.
This is powerful in determining the general function performance across browsers and identify implementations
that underperform on various browsers.

What a performance fixture does is the following:

* The test is 'calibrated'.  This means that the function is executed repeatedly in blocks until the framework
  determines that X iterations runs longer than a set time.
  The set time is configurable as the 'trialDuration', and the default value is 100ms.
  The reason that tests have to be calibrated is that JavaScript doesn't handle timings below 15 ms very well.
  So you have to keep repeatedly running the function until a time greater than 15ms passes
  and only then can you compute the average runtime of a single function call.
  This is a well documented problem with doing JavaScript performance testing and calibration is how D.O.H. deals with it.
* Once calibrated, D.O.H. will then go execute a number of trials.
  A single trial is a set number of iterations of the test function.
  The set number of iterations is what the calibration run determines.
  The number of trials you want to run is also configurable as a 'trialIterations' option of your test fixture.
* Once all the trial iterations are done, it calculates the basic averages and such.
  All this information is stored on the D.O.H. root object 'doh' as attribute 'perfTestResults'.
  In fact, you can access the perf test results for a particular function by just doing:
  doh.perfTestResults[groupName][functionName].
  The structure of the results is an array of entries of the following structure:

.. js ::

   {
      trial: number, // The trial number, 0 .. N trial run
      testIterations: number, // The number of iterations the test function was run for the trial.
      executionTime: number, // The total execution time of the trial, in milliseconds.
      average: number // The average time a single iteration of the test function takes.  executionTime/testIterations
   }

* At the end of all the performance tests, if the tests were run in a browser, D.O.H. then calculates statistical information off the run, such as standard deviation, max, min, median, and the like.  It also then plots each trial out using dojox.charting.DataChart (if available).  All this data is displayed on the 'Performance Tests Results' page.  To see this in action, take a look at the `dojox.gfx performance tests <http://archive.dojotoolkit.org/nightly/checkout/dojox/gfx/tests/performance/runTests.html>`_ in nightly.

You can also look at how to write performance tests by looking at: dojox/gfx/tests/performance/\*
in your extract of Dojo 1.4 or development trunk.

Reference
=========

This section is intended for documentation on the various aspects of D.O.H.,
such as what registration functions there are and what they do, to information on test formats.

File Structure
--------------
D.O.H. resides in the utils project of the dojo toolkit.
Users can find it explicitly at: **utils/doh**.
The following files structure shows the files important to the usage of the framework:

* **utils**

  * **doh**
    
    * **runner.js**:  The main JavaScript file that defines environment agnostic D.O.H APIs.
    * **_browserRunner.js**:  Additional file that augments the definitions in runner.js for a web browser.
    * **_nodeRunner.js**: Additional file that augments the definitions in runner.js for a node.js environment.
    * **_rhinoRunner.js**: Additional file that augments the definitions in runner.js for a Rhino environment.
    * **runner.html**: HTML bootstrap file used to load D.O.H. in the browser and execute tests.
    * **runner.sh**: UNIX shell script to launch D.O.H. under Rhino.
    * **Robot.html**:  HTML file used to bootstrap in the D.O.H Robot for tests that require synthetic user input.
    * **LICENSE**: The license that governs D.O.H.

Registration Functions
----------------------
These functions are how you register tests within the D.O.H.
framework to run.
The two main functions you will use are *doh.register* and *doh.registerUrl*.
The others are provided for completeness.

doh.register(...)
~~~~~~~~~~~~~~~~~
  An almost 'magical' function.
  The doh.register() method accepts the function signatures of any of the other registration functions and determines the correct underlying function (listed below) to dispatch registration to.
  It's the function you'll most commonly use for registering Unit Tests.


doh.registerTest(group, testFuncOrObj)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  This function registers a test as a member of the group 'group', and the test can either be a simple function definition or a 'Test Fixture', which is an object that defines the run requirements of the test.


doh.registerTests(group, testFuncOrObjArr)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  This function registers an array of tests as a member of the group 'group'.
  The contents of the array of tests can be an array of simple test functions or an array of 'test fixtures', or a mix of them.


doh.registerTestNs(group, obj)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  This function registers an object comprised of functions as a member of the group 'group'.
  Note that this function will only add in non-private (functions without an _ at the beginning of the name), as a test function.
  If you'd like to use fixtures (setUp(), tearDown(), and runTest()), please use doh.register(), doh.registerTest() or doh.registerTests().

doh.registerTestUrl(url)
~~~~~~~~~~~~~~~~~~~~~~~~
  This function registers a URL as a location to load tests from.
  The URL is used to populate the contents of an iframe, and usually refers to an HTML page that boot-loads D.O.H.
  internally for running tests in a segmented iframe.
  A good example showing this is the dojo/tests/fx.html.
  It loads dojo, doh, and then on dojo load completion calls doh.registerTests().
  The D.O.H. instance in the iframe will proxy back the results of the test run to the primary D.O.H. instance.

Test Functions
--------------
These functions are the test functions you use inside your unit tests in order to check conditions are report errors if the conditions are not met.
These should be familiar to anyone who has used other test frameworks before, such as JUnit.

doh.assertTrue(boolean)
~~~~~~~~~~~~~~~~~~~~~~~
  This function asserts that  particular condition is true.
  If the condition is not true, the function will throw an Error object.

  * Note:  This function is aliased to doh.t();

doh.assertFalse(boolean)
~~~~~~~~~~~~~~~~~~~~~~~~
  This function asserts that particular condition is false.
  If the condition is not false, the function will throw an Error object.

  * Note:  This function is aliased to doh.f();

doh.assertEqual(obj1, obj2)
~~~~~~~~~~~~~~~~~~~~~~~~~~~
  This function asserts that the two particular inputs are 'equal to each other, such as 5 == 5, or "Bob" == "Bob".
  The equality is fairly loose, so this is not a good function to use if you want to assert something is equal and of the same data type.
  For example, this function will return that 5 == "5" (number 5 equals string 5).
  It will also do deep object equality, so beware of object cycles.
  If the equality condition is not met, the function will throw and Error object.

  * Note:  This function is aliased to doh.is();

doh.assertNotEqual(obj1, obj2)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  This function asserts that the two particular inputs are not 'equal to each other, such as 5 != 6, or "Bob" == "Doe".
  The equality is fairly loose, so this is not a good function to use if you want to assert something is not equal and of the same data type.
  It will also do deep object equality/inequality when checking, so beware of object cycles.
  If the 'not equal' condition is not met, the function will throw and Error object.

  * Note:  This function is aliased to doh.isNot();

Test Structures
---------------

D.O.H. is flexible in how you define tests.
In some respects, perhaps it is too flexible in that it can be confusing which way to define a test or how to define an asynchronous test.
This following section is intended to help explain the various test function formats and when to use them.

Simple tests (no setup, standalone, synchronous test)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A lot of testing involves checking a widget or JavaScript API or the like and doesn't require any initial setup or teardown to do.
These are simple to define.
You simply write it as a function object.
This object can then be registered through the doh.register() functions.

.. js ::

  function mySimpleTest(doh){
    doh.assertTrue(true);
  }

What the D.O.H. framework will do with this test is wrap it in  a default 'test fixture',
which has null setUp and tearDown functions and a default timeout of 500ms.


Simple tests (no setup, standalone, asynchronous test)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Simple asynchronous tests are no more complicated to write than the above synchronous test.
You simply write it as a function object that returns a doh.Deferred object.
The test framework detects the return type and knows that if a doh.Deferred is returned, then D.O.H.
should pause here and wait for either the test timeout to fire or the asynchronous test
to invoke either the Deferred to resolve, which is done via the getTestCallback() method.
This object can then be registered through the doh.register() functions.
The example below implements an async test via timeout to demonstrate it.

.. js ::

  function mySimpleAsyncTest(doh){
    var deferred = new doh.Deferred();
    setTimeout(deferred.getTestCallback(function(){
        doh.assertTrue(true);
    }), 100);
    return deferred;
  }

What the D.O.H. framework will do with this test is wrap it in  a default 'test fixture',
which has null setUp and tearDown functions and a default timeout of 500ms.

Test Fixture (setup, standalone, synchronous test)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Some testing will require setup and/or teardown, specific pre and post configurations that need to occur ...
or the test requires a different timeout from the default (such as a long-running xhr).
The test fixture format for a test allows for this configuration.
See the following code snippit for an example of a test fixture.

.. js ::

  {
    name: "thingerTest",
    setUp: function(){
      // Setup to do before runTest.
      this.thingerToTest = new Thinger();
      this.thingerToTest.doStuffToInit();
    },
    runTest: function(){
      // Our test function to run.
      doh.assertEqual("blah", this.thingerToTest.blahProp);
      doh.assertFalse(this.thingerToTest.falseProp);
      // ...
    },
    tearDown: function(){
      // cleanup to do after runTest.
    },
    timeout: 3000 // 3 second timeout.
  }

Test Fixture (setup, standalone, asynchronous test)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Test fixtures can also do asynchronous tests.
All that has to occur for the D.O.H.
framework to recognize that a test fixture is asynchronous is that the runTest method returns a doh.Deferred or
dojo.Deferred.
See below for a fixture that operates asynchronously.

.. js ::

  {
    name: "thingerTest",
    setUp: function(){
      // Setup to do before runTest.
      this.thingerToTest = new Thinger();
      this.thingerToTest.doStuffToInit();
    },
    runTest: function(){
      // Our test function to run.
      var deferred = new doh.Deferred();
      setTimeout(deferred.getTestCallback(function(){
          doh.assertEqual("blah", this.thingerToTest.blahProp);
          doh.assertFalse(this.thingerToTest.falseProp);
      }), 100);
      return deferred;
    },
    tearDown: function(){
      // cleanup to do after runTest.
    },
    timeout: 3000 // 3 second timeout.
  }


Performance Test Fixture (setup, standalone, synchronous test)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

(Dojo 1.4 and higher)

Performance test fixtures are just like a regular test fixture, except that it has some extra options developers make use of.
Specifically, it uses 'testType' to mark it as a "perf" test, which instructs the D.O.H.
runner to treat the tests as performance and use the calibrate and execute test runner.
It also allows users to define how long a performance test should run per trial
(we recommend 50ms or more to avoid JS timing issues), how many trials to run,
and how long to delay between each trial to give GC time to the browser.

.. js ::

  {
    testType: "perf", // Define this as a performance test.  Used to select the runner in D.O.H.
    trialDuration: 100, // Define that a trial (test run) of the performance test should run minimally for 100ms (however many runs of the function this means.  It is calibrated).
    trialIterations: 100, // Run 100 trials of the test function.
    trialDelay: 100, // Wait 100MS between each trial to allow for GC, etc.
    name: "thingerPerformanceTest",
    setUp: function(){
      // Setup to do before the trial runs of runTest.
    },
    runTest: function(){
      // Our test function to do performance profiling.
      myModule.doSomePerformanceRelatedThing();
    },
    tearDown: function(){
      // cleanup to do after all the trials.
    }
  }

Performance Test Fixture (setup, standalone, asynchronous test)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

(Dojo 1.4 and higher)

Async performance test fixtures are just like synchronous performance test fixtures.
The only difference is that these return doh.Deferreds to tell the runner framework to treat the test as async.
Note:  Performance profiling asynchronous operations will not always provide useful information.
By the nature of being async means its performance profile will likely vary considerably.
The below example demonstrates an async performance fixture through the use of setTimeout.

.. js ::

  {
    testType: "perf", // Define this as a performance test.  Used to select the runner in D.O.H.
    trialDuration: 100, // Define that a trial (test run) of the performance test should run minimally for 100ms (however many runs of the function this means.  It is calibrated).
    trialIterations: 100, // Run 100 trials of the test function.
    trialDelay: 100, // Wait 100MS between each trial to allow for GC, etc.
    name: "thingerAsyncPerfTest",
    setUp: function(){
      // Setup to do before runTest.
    },
    runTest: function(){
      // Our test function to run.
      var deferred = new doh.Deferred();
      setTimeout(deferred.getTestCallback(function(){
          myModule.doSomePerformanceRelatedThing();
      }), 100);
      return deferred;
    },
    tearDown: function(){
    },
    timeout: 3000 // 3 second timeout.
  }


See also
========

* The numerous unit tests in dojo itself!  For example: dojo/tests/\*, dijit/tests/module.js, dojox/\*/ tests/\*, and so on.
* `D.O.H tutorial by IBM <http://www.ibm.com/developerworks/web/library/wa-aj-doh/index.html>`_  *(Has example code)*
* `Running Dojo 1.7+ DOH unit tests on the command line with Rhino <http://www.artificialworlds.net/blog/2012/10/09/running-dojo-doh-unit-tests-on-the-command-line-with-rhino/>`_ - A fuller explanation of running DOH tests using Rhino
