#format dojo_rst

Key Constants
=============

Dojo provides normalized constants for all the available keys you can press, which is passed in an Event Object when using `dojo.connect <quickstart/events>`_. 

Available Keys
--------------

Dojo provides the following keycode constants in the namespace ``dojo.keys``. These are provided in Base Dojo (``dojo.js``):

* BACKSPACE 
* TAB 
* CLEAR 
* ENTER 
* SHIFT 
* CTRL 
* ALT
* META - the apple key on macs
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
* copyKey - this is a "virtual key" that is either CTRL on Windows, or the meta key (a.k.a. apple key) on Macintoshes, since cut and paste on Windows is performed using CTRL (CTRL-X, CTRL-C, and CTRL-P) whereas it's performed using META (META-X, META-C, and META-P)

Key Event Modifiers
-------------------
Any keyboard event will have the following boolean attributes:

* ctrlKey
* altKey
* shiftKey
* metaKey

They indicate if the control, alt, shift, or meta key was held down while the other key (alphanumeric or punctuation) was pressed.

For example, pressing CTRL-A will produce an onkeypress event like {charOrCode: 'a', ctrlKey: true}
