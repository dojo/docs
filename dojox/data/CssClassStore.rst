#format dojo_rst

dojox.data.CssClassStore
========================

:Status: Contributed, Draft
:Version: 1.0
:Available: since V1.2

.. contents::
  :depth: 3

CssClassStore is a read interface based on the CssRuleStore.  Items represent the individual classes present in the stylesheets loaded in the current page.  In other words, compared to the results of a query on the CssRuleStore, the CssClassStore generates items that may be represented by a single item in the rule store (if several classes are mentioned in a single selector) OR may occur multiple times in the rule store (for a class that's mentioned in several selectors).  Since the class store is based upon (extends) the rule store, it takes the same constructor parameters and operates very similarly.  The single biggest difference is the support for the Identity API in the CssClassStore.  The identity of an individual item is the same as it's 'class' attribute, which is the class name, including the '.' that is used to denote a class in a CSS selector.

===========
API Support
===========
* dojo.data.api.Read
* dojo.data.api.Identity

======================
Constructor Parameters
======================

The constructor for CssClassStore allows for one optional parameter.

+----------+-------------------------------------------------------------------------------------------------+-------------+
|**Name**  |**Description**                                                                                  |**Type**     |
+----------+-------------------------------------------------------------------------------------------------+-------------+
|context   |An array of strings, each being a pattern to match on the paths of loaded stylesheets, indicating|Array        |
|          |which rules to index.                                                                            |             |
+----------+-------------------------------------------------------------------------------------------------+-------------+

===============
Item Attributes
===============

+--------------------+-------------------------------------------------------------------------------------------------------+
|class               |The class name, including the '.'                                                                      |
+--------------------+-------------------------------------------------------------------------------------------------------+
|classSans           |The class name, without the '.'                                                                      |
+--------------------+-------------------------------------------------------------------------------------------------------+

============
Query Syntax
============

The query syntax is identical to `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_. Please refer to it for the format of the queries.
