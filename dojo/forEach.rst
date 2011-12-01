.. _dojo/forEach:

============
dojo.forEach
============

.. contents :: 
    :depth: 2

About
=====
        
Since it's not supported natively on every browser, ``dojo.forEach`` provides the `standard JavaScript 1.6 forEach construct <https://developer.mozilla.org/En/Core_JavaScript_1.5_Reference:Objects:Array:forEach>`_ everywhere. ``dojo.forEach`` lets you apply a function to each element of an array, emulating a ``for`` loop, but with fewer scoping compliations.

``dojo.forEach`` has a notable difference from the JavaScript 1.6 forEach: ``dojo.forEach`` runs over sparse arrays, passing the "holes" in the sparse array to the callback function. JavaScript 1.6's forEach skips the holes in the sparse array.

dojo.forEach() cannot terminate a loop (save for throwing an exception). Use dojo.some() or dojo.every() instead.

``forEach`` is syntactic sugar for a regular 'ol for loop:

.. js ::
  
  for(var i=0; i<queueEntries.length; i++){
    console.debug(queueEntries[i], "at index", i);
  }

(From dojo 1.7 on) It can be written as:

.. js ::
  
  require(["dojo/_base/array"], function(array){
    array.forEach(queueEntries, function(entry, i){
      console.debug(entry, "at index", i);
    });
  });

(Before dojo 1.7) It can be written as:

.. js ::
  
  dojo.forEach(queueEntries, function(entry, i){
    console.debug(entry, "at index", i);
  });

We use an anonymous function to define the operation. This function is always passed 3 arguments: the current item value, the index in the list being iterated over, an a reference to the list itself.

For this simple loop, `dojo.forEach` isn't anything exciting. But combined with other Dojo functions, especially :ref:`dojo.query() <dojo/query>`, it becomes remarkably useful. Consider this snippet, which disables all ``<select>`` tags on the page:

.. js ::
  
  // Dojo 1.7+ (AMD)
  require(["dojo/_base/array", "dojo/query"], function(array, query){
    array.forEach(
      query("select"),
      function(selectTag){
        selectTag.disabled = true;
      }
    );
  });
  
  // Dojo < 1.7
  dojo.forEach(
    dojo.query("select"),
    function(selectTag){
      selectTag.disabled = true;
    }
  );

How cool is that? (Answer: very!) There's no monkeying around with DOM functions, no using tedious names or id's, and it continues to work even when you add new SELECT tags.

Running ``dojo.forEach`` on a ``dojo.query`` result is so common, that Dojo defines a shortcut:

.. js ::
    
  // Dojo 1.7+ (AMD)
  require(["dojo/query"], function(query){
    query("select").forEach(function(selectTag){
      selectTag.disabled = true;
    });
  });
  
  // Dojo < 1.7
  dojo.query("select").forEach(function(selectTag){
      selectTag.disabled = true;
  });

does the same thing. But that's not all! New in 1.0 you can collapse the function down to its body, passed in as a string like so:

.. js ::
    
  // Dojo 1.7+ (AMD)
  require(["dojo/query"], function(query){
    query("select").forEach("item.disabled = true;");
  });
  
  // Dojo < 1.7
  dojo.query("select").forEach("item.disabled = true;");

That's a lot of functionality from a single method! Once you get used to the syntax, you'll never want to go back.

.. api-inline :: dojo.forEach

See Also
========
- :ref:`dojo.map <dojo/map>` - The Dojo version of Array.map
- :ref:`dojo.filter <dojo/filter>` - Helps you narrow down the items in a list
- :ref:`dojo.some <dojo/some>` - Does any item in the list meet your criteria?
- :ref:`dojo.every <dojo/every>` - Do *all* items in the list meet your criteria?
- :ref:`dojo.indexOf <dojo/indexOf>` - Find something in a list easily
- :ref:`dojo.lastIndexOf <dojo/lastIndexOf>` - Find something in the list easily, but starting from the back
- :ref:`dojo.query <dojo/query>` - A CSS query engine that returns instances of ``dojo.NodeList``
- :ref:`dojo.NodeList <dojo/NodeList>` - A subclass of Array which can also have forEach applied.
