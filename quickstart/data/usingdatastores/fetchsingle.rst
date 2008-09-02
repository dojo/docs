#format dojo_rst

**Selecting single items**
==========================
A common desire is to retrieve a single item of data and display it in some fashion.  Dojo.data provides an API definition that can be implemented by DataStores to make this a simple operation.  The API is called the Identity API and the definition can be found `here <dojo/data/api/Identity>`_.

For this example, we'll assume the following simple data source:

.. code-block :: javascript

  { identifier: 'name', 
    items: [
      { name: 'Adobo', aisle: 'Mexican', price: 3.00 },
      { name: 'Balsamic vinegar', aisle: 'Condiments', price: 4.00 },
      { name: 'Basil', aisle: 'Spices' price: 3.59  },
      { name: 'Bay leaf', aisle: 'Spices',  price: 2.00 },
      { name: 'Beef Bouillon Granules', aisle: 'Soup',  price: 5.00  },
      { name: 'Vinegar', aisle: 'Condiments',  price: 1.99  },
      { name: 'White cooking wine', aisle: 'Condiments',  price: 2.00 },
      { name: 'Worcestershire Sauce', aisle: 'Condiments'  price: 3.99 },
      { name: 'pepper', aisle: 'Spices',  price: 1.00  }
  ]}
