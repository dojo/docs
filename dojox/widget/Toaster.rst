#format dojo_rst

dojox.widget.Toaster
====================

:Status: Draft
:Version: beta
:Authors: Peter Higgins, ???
:Documentation: Josh Trutwin, Peter Higgins

[http://docs.dojocampus.org/dojox/widget Back]
==============================================

A toaster is an inobtrusive mechanism for displaying messages, and has become popular in recent years. Like toast, the message "pops up" in the window corner, temporarily overlaying any content there. The message stays up for a certain duration, or until the user clicks on it.

Toasters are preferrable to alert() boxes. Alert() must always be modal, meaning all action on the page stops until the user clicks "OK". Toasters are non-modal, so the user can continue working and finish their thought before responding.

You can either set the message programmatically, or use dojo's publish/subscribe event feature. Publish/subscribe allows you to have several toasters, or several controls besides toasters, respond to a particular event.

Examples
--------

The first example uses setContent() and show() to vary the message and display it. 

.. cv-compound::

  A stylesheet is required for Toasters to render properly

  .. cv:: css

    <link rel="stylesheet" type="text/css" href="/moin_static163/js/dojo/trunk/dojox/widget/Toaster/Toaster.css" >

  Javascript   

  .. cv:: javascript

    <script type="text/javascript">
       dojo.require("dojox.widget.Toaster");
       dojo.require("dojo.parser");

       function surpriseMe() {
          dijit.byId('first_toaster').setContent('Twinkies are now being served in the vending machine!', 'fatal');
          dijit.byId('first_toaster').show();
       }
    </script>

  The html is very simple

  .. cv:: html

    <div dojoType="dojox.widget.Toaster" 
         id="first_toaster" 
         positionDirection="br-left" >
    </div>
    <input type="button" onclick="surpriseMe()" value="Click here to see Toaster"/>

The next example does the same thing, but uses the publish/subscribe model.  The message coming over the topic must be of the form:

- "message" : a single string with the message text
- -OR- {message: "...", type: "...", duration: "..."}: where message is the message text, duration is as the attribute, and type is either:

  - fatal
  - error
  - warning
  - message

- in decreasing order of severity. 

.. cv-compound::

  A stylesheet is required for Toasters to render properly

  .. cv:: css

    <link rel="stylesheet" type="text/css" href="/moin_static163/js/dojo/trunk/dojox/widget/Toaster/Toaster.css" >

  Javascript   

  .. cv:: javascript

    <script>
      function surpriseMe() {
        dojo.publish("testMessageTopic", 
          [
            {
              message: "Twinkies are now being served in the vending machine!", 
              type: "fatal", 
              duration: 500
            }
          ]
        );
      }
    </script>

  .. cv:: html

    <div dojoType="dojox.widget.Toaster" 
         id="publish_subscribe_toaster" 
         positionDirection="br-left" 
         duration="0" 
         messageTopic="testMessageTopic">
    </div>
    <input type="button" onclick="surpriseMe()" value="Click here for Publish Subscribe toaster"/>

Additional Considerations:

- Toasters defined in Dialogs
- Creating Toaster programatically
- Multiple Toasters
