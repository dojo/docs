#format dojo_rst

**Lazy Loading**
================

One of the design goals of dojo.data was to handle the concept of hierarchical items.  What that means is that an item may have references to, or contain, other items.  The end result when viewed graphically is a Tree instead of a flat list.  So, this leads to the questions of how do you determine if there is hierarchy and how do you walk across it.  This is, in fact, quite easy to do using dojo.data.ItemFileReadStore as it supports data in hierarchical structure.

Lets take a look at an example hierarchy built up with references in dojo.data.ItemFileReadStore.  Please take note that this information on constructing a structure that shows hierarchy is specific to dojo.data.ItemFileReadStore.  The concepts of how you then walk over the hierarchy is what is general and generic to dojo.data.  The internal format used by a store is not.

**Example data structure for ItemFileReadStore:**

.. code-block :: javascript

  { identifier: 'name',
    label: 'name',
    items: [
      { name:'Africa', type:'continent',
        children:[{_reference:'Egypt'}, {_reference:'Kenya'}, {_reference:'Sudan'}] },
      { name:'Egypt', type:'country' },
      { name:'Kenya', type:'country',
        children:[{_reference:'Nairobi'}, {_reference:'Mombasa'}] },
      { name:'Nairobi', type:'city' },
      { name:'Mombasa', type:'city' },
      { name:'Sudan', type:'country',
        children:{_reference:'Khartoum'} },
      { name:'Khartoum', type:'city' },
      { name:'Asia', type:'continent',
        children:[{_reference:'China'}, {_reference:'India'}, {_reference:'Russia'}, {_reference:'Mongolia'}] },
      { name:'China', type:'country' },
      { name:'India', type:'country' },
      { name:'Russia', type:'country' },
      { name:'Mongolia', type:'country' },
      { name:'Australia', type:'continent', population:'21 million',
        children:{_reference:'Commonwealth of Australia'}},
      { name:'Commonwealth of Australia', type:'country', population:'21 million'},
      { name:'Europe', type:'continent',
        children:[{_reference:'Germany'}, {_reference:'France'}, {_reference:'Spain'}, {_reference:'Italy'}] },
      { name:'Germany', type:'country' },
      { name:'France', type:'country' },
      { name:'Spain', type:'country' },
      { name:'Italy', type:'country' },
      { name:'North America', type:'continent',
        children:[{_reference:'Mexico'}, {_reference:'Canada'}, {_reference:'United States of America'}] },
      { name:'Mexico', type:'country',  population:'108 million', area:'1,972,550 sq km',
        children:[{_reference:'Mexico City'}, {_reference:'Guadalajara'}] },
      { name:'Mexico City', type:'city', population:'19 million', timezone:'-6 UTC'},
      { name:'Guadalajara', type:'city', population:'4 million', timezone:'-6 UTC' },
      { name:'Canada', type:'country',  population:'33 million', area:'9,984,670 sq km',
        children:[{_reference:'Ottawa'}, {_reference:'Toronto'}] },
      { name:'Ottawa', type:'city', population:'0.9 million', timezone:'-5 UTC'},
      { name:'Toronto', type:'city', population:'2.5 million', timezone:'-5 UTC' },
      { name:'United States of America', type:'country' },
      { name:'South America', type:'continent',
        children:[{_reference:'Brazil'}, {_reference:'Argentina'}] },
      { name:'Brazil', type:'country', population:'186 million' },
      { name:'Argentina', type:'country', population:'40 million' }
  ]}

There are two things to notice about the above structure.  The first is that yes, it is still a flat list of data items to feed to dojo.data.ItemFileReadStore.  But, as you can see, there is a special attribute, *_reference* that is used to point to another item in the list.  These references, when processed by ItemFileReadStore, will establish the relationships in the data.  This means that when you call store.getValues(item, children), the array returned is an array of the actual items pointed to.  So, if you then try to visualize it, you can see how the Tree of hierarchy is formed from the references.  Below is an example of using dijit.Tree with the above dataset to construct and display a tree.

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojo.data.ItemFileReadStore");
      dojo.require("dijit.Tree");
      var storeData = { identifier: 'name',
        label: 'name',
        items: [
          { name:'Africa', type:'continent',
            children:[{_reference:'Egypt'}, {_reference:'Kenya'}, {_reference:'Sudan'}] },
          { name:'Egypt', type:'country' },
          { name:'Kenya', type:'country',
            children:[{_reference:'Nairobi'}, {_reference:'Mombasa'}] },
          { name:'Nairobi', type:'city' },
          { name:'Mombasa', type:'city' },
          { name:'Sudan', type:'country',
            children:{_reference:'Khartoum'} },
          { name:'Khartoum', type:'city' },
          { name:'Asia', type:'continent',
            children:[{_reference:'China'}, {_reference:'India'}, {_reference:'Russia'}, {_reference:'Mongolia'}] },
          { name:'China', type:'country' },
          { name:'India', type:'country' },
          { name:'Russia', type:'country' },
          { name:'Mongolia', type:'country' },
          { name:'Australia', type:'continent', population:'21 million',
            children:{_reference:'Commonwealth of Australia'}},
          { name:'Commonwealth of Australia', type:'country', population:'21 million'},
          { name:'Europe', type:'continent',
            children:[{_reference:'Germany'}, {_reference:'France'}, {_reference:'Spain'}, {_reference:'Italy'}] },
          { name:'Germany', type:'country' },
          { name:'France', type:'country' },
          { name:'Spain', type:'country' },
          { name:'Italy', type:'country' },
          { name:'North America', type:'continent',
            children:[{_reference:'Mexico'}, {_reference:'Canada'}, {_reference:'United States of America'}] },
          { name:'Mexico', type:'country',  population:'108 million', area:'1,972,550 sq km',
            children:[{_reference:'Mexico City'}, {_reference:'Guadalajara'}] },
          { name:'Mexico City', type:'city', population:'19 million', timezone:'-6 UTC'},
          { name:'Guadalajara', type:'city', population:'4 million', timezone:'-6 UTC' },
          { name:'Canada', type:'country',  population:'33 million', area:'9,984,670 sq km',
            children:[{_reference:'Ottawa'}, {_reference:'Toronto'}] },
          { name:'Ottawa', type:'city', population:'0.9 million', timezone:'-5 UTC'},
          { name:'Toronto', type:'city', population:'2.5 million', timezone:'-5 UTC' },
          { name:'United States of America', type:'country' },
          { name:'South America', type:'continent',
            children:[{_reference:'Brazil'}, {_reference:'Argentina'}] },
          { name:'Brazil', type:'country', population:'186 million' },
          { name:'Argentina', type:'country', population:'40 million' }
      ]};
    </script>

  .. cv :: html 

    <div dojoType="dojo.data.ItemFileReadStore" data="storeData" jsId="geographyStore"></div>
    <div dojoType="dijit.tree.ForestStoreModel" jsId="geographyModel" store="geographyStore" query="{type: 'contintent'}" rootId="Geography" rootLabel="Geography"></div>
    <div dojoType="dijit.Tree" model="geographyModel"></div>
