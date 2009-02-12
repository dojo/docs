#format dojo_rst

dojox.dtl
=========

:Status: Draft
:Version: experimental
:Authors: Neil Roberts

The Django Template language uses a system of templates that can be compiled
once and rendered indefinitely afterward. It uses a simple system of tags
and filters.

This is a 1:1 match with the Django Template Language as of Django 0.9 outlined in
http://www.djangoproject.com/documentation/templates/. The new features as currently
being added. Along with the standard tags and filters, some new ones have been added
that leverage the additional capabilities of the browser.

The Django Template Language is intended within Django to only handle text.
Our implementation is able to handle HTML which gets parsed to DOM instrctions
in addition to text. Actually, the
text and DOM portions of dojox.dtl are two separate layers, the DOM layer
sits on top of the text layer (base). It's been implemented in such a way
that you have little to fear when moving your code from Django to dojox.dtl.
Your existing templates should work, and will benefit from the massive
performance gain of being able to manipulate the DOM, rather than having to do
clunky innerHTML swaps you would have to do with a text-only system. It also
allows for new DOM-centric capabilities.
