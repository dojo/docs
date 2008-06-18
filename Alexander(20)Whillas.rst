##master-page:HomepageTemplate
#format wiki

= Proposal for dojo.Node object =

A dojo.Node object could be developed to add some useful extended functionality to the standard DOM Node type '''without''' interfering with the standard Javascript DOM Node. This object would simply be an optional wraper to the DOM Node type as dojo.NodeList is a wraper to the standard Javascriopt Array object.

The interface this object would have would be identical in as many ways as possible to the dojo.NodeList object so that learning on would be knowning the other. This might even simplify the object heirarchy by allowing dojo.NodeList to actually contain a list of dojo.Node's and most of the existing functionality of dojo.NodeList would be converted to just looping thought ints internal array and calling the same funciton on each dojo.Node.

To use this object its proposed that dojo.byId would return a dojo.Node instead of a DOM Node. If the plain DOM Node was require then perhaps 

== Argument ==

Since dojo.query() is already returning a dojo.NodeList then why not take it further to 


CategoryHomepage
