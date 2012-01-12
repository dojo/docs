.. _quickstart/data/usingdatastores/fetchsingle:

======================
Selecting single items
======================

.. contents ::
  :depth: 3

A common desire is to retrieve a single item of data and display it in some fashion. Dojo.data provides an API definition that can be implemented by DataStores to make this a simple operation. The API is called the Identity API and the definition can be found :ref:`here <dojo/data/api/Identity>`.

For this example, we'll assume the following simple data source:

.. js ::

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
      { name: 'pepper', aisle: 'Spices',  price: 1.01 }
  ]}

Examples
========

The following example will make use of APIs defined by both :ref:`Read <dojo/data/api/Read>` and :ref:`Identity <dojo/data/api/Identity>`. In specific, they use:

**Identity**
  fetchItemByIdentity() Fetches an item by its key value. Because the identity value of each item is unique, you are guaranteed at most one answer back.
**Read**
  getValue() Takes an item and an attribute and returns the associated value

Fetch by Identity
-----------------

This example shows how to fetch items by their identity programmatically.

.. code-example ::
  
  .. js ::

      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.form.ComboBox");

      var storeData = { identifier: 'name',
        items: [
          { name: 'Adobo', aisle: 'Mexican', price: 3.01 },
          { name: 'Balsamic vinegar', aisle: 'Condiments', price: 4.01 },
          { name: 'Basil', aisle: 'Spices', price: 3.59  },
          { name: 'Bay leaf', aisle: 'Spices',  price: 2.01 },
          { name: 'Beef Bouillon Granules', aisle: 'Soup',  price: 5.01 },
          { name: 'Vinegar', aisle: 'Condiments',  price: 1.99  },
          { name: 'White cooking wine', aisle: 'Condiments',  price: 2.01 },
          { name: 'Worcestershire Sauce', aisle: 'Condiments',  price: 3.99 },
          { name: 'pepper', aisle: 'Spices',  price: 1.01  }
        ]};

        // This function performs some basic dojo initialization. In this case it connects the ComboBox
        // onChange event to a function which invokes the fetchItemByIdentity function. The fetchItemByIdentity
        // function uses the value selected in the combobox to do a lookup on the datastore for an item with the
        // identifier that matches the combobox value. If it gets one, the price and aisle are updated, if it
        // does not locate one, the then the values are set to N/A and 0.00.
        function init(){
           // Function to perform a lookup on the datastore on each change event of the combo box.
           function getItemFromStore(){
              function updatePrice(item, request){
                 var lNode = dojo.byId("aisleNode");
                 var pNode = dojo.byId("priceNode");
                 if(!item){
                     lNode.innerHTML = "N/A.";
                     pNode.innerHTML = "0.00";
                 }else{
                     lNode.innerHTML = foodStore.getValue(item, "aisle");
                     pNode.innerHTML = foodStore.getValue(item, "price");
                 }
              }
              // Invoke the lookup. The callback for when the lookup succeeds is the updatePrice function
              // defined above.
              foodStore.fetchItemByIdentity({identity: combo.getValue(), onItem: updatePrice});
           }
           // Link any change events in the combo to driving the fetchItemByIdentity lookup.
           dojo.connect(combo, "onChange", getItemFromStore);
        }
        // Set the init function to run when dojo loading and page parsing has completed.
        dojo.ready(init);

  .. html ::

    Pick a grocery item: <div data-dojo-type="dojo/data/ItemFileReadStore" data-dojo-props="data:storeData" data-dojo-id="foodStore"></div>
    <div data-dojo-type="dijit/form/ComboBox" data-dojo-props="store:foodStore, searchAttr:'name'" data-dojo-id="combo"></div>
    <br>
    <br>
    <span>
      <b>AISLE: </b><span id="aisleNode"></span><br>
      <b>PRICE: </b><span id="priceNode"></span><br>
    </span>

**Note:** In the example, the fetchItemByIdentity makes use of a callback to pass the fetched item to. This is because by definition, dojo.data is an asynchronous API for querying of data values. This is because many Data Stores will need to go back to a server to actually look up the data and some Ajax I/O methods do not readily allow for a synchronous call. For example, script source IO cannot be done synchronously, nor can iFrame IO. They must have callbacks to operate.
