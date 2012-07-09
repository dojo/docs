.. _dojox/mvc/Output:

===========================
dojox.mvc.Output
===========================

:Authors: Rahul Akolkar, Ed Chatelain
:Developers: Rahul Akolkar, Ed Chatelain
:since: V1.7


.. contents ::
   :depth: 2

A simple widget that displays templated output, parts of which may be data-bound.


Parameters
======================

+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+
|Parameter         |Type         |Default   |Description                                                                                             |
+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+
|ref               |String or    |          |*Deprecated*. ref is only used with StatefulModel which is Deprecated, use value: at(model, 'attr').    |
|                  |StatefulModel|          |The value of the data binding expression passed declaratively by the developer. This usually references |
|                  |             |          |a location within an existing datamodel and may be a relative reference based on the parent / container |
|                  |             |          |data binding (dot-separated string).                                                                    |
+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+
|exprchar          |Character    | '$'      |Character to use for a substitution expression, for a substitution string like ${this.value}            |
|                  |             |          |                                                                                                        |
+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+


Available Methods
=================

* dojox/mvc/Output.set

Override and refresh output on value change.


Examples
========

Declarative example
-------------------

.. html ::

    <span data-dojo-type="dojox/mvc/Output" data-dojo-props="value: at(model, 'balance')"></span>

In the above example, since the span is empty the output widget displays the value of 'balance' from model in the span. If the  balance changes in the model, the content within the <span> will be updated accordingly.


.. html ::

    <span data-dojo-type="dojox/mvc/Output" data-dojo-props="value: at(model, 'balance')">
        Your balance is: ${this.value}
    </span>

In the above example, the output widget being data-bound, if the  balance changes in the model, the content of ${this.value} within the <span> will be updated accordingly.
