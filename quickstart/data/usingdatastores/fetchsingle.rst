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
      { name: 'Basil', aisle: 'Spices', price: 3.59  },          
      { name: 'Bay leaf', aisle: 'Spices',  price: 2.00 },
      { name: 'Beef Bouillon Granules', aisle: 'Soup',  price: 5.00  },
      { name: 'Vinegar', aisle: 'Condiments',  price: 1.99  },
      { name: 'White cooking wine', aisle: 'Condiments',  price: 2.00 },
      { name: 'Worcestershire Sauce', aisle: 'Condiments',  price: 3.99 },
      { name: 'pepper', aisle: 'Spices',  price: 1.00  }
  ]}

The following example will make use of APIs defined by both `Read <dojo/data/api/Read>`_ and `Identity <dojo/data/api/Identity>`_.  In specific, they use:

**Identity**
  fetchItemByIdentity() Fetches an item by its key value. Because the identity value of each item is unique, you are guaranteed at most one answer back. 
**Read**
  getValue() Takes an item and an attribute and returns the associated value


.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.form.ComboBox");

      var storeData = { identifier: 'name', 
        items: [
          { name: 'Adobo', aisle: 'Mexican', price: 3.00 },
          { name: 'Balsamic vinegar', aisle: 'Condiments', price: 4.00 },
          { name: 'Basil', aisle: 'Spices', price: 3.59  },          
          { name: 'Bay leaf', aisle: 'Spices',  price: 2.00 },
          { name: 'Beef Bouillon Granules', aisle: 'Soup',  price: 5.00  },
          { name: 'Vinegar', aisle: 'Condiments',  price: 1.99  },
          { name: 'White cooking wine', aisle: 'Condiments',  price: 2.00 },
          { name: 'Worcestershire Sauce', aisle: 'Condiments',  price: 3.99 },
          { name: 'pepper', aisle: 'Spices',  price: 1.00  }
        ]};

        function init () {
           //Function to perform a lookup on the datastore on each change event of the combo box.
           function getItemFromStore () {
              function updatePrice(item, request) {
                 var lNode = dojo.byId("isleNode");
                 var pNode = dojo.byId("priceNode");
                 if (!item) {
                     lNode.innerHTML = "N/A.";
                     priceNode.innerHTML = "0.00";
                 } else {
                     lNode.innerHTML = foodStore.getValue(item, "isle");
                     priceNode.innerHTML = foodStore.getValue(item, "price");
                 }
              }
              foodStore.fetchItemByIdentity({identity: combo.getValue(), onItem: updatePrice});
           }
           //Link any change events in the combo to driving the fetchItemByIdentity lookup.
           dojo.connect(combo, "onChange", getItemFromStore);
        }
        dojo.addOnLoad(init);
    </script>

  .. cv :: html 

    <div dojoType="dojo.data.ItemFileReadStore" data="storeData" jsId="foodStore"></div>
    <div dojoType="dijit.form.ComboBox" store="foodStore" searchAttr="name" jsId="combo"></div>
    <br>
    <br>
    <span>
      <b>ISLE: </b><span id="isleNode"></span><br>
      <b>PRICE: </b><span id="isleNode"></span><br>
    </span>
