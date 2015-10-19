.. _dojo/dnd:

========
dojo/dnd
========

:since: 0.9
:Author: Eugene Lazutkin

.. contents ::
  :depth: 2

The drag and drop (DnD) package/system of Dojo.

Introduction
============

**dojo/dnd** provides the basic user interface concepts of "drag and drop" where a user interface element is clicked,
dragged and then dropped in another location. ``dojo/dnd`` uses an "avatar" to represent objects that are being dragged
from one location to another. As the avatar is shifted, it is designed to not obscure objects under the mouse giving
better visibility. Additionally, it is possible to represent objects in the Avatar_ differently, which is described in
detail below. A special sub-package ``dojo/dnd/Moveable`` accommodates direct movement of elements in the *old style* of
Dojo Drag and Drop (version 0.4).

DnD (both :ref:`dojo.dnd <dojo/dnd>` and :ref:`dojo.dnd.Moveable <dojo/dnd/Moveable>` packages) is implemented as a state
machine, which reflects its state by adding and removing CSS classes to relevant objects, which gives the ultimate
flexibility over customizing the look-and-feel.

Every DnD container and DnD item has the concept of a type. The type is represented by a unique text string. Every
container and item has an array of types assigned to them. In order to transfer (drop) items on a container they should
have at least one type in common. When transferring a group of items to a container all items should have at least one
type in common with the container. Otherwise the transfer is denied. If the list of types is not specified ``["text"]``
is assumed.

``dojo/dnd`` supports copy and move styles with DnD out of the box.

User interface
--------------

The existing implementation supports a *linear* container paradigm:

* Selection of an item on a mouse *click*.

* Adding an item to the existing selection by *ctrl+click*.

* Selecting a range of items by *shift+click*.

* Adding a range of items by *ctrl+shift+click*.

*Note* On a Macintosh the Meta key is used instead of the Ctrl key.

*Note* In order to show an insertion point correctly, it is possible to specify if we are dealing with a vertical or
horizontal container.

See Selector_ for more details.

dojo/dnd Principals
===================

The ``dojo/dnd`` consists of 5 classes: Container_, Selector_, Source_, Manager_, and Avatar_. The first three classes
are responsible for DnD sources and targets. The last two classes are singletons responsible for orchestration of DnD on
the web page.

Container
---------

The default implementation of ``dojo/dnd/Container`` represents a uniform linear collection of items. It knows when the mouse hovers over it, and when the mouse hovers over a particular item.

The draggable item is represented by an abstract data object, which can be anything. There is a function ``creator``, which is called when we need to visualize a data item for the container_, or for the avatar_. It allows us to have different representations of the same data item in different containers and in the avatar_. More on that later.

Constructor
~~~~~~~~~~~

Constructor take two parameters:

``node``
  A DOM node or the String ID of a node. This node represents a container. All draggable items will be direct 
  descendants of this node (the important exception: a ``<table>`` node, in this case items will be direct descendants 
  of the embedded ``<tbody>`` node). If you want to override this default behavior, use ``dropParent`` attribute of 
  ``params`` (see below).

``params``
  a dictionary object, which defines optional parameters. Following optional parameters are recognized:

  ``creator(item, hint)``
    A creator function, which is used to build a representation of the data item.

  ``item``
    a data item (an abstract object), which defines a draggable object. The creator function is solely responsible for 
    the interpretation of this item.

  ``hint``
    An optional string, which hints at the purpose of the call. The creator function can use it to produce different 
    visual representations. At the moment only one value is defined: ``"avatar"``. When ``hint == "avatar"`` the creator 
    can produce a special version for the avatar.

  ``type``
    An array of strings, which identify the type of this item. It is used during the DnD operation to select compatible 
    targets.

  ``skipForm``
    If it is ``true``, the container passes selection and dragging operations to the browser, otherwise it suppresses 
    them. It is useful when draggable items include text form elements that can be edited. By default it is ``false``.                                     

  ``dropParent``
    a DOM node below the main node, which serves as a physical container for data item nodes. It can be used to 
    structure the visual design of your container. This value will be assigned to ``parent`` attribute of the container 
    (see below).                           

During the construction the constructor checks immediate children of ``parent`` attribute (see below) for the presence
of ``dojoDndItem`` class. All such items are added as container's children automatically. It is assumed that you already
built the visual representation of the data item, so the creator function is not involved. Instead the necessary triplet
is formed like this:

``node``
  the node itself. If it doesn't have an id, a unique id is generated for it.

``data``
  the content of ``dndData`` member of the node. If it is missing, ``node.innerHTML`` is used instead.

``type``
  the content of ``dndType`` member of the node split on "," character. If it is missing, ``["text"]`` is used as the 
  default type.

Default creator
~~~~~~~~~~~~~~~

If the creator function was not specified, a default creator is used. The default creator does following things:

* It creates a context-appropriate node:

  * If the container is ``<div>`` or ``<p>``-based, it will create a ``<div>`` node.

  * If the container is ``<ul>`` or ``<ol>``-based, it will create a ``<li>`` node.

  * If the container is ``<table>``-based, it will create a ``<tr><td>`` group of nodes, and it will be inserted in
    ``<tbody>``.

  * In all other contexts it will create a ``<span>`` node.

  * If the ``hint`` is ``"avatar"`` it will create a ``<span>`` node.

* If the data item is an object, it will test for the presence of ``data`` member. If it is present, it will be used as
  a data object. Otherwise the item itself will be used as a data object.

* If the data item is an object, it will test for the presence of ``type`` member. If it is present, it will be used as
  a type object. Otherwise ``["text"]`` will be used as a type object.

* It will set a content of the node to ``String(data)``. You can override the ``toString()`` member function of your
  object to change how it is converted to the string. Or specify the ``creator`` function.

* As any creator it returns a triplet object with newly created/identified ``node``, ``data``, and ``type``.

After the creator function was called the result is post-processed:

* If the returned node doesn't have an ``id``, the default unique id will be generated.

* The returned node will be assigned a ``dojoDndItem`` class.

* If the returned ``type`` is not an array or missing, it will be replaced with ``["text"]``.

Public methods and attributes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following public methods are defined:

