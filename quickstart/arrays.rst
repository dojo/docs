## page was renamed from dojo/array
## page was renamed from 1.2/dojo/array
#format dojo_rst

Arrays and Dojo
===============

:Status: Contributed, Draft
:Version: 1.0

Dojo comes with a bunch of useful methods to deal with arrays, a few more than you get from your browser by default.

dojo.indexOf
------------

dojo.indexOf lets you easily determine the index of an element in an array.
Included are a few doctests which will either pass or fail depending on the expected result.
Note that the second test should fail, since the value of the passed array at position 3 is not existant

.. codeviewer::
  
  <style type="text/css">
    @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/widget/DocTester/DocTester.css"; 
  </style>
  <script type="text/javascript">dojo.require("dojox.widget.DocTester");</script>
  <div dojoType="dojox.widget.DocTester">
    >>> dojo.indexOf(["foo", "hoo", "zoo"], "zoo")
    "2"
    >>> dojo.indexOf(["foo", "hoo", "zoo"], "zoo")
    "3"
  </div>

dojo.lastIndexOf
----------------

dojo.lastIndexOf lets you easily determine the last index of an element in an array.
Included are a few doctests which will either pass or fail depending on the expected result.
Note that the second doctest should fail since the last index of the tested element is not 2, but 4.

.. codeviewer::
  
  <style type="text/css">
    @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/widget/DocTester/DocTester.css"; 
  </style>
  <script type="text/javascript">dojo.require("dojox.widget.DocTester");</script>
  <div dojoType="dojox.widget.DocTester">
    >>> dojo.lastIndexOf(["foo", "hoo", "zoo", "shoe", "zoo", "nuu"], "zoo")
    "4"
    >>> dojo.lastIndexOf(["foo", "hoo", "zoo", "shoe", "zoo", "nuu"], "zoo")
    "2"
  </div>

dojo.forEach
------------

This is a heavylifer you will use a lot when writing your apps using Dojo. dojo.forEach lets you iterate over arrays, node lists and provides you with ways to filter your results. Lets take a look at a very basic example.
Note the "i" variable which returns the current position of an iteration

.. cv-compound::

  .. cv :: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button"); // this is just to make the demo look nicer

    var arr = ["apples", "kiwis", "pineapples"];
    function populateData(){
      dojo.forEach(arr, function(item, i){
        var li = dojo.doc.createElement("li");
        li.innerHTML = i+1+". "+item;
        dojo.byId("forEach-items").appendChild(li);
      });
    }
    </script>

  .. cv :: html

    <button dojoType="dijit.form.Button" onClick="populateData()">Populate data</button>
    <ul id="forEach-items">

    </ul>

Now lets use dojo.forEach with a list of dom nodes we retrieve using dojo.query. Note that dojo.query returns the list of dom nodes as an array. This way you can easily iterate over each dom node using dojo.forEach

.. cv-compound::

  .. cv :: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button"); // this is just to make the demo look nicer

    var arr = ["apples", "kiwis", "pineapples"];
    function populateQueryData(){
      dojo.query("li").forEach(function(item, i){
        var li = dojo.doc.createElement("li");
        li.innerHTML = i+1+". "+item.innerHTML;
        dojo.byId("forEachQuery-items").appendChild(li);
      });
    }
    </script>

  .. cv :: html

    <button dojoType="dijit.form.Button" onClick="populateQueryData()">Populate data</button>
    <ul id="forEachQuery-items">

    </ul>

dojo.filter
-----------

There are many cases when you have an array and want to filter it by a certain condition, say you have an array of people with a last name. You would like to filter those having a certain last name. Lets take a look at anexample

.. cv-compound::

  .. cv :: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button"); // this is just to make the demo look nicer

    var arr = [{surname: "Washington", name: "Paul"}, 
               {surname: "Gordon", name: "Amie"}, 
               {surname: "Meyer", name: "Sofie"}, 
               {surname: "Jaysons", name: "Josh"}, 
               {surname: "Washington", name: "George"}, 
               {surname: "Doormat", name: "Amber"}, 
               {surname: "Smith", name: "Susan"}, 
               {surname: "Hill", name: "Strawberry"}, 
               {surname: "Washington", name: "Dan"}, 
               {surname: "Dojo", name: "Master"}];

    function filterArray(){
      var filteredArr = dojo.filter(arr, function(item){
        return item.surname == "Washington";
      });

      dojo.forEach(filteredArr, function(item, i){
        var li = dojo.doc.createElement("li");
        li.innerHTML = i+1+". "+item.surname+", "+item.name;
        dojo.byId("filtered-items").appendChild(li);
      });

      dojo.forEach(arr, function(item, i){
        var li = dojo.doc.createElement("li");
        li.innerHTML = i+1+". "+item.surname+", "+item.name;
        dojo.byId("unFiltered-items").appendChild(li);
      });
    }
    </script>

  .. cv :: html

    <button dojoType="dijit.form.Button" onClick="filterArray()">Filter array</button>
    <div style="width: 300px; float: left;">
    Filtered items<br />(only people with "Washington" as surname)
    <ul id="filtered-items">

    </ul>
    </div>
    <div style="width: 300px; float: left;">
    Unfiltered items<br /> (all people are represented in the list)
    <ul id="unFiltered-items">

    </ul>
    </div>

dojo.map
--------

Another great funtion, Dojo is providing is dojo.map. dojo.map lets you run a function on all elements of an array and returns a new array with the changed values. A very good example is the "Give all my employees a 10% salary rise":

.. cv-compound::

  .. cv :: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button"); // this is just to make the demo look nicer

    var arrSalary = [{surname: "Washington", name: "Paul", salary: "200"}, 
               {surname: "Gordon", name: "Amie", salary: "350"}, 
               {surname: "Meyer", name: "Sofie", salary: "100"}, 
               {surname: "Jaysons", name: "Josh", salary: "2500"}, 
               {surname: "Washington", name: "George", salary: "10"}, 
               {surname: "Doormat", name: "Amber", salary: "320"}, 
               {surname: "Smith", name: "Susan", salary: "3200"}, 
               {surname: "Hill", name: "Strawberry", salary: "290"}, 
               {surname: "Washington", name: "Dan", salary: "200"}, 
               {surname: "Dojo", name: "Master", salary: "205"}];

    function raiseSalary(){
      var raisedSalaries = dojo.map(arrSalary, function(item){
        item.salary += 10%;
        return item;
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
