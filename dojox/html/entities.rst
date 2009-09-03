#format dojo_rst

dojox.html
==========

:Status: Draft
:Version: 1.0
:Authors: Jared Jurkiewicz
:Developers: Jared Jurkiewicz
:Available: since V1.4

.. contents::
    :depth: 2

**dojox.html.entities** offers basic entity mapping for HTML and LATIN-1 (8859-1) characters, as well as helper functions for encoding and decoding entities in text strings

========
Features
========

* Complete entity map for HTML.
* Complete entiity map for LATIN-1 (8859-1)
* Simple to use encode and decode functions.

=================
Entity Map Format
=================

Users can use their own entity maps with the encode and decode functions, which makes them highly flexible.  So, how do users go about defining their own entity maps.  Simple, the format is an array of arrays and is as follows:

.. code-block ::

  [
     ["<UTF-8 character", "Entity encoding minus & and  ;"]
     ... //Any number of other mappings
  ];

So, for example say you want to *just* encode & characters to an entity representation.  You would define the map as follows:

.. code-block ::

  [
     ["\u0026", "amp"]
  ];

Then call the encode and decode functions with that as the map to use instead of the default maps.
