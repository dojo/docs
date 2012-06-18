.. _dojo/_base/array:

===============
Arrays and Dojo
===============

.. contents ::
    :depth: 2

Dojo comes with a bunch of useful methods to deal with arrays, a few more than you get from your browser by default.
They are in the dojo/_base/array module.


indexOf()
=========

.. js ::

  require(["dojo/_base/array"], function(array){
    array.indexOf(arrayObject, valueToFind, fromIndex, findLast);
  });


indexOf() lets you easily determine the index of an element in an array. It locates the first index of the provided value in the passed array. If the value is not found, -1 is returned.

.. code-example ::

  .. js ::

	require(["dojo/_base/array", "dojo/dom-construct", "dijit/form/Button"], function(array, domConstruct){

		var arrIndxOf = ["foo", "hoo", "zoo"];

		testIndxOf = function(){
			var position = array.indexOf(arrIndxOf, "zoo");
			domConstruct.place(
				"<p>The index of the word 'zoo' within the array is " + position + "</p>",
				"result1",
				"after"
			);
		}
	});

  .. html ::

    <div>The content of our test array is ["foo", "hoo", "zoo"].</div>
    <button id="refButton1" data-dojo-type="dijit/form/Button" onClick="testIndxOf();" type="button">Show the index of the word 'zoo' within the array.</button>
    <div id="result1"></div>


lastIndexOf()
=============

.. js ::

  require(["dojo/_base/array"], function(array){
    array.lastIndexOf(arrayObject, valueToFind, fromIndex);
  });

lastIndexOf() lets you easily determine the last index of an element in an array. It locates the last index of the provided value in the passed array. If the value is not found, -1 is returned.

**Note**: Calling `indexOf` with the `findLast` parameter set to true is the same as calling `lastIndexOf`.

.. code-example ::

  .. js ::

	require(["dojo/_base/array", "dojo/dom-construct", "dijit/form/Button"], function(array, domConstruct){

		var arrLastIndxOf = ["foo", "hoo", "zoo", "shoe", "zoo", "nuu"];

		testLastIndxOf = function(){
			var position = array.lastIndexOf(arrLastIndxOf , "zoo");
			domConstruct.place(
				"<p>The last index of the word 'zoo' within the array is " + position + "</p>",
				"result2",
				"after"
			);
		}
	});

  .. html ::

    <div>The content of our test array is ["foo", "hoo", "zoo", "shoe", "zoo", "nuu"].</div>
    <button id="refButton2" data-dojo-type="dijit/form/Button" data-dojo-props="onClick:testLastIndxOf" type="button">Show the last index of the word 'zoo' within the array.</button>
    <div id="result2"></div>


forEach()
=========

.. js ::

  require(["dojo/_base/array"], function(array){
    array.forEach(arrayObject, callback, thisObject);
  });

This is a heavy lifter you will use often when writing your apps.
Using forEach() lets you iterate over arrays, node lists and provides you with ways to filter your results.
Let's take a look at a very basic example.
Note the "i" variable which returns the current position of an iteration

.. code-example ::

  .. js ::

 	require(["dojo/_base/array", "dojo/dom-construct", "dijit/form/Button"], function(array, domConstruct){
		var arrFruit = ["apples", "kiwis", "pineapples"];
		populateData = function(){
		  array.forEach(arrFruit, function(item, i){
			domConstruct.create("li", {innerHTML: i+1+". "+item}, "forEach-items");
		  });
		}
	});

  .. html ::

    <button data-dojo-type="dijit/form/Button" data-dojo-props="onClick:populateData" type="button">Populate data</button>
    <ul id="forEach-items">

    </ul>


To break the forEach-Loop you should use some():

.. code-example ::

  .. js ::

 	require(["dojo/_base/array", "dijit/form/Button"], function(array){

		arrayLoopTest = function(){
			var myArray = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
			var count;

			// let's iterate ALL entries of myArray
			count = 0;
			array.forEach(myArray, function(entry){
				count++;
			});

			alert("iterated "+count+" entries (forEach())"); // will show "iterated 10 entries"

			// let's only iterate the first 4 entries of myArray
			count = 0;
			array.some(myArray, function(entry){

				if(count >= 4)
				{
					return false;
				}

				count++;
			});

			alert("iterated "+count+" entries (some())"); // will show "iterated 4 entries"
		}
	});

  .. html ::

    <button data-dojo-type="dijit/form/Button" data-dojo-props="onClick: arrayLoopTest" type="button">Start Testloops</button>

Using the third argument ``thisObject`` forEach is capable of scoping:

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

``forEach`` has a notable difference from the JavaScript 1.6 forEach: ``dojo's forEach`` runs over sparse arrays, passing the "holes" in the sparse array to the callback function. JavaScript 1.6's forEach skips the holes in the sparse array.


