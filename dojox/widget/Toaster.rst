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
          dijit.byId('toast').setContent('Twinkies are now being served in the vending machine!','fatal');
          dijit.byId('toast').show();
       }
    </script>

  The html is very simple

  .. cv:: html

    <div dojoType="dojox.widget.Toaster" 
         id="toast" 
         positionDirection="br-left" >
    </div>
    <input type="button" onclick="surpriseMe()" value="Click here"/>
