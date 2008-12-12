#format dojo_rst

dojox.widget.Standby
====================

:Status: Draft
:Version: 1.3
:Project owner: Jared Jurkiewicz
:Available: since V1.3

.. contents::
   :depth: 2

Ever want to mark a widget as busy?  Ever have a time it was taking a grid a bit to fetch data?  Ever want to verlay some progress information on top of a login widget?  Well, this little widget solves all those scenarios!  The dojox.widget.Standby widget is designed as a 'overlay' style widget that will position a translucent overlay in a color of your choice with a graphic of your choice ontop of of any visible DOM node in your page.  The widget overlay blocks access to the underlying DOM node and will even track the DOM node's position so that if it moves, the overlay will shift its position to match.  It's very simple and easy to use!  

**Note:** There have been several examples of this style of widget around, including one done by Peter Higgins as an example of writing a dojo widget.  None of them, though, handle all the cases this one does.  It will mirror over any CSS applied curved borders in Firefox and Safari, as well as any CSS3 compliant broswer, it will track position and update if the target node moves.  It will also rescale itself should the target rescale as well as try to adapt for any margins applied to the target.


============
Known issues
============

* It does not lay out correctly on Google Chrome.  This is caused by the dojo.coords() function not returning the correct value for the width of the target node.
