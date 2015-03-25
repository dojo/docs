.. _dojox/collections:

=================
dojox.collections
=================

:Project owner: Tom Trenka
:since: V?

.. contents ::
   :depth: 2

It is intended for use by people who are looking for a little bit more functionality out of common collections, like ArrayLists or Dictionaries.

Included are the Iterator and DictionaryIterator classes, both of which can operate on standard arrays and objects (respectively).


Introduction
============
The dojox.collections module provides implementations of common collection types. These implementations are ArrayList, BinaryTree, Dictionnary, Queue, Set, SortedList and Stack. In addition to these collection types, the dojox.collections module also provides two iterators classes designed to work with the collections included in this module, but can also be used with JavaScript arrays and objects.

Available collections
=====================

ArrayList
~~~~~~~~~

The dojox.collections.ArrayList class is an index-based resizable collection of elements.

  add(obj)
    Adds the given element to the collection.

  addRange(array)
    Adds the given array or collection of elements to the collection.

  clear()
    Clears all elements out of the collections.

  clone()
    Clones this collection.

  contains(obj)
    Returns whether the given element is in this collection.

  forEach(func, scope)
    Applies the given function to the collection items in the (optional) scope.

  getIterator()
    Returns an Iterator for this collection.

  indexOf(obj)
    Returns the index in the collection of the given element.
  
  insert(idx, obj)
    Inserts the specified element at the given index.

  item(i)
    Returns the element at the given position.

  remove(obj)
    Removes the given element from the collection.

  removeAt(idx)
    Removes the element located at the given index.

  reverse()
    Reverses the internal array.

  sort()
    Sorts the internal array.
 
  setByIndex(idx, obj)
    Sets an element in the array by the passed index.

  toArray()
    Returns a new array with all of the items of the internal array concatenated.

BinaryTree
~~~~~~~~~~

The dojox.collections.BinaryTree class stores data in a tree structure. 

  add(data)
    Adds the given element to the collection.

  clear()
    Clears all elements out of the collections.

  clone()
    Clones this collection.

  contains(data)
    Returns whether the given element is in this collection.

  deleteData(data)
     Removes the given element from the collection.

  getIterator()
    Returns an Iterator for this collection.

  search(data)
    Returns the tree node of the given element or null if the element is not in the collection.


Dictionary
~~~~~~~~~~

The dojox.collections.Dictionary class implements a collection of key/value pairs.

  add(key, value)
    Adds a new element with the gviven key and values to the collection.

  clear()
    Clears all elements out of the collections.

  clone()
    Clones this collection.

  containsKey(key)
    Returns whether the dictionary has an entry at key "key".

  containsValue(value)
    Returns whether the dictionary has an entry with value "value".
  
  entry(key)
    Returns the dictionary entry corresponding to the given key.

  forEach(function, scope)
    Applies the given function to the collection items in the (optional) scope.

  getKeyList()
    Returns an array of the keys in the dictionary.

  getValueList()
    Returns an array of the values in the dictionary.

  item(key)
    Returns the element with the given key.

  getIterator()
    Returns an Iterator for this collection.

  remove(key)
    Removes the element with the given key from the collection.


Queue
~~~~~

The dojox.collections.Queue class implements a first-in first-out collection of objects.

  clear()
    Clears all elements out of the collections.

  clone()
    Clones this collection.

  contains(obj)
    Returns whether the given element is in the collection.

  copyTo(array, idx)
    Copies the contents of this queue into the passed array at the given index.

  dequeue()
    Shifts the first element off the queue and return it.

  enqueue()
    Puts the passed object at the end of the queue.

  forEach(function, scope)
    Applies the given function to the collection items in the (optional) scope.

  getIterator()
    Returns an Iterator for this collection.

  toArray()
    Returns a new array with all of the items of the internal array.

  count
    The number of elements in this collection.


SortedList
~~~~~~~~~

The dojox.collections.SortedList class implements a collection that acts like a dictionary but is also internally sorted. Note that the act of adding any elements forces an internal resort, making this object potentially slow.

  add(key, value)
    Adds a new element with the gviven key and values to the collection.

  clear()
    Clears all elements out of the collections.

  clone()
    Clones this collection.

  containsKey(key)
    Returns whether the dictionary has an entry at key "key".

  containsValue(value)
    Returns whether the dictionary has an entry with value "value".

  copyTo(array, idx)
    Copies the contents of this queue into the passed array at the given index.

  entry(key)
    Returns the dictionary entry corresponding to the given key.

  forEach(function, scope)
    Applies the given function to the collection items in the (optional) scope.

  getByIndex(idx)
    Returns the element at the given index.

  getIterator()
    Returns an Iterator for this collection.

  getKey(idx)
    Returns the key of the element at the given index.

  getKeyList()
    Returns an array of the keys in the dictionary.

  getValueList()
    Returns an array of the values in the dictionary.

  indexOfKey(key)
    Returns the index of the given key.

  indexOfValue(obj)
    Returns the first index of the given element

  item(key)
    Returns the value of the element at the given key.

  remove(key)
    Removes the element with the given key from the collection.

  removeAt(idx)
    Removes the element located at the given index.

  replace(key, value)
    Replaces an existing element if it is there, and adds a new one if not.

  setByIndex(idx, obj)
    Sets an element in the collection by the passed index.

  count
    The number of elements in this collection.


Stack
~~~~~

The dojox.collections.Stack class implements a last-in first-out collection of objects.


  clear()
    Clears all elements out of the collections.

  clone()
    Clones this collection.

  contains(obj)
    Returns whether the given element is in the collection.

  copyTo(array, idx)
    Copies the contents of the collection into the passed array at the given index.

  forEach(function, scope)
    Applies the given function to the collection items in the (optional) scope.

  getIterator()
    Returns an Iterator for this collection.

  peek()
    Returns the next item without altering the stack itself.

  pop()
    Pops and return the next item on the stack.

  push(object)
    Pushes object o onto the stack

  toArray()
    Returns a new array with all of the items of the internal array.

  count
    The number of elements in this collection.


Additional API
==============

Set
~~~

The dojox.collections.Set object defines several set operations that can be performed on standard JavaScript arrays or dojox.collections.ArrayList instances.

  union(setA, setB)
    Returns the union of the two passed sets.

  intersection(setA, setB)
    Returns the intersection of the two passed sets.

  difference(setA, setB)
    Returns everything in setA that is not in setB.

  isSubSet(setA, setB)
    Returns if set B is a subset of set A.

  isSuperSet(setA, setB)
    Returns if set B is a superset of set A.

Iterators
~~~~~~~~~

The dojox.collections.Iterator and dojox.collections.DictionaryIterator classes enable iteration over dojox.collections instances. In addition, they can also be used to iterate over a standard JavaScript array (for dojox.collections.Iterator) or JavaScript object (for dojox.collections.DictionaryIterator).

Both share the following API:

  atEnd()
    Checks if the internal cursor has reached the end of the internal collection.

  get()
    Gets the next element in the collection.

  map(function, scope)
    Applies the given function to the elements in the collection.

  reset()
    Resets the internal cursor.

  element
    The current element.

Usage
=====

The following example shows how to iterate over a collection:

.. js ::

  var al=new dojox.collections.ArrayList(["foo","bar","test","bull"]);
  var itr = al.getIterator();
  while(!itr.atEnd()){
    var element = itr.get(); // element is "foo", "bar", etc...
  }
