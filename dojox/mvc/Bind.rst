.. _dojox/mvc/Bind:

=======================
dojox.mvc.Bind
=======================

:Authors: Rahul Akolkar, Ed Chatelain
:Developers: Rahul Akolkar, Ed Chatelain
:since: V1.7


.. contents ::
   :depth: 2


Available Methods
=================

* dojox.mvc.bind

Bind the specified property of the target to the specified property of the source with the supplied transformation.


Parameters
----------

+------------------+---------+--------------+--------------------------------------------------------------------------------------------------------+
|Parameter         |Type     |Default       |Description                                                                                             |
+------------------+---------+--------------+--------------------------------------------------------------------------------------------------------+
|source            |Stateful |              |The source dojo.Stateful object for the bind.                                                           |
+------------------+---------+--------------+--------------------------------------------------------------------------------------------------------+
|sourceProp        |String   |              |The name of the source's property whose change triggers the bind.                                       |
+------------------+---------+--------------+--------------------------------------------------------------------------------------------------------+
|target            |Stateful |              |The target dojo.Stateful object for the bind whose property will be updated with the result of the      |
|                  |         |              |function.                                                                                               |
+------------------+---------+--------------+--------------------------------------------------------------------------------------------------------+
|targetProp        |String   |              |The name of the target's property to be updated with the result of the function.                        |
+------------------+---------+--------------+--------------------------------------------------------------------------------------------------------+
|func              |Function |              |The optional calculation to be performed to obtain the target property value.                           |
+------------------+---------+--------------+--------------------------------------------------------------------------------------------------------+
|bindOnlyIfUnequal |Function | false        |Whether the bind notification should happen only if the old and new values are unequal (optional).      |
+------------------+---------+--------------+--------------------------------------------------------------------------------------------------------+


* dojox.mvc.bindInputs

Bind the values at the sources specified in the first argument array such that a composing function in the second argument is called when any of the values changes.


Parameters
----------

+------------------+----------+-------------+--------------------------------------------------------------------------------------------------------+
|Parameter         |Type      |Default      |Description                                                                                             |
+------------------+----------+-------------+--------------------------------------------------------------------------------------------------------+
|sourceBindArray   |Stateful[]|             |The array of dojo.Stateful objects to watch values changes on.                                          |
+------------------+----------+-------------+--------------------------------------------------------------------------------------------------------+
|func              |String    |             |The composing function that is called when any of the source values change.                             |
+------------------+----------+-------------+--------------------------------------------------------------------------------------------------------+
