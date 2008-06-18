##master-page:HomepageTemplate
#format wiki

= Proposal for dojo.Node object =

A dojo.Node object could be developed to be a wrapper to the standard DOM Node object and add some useful extended functionality to it. This would be much like the dojo.NodeList object extending the DOM Node '''without''' interfering with the standard Javascript namespace. The interface this object would have would be identical in as many ways as possible to the dojo.NodeList object so that learning on would be knowning the other.

This might simplify the object hierarchy by allowing dojo.NodeList to actually contain a list of dojo.Node's and most of the existing functionality of dojo.NodeList would be converted to just looping thought its internal array and calling the same function on each dojo.Node within.

== Usage ==

Creating a dojo.Node is done using the same semantics as dojo.byId(), i.e. dojo.Node('nodeID') would return a dojo.Node wrapping the DOM node with id == 'nodeID'.

Building additional functionality on top of dojo.Node would allow simple constructs like:

{{{#!javascript
    dojo.Node('myId').hide();
}}}

Compare this with the equivalent in today's dojo:

{{{#!javascript
    dojo.byId('myId').style.display = 'none';
}}}

While not a huge difference in the number of characters, the semantic bonuses should be pretty evident.

This would enable us to fill the current gap between a Nodelist, which offers rich functionality over a list of DOM nodes with simple semantics like nodelist.highlight() and nodelist.addContent(), and the DOM:element returned by dojo.byId() which is little more than a glorified data structure.

== Reasoning ==

Two of the most popular javascript frameworks in use today, Prototype and jQuery, have extensions to the DOM element which enables them to be treated as first class objects with extensible functionality.  Dojo has taken the approach that doing so is bad because it pollutes the global namespace.  However, dojo already does something like this with dijit.byId(), which returns a widget instance.

Javascript often involves a good amount of DOM manipulation. The harder we make it for developers to do so, the less willing they are to use our framework.
