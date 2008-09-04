#format dojo_rst

**Paging Data**
===============


As shown in the other datastore sections, the fetch method of the Read API can query across and return sets of items in a variety of ways. However, there is generally only so much space on a display to list all the data returned. Certainly, an application could implement its own custom display logic for just displaying subsets of the data, but that would be inefficient because the application would have had to load all the data in the first place. And, if the data set is huge, it could severely increase the memory usage of the browser. Therefore, dojo.data provides a mechanism by which the store itself can do the paging for you. When you use the paging options of fetch, all that is returned in the callbacks for fetch is the page of data you wanted, no more. This allows the application to deal with data in small chunks, the parts currently visible to you.

The paging mechanism is used by specifying a start parameter in the fetch arguments. The start parameter says where, in the full list of items, to start returning items. The index 0 is the first item in the collection. The second argument you specify is the count argument. This option tells dojo.data how many items, starting at start, to return in a request. If start isn't specified, it is assumed to be 0. If count isn't specified, it is assumed to return all the items starting at start until it reaches the end of the collection. With this mechanism, you can implement simple paging easily.

To demonstrate the paging function, we'll assume an ItemFileReadStore with the following datasource:

.. code-block :: javascript 
  { identifier: 'name',
    items: [
      { name: 'Adobo', aisle: 'Mexican', price: 3.01 },
      { name: 'Balsamic vinegar', aisle: 'Condiments', price: 4.01 },
      { name: 'Basil', aisle: 'Spices', price: 3.59  },
      { name: 'Bay leaf', aisle: 'Spices',  price: 2.01 },
      { name: 'Beef Bouillon Granules', aisle: 'Soup',  price: 5.01  },
      { name: 'Vinegar', aisle: 'Condiments',  price: 1.99  },
      { name: 'White cooking wine', aisle: 'Condiments',  price: 2.01 },
      { name: 'Worcestershire Sauce', aisle: 'Condiments',  price: 3.99 },
      { name: 'white pepper', aisle: 'Spices',  price: 1.01 },
      { name: 'Black Pepper', aisle: 'Spices',  price: 1.01 }
  ]}
