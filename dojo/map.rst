#format dojo_rst

dojo.map
========

:Status: Draft
:Version: 1.2

.. contents::
   :depth: 3

Examples
--------

This example shows you how to use dojo.map with a simple array. All values of the array will get doubled:

.. cv-compound::

  .. cv :: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button"); // this is just to make the demo look nicer

    var arrValues = [1,2,3,4,5,6,7,8,9,10]

    function raiseSalary(){
      var doubleValue = dojo.map(arrValues, function(item){
        return item*2;
      });

      dojo.forEach(doubleValue, function(item){
        var li = dojo.doc.createElement("li");
        li.innerHTML = item;
        dojo.byId("arrValuesAfter-items").appendChild(li);
      });

      dojo.forEach(arrValues, function(item){
        var li = dojo.doc.createElement("li");
        li.innerHTML = item;
        dojo.byId("arrValues-items").appendChild(li);
      });
    }
    </script>

  .. cv :: html

    <button dojoType="dijit.form.Button" onClick="raiseSalary()">Run dojo.map()</button>
    <div style="width: 300px; float: left;">
    Values before running dojo.map()
    <ul id="arrValues-items">

    </ul>
    </div>
    <div style="width: 300px; float: left;">
    Values after running dojo.map()
    <ul id="arrValuesAfter-items">

    </ul>
    </div>

This example shows you how to use dojo.map with objects. In JavaScript, objects are references, so you can not just change a value of a property without modifying the object itself. Luckily Dojo provides you with a method to clone objects: `dojo.clone <dojo/clone>`_

.. cv-compound::

  .. cv :: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button"); // this is just to make the demo look nicer

    var arrSalary = [{surname: "Washington", name: "Paul", salary: 200}, 
               {surname: "Gordon", name: "Amie", salary: 350}, 
               {surname: "Meyer", name: "Sofie", salary: 100}, 
               {surname: "Jaysons", name: "Josh", salary: 2500}, 
               {surname: "Washington", name: "George", salary: 10}, 
               {surname: "Doormat", name: "Amber", salary: 320}, 
               {surname: "Smith", name: "Susan", salary: 3200}, 
               {surname: "Hill", name: "Strawberry", salary: 290}, 
               {surname: "Washington", name: "Dan", salary: 200}, 
               {surname: "Dojo", name: "Master", salary: 205}];

    function raiseSalary(){
      var raisedSalaries = dojo.map(arrSalary, function(item){
        var newItem = dojo.clone(item);
        newItem.salary += (newItem.salary/100)*10;
        return newItem;
      });

      dojo.forEach(raisedSalaries, function(item, i){
        var li = dojo.doc.createElement("li");
        li.innerHTML = i+1+". "+item.surname+", "+item.name+". New salary: "+item.salary;
        dojo.byId("filteredSalary-items").appendChild(li);
      });

      dojo.forEach(arrSalary, function(item, i){
        var li = dojo.doc.createElement("li");
        li.innerHTML = i+1+". "+item.surname+", "+item.name+". Old salary: "+item.salary;
        dojo.byId("unFilteredSalary-items").appendChild(li);
      });
    }
    </script>

  .. cv :: html

    <button dojoType="dijit.form.Button" onClick="raiseSalary()">Raise the salary</button>
    <div style="width: 300px; float: left;">
    Peoples salaries after raise:
    <ul id="filteredSalary-items">

    </ul>
    </div>
    <div style="width: 300px; float: left;">
    Peoples salaries before raise:
    <ul id="unFilteredSalary-items">

    </ul>
    </div>
