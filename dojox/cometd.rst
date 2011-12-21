.. _dojox/cometd:

============
dojox.cometd
============

:Authors: Alex Russell, Greg Wilkins

Low-latency data transfer from servers to clients. dojox.cometd implements a
Bayeux protocol client for use with most Bayeux servers. See cometd.com for
details on Cometd or on the Bayeux protocol.

Basic Example
-------------

Using dojox.cometd to connect to a Bayeux-compliant server is very straightforward:

.. code-example ::

  As a simple example, we'll setup a chat room; we will subscribe to a channel and log any messages received.
  When you send a message it is published on this channel. You can open a couple browsers to and send messages
  back and forth to see this in action. Just enter your name and type a message and click send.

  .. js ::

    dojo.require("dijit.form.TextBox"); // Those widgets are only included to make the example look nice
    dojo.require("dijit.form.Button"); // Those widgets are only included to make the example look nice

    dojo.require("dojo.io.script");
    dojo.require("dojox.cometd");
    dojo.require("dojox.cometd.callbackPollTransport");
    dojo.ready(function(){
        dojox.cometd.init("http://cometd.dojocampus.org:9000/cometd");
        dojox.cometd.subscribe("/demo", function(message){
            console.log("received", message);
            dojo.byId("messageLog").
                appendChild(document.createElement("div")).
                appendChild(document.createTextNode(message.data.from + ": " + message.data.text));
        });
        dojo.connect(dojo.byId("send"), "onclick", function(){
            if(!dojo.byId("sendName").value.length || !dojo.byId("sendText").value.length){
                                alert("Please enter some text");
                                return;
                        }
                        dojox.cometd.publish("/demo", {
                 from: dojo.byId("sendName").value,
                 text: dojo.byId("sendText").value
            });
        });
    });

  The html is a just a simple form to enter you name and message to send

  .. html ::

    <div id="chatroom">
        <div style="clear: both;"><label for="sendName" style="float: left; width: 100px; padding: 3px;">Name:</label> <input id="sendName" type="text" data-dojo-type="dijit.form.TextBox"></div>
        <div style="clear: both;"><label for="sendText" style="float: left; width: 100px; padding: 3px;">Message:</label> <input id="sendText" type="text" data-dojo-type="dijit.form.TextBox"><button id="send" data-dojo-type="dijit.form.Button">Send Message</button></div>
        <div id="messageLog"><strong>Messages:</strong></div>
    </div>

  .. css ::

      #messageLog {
        margin-top: 20px;
        padding: 5px;
        width: 400px;
      }
