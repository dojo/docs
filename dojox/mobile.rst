Describe dojox/mobile here.


This project tries to solve an area lacking in dojo, namely better
support for mobile devices.  This project provides through CSS3 and
custom styles, interfaces that display and work well on mobile devices
such as the Android and iPhone Smart Phones.

The code is deliberately kept as lightweight as possible, using CSS3 animations
and the like to perform the effects.  There is a compat.js, which will simulate
most of the effects using dojo.animateProperty and dojox.gfx where possible on
browsers such as FireFox and IE.  It will not load by default, it has to be
required in separately.
