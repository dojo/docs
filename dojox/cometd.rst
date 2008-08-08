#format dojo_rst

dojox.cometd
============

:Status: Draft
:Version: beta
:Authors: Alex Russell, Greg Wilkins

Low-latency data transfer from servers to clients. dojox.cometd implements a
Bayeux protocol client for use with most Bayeux servers. See cometd.com for
details on Cometd or on the Bayeux protocol.

Basic Example
-------------

Using dojox.cometd to connect to a Bayeux-compliant is very straightforward:

.. cv-compound::
 
  As a simple example, we'll setup a chat room; we will subscribe to a channel and log any messages received.
  When you send a message it is published on this channel. You can open a couple browsers to and send messages 
  back and forth to see this in action.

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dojo.io.script");
    dojo.require("dojox.cometd");
    dojo.require("dojox.cometd.callbackPollTransport");
    dojo.addOnLoad(function(){
	dojox.cometd.init("http://cometd.dojocampus.org:9000/cometd");
	dojox.cometd.subscribe("/demo",function(message){
		console.log("received",message);
		dojo.byId("messageLog").
			appendChild(document.createElement("div")).
			appendChild(document.createTextNode(message));
	});
	dojo.connect(dojo.byId("send"),"onclick",function(){
		dojox.cometd.publish("/demo",dojo.byId("sendText"));
	});
    });
    </script>

  The html is very simple

  .. cv:: html

    <div id="chatroom">
    	<div><input id="sendText" type="text"><button id="send">Send Message</button></div>
    	<div id="messageLog"></div>
    </div>