``getAllNodes()``
  returns a ``NodeList`` of all controlled DOM nodes in the order they are listed in the container.

``insertNodes(data, before, anchor)``
  inserts data items before/after the anchor node. It returns the container object itself for easy chaining of calls.

  ``data`` 
    an array of data items to be inserted. Each data item will be passed to the creator function, the result will
    be registered with the container, the node will be inserted according to ``before`` and ``anchor`` parameters.

  ``before``
    a boolean flag. If it is ``true``, nodes will be added before the ``anchor``, and after otherwise.

  ``anchor``
    a node to be used as a reference for the insertion. It should be an immediate child of the container node (or a 
    child of ``<tbody>`` for the ``<table>``-based node). If it is not specified, all items will be appended to the 
    container node (or ``<tbody>`` for tables).

``destroy()``
  prepares the container object to be garbage-collected. You cannot use the container object after it was destroyed.

``sync()``
  inspects all controlled DOM nodes updating internal structures by removing information of removed nodes, and adding
  newly added DOM nodes marked with ``dojoDndItem`` class.

The following public attributes are defined:

``current``
  a DOM node, which corresponds to a child with a mouse hovering over it. If there is no such item, this variable is 
  null.

``node``
  the DOM node of the container. This node is used to set up mouse event handlers for the container.

``parent``
  the DOM node, which is an immediate parent of DnD item nodes. In most cases it is the same as node, but in some cases 
  it can be node's descendant. Example: for tables ``node`` can point to ``<table>``, while ``parent`` points to 
  ``<tbody>`` (DnD item nodes will be ``<tr>`` nodes). You can freely change parent to achieve the desired behavior of 
  your container by specifying ``dropParent`` parameter.

``creator``
  the creator function or ``null``, if the default creator is used.

``skipForm``
  the flag propagated from the initial parameters.

``map``
  a dictionary, which is keyed by node ids. Each registered child has an entry in the ``map`` by its node id (this is 
  why all nodes should have unique ids). ``map[id]`` returns an object with two attributes:

  ``data``
    an associated data item.

  ``type``
    an associated array of types.

  *Note* that ``map`` does not contain a reference to any DOM nodes; its purpose is to store metadata, ``data`` and
  ``type``, associated with the DOM node. For example, if you wish to programmatically move a DnD item from one
  ``Source`` to another, you must perform DOM manipulations in addition to moving the item from one ``Source``'s ``map``
  to the other ``Source``'s ``map``.

  However, it is not recommended to access ``map`` directly. There are several utility functions to access it. They can
  be used to virtualize the map, and you can use them with ``dojo.connect()`` so you know when DnD items are
  added/removed/accessed and use it to customize the behavior:

The following accessor and utility functions are defined:

``getItem(id)``
  returns an object with ``data`` and ``type`` described above, which are associated with the node corresponding to that 
  ``id``.

``setItem(id, obj)``
  associates an object ``obj`` with this ``id``. ``obj`` should define ``data`` and ``type`` attributes.

``delItem(id)``
  deletes a record of the node with this ``id``. **Warning:** it does not delete the node from the container.

``clearItems()``
  delete all records. **Warning:** it does not delete nodes from the container.

``forInItems(f, o)``
  similar to ``dojo.forEach()`` but goes over all items in the map in an unspecified order. The function ``f`` will be
  called in the context ``o`` for every item in the ``map`` with following parameters:

  ``obj``
    the corresponding object with ``data`` and ``type`` defined.

  ``id``
    the node id.

  ``map``
    the map object itself.

  *Note:* ``forInItems()`` iterates over all DnD items in unspecified order. If you want to iterate over items in the
  order they are listed in the container you can use the code similar to this:

  .. js ::

    function OrderedIter(container, f, o){
      // similar to:
      // container.forInItems(f, o);
      // but iterates in the listed order

      o = o || dojo.global;
      container.getAllNodes().forEach(function(node){
        var id = node.id;
        f.call(o, container.getItem(id), id, container);
      });
    }

Event processors
~~~~~~~~~~~~~~~~

Following event processors are defined: ``onMouseOver``, ``onMouseOut``. Two pseudo-events are defined: ``onOverEvent``,
``onOutEvent``, which are cleaned up argument-less ``onMouseOver`` and ``onMouseOut`` events (otherwise they can be
fired several times without actually leaving the container).

CSS classes
~~~~~~~~~~~

Following CSS classes are used by the container object:

``dojoDndContainer``
  assigned to each container node during the construction.

``dojoDndContainerOver``
  assigned when the mouse hovers over the container.

``dojoDndItem``
  assigned to every new data item node. It should be assigned to every item before the container construction, if you 
  want it to be added automatically by the constructor.

``dojoDndItemOver``
  assigned to a data item node when the mouse hovers over the this item. This class is assigned in addition to 
  ``dojoDndItem`` class.

Partial reason to add "over" states when the mouse hovers over instead of using CSS was to support it in Internet
Explorer too.

Selector
--------

The default implementation of ``Selector`` is built on top of Container_ and adds the ability to select children items.
Selector inherits all Container_'s methods and objects. Additionally it adds a notion of an anchor. The anchor is used
to specify a point of insertion of other items. The selector assumes that the container is organized in a linear fashion
either vertically (e.g., embedded ``<div>``\s, lists, tables) or horizontally (e.g., ``<span>``\s). This assumption
allows implementation of familiar user interface paradigms: selection of one element with a mouse *click*, selection of
an additional element with *ctrl+click*, linear group selection from the anchor to the clicked element with
*shift+click*, selecting an additional linear group from the anchor to the clicked element with *shift+ctrl+click*.
Obviously if you have more complex containers, you could implement different user interface actions.

Constructor
~~~~~~~~~~~

Constructor takes the same two parameters as the Container_'s constructor. It understands more optional parameters and
passes the rest to the underlying container. Following optional parameters are understood by the selector object:

``singular``
  a Boolean flag. If it is ``true``, the user is allowed to select just one item, otherwise any number of items can be 
  selected. It is ``false`` by default.

