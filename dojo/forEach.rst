#format dojo_rst

dojo.forEach
============

:Status: Contributed, Draft
:Version: 1.0

JavaScript 1.6 has a forEach loop, where you can apply a certain function to each element of an array. Unfortunately at the time of this writing, only Firefox 2 has support for JS 1.6. But never fear! Dojo has defined one you can use in any Dojo-supported browser.

Foreach is syntactic sugar for a regular ol' for loop. So for example:

.. code-block :: javascript
  :linenos:

  for(var i in queueEntries){
    console.debug(queueEntries[i]);
  }

Can be written as:

.. code-block :: javascript
  :linenos:

  dojo.forEach(queueEntries,
    function(oneEntry, index, array) {
      console.debug(oneEntry + " at index " + index);
    }
  );

Like dojo.connect, we use an anonymous function here to define the operation. This function must accept between one and three arguments. The first argument is the value of each value in the array in turn, the second is the current index or position in the array, and the third argument is the array itself.

For this simple loop, forEach isn't anything exciting. But combined with other Dojo functions, especially dojo.query(), it becomes remarkably useful. Consider this snippet, which disables all SELECT tags on the page:

.. code-block :: javascript
  :linenos:

  dojo.forEach(
    dojo.query("select", document),
    function(selectTag) {
      selectTag.disabled = true;
    }
  );

How cool is that? (Answer: very!) There's no monkeying around with DOM functions, no using tedious names or id's, and it continues to work even when you add new SELECT tags.

Running dojo.forEach on a dojo.query result is so common, that Dojo defines a shortcut. This snippet:

.. code-block :: javascript
  :linenos:

  dojo.query("select", document).forEach(
    function(selectTag) {
      selectTag.disabled = true;
    }
  );

does the same thing. But that's not all! New in 1.0 you can collapse the function down to its body, passed in as a string like so:

// 1.0 only.

.. code-block :: javascript
  :linenos:
  
  dojo.query("select", document).forEach("item.disabled = true;");

Ay carumba! That's a lot of functionality in a tiny 1-line package. Once you get used to the syntax, you'll never want to go back.

There's more on dojo.query in Selecting DOM Nodes with dojo.query
