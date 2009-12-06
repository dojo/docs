#format dojo_rst

Using Datastores
================

Datastores provide access to data through a standardized interface for talking to data services. The most common operations performed on data are: 

* `Terminology <quickstart/data/usingdatastores/terminology>`_

  Useful definitions used throughout the documentation.

* `A Simple Data Source and Examples <quickstart/data/usingdatastores/simple>`_

  A definition of what data sources are and examples of connecting data stores to widgets.

* `Fetching data items <quickstart/data/usingdatastores/fetchsingle>`_

  How to fetch a single data item and display attributes of that item.

* `Fetching multiple data items and values <quickstart/data/usingdatastores/fetchmultiple>`_

  How to fetch multiple items at once and display attribute values.

* `Selecting subsets of data items (filtering) <quickstart/data/usingdatastores/filteringitems>`_

  How to select subsets of items through query filters.

* `Nested Items and Lazy Loading <quickstart/data/usingdatastores/lazyloading>`_

  How to access item attributes that have values which are other data items and how dojo.data defines lazy-loading of child items should be done.

* `Too much data, I need paging! <quickstart/data/usingdatastores/pagination>`_

  How to use the dojo.data interface to access large data sets through subsets (pages).

* `Sorting data items into defined orders <quickstart/data/usingdatastores/sorting>`_

  How to issue a fetch of data that returns data items in sorted order.

* `FAQ (frequent questions about using dojo.data) <quickstart/data/usingdatastores/faq>`_


========
See also
========

Dojo Toolkit comes with a wide range of Datastores:

* Basic datastores `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_ and `dojo.data.ItemFileWriteStore <dojo/data/ItemFileWriteStore>`_
* `List of additional available Datastores <dojox/data>`_
