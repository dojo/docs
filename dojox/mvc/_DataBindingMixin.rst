.. _dojox/mvc/_DataBindingMixin:

===========================
dojox.mvc._DataBindingMixin
===========================

:Authors: Rahul Akolkar, Ed Chatelain
:Developers: Rahul Akolkar, Ed Chatelain
:since: V1.7


.. contents ::
   :depth: 2

Provides the ability for dijits or custom view components to become data binding aware.  Data binding awareness enables Dijits 
or other view layer components to bind to locations within a client-side data model, which is commonly an instance of the 
:ref:`dojox.mvc.StatefulModel <dojox/mvc/StatefulModel>` class. A bind is a bi-directional update mechanism which is capable of 
synchronizing value changes between the bound dijit or other view component and the specified location within the data model, as 
well as changes to other properties such as "valid", "required", "readOnly" etc


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

* dojox.mvc._DataBindingMixin.isValid

Returns the validity of the data binding. This function is meant to provide an API bridge to the dijit API. 
Validity of data-bound Dijits is a function of multiple concerns:

- 'The validity of the value as ascertained by the data binding and constraints specified in the data model (usually semantic).'

- 'The validity of the value as ascertained by the widget itself based on widget constraints (usually syntactic).'

In order for Dijits to function correctly in data-bound environments, it is imperative that their isValid() functions
assess the model validity of the data binding via the this.inherited(arguments) hierarchy and declare any values
failing the test as invalid.


Examples
========

Declarative example
-------------------

.. code-example ::

  .. js ::

        var model;
        require(["dijit/StatefulModel", "dojo/parser", "dijit/form/TextBox", "dojo/domReady!"], function(StatefulModel, parser){
            model = new StatefulModel({ data : {
                hello : "Hello World"
            }});
            parser.parse();
        });


  .. html ::

        <input id="hello1" data-dojo-type="dijit.form.TextBox"
            data-dojo-props="ref: model.hello"></input>

        <input id="hello2" data-dojo-type="dijit.form.TextBox"
            data-dojo-props="ref: model.hello"></input>

In the above example, both dijit.form.TextBox instances (with IDs "hello1" and "hello2" respectively) are bound to the same 
reference location in the data model i.e. "hello" via the "ref" expression "model.hello". Both will have an initial value of "Hello 
World". Thereafter, a change in the value of either of the two textboxes will cause an update of the value in the data model at 
location "hello" which will in turn cause a matching update of the value in the other textbox.