``autoSync``
  a Boolean flag. If it is ``true``, Selector calls Container_'s ``sync()`` method for every ``onMouseDown``. It helps 
  when you add/remove DnD items using HTML DOM API, but can be taxing for containers with large number of DnD items. In 
  order to be more efficient consider calling ``sync()`` method after the manipulations were done, or (even more 
  efficient) adding new DnD items using ``insertNodes()`` method. The default value of this parameter is ``false``.

Public methods and attributes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Following public methods are defined in addition to the container public methods:

``getSelectedNodes()``
  returns a :ref:`NodeList <dojo/NodeList>` of selected DOM nodes.

``selectNone()``
  remove the selection from all items. It returns the selector object itself for easy chaining of calls.

``selectAll()``
  selects all items. It returns the selector object itself for easy chaining of calls.

``deleteSelectedNodes()``
  deletes all selected nodes. It returns the selector object itself for easy chaining of calls.

Following public method is redefined with a new signature:

``insertNodes(addSelected, data, before, anchor)``
  the last three parameters are the same as in Container_. The first parameter is a flag, if it is ``true`` all newly 
  added items will be added as selected, otherwise they will be added unselected.

The container object defines following public attributes:

``selection``
  a dictionary object keyed by ids of selected nodes. No useful payload is attached to objects in the dictionary.

``anchor``
  the current anchor node or ``null``.

Event processors
~~~~~~~~~~~~~~~~

Following event processors are defined: ``onMouseDown``, ``onMouseUp``. ``onMouseMove`` is attached by ``onOverEvent`` and detached by ``onOutEvent`` dynamically.

CSS classes
~~~~~~~~~~~

Following CSS classes are used by the selector object in addition to classes assigned the container object:

``dojoDndItemSelected``
  assigned if a data item is selected but it is not an anchor (the last selected element). This class is assigned in 
  addition to ``dojoDndItem`` class.

``dojoDndItemAnchor``
  assigned to an anchor data item. At any given time the selector can have zero or one anchor. This class is assigned in 
  addition to ``dojoDndItem`` class. Being an anchor means that this item is selected.

Source
------

The source object represents a source of items for DnD operations. It is used to represent DnD targets as well. In order
to be compatible your custom sources should emulate the common source API. Instances of this class can be created from
the HTML markup automatically by :ref:`dojo/parser <dojo/parser>` using ``data-dojo-type="dojo/dnd/Source"``.

The default implementation of the source is built on top of Selector_, and adds the ability to start a DnD operation,
and participate in the orchestration of the DnD. Source_ inherits all Selector_'s (and Container_'s) methods and
attributes. User can initiate the DnD operation by dragging items (click and move without releasing the mouse). The DnD
operation can be used to rearrange items within a single source, or items can be moved or copied between two sources.
The user can select whether they want to copy or move items by pressing the `Ctrl` button during the operation. If
`Ctrl` is pressed, items will be copied, otherwise they will be moved. This behavior can be overwritten
programmatically.

Constructor
~~~~~~~~~~~

Constructor takes the same two parameters as the container's Selector_. It understands more optional parameters and
passes the rest to the underlying Selector_. Following optional parameters are understood by the source object:

``isSource``
  a Boolean flag. If it is ``true``, this object can be used to start the DnD operation, otherwise it can serve only as 
  a target. It is ``true`` by default.

``accept``
  an array of strings. It defines what types can be accepted by this object, when it is used as a target. The default is 
  ``["text"]``. If the array is empty it means that this source cannot be a target.

``horizontal``
  a Boolean flag. If ``true``, the source is based on the horizontally organized list container, otherwise it is based 
  on the vertical one. The default is ``false``.

``withHandles``
  a Boolean flag. If ``true``, an item can be dragged only by a predefined node inside the item, otherwise the whole 
  item can be used for dragging. By default it is ``false``. The handle should be a descendant of the item node and 
  should be marked with class ``dojoDndHandle``.

``copyOnly``
  a Boolean flag. If ``true``, the source doesn't allow to move items out of it, any DnD operation will copy items from 
  such sources. By default it is ``false``.

``selfCopy``
  a Boolean flag. If ``true``, the source copies items by default when dropping on itself. It is ``false`` by default. 
  This flag has meaning only if ``copyOnly`` is ``true``.

``selfAccept``
  a Boolean flag. If ``true``, the source accepts its own items. It is ``true`` by default. This flag has meaning only 
  if ``copyOnly`` is ``true``.

``delay``
  a number, which defines the move delay in pixels before detecting a drag; 0 (no delay) by default.

Public methods and attributes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following public methods are defined (they can be replaced to change the DnD behavior):

``checkAcceptance(source, nodes)``
  returns ``true``, if this object can accept ``nodes`` from ``source``. The default implementation checks item's types 
  with accepted types of the object, and rejects the operation if there is no full match. Such objects are marked as 
  disabled targets and they do not participate in the current DnD operation. The source of items can always accept its 
  items regardless of the match (for exceptions see the definition of ``selfAccept`` above) preventing the situation 
  when user started to drag items and cannot find a suitable target, and cannot return them back. Take this into 
  consideration when replacing the method. The Target_'s ``checkAcceptance()`` is called during the DnD in progress when 
  user hovers above it. Following parameters are passed to the method:

  ``source``
    the source object for the dragged items.

  ``nodes``
    a list of DOM nodes.

``copyState(keyPressed)``
  returns ``true`` if the copy operation should be performed, the move will be performed otherwise. The default 
  implementation checks the ``copyOnly`` and ``selfCopy`` parameters described above. This method can be replaced if you 
  want to implement a more complex logic. Following parameters are passed in:

  ``keyPressed``
    a Boolean flag. If ``true``, user pressed the ``copy`` key.

  ``self``
    a Boolean flag. If it is ``true``, we are about to drop items on itself.

Event processors
~~~~~~~~~~~~~~~~

Following event handlers are overloaded: ``onMouseDown``, ``onMouseUp``, and ``onMouseMove``. They are used to perform
additional actions required by Source_.

Following local events are defined by Source_, which are meant to be overridden or connected with
:ref:`dojo/on <dojo/on>` or `dojo.connect()`:

