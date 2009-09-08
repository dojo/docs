#format dojo_rst

dojox.widget.Toaster
====================

:Status: Draft
:Version: beta
:Authors: Peter Higgins
:Documentation: Josh Trutwin, Peter Higgins

A toaster is an unobtrusive mechanism for displaying messages, and has become popular in recent years. Like toast, the message "pops up" in the window corner, temporarily overlaying any content there. The message stays up for a certain duration, or until the user clicks on it.

Toasters are preferable to alert() boxes. Alert() must always be modal, meaning all action on the page stops until the user clicks "OK". Toasters are non-modal, so the user can continue working and finish their thought before responding.

You can either set the message programmatically, or use dojo's publish/subscribe event feature. Publish/subscribe allows you to have several toasters, or several controls besides toasters, respond to a particular event.

To load a Toaster, issue the call:

.. code-block :: javascript
  :linenos:

  dojo.require("dojox.widget.Toaster");

And include the CSS somewhere in your page:

.. code-block :: html
  :linenos:

    <link rel="styleheet" href="dojotoolkit/dojox/widget/Toaster/Toaster.css" />


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
      dojo.require("dojox.widget.Toaster");
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

This example builds a Toaster programatically and lets you set params. 

.. cv-compound::

  A stylesheet is required for Toasters to render properly

  .. cv:: css

    <link rel="stylesheet" type="text/css" href="/moin_static163/js/dojo/trunk/dojox/widget/Toaster/Toaster.css" >

  Javascript

  .. cv:: javascript

    <script type="text/javascript">
       dojo.require("dojox.widget.Toaster");
       dojo.require("dojo.parser");

       function showMyToaster() {
          toaster = dijit.byId('myToaster');
          pos_fld = dojo.byId('myPosition');
          pos = pos_fld.options[pos_fld.selectedIndex].value;
          type_fld = dojo.byId('myMessageType');
          msg_type = type_fld.options[type_fld.selectedIndex].value;

          toaster.positionDirection = pos;
          toaster.setContent(dojo.byId('myToasterMsg').value, msg_type, dojo.byId('myDuration').value);
          toaster.show();
       }

       dojo.addOnLoad(function() {
          // create a toaster
          var myToaster = new dojox.widget.Toaster({
             id: 'myToaster',
          }, dojo.byId('ToasterPane'));
       });
    </script>

  The html creates an empty div to place the new Toaster instance into.  The rest is basic form stuff to parameterize the toaster.

  .. cv:: html

    <div id="ToasterPane"></div>
    <table style="border: 0px" border="0">
      <tr>
        <td>Position:</td>
        <td>
         <select id="myPosition" name="myPosition">
           <option value="br-up">br-up</option>
           <option value="br-left">br-left</option>
           <option value="bl-up">bl-up</option>
           <option value="bl-right">bl-right</option>
           <option value="tr-down">tr-down</option>
           <option value="tr-left">tr-left</option>
           <option value="tl-down">tl-down</option>
           <option value="tl-right">tl-right</option>
         </select>
       </td>
     </tr>
     <tr>
       <td>Message Type:</td>
       <td>
         <select id="myMessageType" name="myMessageType">
           <option value="message">message</option>
           <option value="warning">warning</option>
           <option value="error">error</option>
           <option value="fatal">fatal</option>
         </select>
       </td>
     </tr>
     <tr>
       <td>Duration:</td>
       <td><input type="text" id="myDuration" name="myDuration" size="6" value="2000"/> <small>Set to 0 to disable auto-fade</small></td>
     </tr>
     <tr>
       <td valign="top">Message:<br><small>HTML is accepted</small></td>
       <td><textarea id="myToasterMsg" name="myToasterMsg" rows="4" cols="60">Test Message</textarea></td>
     </tr>
     <tr>
       <td></td>
       <td><input type="button" onclick="showMyToaster()" value="Click here to see YOUR Toaster"/></td>
     </tr>
   </table>

Additional Considerations:

- Toasters defined in Dialogs
- Creating Toaster programatically
- Multiple Toasters
