## page was copied from MyStartingPage
##master-page:HomepageTemplate


= *Proposal* for dojo.Node object =

A dojo.Node object could be developed to be a wrapper to the standard DOM Node object and add some useful extended functionality to it. This would be much like the dojo.NodeList object, which is a wrapper for the standard Array class, and extending the DOM Node '''without''' interfering with the standard Javascript namespace. The interface this object would have would be identical in as many ways as possible to the dojo.NodeList object so that learning one would be knowning the other.

This might simplify the object hierarchy by allowing dojo.NodeList to actually contain a list of dojo.Node's and most of the existing functionality of dojo.NodeList would be converted to just looping thought its internal array and calling the same function on each dojo.Node within.

== Usage ==

Creating a dojo.Node is done using the same semantics as dojo.byId(), i.e. dojo.Node('nodeID') would return a dojo.Node wrapping the DOM node with id of 'nodeID'.

Building additional functionality on top of dojo.Node would allow simple constructs like:

{{{#!javascript
    dojo.Node('myId').css('display', 'none');
}}}

Compare this with the equivalent in today's Dojo:

{{{#!javascript
    dojo.style("myId", 'display', 'none');
    dojo.query("#myId").style('display', 'none');
}}}

While not a huge difference in the number of characters, the semantic bonuses should be pretty evident.

This would enable us to fill the current gap between a Nodelist, which offers rich functionality over a list of DOM nodes with simple semantics like nodelist.highlight() and nodelist.addContent(), and the DOM:element returned by dojo.byId() which is little more than a glorified data structure.

== Reasoning ==

This idea simply follows the same design idea behind dojo.query() returning a Nodelist instead of just an Array of DOM Nodes. The Nodelist has proven to be a very powerful addition to the Dojo object library and reduces the amount of code required to do the tedious everyday tasks, which is what good API design aspires to do, and less code is easier to maintain by definition.

Two of the most popular javascript frameworks in use today, Prototype has extensions to the DOM element which enables them to be treated as first class objects with extensible functionality.  Dojo has taken the approach that doing so is bad because it pollutes the global namespace.  However, Dojo already does something like this with dijit.byId(), which returns a widget instance. The DOM Node can be extended in the same way without changes to the global namespace and keep the developer aware that they are dealing with an extended dojo.Node type while still leaving them the option of using the original DOM Node if they so require.

Javascript often involves a good amount of DOM manipulation. The harder we make it for developers to do so, the less willing they are to use the our framework.

**NOTE** This function exists in plugd, as dojo.node(someid) - It will be proposed to Dojo Core as node.js, perhaps landing in time for Dojo 1.6
see: http://code.google.com/p/plugd/source/browse/trunk/node.js

**NOTE** James Burke has an adaptation of plugd's node.js which wraps NodeList directly, renaming the few APIs that are unable to translate to a single-node pattern. (eg: .style becomes .css and so on)
