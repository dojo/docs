.. _dojo/keys:

=========
dojo/keys
=========

.. contents ::
    :depth: 2

**dojo/keys** is the module that provides normalized constants for all the available keys you can press, which is passed in an Event Object when using :ref:`dojo/connect <dojo/connect>` or :ref:`dojo/on <dojo/on>`.

Usage
=====

To utilize the module, simply require in the module:

.. js ::

  require(["dojo/keys"], function(keys){
    // keys will now contain the constants
  });

In order to take advantage of of the constants though, you need to couple them with an event.  For example:

.. js ::

  require(["dojo/keys", "dojo/dom", "dojo/on"], function(keys, dom, on){
    on(dom.byId("someid"), "keypress", function(evt){
      switch(evt.charOrCode){
        case keys.RIGHT_ARROW:
          // handle right arrow
          break;
        case keys.LEFT_ARROW:
          // handle left arrow
          break;
      }
    });
  });

Available Keys
--------------

The module provides the following keycode constants. If running in sync mode, these will also be loaded as part of Dojo Base and be available in ``dojo.keys`` as well:

* BACKSPACE

* TAB

* CLEAR

* ENTER

* SHIFT

* CTRL

* ALT

* META

  the CMD key on Macs

* PAUSE

* CAPS_LOCK

* ESCAPE

* SPACE

* PAGE_UP

* PAGE_DOWN

* END

* HOME

* LEFT_ARROW

* UP_ARROW

* RIGHT_ARROW

* DOWN_ARROW

* INSERT

* DELETE

* HELP

* LEFT_WINDOW

* RIGHT_WINDOW

* SELECT

* NUMPAD_0

* NUMPAD_1

* NUMPAD_2

* NUMPAD_3

* NUMPAD_4

* NUMPAD_5

* NUMPAD_6

* NUMPAD_7

* NUMPAD_8

* NUMPAD_9

* NUMPAD_MULTIPLY

* NUMPAD_PLUS

* NUMPAD_ENTER

* NUMPAD_MINUS

* NUMPAD_PERIOD

* NUMPAD_DIVIDE

* F1

* F2

* F3

* F4

* F5

* F6

* F7

* F8

* F9

* F10

* F11

* F12

* F13

* F14

* F15

* NUM_LOCK

* SCROLL_LOCK

* copyKey

  This is a "virtual key" that is either CTRL on Windows, or the meta key (a.k.a. CMD key) on Macintoshes, 
  since cut and paste on Windows is performed using CTRL (CTRL-X, CTRL-C, and CTRL-P) whereas it's performed using META 
  (META-X, META-C, and META-P) on Macs.

Key Event Modifiers
-------------------

Any keyboard event will have the following boolean attributes:

* ctrlKey

* altKey

* shiftKey

* metaKey

They indicate if the ``control``, ``alt``, ``shift``, or ``meta`` key was held down while the other key (alphanumeric or punctuation) was pressed.

For example, pressing ``CTRL-A`` will produce an event object like:

.. js ::

  {
    charOrCode: 'a',
    ctrlKey: true
  }

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  This example shows basic key handling on a text input field.

  .. js ::

    require(["dojo/keys", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(keys, dom, on){
      on(dom.byId("keytest"), "keypress", function(evt){
        var charOrCode = evt.charCode || evt.keyCode,
            output;
        switch(charOrCode){
          case keys.LEFT_ARROW:
          case keys.UP_ARROW:
          case keys.DOWN_ARROW:
          case keys.RIGHT_ARROW:
            output = "You pressed an arrow key";
            break;
          case keys.BACKSPACE:
            output = "You pressed the backspace";
            break;
          case keys.TAB:
            output = "You pressed the tab key";
            break;
          case keys.ESCAPE:
            output = "You pressed the escape key";
            break;
          default:
            output = "You pressed some other key";
        }
        dom.byId("output").innerHTML = output;
      });
    });

  .. html ::

    <label for="keytest">Press Some Keys:</label>
    <input type="text" name="keytest" id="keytest" />
    <p><strong>Output:</strong></p>
    <div id="output"></div>

See Also
========

* :ref:`dojo/mouse <dojo/mouse>` - Module for handling mouse input

* :ref:`dojo/touch <dojo/touch>` - Module for handling touch input
