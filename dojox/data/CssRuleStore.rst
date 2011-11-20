.. _dojox/data/CssRuleStore:

dojox.data.CssRuleStore
=======================

:Status: Contributed, Draft
:Version: 1.0
:Available: since V1.2

.. contents::
  :depth: 3

CssRuleStore is a read interface to the CSS rules loaded in the current page. Rules can be selected based on several different filterable attributes outlined below. Which CSS rules are indexed can be determined by a context provided to the store at the time of creation. This store is useful for reading the CSS rules that are loaded and in effect on the page.

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

===============
Item Attributes
===============

+--------------------+-------------------------------------------------------------------------------------------------------+
|selector            |The selector text (for example, '.class')                                                              |
+--------------------+-------------------------------------------------------------------------------------------------------+
|classes             |An array of strings representing the classes present in this selector (for example, if the selector is |
|                    |'.class1, .class2', the result would be ['class1', 'class2'])                                          |
+--------------------+-------------------------------------------------------------------------------------------------------+
|rule                |The DOM Rule object as provided by the browser                                                         |
+--------------------+-------------------------------------------------------------------------------------------------------+
|style               |The DOM CSSStyleDeclaration object as provided by the browser                                          |
+--------------------+-------------------------------------------------------------------------------------------------------+
|cssText             |The cssText string from the Rule object, provided by the browser                                       |
+--------------------+-------------------------------------------------------------------------------------------------------+
|styleSheet          |The DOM Stylesheet object this rule came from                                                          |
+--------------------+-------------------------------------------------------------------------------------------------------+
|parentStyleSheet    |The parent stylesheet to the sheet this rule came from.  May be null (if the rule came from a <style>  |
|                    |block, for instance).                                                                                  |
+--------------------+-------------------------------------------------------------------------------------------------------+
|parentStyleSheetHref|The url to the parent stylesheet. May be null.                                                         |
+--------------------+-------------------------------------------------------------------------------------------------------+

============
Query Syntax
============

The query syntax is identical to :ref:`dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`. Please refer to it for the format of the queries.

========
Examples
========

Programmatic construction of a ComboBox to browse rules
-------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.data.CssRuleStore");
      dojo.require("dijit.form.ComboBox");

      function init() {
        var ruleStore = new dojox.data.CssRuleStore({'context': ['dijit/themes/nihilo/nihilo.css']});
        var ruleCombo = new dijit.form.ComboBox({'store': ruleStore, 'searchAttr': 'selector'}, dojo.byId('ruleCombo'));

        function setCssText() {
           var item = ruleCombo.item;
           var text = dojo.byId("textLoc");
           if (text) {
             while(text.firstChild){
               text.removeChild(text.firstChild);
             }
             if (item) {
                text.innerHTML = ruleStore.getValue(item, "cssText");
             }
           }else {console.log("foo!")}
        }
        dojo.connect(ruleCombo, "onChange", setCssText);
      }
      dojo.addOnLoad(init);
    </script>

  .. cv :: html 

    <b>Combo lookup of selectors (scoped to nihilo.css)</b>
    <br> 
    <br> 
    <div id="ruleCombo"></div>
    <br>
    <br>
    <b>The css text associated with the rule: </b>
    <br>
    <span id="textLoc"></span>
    <br>
    <br>
