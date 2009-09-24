## page was renamed from 1.2/dojo/forEach
#format dojo_rst

dojo.forEach
============

:Status: Contributed, Draft
:Version: 1.0

Since it's not supported natively on every browser, ``dojo.forEach`` provides the `standard JavaScript 1.6 forEach construct <https://developer.mozilla.org/En/Core_JavaScript_1.5_Reference:Objects:Array:forEach>`_ everywhere. ``dojo.forEach`` lets you apply a function to each element of an array, emulating a ``for`` loop, but with fewer scoping compliations. 

``dojo.forEach`` has a notable difference from the JavaScript 1.6 forEach: ``dojo.forEach`` runs over sparse arrays, passing the "holes" in the sparse array to the callback function. JavaScript 1.6's forEach skips the holes in the sparse array.

dojo.forEach() cannot terminate a loop (save for throwing an exception). Use dojo.some() or dojo.every() instead.

``forEach`` is syntactic sugar for a regular 'ol for loop:

.. code-block :: javascript
  :linenos:

  for(var i=0; i<queueEntries.length; i++){
    console.debug(queueEntries[i], "at index", i);
  }

Can be written as:

.. code-block :: javascript
  :linenos:

  dojo.forEach(queueEntries, function(entry, i){
    console.debug(entry, "at index", i);
  });

We use an anonymous function to define the operation. This function is always passed 3 arguments: the current item value, the index in the list being iterated over, an a reference to the list itself.

For this simple loop, `dojo.forEach` isn't anything exciting. But combined with other Dojo functions, especially `dojo.query() <dojo/query>`_, it becomes remarkably useful. Consider this snippet, which disables all ``<select>`` tags on the page:

.. code-block :: javascript
  :linenos:

  dojo.forEach(
    dojo.query("select"),
    function(selectTag) {
      selectTag.disabled = true;
    }
  );

How cool is that? (Answer: very!) There's no monkeying around with DOM functions, no using tedious names or id's, and it continues to work even when you add new SELECT tags.

Running ``dojo.forEach`` on a ``dojo.query`` result is so common, that Dojo defines a shortcut:

.. code-block :: javascript
  :linenos:

  dojo.query("select").forEach(function(selectTag){
      selectTag.disabled = true;
  });

does the same thing. But that's not all! New in 1.0 you can collapse the function down to its body, passed in as a string like so:

// 1.0 only.

.. code-block :: javascript
  :linenos:
  
  dojo.query("select").forEach("item.disabled = true;");

Ay carumba! That's a lot of functionality in a tiny 1-line package. Once you get used to the syntax, you'll never want to go back.

See Also
========
- `dojo.map <dojo/map>`_ - The Dojo version of Array.map
- `dojo.filter <dojo/filter>`_ - Helps you narrow down the items in a list
- `dojo.some <dojo/some>`_ - Does any item in the list meet your critera?
- `dojo.every <dojo/every>`_ - Do *all* items in the list meet your critera?
- `dojo.indexOf <dojo/indexOf>`_ - Find something in a list easily
- `dojo.lastIndexOf <dojo/lastIndexOf>`_ - Find something in the list easily, but starting from the back
- `dojo.query <dojo/query>`_ - A CSS query engine that returns instances of ``dojo.NodeList``
- `dojo.NodeList <dojo/NodeList>`_ - A subclass of Array which can also have forEach applied.
