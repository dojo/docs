.. _dojo/_base/array:

================
dojo/_base/array
================

.. contents ::
    :depth: 2

**dojo/_base/array** provides enhancements to native Array functions which may not be available.

In Dojo 2.0, this module will likely be replaced with a shim to support functions on legacy browsers that don't have 
these native capabilities.

Usage
=====

As with the rest of ``dojo/_base`` modules, if you are running the Dojo loader in legacy mode (``async: false``) this 
module is automatically loaded.  Even if it is automatically loaded, you should require it in to have access to its 
features:

.. js ::

  require(["dojo/_base/array"], function(array){
    // array contains the features
  });

.. _dojo/_base/array#indexof:

indexOf()
---------

``indexOf()`` determines the index of an element in an Array. It locates the first index of the provided value in the 
passed array. If the value is not found, ``-1`` is returned.

.. js ::

  require(["dojo/_base/array"], function(array){
    array.indexOf(arrayObject, valueToFind, fromIndex, findLast);
  });


Examples
~~~~~~~~

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/_base/array", "dojo/dom", "dojo/dom-construct", "dojo/on", "dojo/domReady!"], 
    function(array, dom, domConst, on){

      var arrIndxOf = ["foo", "hoo", "zoo"];

      on(dom.byId("refButton1"), "click", function(){
        var position = array.indexOf(arrIndxOf, "zoo");
        domConst.place(
          "<p>The index of the word 'zoo' within the array is " + position + "</p>",
          "result1",
          "after"
        );
      });

    });

  .. html ::

    <div>The content of our test array is <code>["foo", "hoo", "zoo"]</code>.</div>
    <button id="refButton1" type="button">Show the index of the word 'zoo' within the array.</button>
    <div id="result1"></div>

.. _dojo/_base/array#lastIndexOf:

lastIndexOf()
-------------

``lastIndexOf()`` determines the last index of an element in an array. It locates the last index of the provided value 
in the passed array. If the value is not found, ``-1`` is returned.

.. js ::

  require(["dojo/_base/array"], function(array){
    array.lastIndexOf(arrayObject, valueToFind, fromIndex);
  });

*Note*: Calling ``indexOf()`` with the ``findLast`` parameter set to ``true`` is the same as calling ``lastIndexOf()``.

Examples
~~~~~~~~

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/_base/array", "dojo/dom-construct", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(array, domConst, dom, on){

      var arrLastIndxOf = ["foo", "hoo", "zoo", "shoe", "zoo", "nuu"];

      on(dom.byId("refButton2"), "click", function(){
        var position = array.lastIndexOf(arrLastIndxOf, "zoo");
        domConst.place(
          "<p>The last index of the word 'zoo' within the array is " + position + "</p>",
          "result2",
          "after"
        );
      });
    });

  .. html ::

    <div>The content of our test array is <code>["foo", "hoo", "zoo", "shoe", "zoo", "nuu"]</code>.</div>
    <button id="refButton2" type="button">Show the last index of the word 'zoo' within the array.</button>
    <div id="result2"></div>

.. _dojo/_base/array#foreach:

forEach()
---------

``forEach()`` iterates over Arrays and NodeLists and provides ways to filter the results.

.. js ::

  require(["dojo/_base/array"], function(array){
    array.forEach(arrayObject, callback, thisObject);
  });


Using the third argument ``thisObject``, ``forEach()`` is capable of scoping:

.. js ::

  require(["dojo/_base/array"], function(array){
    var foo = {
      myMethod: function(el){
          console.log(el);
      }
    };

    array.forEach(["a","b","c"],function(item){
      this.myMethod(item);
    }, foo);
  });

*Note*: ``forEach()`` has a notable difference from the JavaScript 1.6's ``Array.forEach()`` in that it runs over 
sparse arrays, passing the "holes" in the sparse array to the callback function. JavaScript 1.6's ``Array.forEach()`` 
skips the holes in the sparse array.

Examples
~~~~~~~~

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  Basic Iteration Example

  .. js ::

    require(["dojo/_base/array", "dojo/dom-construct", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(array, domConst, dom, on){

      var arrFruit = ["apples", "kiwis", "pineapples"];

      on(dom.byId("start"), "click", function(){
        array.forEach(arrFruit, function(item, i){
          domConst.create("li", {innerHTML: i+1+". "+item}, "forEach-items");
        });
      });
    });

  .. html ::

    <button id="start" type="button">Populate data</button>
    <ul id="forEach-items">

    </ul>

To break the forEach-Loop you should use `some()`_:

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/_base/array", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(array, dom, on){

      on(dom.byId("start"), "click", function(){
        var myArray = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
            count;

        // iterate ALL entries of myArray
        count = 0;
        array.forEach(myArray, function(entry){
          count++;
        });

        alert("iterated " + count + " entries (forEach())"); // will show "iterated 10 entries"

        // let's only iterate the first 4 entries of myArray
        count = 0;
        array.some(myArray, function(entry){
          if(count >= 4){
            return false;
          }
          count++;
        });

        alert("iterated "+count+" entries (some())"); // will show "iterated 4 entries"
      });
    });

  .. html ::

    <button id="start" type="button">Start Testloops</button>

