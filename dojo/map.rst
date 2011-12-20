.. _dojo/map:

========
dojo.map
========


.. contents ::
   :depth: 3

Applies callback to each element of given array and returns an Array with the results.


Introduction
============

This function corresponds to the JavaScript 1.6 Array.map() method, with one difference: when run over sparse arrays, this implementation passes the "holes" in the sparse array to the callback function with a value of undefined. JavaScript 1.6's map skips the holes in the sparse array. For more details, see: https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Objects/Array/map


Usage
=====

.. js ::
 
 // Before dojo 1.7
 var changedArray = dojo.map([1, 2, 3, 4], function(item){ return item+1; });
 console.log(changedArray); // logs [2, 3, 4, 5]

 // From dojo 1.7 on
 require(["dojo/_base/array"], function(array){
   var changedArray = array.map([1, 2, 3, 4], function(item){ return item+1; });
   console.log(changedArray); // logs [2, 3, 4, 5]
 });

Examples
========

This example shows you how to use dojo.map with a simple array. All values of the array will get doubled:

.. code-example ::

  .. js ::

    dojo.require("dijit.form.Button"); // this is just to make the demo look nicer

    var arrValues = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    function mapArray(){
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

  .. html ::

    <button data-dojo-type="dijit.form.Button" onClick="mapArray()">Run dojo.map()</button>
    <div style="width: 300px; float: left; margin-top: 10px;">
    Values before running dojo.map()
    <ul id="arrValues-items">

    </ul>
    </div>
    <div style="width: 300px; float: left; margin-top: 10px;">
    Values after running dojo.map()
    <ul id="arrValuesAfter-items">

    </ul>
    </div>

This example shows you how to use dojo.map with objects. In JavaScript, objects are references, so you can not just change a value of a property without modifying the object itself. Luckily Dojo provides you with a method to clone objects: :ref:`dojo.clone <dojo/clone>`

.. code-example ::

  .. js ::

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

  .. html ::

    <button data-dojo-type="dijit.form.Button" onClick="raiseSalary()">Raise the salary</button>
    <div style="width: 300px; float: left; margin-top: 10px;">
    Peoples salaries after raise:
    <ul id="filteredSalary-items">

    </ul>
    </div>
    <div style="width: 300px; float: left; margin-top: 10px;">
    Peoples salaries before raise:
    <ul id="unFilteredSalary-items">

    </ul>
    </div>
