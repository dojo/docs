#format dojo_rst

dojo.back
=========

:Status: Contributed, Draft
:Version: 1.0
:Available: 1.0

.. contents::
    :depth: 2

dojo.back allows you to update the browser history, so that it's possible to use the Back- and Forward-buttons of a Browser without leaving the web application.

=====
Usage
=====

Initialization
--------------

To use dojo.back:

1. Add the appropriate require statement:

   .. code-block :: javascript

      dojo.require("dojo.back");
   ..

2. Register the initial state of the page by calling:

   .. code-block :: javascript

       dojo.back.setInitialState(state);
   ..

   This state object will be called when the user clicks Back all the way back to the start of the web application. If the user clicks Back once more, they will go back in the browser to wherever they were before loading the web application.

   The state object should have the following functions defined:

   * For receiving Back notifications: back(), backButton() or handle(type), where type will either be the string "back" or "forward".
   * For receiving Forward notifications: forward(), forwardButton() or handle(type), where type will either be the string "back" or "forward".

   Example of a very simple state object:

   .. code-block :: javascript

       var state = {
           back: function() { alert("Back was clicked!"); },
           forward: function() { alert("Forward was clicked!"); }
       };
   ..

3. Call dojo.back.init(); inside a script tag that is inside the <body> tag:

   .. code-block :: javascript

       <body>
         <script type="text/javascript">dojo.back.init();</script>
         (rest of the body here)
       </body>

   ..

**WARNING:** dojo.back.init() must be called before the page's DOM is finished loading. Otherwise it will not work. Be careful with xdomain loading or djConfig.debugAtAllCosts scenarios, in order for this method to work, dojo.back will need to be part of a build layer.

Register a state object
-----------------------

To register a state object that represents the result of a user action, use the following call:

.. code-block :: javascript

  dojo.back.addToHistory(state);


Change the URL in the location bar
----------------------------------

To change the URL in the browser's location bar, include a **changeUrl** property on the state object.

* If this property is set to true, dojo.back will generate a unique value for the fragment identifier. 
* If it is set to any other value (except undefined, null, 0 or empty string), then that value will be used as the fragment identifier. 

This will allow users to bookmark the page.

========
Examples
========

TODO
