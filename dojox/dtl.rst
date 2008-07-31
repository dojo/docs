#format dojo_rst

dojox.dtl
=========

:Status: Draft
:Version: experimental
:Authors: Neil Roberts

The Django Template language uses a system of templates that can be compiled
once and rendered indefinitely afterwards. It uses a simple system of tags
and filters.

This is a 1:1 match with the Django Template Language as outlined in
http://www.djangoproject.com/documentation/templates/. All applicable tags and
filters have been implemented (see below), along with new filters and tags as
necessary (see below).

The Django Template Language is intended within Django to only handle text.
Our implementation is able to handle HTML in addition to text. Actually, the
text and HTML portions of dojox.dtl are two separate layers, the HTML layer
sits on top of the text layer (base). It's also been implemented in such a way
that you have little to fear when moving your code from Django to dojox.dtl.
Your existing templates should work, and will benefit from the massive
performance gain of being able to manipulate nodes, rather than having to do
clunky innerHTML swaps you would have to do with a text-only system. It also
allows for new HTML-centric abilities, outlined below.

Despite having two levels of complexity, if you write your tags correctly, they
will work in both environments.
