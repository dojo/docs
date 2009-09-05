#format dojo_rst

dojox.dtl
=========

:Status: Draft
:Version: experimental
:Authors: Neil Roberts

The Django Template Language (DTL) uses a system of templates that can be compiled
once and rendered indefinitely afterward. Templates consist of simple tags
and filters.

Dojo's implementation of DTL matches Django 0.9, as outlined in
http://www.djangoproject.com/documentation/templates/. Features from more recent releases of Django are currently
being added. Along with the standard tags and filters, some new ones have been added
that leverage the additional capabilities of the browser.

Within Django, DTL is intended to only handle text.
Dojo's implementation is able to handle HTML which gets parsed to DOM instructions
in addition to text. Actually, the text and DOM portions of dojox.dtl are two separate layers. 
The DOM layer sits on top of the text layer (base). It's been implemented in such a way
that you have little to fear when moving your code from Django to dojox.dtl.
Your existing templates should work, and will benefit from the massive
performance gain of being able to manipulate the DOM, rather than having to do
clunky innerHTML swaps you would have to do with a text-only system. It also
allows for new DOM-centric capabilities.


========
Examples
========

Printing a simple list
----------------------

.. code-example::
  :version: 1.3.2-2.0

  .. javascript::

    <script type="text/javascript">
      dojo.require("dojox.dtl.Inline");
    </script>

  .. html::
 
    <!-- Use the DOM-based version with an external context -->
    <script type="text/html" dojoType="dojox.dtl.Inline" id="inline" context="{items: ['apple', 'banana', 'orange']}">
      <ul>
        {% for item in items %}
          <li>{{ item }}</li>
        {% endfor %}
      </ul>
    </script>