filter()
========

.. js ::

  require(["dojo/_base/array"], function(array){
    filteredArray = array.filter(unfilteredArray, callback, thisObject);
  });

There are many cases when you have an array and want to filter it by a certain condition, ``filter()`` will only keep values from ``unfilteredArray`` for which ``callback`` returns ``true``. The original array is not modified.

Say you have an array of people with a last name.
You would like to filter those having a certain last name.
Let's take a look at an example:

.. code-example ::

  .. js ::

 	require(["dojo/_base/array", "dojo/dom-construct", "dijit/form/Button"], function(array, domConstruct){

		var arr = [
			{surname: "Washington", name: "Paul"},
			{surname: "Gordon", name: "Amie"},
			{surname: "Meyer", name: "Sofie"},
			{surname: "Jaysons", name: "Josh"},
			{surname: "Washington", name: "George"},
			{surname: "Doormat", name: "Amber"},
			{surname: "Smith", name: "Susan"},
			{surname: "Hill", name: "Strawberry"},
			{surname: "Washington", name: "Dan"},
			{surname: "Dojo", name: "Master"}
		];

		filterArray = function(){
			var filteredArr = array.filter(arr, function(item){
				return item.surname == "Washington";
			});

			array.forEach(filteredArr, function(item, i){
				domConstruct.create("li", {innerHTML: i+1+". "+item.surname+", "+item.name}, "filtered-items");
			});

			array.forEach(arr, function(item, i){
				domConstruct.create("li", {innerHTML: i+1+". "+item.surname+", "+item.name}, "unFiltered-items");
			});
		};
	});

  .. html ::

    <button data-dojo-type="dijit/form/Button" data-dojo-props="onClick:filterArray" type="button">Filter array</button>
    <br/>
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

map()
=====

.. js ::

  require(["dojo/_base/array"], function(array){
    array.map(arrayObject, callback, thisObject);
  });

Another great function provided by Dojo is map(). map() lets you run a function on all elements of an array and returns a new array with the changed values.

This example shows you how to use map() with a simple array. All values of the array will get doubled:

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require([
		"dojo/_base/array",
		"dojo/dom",
		"dojo/dom-construct",
		"dijit/registry",
		"dijit/form/Button", // the button is only used to make the demo look nicer
		"dojo/ready",
		"dojo/parser",
    ], function(array, dom, domConstruct, registry, Button, ready){

		ready(function(){
			registry.byId('button').on('click', mapArray);
		});

		var arrValues = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

		function mapArray(){
			var doubleValue = array.map(arrValues, function(item){
				return item*2;
			});

			array.forEach(doubleValue, function(item){
				var li = domConstruct.create("li");
				li.innerHTML = item;
				dom.byId("arrValuesAfter-items").appendChild(li);
			});

			array.forEach(arrValues, function(item){
				var li = domConstruct.create("li");
				li.innerHTML = item;
				dom.byId("arrValues-items").appendChild(li);
			});
		}
	});

  .. html ::

    <button data-dojo-type="dijit/form/Button" id="button">Run array.map()</button>
    <br>
    <div style="width: 300px; float: left; margin-top: 10px;">
      Values before running array.map()
      <ul id="arrValues-items"></ul>
    </div>
    <div style="width: 300px; float: left; margin-top: 10px;">
      Values after running array.map()
      <ul id="arrValuesAfter-items"></ul>
    </div>

This example shows you how to use array.map with objects. In JavaScript, objects are references, so you can not just change a value of a property without modifying the object itself. Luckily Dojo provides you with a method to clone objects: :ref:`dojo.clone <dojo/clone>`

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require([
		"dojo/_base/array",
		"dojo/_base/lang",
		"dojo/dom",
		"dojo/dom-construct",
		"dijit/registry",
		"dijit/form/Button", // the button is only used to make the demo look nicer
		"dojo/ready",
		"dojo/parser",
    ], function(array, lang, dom, domConstruct, registry, Button, ready){

		ready(function(){
			registry.byId('button').on('click', raiseSalary);
		});

		var arrSalary = [
			{surname: "Washington", name: "Paul", salary: 200},
			{surname: "Gordon", name: "Amie", salary: 350},
			{surname: "Meyer", name: "Sofie", salary: 100},
			{surname: "Jaysons", name: "Josh", salary: 2500},
			{surname: "Washington", name: "George", salary: 10},
			{surname: "Doormat", name: "Amber", salary: 320},
			{surname: "Smith", name: "Susan", salary: 3200},
			{surname: "Hill", name: "Strawberry", salary: 290},
			{surname: "Washington", name: "Dan", salary: 200},
			{surname: "Dojo", name: "Master", salary: 205}
		];

		function raiseSalary(){
			var raisedSalaries = array.map(arrSalary, function(item){
				var newItem = lang.clone(item);
				newItem.salary += (newItem.salary/100)*10;
				return newItem;
			});

			array.forEach(raisedSalaries, function(item, i){
			    var li = domConstruct.create("li");
			    li.innerHTML = i+1+". "+item.surname+", "+item.name+". New salary: "+item.salary;
			    dom.byId("filteredSalary-items").appendChild(li);
			});

			array.forEach(arrSalary, function(item, i){
			    var li = domConstruct.create("li");
			    li.innerHTML = i+1+". "+item.surname+", "+item.name+". Old salary: "+item.salary;
			    dom.byId("unFilteredSalary-items").appendChild(li);
			});
        }
    });

  .. html ::

    <button data-dojo-type="dijit/form/Button" id="button">Raise the salary</button>
    <br>
    <div style="width: 300px; float: left; margin-top: 10px;">
      Peoples salaries after raise:
      <ul id="filteredSalary-items"></ul>
    </div>
    <div style="width: 300px; float: left; margin-top: 10px;">
      Peoples salaries before raise:
      <ul id="unFilteredSalary-items"></ul>
    </div>