``onDrop(source, nodes, copy)``
  this method is called when DnD items is dropped in this target. The default implementation calls ``onDropExternal()`` 
  or ``onDropInternal()`` based on the value of ``source`` (see below). Following parameters are passed in:

  ``source``
    the source of dragged items, can be the same object as the target.

  ``nodes``
    the array of DOM nodes to be dropped. Their IDs can be used to access associated types and data.

  ``copy``
    the Boolean flag. If ``true``, the target is requested to copy items, otherwise the target should move items.

``onDropExternal(source, nodes, copy)``
  this method is called by the default implementation of ``onDrop()`` only if we have an external drop meaning that the 
  source is different from the target. All parameters are the same as in ``onDrop()``. The default implementation 
  performs the drop as instructed.

``onDropInternal(nodes, copy)`` 
  this method is called by the default implementation of ``onDrop()`` only if we have an internal drop.  This means that 
  the source is the same as the target. All parameters are the same as in ``onDrop()``, but ``source`` parameter is 
  skipped as redundant (it is the same as ``this``). The default implementation performs the drop as instructed.

``onDraggingOver()``
  this method is called during the DnD operation in progress when the mouse is over this target, and it is not disabled 
  for any reasons. The default implementation does nothing.

``onDraggingOut()``
  this method is called during the DnD operation in progress when the mouse went out of this target, and it is not 
  disabled for any reasons. The default implementation does nothing.

Topic processors
~~~~~~~~~~~~~~~~

Following topic listeners are defined: ``onDndSourceOver``, ``onDndStart``, ``onDndDrop``, ``onDndCancel``. These topics
are published by the Manager_. If you want to override topic listeners, please read `Summary of topics`_.

**Warning:** in most cases you want to use events. Topics are low-level constructs, which are used internally and
generally should not be used for customization.

CSS classes
~~~~~~~~~~~

Following CSS classes are used by the source object in addition to classes assigned by Selector_ and Container_ objects:

``dojoDndHorizontal``
  assigned to the container node during the construction, if this object represents a horizontal list of ``dndItems``, 
  its ``horizontal`` property set to ``true``.

``dojoDndSource``
  assigned to the container node during the construction, if this object can be used as a source of DnD items, its 
  ``isSource`` property set to true.

``dojoDndSourceCopied``
  assigned to the container node during the active DnD operation when user copies items from it (e.g. pressed the 
  *Ctrl* key while dragging). When this class is assigned to the node, ``dojoDndSource`` class is removed.

``dojoDndSourceMoved``
  assigned to the container node during the active DnD operation when user moves items from it (e.g. the *Ctrl* key is 
  not pressed while dragging). When this class is assigned to the node, ``dojoDndSource`` class is removed.

``dojoDndTarget``
  assigned to the container node during the construction, if this object can potentially accept DnD items, its 
  ``accept`` list is not empty.