.. _dojo/_base/array#filter:

filter()
--------

``filter()`` does at it implies, filter an array or array-like structure.  ``filter()`` will return an array for 
values from ``unfilteredArray`` for which the ``callback`` returns a truthy value.  The original array is not modified.

.. js ::

  require(["dojo/_base/array"], function(array){
    filteredArray = array.filter(unfilteredArray, callback, thisObject);
  });


Examples
~~~~~~~~

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  Filter an array of objects for only those with a certain surname.

  .. js ::

    require(["dojo/_base/array", "dojo/dom", "dojo/dom-construct", "dojo/on", "dojo/domReady!"],
    function(array, dom, domConst, on){
      var arr = [
        { surname: "Washington", name: "Paul" },
        { surname: "Gordon", name: "Amie" },
        { surname: "Meyer", name: "Sofie" },
        { surname: "Jaysons", name: "Josh" },
        { surname: "Washington", name: "George" },
        { surname: "Doormat", name: "Amber" },
        { surname: "Smith", name: "Susan" },
        { surname: "Hill", name: "Strawberry" },
        { surname: "Washington", name: "Dan" },
        { surname: "Dojo", name: "Master" }
      ];

      on(dom.byId("start"), "click", function(){
        var filteredArr = array.filter(arr, function(item){
          return item.surname == "Washington";
        });

        array.forEach(filteredArr, function(item, i){
          domConst.create("li", {innerHTML: i+1+". "+item.surname+", "+item.name}, "filtered-items");
        });

        array.forEach(arr, function(item, i){
          domConst.create("li", {innerHTML: i+1+". "+item.surname+", "+item.name}, "unFiltered-items");
        });
      });
    });

  .. html ::

    <button id="start" type="button">Filter array</button>
    <br/>
    <div style="width: 300px; float: left;">
      Filtered items<br />
      (only people with "Washington" as surname)
      <ul id="filtered-items">

      </ul>
    </div>
    <div style="width: 300px; float: left;">
      Unfiltered items<br />
      (all people are represented in the list)
      <ul id="unFiltered-items">

      </ul>
    </div>

.. _dojo/_base/array#map:

map()
-----

``map()`` iterates all the elements in an array, passing them to the ``callback`` function and then returning a new 
array with any of the modified results.

.. js ::

  require(["dojo/_base/array"], function(array){
    array.map(arrayObject, callback, thisObject);
  });

Examples
~~~~~~~~

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  Double the values of an array.

  .. js ::

    require(["dojo/_base/array", "dojo/dom", "dojo/dom-construct", "dojo/on", "dojo/domReady!"], 
    function(array, dom, domConst, on){

      var arrValues = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

      on(dom.byId("button"), "click", function(){
        var doubleValue = array.map(arrValues, function(item){
          return item * 2;
        });

        array.forEach(doubleValue, function(item){
          var li = domConst.create("li");
          li.innerHTML = item;
          dom.byId("arrValuesAfter-items").appendChild(li);
        });

        array.forEach(arrValues, function(item){
          var li = domConst.create("li");
          li.innerHTML = item;
          dom.byId("arrValues-items").appendChild(li);
        });
      });
    });

  .. html ::

    <button id="button" type="button">Run array.map()</button>
    <br />
    <div style="width: 300px; float: left; margin-top: 10px;">
      Values before running array.map()
      <ul id="arrValues-items"></ul>
    </div>
    <div style="width: 300px; float: left; margin-top: 10px;">
      Values after running array.map()
      <ul id="arrValuesAfter-items"></ul>
    </div>

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

    Using ``map()`` with objects.

    *Note*: In JavaScript, objects are references, so you can not just change a value of a property without modifying 
    the object itself. Luckily Dojo provides you with a method to clone objects: 
    :ref:`dojo/_base/lang::clone() <dojo/_base/lang#clone>`

  .. js ::

    require(["dojo/_base/array", "dojo/_base/lang", "dojo/dom", "dojo/dom-construct", "dojo/on", "dojo/domReady!"], 
    function(array, lang, dom, domConst, on){

      var arrSalary = [
        { surname: "Washington", name: "Paul", salary: 200 },
        { surname: "Gordon", name: "Amie", salary: 350 },
        { surname: "Meyer", name: "Sofie", salary: 100 },
        { surname: "Jaysons", name: "Josh", salary: 2500 },
        { surname: "Washington", name: "George", salary: 10 },
        { surname: "Doormat", name: "Amber", salary: 320 },
        { surname: "Smith", name: "Susan", salary: 3200 },
        { surname: "Hill", name: "Strawberry", salary: 290 },
        { surname: "Washington", name: "Dan", salary: 200 },
        { surname: "Dojo", name: "Master", salary: 205 }
      ];

      on(dom.byId("button"), "click", function(){
        var raisedSalaries = array.map(arrSalary, function(item){
          var newItem = lang.clone(item);
          newItem.salary += (newItem.salary/100)*10;
          return newItem;
        });

        array.forEach(raisedSalaries, function(item, i){
          var li = domConst.create("li");
          li.innerHTML = i+1+". "+item.surname+", "+item.name+". New salary: "+item.salary;
          dom.byId("filteredSalary-items").appendChild(li);
        });

        array.forEach(arrSalary, function(item, i){
          var li = domConst.create("li");
          li.innerHTML = i+1+". "+item.surname+", "+item.name+". Old salary: "+item.salary;
          dom.byId("unFilteredSalary-items").appendChild(li);
        });
      });
    });

  .. html ::

    <button id="button" type="button">Raise the salary</button>
    <br />
    <div style="width: 300px; float: left; margin-top: 10px;">
      Peoples' salaries after raise:
      <ul id="filteredSalary-items"></ul>
    </div>
    <div style="width: 300px; float: left; margin-top: 10px;">
      Peoples' salaries before raise:
      <ul id="unFilteredSalary-items"></ul>
    </div>