some()
======

.. js ::

    require(["dojo/_base/array"], function(array){
        array.some(arrayObject, callback, thisObject);
    });

Semantically, calling ``some()`` is like asking, "does the test this function performs hold true for at least one item ('some item') in the array?"  Like ``forEach()``, ``some()`` iterates over the items in an array; however, it stops and returns ``true`` as soon as it encounters an item for which the provided callback returns ``true``.  If the callback doesn't return ``true`` for even a single item, ``some()`` returns ``false``.

For example, imagine you are a manager of a famous bank. A client of you comes and visits your office asking for another million dollars as a credit.
Now your bank policies only allow you to give each client one credit over 1 million, not two, not three - though you may have several smaller credits. Even 3 credits a 500.000 - weird bank.. anyways. some() is the perfect function to tell you whether an array has some values satisfying this condition:

.. code-example ::

  .. js ::

	require(["dojo/_base/array", "dojo/dom-construct", "dijit/form/Button"], function(array, domConstruct){

		var arrIndxSome = [200000, 500000, 350000, 1000000, 75, 3];

		testIndxSome = function(){
			if(array.some(arrIndxSome, function(item){ return item>=1000000})){
				result = 'yes, there are';
			}else{
				result = 'no, there are no such items';
			}
			domConstruct.place(
				"<p>The answer is: " + result + "</p>",
				"result6",
				"after"
			);
		};
	});

  .. html ::

    <div>The content of our test array is [200000, 500000, 350000, 1000000, 75, 3].</div>
    <button id="refButton6" data-dojo-type="dijit/form/Button" data-dojo-props="onClick:testIndxSome" type="button">Are there some items >=1000000 within the array?</button>
    <div id="result6"></div>


every()
=======

.. js ::

  require(["dojo/_base/array"], function(array){
    array.every(arrayObject, callback, thisObject);
  });

``every()`` is somewhat of a spiritual opposite to ``some()`` - in this case, it's like asking, "does this test hold true for *every* item in the array?"  In other words, if even one invocation of the callback returns ``false``, ``every()`` immediately short-circuits and returns false.  If all iterations of the callback return ``true``, so does ``every()``.

Let's get back to our bank manager example.  A client wants another credit, but you only allow a credit if every income transfer is at least 3000,-
An example:

.. code-example ::

  .. js ::

	require(["dojo/_base/array", "dojo/dom-construct", "dijit/form/Button"], function(array, domConstruct){

		var arrIndxEvery = [{'month': 'january', 'income': 2000}, {'month': 'february', 'income': 3200}, {'month': 'march', 'income': 2100}];

		testIndxSome = function(){
			if(array.every(arrIndxEvery , function(item){ return item.income>=3000})){
				result = 'yes, he is allowed';
			}else{
				result = 'no, unfortunately not';
			}
			domConstruct.place(
				"<p>The answer is: " + result + "</p>",
				"result7",
				"after"
			);
		};
	});

  .. html ::

    <div>The content of our test array is [{'month': 'january', 'income': 2000}, {'month': 'february', 'income': 3200}, {'month': 'march', 'income': 2100}].</div>
    <button id="refButton7" data-dojo-type="dijit/form/Button" data-dojo-props="onClick:testIndxSome" type="button">Is the client allowed to get the credit?</button>
    <div id="result7"></div>

As you may have guessed, due to the short-circuiting nature of ``some()`` and ``every()``, they can be cleverly employed as more efficient alternatives to ``forEach`` in cases where there is potential to break out of the loop early and save processing.
