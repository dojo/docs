#format dojo_rst

dojox.widget.Toaster
====================

:Status: Draft
:Version: beta
:Authors: Peter Higgins, ???
:Documentation: Josh Trutwin

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
    <input type="button" onclick="surpriseMe()" value="Click here"/>

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
    <input type="button" onclick="surpriseMe()" value="Click here"/>

Dijit Types, Attributes, Events and Methods
-------------------------------------------

=========          =========         =============  ===========
Attribute          Data Type         Default Value  Explanation
=========          =========         =============  ===========
duration           integer           2000           Duration of the message, in ms. 0 means the user must acknowledge the message by clicking on it.
messageTopic       String or object  -              Subscription topic to monitor. When a page publishes a message on this topic, the toaster will pop up.
positionDirection  br-up br-left     br-up          Corner from which message slides into screen (e.g. br=bottom right) and direction of slide.
                   bl-up bl-right 
                   tr-down tr-left 
                   tl-down tl-right
separator          html              <hr>           If more than one unacknowledged message is present separate them with this.
=========          =========         =============  ===========

Events
------

Event Name  Description
==========  ===========
onSelect  called when user clicks the message to acknowledge it
==========  ===========

Methods
-------

Method Name  Description
===========  ===========
hide()  Hide the toaster
setContent(String message, String type, int duration)  Set the content of the message to message. type can be "message" ,"warning", "error", "fatal" and determines the color (hence the importance)of the message. Duration is in ms, like the duration attribute.
show()  Display the toaster
===========  ===========

CSS Classes I'm not quite sure how to represent these yet. In this case, you set styles on dojoProgressBarColorLayer and set the class of the outer div to dojoProgressBarColor.
