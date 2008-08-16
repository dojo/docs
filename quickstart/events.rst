#format dojo_rst

JavaScript events and Dojo
==========================

:Status: Draft
:Version: 1.2

Dojo's event system offers a refreshing alternative to the normal JavaScript events. With Dojo, you connect functions to one another, creating a link that calls one function when another fires. This means that you can connect a function of your own to

* a DOM event, such as when a link is clicked;
* an event of an object, such as an animation starting or stopping;
* a function call of your own, such as bar();
* a topic, which acts as a queue that other objects can publish objects to.

Your connected function is called when the event occurs. With simple events, when it calls your function, dojo passes your function a normalized event object, so that it can respond correctly, responding to keystrokes or stopping default behavior. With topics, Dojo passes any subscribed functions the object that was published. Dojo happily abstracts away all of the difficulty of cross-browser event systems, offering programmers a coherent event system that acts consistently across browsers.

Dojo's event system is flexible and gives you a few options for connecting your functions. In the core package, you have both simple events (which use a signal and slot system, similar to Qt's) and topics. In this section, you'll learn the following:

* how to connect functions to one another with dojo.connect,
* what comes with an event object
* how to connect functions with topics and even publish your own objects to the topic
* how to enjoy event-based programming
