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