.. _dojo/_base/array#some:

some()
------

``some()`` semantically answers the question "does a test hold true for at least one item in the array?"  Like 
`forEach()`_, ``some()`` iterates over the items in an array.  However, it short circuits and returns ``true`` as soon 
as it encounters an item for which the provided callback returns a truthy value.  If the callback doesn't return 
``true`` for any item, ``some()`` returns ``false``.

.. js ::

  require(["dojo/_base/array"], function(array){
    var a = array.some(arrayObject, callback, thisObject);
  });

*Note*: Because of the short circuiting, ``some()`` can be more efficient than ``forEach()`` when the loop is used for 
comparison purposes.

Examples
~~~~~~~~

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  Check if there is a value >= 1,000,000 in an array.

  .. js ::

    require(["dojo/_base/array", "dojo/dom", "dojo/dom-construct", "dojo/on", "dojo/domReady!"],
    function(array, dom, domConst, on){
      var arrIndxSome = [200000, 500000, 350000, 1000000, 75, 3];

      on(dom.byId("refButton6"), "click", function(){
        if(array.some(arrIndxSome, function(item){ return item >= 1000000; })){
          result = 'yes, there are';
        }else{
          result = 'no, there are no such items';
        }

        domConst.place(
          "<p>The answer is: " + result + "</p>",
          "result6",
          "after"
        );
      });
    });

  .. html ::

    <div>The content of our test array is <code>[200000, 500000, 350000, 1000000, 75, 3]</code>.</div>
    <button id="refButton6" type="button">Are there some items >=1000000 within the array?</button>
    <div id="result6"></div>

.. _dojo/_base/array#every:

every()
-------

``every()`` semantically answers the question "does a test hold true for every item in the array?"  Like `forEach()`_, 
``every()`` iterates over the items in an array.  However, it short circuits and returns ``false`` as soon as it 
encounters an item for which the provided callback returns a falsey value.  If the callback returns ``true`` for all 
items, ``every()`` returns ``true``.

.. js ::

  require(["dojo/_base/array"], function(array){
    array.every(arrayObject, callback, thisObject);
  });

*Note*: Because of the short circuiting, ``every()`` can be more efficient than ``forEach()`` when the loop is used 
for comparison purposes.

Examples
~~~~~~~~

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

    Check if every ``income`` > 3000;

  .. js ::

    require(["dojo/_base/array", "dojo/dom", "dojo/dom-construct", "dojo/on", "dojo/domReady!"],
    function(array, dom, domConst, on){

      var arrIndxEvery = [
        { month: "january", income: 2000 },
        { month: "february", income: 3200 }, 
        { month: "march", income: 2100 }
      ];

      on(dom.byId("refButton7"), "click", function(){
        if(array.every(arrIndxEvery , function(item){ return item.income >= 3000; })){
          result = "yes, all income >= 3000";
        }else{
          result = "no, not all income >= 3000";
        }
        domConst.place(
          "<p>The answer is: " + result + "</p>",
          "result7",
          "after"
        );
      });
    });

  .. html ::

    <div>The content of our test array is <code>[{ month: "january", income: 2000 }, { month: "february", income: 3200 }, { month: "march", income: 2100 }]</code>.</div>
    <button id="refButton7" type="button">Is the client allowed to get the credit?</button>
    <div id="result7"></div>

See Also
========

* :ref:`dojo/query <dojo/query>` - Several of these iteration functions are built into the NodeList return results 
  from ``dojo/query``.

* :ref:`NodeList <dojo/NodeList>` - A sugared Array of DOM Nodes returned from a ``dojo/query`` that leverages these 
  array extensions.
