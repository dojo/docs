#format dojo_rst

dojox.data.CssRuleStore
=======================

:Status: Contributed, Draft
:Version: 1.0
:Available: since V1.2

.. contents::
  :depth: 3

CssRuleStore is a read interface to the CSS rules loaded in the current page.  Rules can be selected based on several different filterable attributes outlined below.  Which CSS rules are indexed can be determined by a context provided to the store at the time of creation.  This store is useful for reading the CSS rules that are loaded and in effect on the page.

===========
API Support
===========
* dojo.data.api.Read

======================
Constructor Parameters
======================

The constructor for CssRuleStore allows for one optional parameter.
+----------+-------------------------------------------------------------------------------------------------+-------------+
|**Name**  |**Description**                                                                                  |**Type**     |
+----------+-------------------------------------------------------------------------------------------------+-------------+
|context   |An array of strings, each being a pattern to match on the paths of loaded stylesheets, indicating|Array        |
|          |which rules to index.                                                                            |             |
+----------+-------------------------------------------------------------------------------------------------+-------------+
