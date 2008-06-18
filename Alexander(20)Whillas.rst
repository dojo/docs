##master-page:HomepageTemplate
#format wiki

= Proposal for dojo.Node object =

A dojo.Node object could be developed to be a wrapper to the standard DOM Node object and add some useful extended functionality to it. This would be much like the dojo.NodeList object extending the DOM Node '''without''' interfering with the standard Javascript namespace. The interface this object would have would be identical in as many ways as possible to the dojo.NodeList object so that learning on would be knowning the other.

This might simplify the object hierarchy by allowing dojo.NodeList to actually contain a list of dojo.Node's and most of the existing functionality of dojo.NodeList would be converted to just looping thought its internal array and calling the same function on each dojo.Node within.

== Usage ==

To use this object its proposed that dojo.byId would return a dojo.Node instead of a DOM Node and the dojo.NodeList would contain a list of dojo.Node objects. If the plain DOM Node was require then perhaps an additional parameter could be added to return the plain DOM Node. An accessor function to return the DOM Node would also certainly be required.

Perhaps to remain backward compatible a new set of function to alias dojo.byId() and dojo.query() could be developed such as dojo.id() and dojo.q() respectively?


== Argument ==

Since dojo.query() is already returning a dojo.NodeList object following the same logic the dojo.byId() could return a dojo.Node object. This would greatly simplify code and make the dojo.byId() quite powerful again.