``dojoDndTargetDisabled``
  assigned to the container node during the active DnD operation when this node cannot accept currently dragged items 
  (e.g. because it doesn't accept items of these types). When this class is assigned to the node, ``dojoDndTarget`` 
  class is removed.

``dojoDndItemBefore``
  assigned to the data item node during the active DnD operation if transferred items will be inserted before this item. 
  This class is assigned in addition to all other classes.

``dojoDndItemAfter``
  assigned to the data item node during the active DnD operation if transferred items will be inserted after this item. 
  This class is assigned in addition to all other classes.

``dojoDndHandle``
  assigned to handles of item nodes. See ``withHandles`` parameter of Source_ above.

``dojoDndSource``, ``dojoDndSourceCopied``, and ``dojoDndSourceMoved`` are mutually exclusive. ``dojoDndTarget``, and
``dojoDndTargetDisabled`` are mutually exclusive. ``dojoDndSourceCopied``, ``dojoDndSourceMoved``,
``dojoDndTargetDisabled``, ``dojoDndItemBefore``, and ``dojoDndItemAfter`` can be assigned only during the active DnD
operation. See the Manager_'s classes below to see what additional classes can be used for custom styling. Use
``dojoDndHorizontal`` with ``dojoDndItemBefore`` and ``dojoDndItemAfter`` to create visually appropriate insertion
markers for horizontal (before, after) and vertical (above, below) containers.

Target
------

Essentially it is Source_ wrapped in with ``isSource`` set to ``false``. Instances of this class can be created from the
HTML markup automatically by :ref:`dojo/parser <dojo/parser>` using ``data-dojo-type="dojo/dnd/Target"``.

AutoSource
----------

Essentially it is Source_ wrapped in with ``autoSync`` set to ``true``. Instances of this class can be created from the
HTML markup automatically by :ref:`dojo/parser <dojo/parser>` using ``data-dojo-type="dojo/dnd/AutoSource"``.

Avatar
------

Avatar is a class for the object (the singleton pattern) that represents dragged items during DnD operations. You can
replace it or style it if you need to customize the look of DnD.

Following methods should be implemented:

``constructor(manager)``
  the constructor of the class takes a single parameter --- the instance of Manager_, which is used to reflect the state 
  of the DnD operation in progress visually. The constructor is called (and the avatar object is created) only when the 
  manager decided to start a DnD operation. In this case Manager_ calls its method ``makeAvatar()``. By default Avatar 
  constructs a ``<table>`` node.

``destroy()``
  this method is called when the DnD operation is finished, the Avatar is unneeded, and is about to be recycled.

``update()``
  this method is called, when the state of the manager changes. It is used to reflect Manager_'s changes visually. 
  Usually this method is called by Manager_ automatically.

``generateText()``
  semi-public method, which is called by ``update()`` to render the header text. The default implementation returns a 
  number of dragged items as a string. You can override this method for localization purposes, or to change the text 
  however you like.

The default implementation of the Avatar class does the following:

* It creates an absolutely positioned table of up to 6 rows.

* The first row (the header) is populated with a text generated by ``generateText()`` method.

* Next rows are populated with DOM nodes generated by the creator function of the current source with hint "avatar" (see
  above the description of the creator function) for data items. Up to 5 rows are populated with decreasing opacity.

If you want to override the avatar with something totally custom, the best way to do it is to override Manager_'s
``makeAvatar()`` to return your own instance.

CSS classes
~~~~~~~~~~~

Following CSS classes are used to style the avatar:

``dojoDndAvatar``
  assigned to the avatar (the table).

``dojoDndAvatarHeader``
  assigned to the first row (the header).

``dojoDndAvatarItem``
  assigned to the avatar item rows.

``dojoDndAvatarCanDrop``
  added to the avatar (the table) when the mouse is over a target, which can accept transferred items. Otherwise it is 
  removed.

Manager
-------

``Manager`` is a class which implements a business logic of DnD and orchestrates the visualization of this process. (It is the replacement for the deprecated ``dojo.dnd.manager`` singleton in 1.6.)  It
accepts events from sources/targets, creates the Avatar_, and checks the validity of the drop. At any given moment there
is only one instance of this class (the singleton pattern), which can be accessed by ``Manager.manager()`` function.
You do not need to instantiate this object explicitly. It is done automatically when DnD modules are required.

This class or its instance can be monkey patched or replaced completely, if you want to change its functionality.

Public methods and attributes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Following public methods are defined to be called by sources:

``startDrag(source, nodes, copy)``
  starts the DnD operations. The parameters are copied as public member variables of the ``Manager`` with the same 
  names. This method creates the avatar by calling ``this.makeAvatar()`` and assigning it to the ``avatar`` public 
  member. Information on parameters:

  ``source``
    the source of dragged items, can be the same object as the target.

  ``nodes``
    the array of DOM nodes to be dropped. Their ids can be used to access associated types and data.

  ``copy``
    the Boolean flag. If ``true``, the target is requested to copy items, otherwise the target should move items.

``stopDrag()``
  resets the DnD operation by resetting all public members. It is not enough to just call this method to abort the DnD 
  operation. Before calling it you should publish ``dnd/cancel`` topic (or ``dnd/drop``, if your forcing the drop). See 
  more information on topics below.

``canDrop(flag)``
  called by the current target to notify that it can accept the DnD items, if flag is ``true``. Otherwise it refuses to 
  accept them.

Following methods deal with the avatar and can be overridden, if something different is required:

``makeAvatar()``
  returns the Avatar_'s node. By default it creates an instance of Avatar_ passing itself as a parameter.

``updateAvatar()``
  updates avatar to reflect changes in the current DnD operation (e.g. copy vs. move) cannot drop at this point.

Following public properties are defined on the manager and can be overwritten if desired:

``OFFSET_X``
  the horizontal offset in pixels between the mouse pointer position and the left edge of the avatar.

``OFFSET_Y``
  the vertical offset in pixels between the mouse pointer position and the top edge of the avatar.

Following public properties are used by the manager during the active DnD operation:

``source``
  the source of DnD items.

``nodes``
  the list of transferred DnD items.

``copy``
  Boolean value to track the copy/move status.

``target``
  the selected target of the drop.

Event processors
~~~~~~~~~~~~~~~~

Following events are processed by the manager to the body: ``onMouseMove``, ``onMouseUp``, ``onKeyDown``, ``onKeyUp``.
These events are attached only during the active DnD operation. Following keys have a special meaning for the manager:

*Ctrl* key
  when it is pressed the copy semantics is assumed. Otherwise the move is assumed.

*Esc* key
  when it is pressed the DnD operation is immediately canceled.

Topic processors
~~~~~~~~~~~~~~~~

Following topic events can be generated by the manager:

``/dnd/start``
  when DnD starts. Current ``source``, ``nodes``, and the ``copy`` flag (see ``startDrag()`` for more info) are passed 
  as parameters of this event.

``/dnd/source/over``
  when the mouse moves over a source. The source in question is passed as a parameter. The same event is raised when the 
  mouse goes out of a source. In this case ``null`` is passed as a parameter.

``/dnd/drop/before``
  raised just before the drop. It can be used to capture the drop parameters. Parameters are the same as for 
  ``/dnd/start``, but reflect current values.

``/dnd/drop``
  raised to perform a drop. Parameters are the same as for ``/dnd/start`` and one additional parameter is ``target`` 
  (the object where items are dropped).

``/dnd/cancel``
  when DnD was canceled either by user (by hitting *Esc*), or by dropping items in illegal location.

**Warning:** During the processing of topics any listener can change the original parameters. It can be done by the
target processing ``/dnd/drop``. In most cases you want to use events local to sources/targets, instead of processing
topics. See Source_'s ``onDrop`` for more details.

CSS classes
~~~~~~~~~~~

Following CSS classes are used by the manager to style the DnD operation:

``dojoDndCopy``
  assigned to ``body`` during the copy DnD operations.

``dojoDndMove``
  assigned to ``body`` during the move DnD operations.

No styles are assigned when there is no DnD in progress.

dojo/dnd/move Principals
========================

The DnD move consists of two principal classes and several specific implementations.

Moveable
--------

Moveable is the main class, which is used to give the "moveable" property to a DOM node. Instances of this class can be
created from the HTML markup automatically by :ref:`dojo/parser <dojo/parser>` using
``data-dojo-type="dojo/dnd/Moveable"``.

Constructor
~~~~~~~~~~~

The constructor accepts following parameters:

``node``
  a DOM node or a String representing an ID of a node. This node will be made moveable. Both ``relative`` and 
  ``absolute`` nodes can be moved. Their ``left`` and ``top`` are assumed to be in pixels. All other nodes are converted 
  to ``absolute`` nodes on the first drag.

``params``
  a dictionary object, which defines optional parameters. Following optional parameters are recognized:

  ``handle``
    the node (or its String ID), which will be used as a drag handle. It should be a descendant of ``node``. If it is 
    ``null`` (the default), the ``node`` itself is used for dragging.

  ``delay``
    a number in pixels. When user started the drag we should wait for ``delay`` pixels before starting dragging the 
    node. It is used to prevent accidental drags. The default is 0 (no delay).

  ``skip``
    a Boolean flag, which indicates that we should skip form elements when initiating drags if it is ``true``. Otherwise 
    the node is dragged no matter what. This parameter is used when we want to drag a form, but keep form elements 
    usable (e.g. we can still select text in a text node). The default is ``false``. When working with a draggable form, 
    the better alternative to ``skip=true`` is to define a drag handle instead.

  ``mover``
    the class to be used to create a mover (see Mover_).

Public methods and attributes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Following public attributes are available:

``node``
  the node to be dragged.

Following public methods are defined:

``destroy()``
  should be called when you want to remove the "moveable" behavior form the node.

Event processors
~~~~~~~~~~~~~~~~

Following public methods/events are defined. They can be used with `dojo.connect()` or overridden:

``onDragDetected(evt)``
  called when the drag is detected. The default implementation creates a Mover_. Parameters:

  ``evt``
    the event object, which triggered the drag.

``onFirstMove(mover)``
  called once after processing the first move event. The default implementation does nothing. Parameters:

  ``mover``
    the Mover_ object used to drag the node

``onMoveStart(mover)``
  called when the move is about to start. The parameter is a Mover_ object just like in ``onFirstMove()``. The default 
  implementation publishes the topic ``/dnd/move/start``, adds ``dojoMove`` class to ``body`` node, and ``dojoMoveItem`` 
  class to the moved node.

``onMoveStop(mover)``
  called when the move is finished. The parameter is a Mover_ object just like in ``onFirstMove()``. The default 
  implementation publishes the topic ``/dnd/move/stop``, removes ``dojoMove`` class from ``body`` node, and 
  ``dojoMoveItem`` class from the moved node.

``onMove(mover, leftTop)``
  called on every update of ``node``'s position. The default implementation calls ``onMoving()``, sets new position of 
  the ``node`` using ``style``, and calls ``onMoved()``. Parameters:

  ``mover`` 
    the Mover_ object for the current move.

  ``leftTop``
    ``{l, t}`` – an object which defines the new left and top position of the object by its attributes ``l`` and ``t`` 
    respectively. Both of them are numbers in pixels.

``onMoving(mover, leftTop)``
  called by the default implementation of ``onMove()`` before updating the ``node``'s position. It uses the same 
  parameters as ``onMove()`` above. You can update ``leftTop`` parameter to whatever you want. The default 
  implementation does nothing.

``onMoved(mover, leftTop)``
  called by the default implementation of ``onMove()`` after updating the ``node``'s position. It uses the same 
  parameters as ``onMove()`` above. The default implementation does nothing.

The most important events are ``onFirstMove()`` and ``onMove()``. ``onFirstMove()`` can be used to set up some initial
parameters for the move, and possibly update some DOM nodes. ``onMove()`` implements the move itself. By overriding
these two methods you can implement a variety of click-drag-release operations (e.g. a resize operation, a draw
operation, and so on).

As you can see ``onMoving()``, ``onMove()``, and ``onMoved()`` fit the classic aspect before/after pattern.
``onMoving()`` can be used to actively modify move parameters, while ``onMoved()`` can be used for book-keeping. You may
want to override ``onMove()`` for your own purposes and use :ref:`dojo/aspect <dojo/aspect>` to augment it however you
like.

Following mouse event handlers are set up:

``onMouseDown``

``onMouseMove``
  can be set up by ``onMouseDown`` when executing the non-zero delay.

``onMouseUp``
  can be set up by ``onMouseDown`` to cancel the drag while processing the non-zero delay.

Additionally ``ondragselect`` and ``onselectstart`` events are canceled by ``onSelectStart()`` handler.

Topic processors
~~~~~~~~~~~~~~~~

Following topic events are raised by Moveable_:

``/dnd/move/start``
  published by the default implementation of ``onMoveStart()`` passing the Mover_ object as a parameter.

``/dnd/move/stop``
  published by the default implementation of ``onMoveStop()`` passing the Mover_ as a parameter.

CSS classes
~~~~~~~~~~~

Following CSS classes are used by Moveable_:

``dojoMove``
  assigned to ``body`` when the move is in progress.

``dojoMoveItem``
  assigned to the moved node when the move is in progress.

Mover
-----

Mover is a utility class, which handles events to move the node, and triggers appropriate high-level events on the
connected object (usually a Moveable_). Instances of this class exist only when the move is in progress. In some cases
you can use it directly.

Constructor
~~~~~~~~~~~

The constructor accepts following parameters:

``node``
  a DOM node or an id (string) of such node. This node will be moved.

``evt``
  a mouse event, which actually indicated the start of the move. It is used to extract the coordinates of the mouse 
  using ``pageX`` and ``pageY`` properties.

``host``
  a host object, which will be called by the mover during the move. It should define at least two methods: 
  ``onFirstMove()``, and ``onMove()``, and two optional methods: ``onMoveStart()`` and ``onMoveStop()``. See Moveable_ 
  for details.

Public methods and attributes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Following public members are available:

``node``
  the node being dragged.

``mouseButton``
  a mouse button, which was pressed when starting the drag.

``marginBox``
  an object with two integer attributes: ``l`` and ``t``. It is initialized by the constructor, updated by the 
  ``onFirstMove()`` method on the mover, and used later on to add to the mouse coordinates before passing them to host's 
  ``onMove()`` as ``leftTop``.

Following public methods are defined:

``destroy()``
  should be called when you want to stop the move.

``onFirstMove()``
  called once to finish setting up the ``marginBox`` property. Additionally it calls the host's ``onFirstMove()``.

Event processors
~~~~~~~~~~~~~~~~

Following mouse event handlers are set up: ``onMouseMove``, ``onMouseUp``. Additionally ``ondragselect`` and
``onselectstart`` events are canceled.

Specialized Moveables
---------------------

Following specialized moveable classes are defined:

constrainedMoveable
~~~~~~~~~~~~~~~~~~~

``dojo/dnd/move/constrainedMoveable`` can be used to constrain a move to a dynamically calculated box. This class is
defined in the ``dojo/dnd/move`` module. It is based on Moveable_, and accepts following additional parameters during
construction:

``constraints``
  a function, which is called in the context of this Moveable_, with a newly created Mover_ object, and returns a 
  rectangle to be used for restrictions. The rectangle is an object, which defines following numeric attributes: ``l`` 
  for left, ``t`` for top, ``w`` for width, and ``h`` for height. All numbers are in pixels.

``within``
  a Boolean flag. When it is ``true``, the dragged node will be moved only within the defined rectangle, and cannot go 
  outside of it. Otherwise, the restriction applies to the left-top corner of the moved node.

boxConstrainedMoveable
~~~~~~~~~~~~~~~~~~~~~~

``dojo/dnd/move/boxConstrainedMoveable`` can be used to constrain a move to a predefined box. This class is defined in
the ``dojo/dnd/move`` module. It is based on constrainedMoveable_ and accepts following additional parameters during
construction:

``box``
  a rectangle box (see constrainedMoveable_), which defines constraint boundaries.

``within``
  see constrainedMoveable_ for details.

parentConstrainedMoveable
~~~~~~~~~~~~~~~~~~~~~~~~~

``dojo/dnd/move/parentConstrainedMoveable`` can be used to constrain the move by the boundaries of the node's parent.
This class is defined in the ``dojo/dnd/move`` module. It is based on constrainedMoveable_ and accepts following
additional parameters during construction:

``area``
  a string, which defines constraint boundaries. Valid values are: ``"content"``, ``"padding"``, ``"border"``, and 
  ``"margin"``.

``within``
  see constrainedMoveable_ for details.

TimedMoveable
~~~~~~~~~~~~~

``dojo/dnd/TimedMoveable`` can be used to throttle refreshes while moving nodes. This class is defined in its own module. It is based on Moveable_, and accepts following additional parameters during construction:

``timeout``
  the time delay number in milliseconds. The node will not be moved for that number of milliseconds, but it will 
  continue to accumulate changes in the mouse position.

Subclassing DnD classes
=======================

If you want to subclass Container_, Selector_, Source_, Moveable_, or their descendants, and you want to use the
declarative markup, don't forget to implement the ``markupFactory()`` method. The reason for that is :ref:`dojo/parser <dojo/parser>`, which instantiates the markup, expects a very particular signature from a constructor. Dojo DnD classes
predate ``dojo/parser``, and have a non-conformant signature. ``dojo/parser`` is smart enough to use a special adapter
function in such cases. See the source code for ``dojo/dnd/Source::markupFactory()`` (for the
Container_-Selector_-Source_ chain), and ``dojo/dnd/Moveable::markupFactory()`` for details. The key point is to return
the instance of your new class there. Otherwise the instance of your base class is going to be created, which is
probably not what you want.

Summary of CSS classes
======================

All DnD-related classes can be used on six different types of DOM nodes. All of them are listed here. Using CSS classes
described here you can design an extremely sophisticated UI to improve usability and enhance the workflow of your
applications.

body
----

The ``body`` node is updated only during active DnD operations. It can be used during the move to de-emphasize
temporarily the web page and to highlight available targets or a moved object.

Following CSS classes are used:

``dojoDndCopy``
  assigned to the ``body`` during the copy DnD operations.

``dojoDndMove``
  assigned to the ``body`` during the move DnD operations.

``dojoMove``
  assigned to the ``body`` when the drag (``dojo/dnd/move``) is in progress.

Source/target (dojo/dnd)
------------------------

Source can be assigned several classes to reflect its current role. These classes can be used together with the body CSS
classes described above to create CSS rules to differentiate containers visually during DnD.

Following CSS classes are used:

``dojoDndContainer``
  assigned to each container node during the construction.

``dojoDndContainerOver``
  assigned when the mouse hovers over the container.

``dojoDndHorizontal``
  assigned to the container node during the construction, if this object represents a horizontal list of DnD items 
  its ``horizontal`` property set to ``true``.

``dojoDndSource``
  assigned to the container node during the construction, if this object can be used as a source of DnD items its 
  ``isSource`` property set to ``true``.

``dojoDndSourceCopied``
  assigned to the container node during the active DnD operation when user copies items from it (e.g. the *Ctrl* key was 
  pressed while dragging). When this class is assigned to the node ``dojoDndSource`` class is removed.

``dojoDndSourceMoved``
  assigned to the container node during the active DnD operation when user moves items from it (e.g. the Ctrl key is not 
  pressed while dragging). When this class is assigned to the node, ``dojoDndSource`` class is removed.

``dojoDndTarget``
  assigned to the container node during the construction, if this object can potentially accept DnD items its ``accept`` 
  array is not empty.

``dojoDndTargetDisabled``
  assigned to the container node during the active DnD operation when this node cannot accept currently dragged items 
  (e.g., because it doesn't accept items of these types). When this class is assigned to the node, ``dojoDndTarget`` 
  class is removed.

DnD Item (dojo/dnd)
-------------------

DnD items can be assigned several classes to reflect their current role visually.

Following CSS classes are used:

``dojoDndItem``
  assigned to every new data item node. It should be assigned to every item before the container construction, if you 
  want it to be added automatically by the constructor or ``sync()``.

``dojoDndItemOver``
  assigned to a data item node when the mouse hovers over the this item. This class is assigned in addition to 
  ``dojoDndItem`` class.

``dojoDndItemSelected``
  assigned if a data item is selected but it is not an anchor (the last selected element). This class is assigned in 
  addition to ``dojoDndItem`` class.

``dojoDndItemAnchor``
  assigned to an anchor data item. At any given time the selector can have zero or one anchor. This class is assigned in 
  addition to ``dojoDndItem`` class. Being an anchor means that this item is selected.

``dojoDndItemBefore``
  assigned to the data item node during the active DnD operation if transferred items will be inserted before this item. 
  This class is assigned in addition to all other classes.

``dojoDndItemAfter``
  assigned to the data item node during the active DnD operation if transferred items will be inserted after this item. 
  This class is assigned in addition to all other classes.

DnD Handles (dojo/dnd)
----------------------

DnD items can defined special handles on their descendants, which can be used for dragging. In this case the body of the
DnD item cannot be used to start the drag.

Following CSS classes are used:

``dojoDndHandle``
  assigned to handles of item nodes. See the ``withHandles`` parameter of Source_.

Avatar (dojo/dnd)
-----------------

The default avatar can be styled to suit your needs.

Following CSS classes are used:

``dojoDndAvatar``
  assigned to the avatar node (the table).

``dojoDndAvatarHeader``
  assigned to the first row/the header (the first ``tr`` node).

``dojoDndAvatarItem``
  assigned to the avatar item rows (``tr`` nodes excluding the very first one).

``dojoDndAvatarCanDrop``
  added to the avatar node (the table) when the mouse is over a target, which can accept transferred items. Otherwise it 
  is removed.

Dragged node (dojo.dnd.move)
----------------------------

The dragged node can be specially styled while in move.

Following CSS classes are used:

``dojoMoveItem``
  assigned to the dragged node when the move is in progress.

Summary of ``topics``
=====================

While local events are the preferred way to handle state changes, in some cases topics (named global events) can be
used. **Note** Please double-check if you have to use topics instead of events.

Following topic events can be generated by Manager_:

``/dnd/start``
  when DnD starts. Current ``source``, ``nodes``, and ``copy`` flag (see Manager_'s ``startDrag()`` for more info) are 
  passed as parameters of this event.

``/dnd/source/over``
  when the mouse moves over a source. The source in question is passed as a parameter. The same event is raised when the 
  mouse goes out of a source. In this case ``null`` is passed as a parameter.

``/dnd/drop/before``
  raised just before the drop. It can be used to capture the drop parameters. Parameters are the same as for 
  ``/dnd/drop``.

``/dnd/drop``
  raised to perform a drop. The first three parameters are the same as for ``/dnd/start``. The fourth parameter is the 
  target object. Note that during the processing of this event nodes can be already moved, or reused. If you need the 
  original nodes, use ``/dnd/drop/before`` to capture them, or use events local to source/target objects.

``/dnd/cancel``
  when DnD was cancelled either by user (by hitting Esc), or by dropping items in illegal location. This topic has no 
  parameters.

All sources subscribe to Manager_'s topics. Some users fail to understand that if they override, say, ``onDndDrop()``
method, which is a ``/dnd/drop`` topic listener, it will be called **every time** ``/dnd/drop`` is signalled. It means
it will be notified even if your source was not the part of the DnD exchange. It wasn't a source of the items, and it is
not a target of the drop. If you subclass Source_ and override ``onDndDrop()``, your new method will be called for every
instance of your class.

Following topic events are raised by Moveable_:

``/dnd/move/start``
  published by the default implementation of Moveable_'s ``onMoveStart()`` passing a mover_ as parameter.

``/dnd/move/stop``
  published by the default implementation of Moveable_'s ``onMoveStop()`` passing a mover as parameter.

Tips
====

In order to limit the maximum number of items in a DnD source, you can override the ``checkAcceptance()`` method on your
source, and return ``false``, when you reached your limit.

If you want to create ``dojo/dnd/Source`` declaratively, and want to select that Source for operations like
``insertNodes()``, you will need to manually supply that Source_ with a ``data-dojo-id``. For example:

.. html ::

  <div data-dojo-type="dojo/dnd/Source" id="test" data-dojo-id="test"></div>

Then you reference it in your code like: ``test.insertNodes();``. Without that, there is no way to use the methods of
the Source_ if you are creating it with markup.

The DnD itself uses ``onmousedown``/``onmousemove``/``onmouseup`` to operate. If you want to process ``onclick``, be
warned that this is the synthetic event: essentially it is ``onmousedown + onmouseup``, which occurred within some
predefined time interval (usually settable on the OS level), or using other criteria. Some browsers generate ``onclick``
on every ``onmouseup``. Working with DnD you will get plenty of false ``onclick`` events. Some of them happen naturally,
when user decided to drag but changed her mind clicking the mouse button generating ``onclick``. *Be extra careful when
processing* ``onclick`` *on DnD sources!*

Accessibility
=============

Low Vision
-----------

The DnD Icons are specifically designed to be useful in a low vision situation, where color is not the only indication
of what is occurring with DnD operation. The follow icons are used:

========================= ==============================================================================================
Image                     Description
========================= ==============================================================================================
.. image :: dndCopy.png   If the copy operation can be performed the DnD icon is a green background with a plus.
.. image :: dndNoCopy.png If the copy operation can not be performed, the DnD icon is a red background with an x.
.. image :: dndMove.png   If the move operation can be performed the DnD icon is a green background with an arrow.
.. image :: dndNoMove.png If the move operation can not be performed the DnD icon is a red background with a dash.
========================= ==============================================================================================

For High Contrast mode in Windows or when images have been turned off in the browser, the following character
representations are used for the DnD operations:

* If the copy operation can be performed the DnD character is a +.

* If the copy operation can not be performed, the DnD is an x.

* If the move operation can be performed the DnD character is a <.

* If the move operation can not be performed the DnD character is an o.


See also
========

* `Dojo Drag And Drop Redux <http://www.sitepen.com/blog/2011/12/05/dojo-drag-n-drop-redux/>`_ by Colin Snover at
  `SitePen <http://www.sitepen.com/>`_. – The comprehensive explanation of ``dojo/dnd``, and how to leverage it in real
  applications. The author builds the "shopping cart" in several iterations commenting code snippets and providing full
  source code for all examples. The only drawback is: this article uses topic handlers, because it was published before
  the introduction of local events.

* `Inside Dojo DnD: Drag Handles <http://www.sitepen.com/blog/2008/10/24/inside-dojo-dnd-drag-handles/>`_ by `Eugene Lazutkin <http://lazutkin.com/>`_ at `SitePen <http://www.sitepen.com/>`_. – The article explains a frequently
  overlooked and underused feature of Dojo’s DnD system: drag handles. It features several simple
  examples and clarifies some fine points.

* `Queued: Drag and Drop in the Queue <http://www.sitepen.com/blog/2009/04/16/queued-drag-and-drop-in-the-queue/>`_ by
  Bryan Forbes at `SitePen <http://www.sitepen.com/>`_. – The article shows how Dojo's DnD was used to implement the
  Netflix movie queue reordering feature in Queued, what features of DnD were used, and how it affected design
  decisions. All relevant code snippets are published along with detailed comments.

* :ref:`dojo.dnd.Moveable <dojo/dnd/Moveable>` Makes a DOM node moveable using the mouse.

* :ref:`dojox.mdnd <dojox/mdnd>` Experimental coordinates based moveable drag and drop.
