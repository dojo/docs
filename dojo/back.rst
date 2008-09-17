#format dojo_rst

dojo.back
=========

:Status: Contributed, Draft
:Version: 1.0
:Available: since V0.4

.. contents::
    :depth: 2

dojo.back allows to update the browser history, so that it's possible to use the Back- and Forward-buttons of a Browser without leaving the web application.

=====
Usage
=====

To use dojo.back:

1. Define ***preventBackButtonFix: false*** in your djConfig like this:.

   .. code-block :: javascript

      <script type="text/javascript"  src="../dojo.js"
          djConfig="preventBackButtonFix: false">
      </script>
   ..

   This allows the hidden iframe to be added to the current page via a document.write(). If you don't do this, dojo.back will not work correctly.

2. Add the appropriate require statement:

   .. code-block :: javascript

      dojo.require("dojo.back");
   ..

3. Register the initial state of the page by calling:

   .. code-block :: javascript

       dojo.back.setInitialState(state);
   ..

   This state object will be called when the user clicks Back all the way back to the start of the web application. If the user clicks Back once more, they will go back in the browser to wherever they were before loading the web application.

   The state object should have the following functions defined:

   * For receiving Back notifications: back(), backButton() or handle(type), where type will either be the string "back" or "forward".
   * For receiving Forward notifications: forward(), forwardButton() or handle(type), where type will either be the string "back" or "forward".

========
Examples
========

Example of a very simple state object:

.. cv-compound ::
  
  .. cv:: javascript

    <script type="text/javascript">
        var state = {
            back: function() { alert("Back was clicked!"); },
            forward: function() { alert("Forward was clicked!"); }
        };
    </script>




To register a state object that represents the result of a user action, use the following call:

dojo.back.addToHistory(state);

To change the URL in the browser's location bar, include a changeUrl property on the state object. If this property is set to true, dojo.back will generate a unique value for the fragment identifier. If it is set to any other value (except undefined, null, 0 or empty string), then that value will be used as the fragment identifier. This will allow users to bookmark the page.
