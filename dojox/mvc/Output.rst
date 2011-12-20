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
|ref               |String or    |          |The value of the data binding expression passed declaratively by the developer. This usually references |
|                  |StatefulModel|          |a location within an existing datamodel and may be a relative reference based on the parent / container |
|                  |             |          |data binding (dot-separated string).                                                                    |
+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+


Available Methods
=================

* dojox.mvc.Output.set

Override and refresh output on value change.


Examples
========

Declarative example
-------------------

.. html ::

    <span data-dojo-type="dojox.mvc.Output" ref="model.balance">
        Your balance is: ${this.value}
    </span>

In the above example, the output widget being data-bound, if the  balance changes in the dojox.mvc.StatefulModel, the content within the <span> will be updated accordingly.
