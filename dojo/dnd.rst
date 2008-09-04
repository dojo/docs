#format dojo_rst

dojo.dnd
========

:Status: Draft
:Version: 1.2

.. contents::
  :depth: 3

====================================
dojo.dnd 1.2 technical documentation
====================================

*(This is a copy of dojo.dnd 1.1 technical documentation. It will be updated to 1.2 as soon as it ships.)*

Underlying concepts
-------------------

This package was built after we learned from mistakes made in dojo.dnd 0.4: 

* The old package relied on position calculations, which fail in many corner cases (the browsers are to blame), and potentially can consume a lot of CPU cycles depending on complexity of the underlying HTML (deeper embedding means more time spent going over parent chains). The new package doesn't do any position calculations instead relying on mouse events "onmouseover" and "onmouseout". In order to do that we had to change the visual metaphor: the old DnD was dragging the object directly (it doesn't make much sense when dragging several objects), the new one uses an avatar to represent dragged objects. The avatar is shifted, so it doesn't obscure objects under the mouse giving the better visibility. Additionally it is possible to represent objects in the avatar differently. More on that later.

* The old package attached event handlers to all draggable items, which slowed down the browser in case of a lot of objects. The new package works with containers, which are responsible for individual items. It scales much better.
 
The old style dragging is useful in some cases, mostly because it looks intuitive for dragging single items. The new DnD accommodates it with a special sub-package dojo.dnd.move (see below).

The DnD (both dojo.dnd and dojo.dnd.move packages) is implemented as a state machine, which reflects its state by adding and removing classes to relevant objects, which gives an ultimate flexibility over customizing the look-and-feel.

Every DnD container and DnD item has a notion of type. The type is represented by a unique text string. Every container and item has an array of types assigned to them. In order to transfer (drop) items on a container they should have at least one type in common. When transferring a group of items to a container all items should have at least one type in common with the container. Otherwise the transfer is denied. If the list of types is not specified ["text"] is assumed.

The dojo.dnd supports copy and move styles of DnD out of the box.

User interface
~~~~~~~~~~~~~~

The existing implementation supports a linear container paradigm:

* Selection of an item on a mouse click.
* Adding an item to the existing selection by ctrl+click.
* Selecting a range of items by shift+click.
* Adding a range of items by ctrl+shift+click.

(On Macintosh the Meta key is used instead of Ctrl.)
In order to show an insertion point correctly it is possible to specify if we deal with a vertical or horizontal container.

See the Selector discussion below for more details.

dojo.dnd principals
-------------------

The dnd consists of 5 classes: Container, Selector, Source, Manager, and Avatar. The former three classes are responsible for dnd sources and targets. The latter two classes are singletons responsible for orchestration of dnd on the web page.

Container
~~~~~~~~~

The default implementation of Container represents a uniform collection of items. It knows when the mouse hovers over it, and when the mouse hovers over a particular item.

The draggable item is represented by an abstract data object, which can be anything. There is a function "creator", which is called when we need to visualize a data item for the container, or for the avatar. It allows us to have different representations of the same data item in different containers and in the avatar. More on that later.

Constructor takes 2 parameters: 
* node --- a DOM node or an id (string) of such node. This node represents a container. All draggable items will be direct descendants of this node (the important exception: a <table> node, in this case items will be direct descendants of the embedded <tbody> node).
* params --- a dictionary object, which defines optional parameters. Following optional parameters are recognized:

  * creator(item, hint) --- a creator function, which is used to build a representation of the data item.

    * item --- a data item (an abstract object), which defines a draggable object. The creator function is solely responsible for the interpretation of this item.
    * hint --- an optional string, which hints at the purpose of the call. The creator function can use it to produce different visual representations. At the moment only one value is defined: "avatar". When hint == "avatar" the creator can produce a special version for the avatar.
    * It should return an object with following members:

      * node --- a DOM representation of the data item built by the creator. This node should have a unique id. If no id was assigned, it will be generated and assigned later by the container. This id will be used to identify this item everywhere.
      * data --- a data item itself. The creator can "massage" or even replace it.
      * type --- an array of strings, which identify the type of this item. It is used during the DnD operation to select compatible targets.

    * skipForm --- a Boolean flag. If it is true, the container passes selection and dragging operations to the browser, otherwise it suppresses them. By default it is false.
    * dropParent --- a DOM node below the main node, which serves as a physical container for data item nodes. It can be used to structure the visual design of your container.

During the construction the constructor checks immediate children of "parent" member (see below) for the presence of "dojoDndItem" class. All such items are added as container's children automatically. It is assumed that you already built the visual representation of the data item, so the creator function is not involved. Instead the necessary triplet formed like that: 

* node --- the node itself. If it doesn't have an id, a unique id is generated for it.
* data --- the content of dndData member of the node. If it is missing, node.innerHTML is used instead.
* type --- the content of dndType member of the node split on "," character. If it is missing, ["text"] is used as the default type.
 
If the creator function was not specified, a default creator is used. The default creator does following things: 

* It creates a context-appropriate node:

  * If the container is <div> or <p>-based, it will create a <div> node. 
  * If the container is <ul> or <ol>-based, it will create a <li> node.
  * If the container is <table>-based, it will create a <tr><td> group of nodes node, and it will be inserted in <tbody>.
  * In all other contexts it will create a <span> node.
  * If the hint is "avatar" it will create a <span> node.
* If the date item is an object, it will test for the presence of "data" member. If it is present, it will be used as a data object. Otherwise the item itself will be used as a data object.
* If the date item is an object, it will test for the presence of "type" member. If it is present, it will be used as a type object. Otherwise ["text"] will be used as a type object.
* It will set a content of the node to String(data). You can override the toString() member function of your object to change how it is converted to the string. Or specify the creator function.
* As any creator it returns a triplet object with newly created/identified node, data, and type.

After the creator function was called the result is post-processed: 

* If the returned node doesn't have an id, the default unique id will be generated.
* The returned node will be assigned a "dojoDndItem" class.
* If the returned type is not an array or missing, it will be replaced with ["text"].
 
Following public methods are defined: 
getAllNodes() --- returns a NodeList of all controlled nodes in the order they are listed in the container.
insertNodes(data, before, anchor) --- inserts data items before/after the anchor node. It returns the container object itself for easy chaining of calls.
data --- an array of data items to be inserted. Each data item will be passed to the creator function, the result will be registered with the container, the node will be inserted according to "before" and "anchor" parameters.
before --- a boolean flag. If it is true, nodes will be added before the anchor, and after otherwise.
anchor --- a node to be used as a reference for the insertion. It should be an immediate child of the container node (or a child of <tbody> for the <table>-based node). If it is not specified, all items will be appended to the container node (or <tbody> for tables).
destroy() --- prepares the container object to be garbage-collected. You cannot use the container object after it was destroyed.

The container object defines following public member variables:
current --- a DOM node, which corresponds to a child with a mouse hovering over it. If there is no such item, this variable is null.
node --- the DOM node of the container. This node is used to set up mouse event handlers for the container.
parent --- the DOM node, which is an immediate parent of DnD item nodes. In most cases it is the same as node, but in some cases it can be node's descendant. Example: for tables node can point to <table>, while parent points to <tbody> (DnD item nodes are <tr> nodes). You can freely change parent to achieve the desired behavior of your container by specifying as "dropParent" parameter.
creator --- the creator function or null, if the default creator is used.
skipForm --- the flag propagated from the initial parameters.

The heart of the Container is the map member:
map --- a dictionary, which is keyed by node ids. Each registered child has an entry in the map by its node id (this is why all nodes should have unique ids). map[id] returns an object with two members:
data --- an associated data item.
type --- an associated array of types.

It is not recommended to access map directly. There are several utility functions to access it. They can be used to virtualize the map, and you can use them with dojo.connect() so you know when DnD items are added/removed/accessed and use it to customize the behavior:
getItem(id) --- returns an object with a dat and a type described above, which are associated with the node corresponding to that id.
setItem(id, obj) --- associates an object "obj" with this id. "obj" should define "data" and "type" member variables.
delItem(id) --- deletes a record of the node with this id. Warning: it does not delete the node from the container.
clearItems() --- delete all records. Warning: it does not delete nodes from the container.
forInItems(f, o) --- similar to dojo.forEach() but goes over all items in the map. The function "f" will be called in the context "o" for every item in the map with following parameters:
obj --- the corresponding object with data and type defined.
id --- the node id.
map --- the map object itself.

Following event processors are defined: onMouseOver, onMouseOut. Two pseudo-events are defined: onOverEvent, onOutEvent, which are cleaned up argument-less onMouseOver and onMouseOut events (otherwise they can be fired several times without actually leaving the container).

Following CSS classes are used by the container object:
dojoDndContainer --- assigned to each container node during the construction.
dojoDndContainerOver --- assigned when the mouse hovers over the container.
dojoDndItem --- assigned to every new data item node. It should be assigned to every item before the container construction, if you want it to be added automatically by the constructor.
dojoDndItemOver -- assigned to a data item node when the mouse hovers over the this item. This class is assigned in addition to dojoDndItem class.
Partial reason to add "over" states when the mouse hovers over instead of using CSS was to support it in IE too.
Selector

The default implementation of the selector is built on top of the container class and adds the ability to select children items. Selector inherits all Container's methods and objects. Additionally it adds a notion of an anchor. The anchor is used to specify a point of insertion of other items. The selector assumes that the container is organized in a linear fashion either vertically (e.g., embedded <div>s, lists, tables) or horizontally (e.g., <span>s). This assumption allows to implement familiar UI paradigms: selection of one element with a mouse click, selection of an additional element with ctrl+click, linear group selection from the anchor to the clicked element with shift+click, selecting an additional linear group from the anchor to the clicked element with shift+ctrl+click. Obviously if you have more complex containers, you should implement different UI actions.

Constructor takes the same two parameters as the container's constructor. It understands more optional parameters and passes the rest to the underlying container. Following optional parameters are understood by the selector object: 
singular --- a boolean flag. If it is true, the user is allowed to select just one item, otherwise any number of items can be selected. It is false by default.

Following public methods are defined in addition to the container public methods:
getSelectedNodes() --- returns a NodeList of selected nodes.
selectNone() --- remove the selection from all items. It returns the selector object itself for easy chaining of calls.
selectAll() --- selects all items. It returns the selector object itself for easy chaining of calls.
deleteSelectedNodes() --- deletes all selected nodes. It returns the selector object itself for easy chaining of calls.

Following public method is redefined with new signature:
insertNodes(addSelected, data, before, anchor) --- the last three parameters are the same (look up the same function in the container). The first parameter is a flag, if it is true all newly added items will be added to the selection, otherwise they will be added unselected.

The container object defines following public member variables:
selection --- a dictionary object keyed by ids of selected nodes. No useful payload is attached to objects in the dictionary.
anchor --- the current anchor node or null.
simpleSelection --- a flag to indicate that a singular selection is active.

Following event processors are defined: onMouseDown, onMouseUp. onMouseMove is attached by onOverEvent and detached by onOutEvent dynamically.

Following CSS classes are used by the selector object in addition to classes assigned the container object:
dojoDndItemSelected --- assigned if a data item is selected but it is not an anchor (the last selected element). This class is assigned in addition to dojoDndItem class.
dojoDndItemAnchor --- assigned to an anchor data item. At any given time the selector can have zero or one anchor. This class is assigned in addition to dojoDndItem class. Being an anchor means that this item is selected.
Source

The source object represents a source of items for drag-and-drop operations. It is used to represent DnD targets as well. In order to be compatible your custom sources should emulate the common source API. Instances of this class can be created from the HTML markup automatically by dojo.parser using dojoType="dojo.dnd.Source".

The default implementation of the source is built on top of the selector class, and adds the ability to start a DnD operation, and participate in the orchestration of the DnD. Source inherits all Selector's (and Container's) methods and objects. User can initiate the DnD operation by dragging items (click and move without releasing the mouse). The DnD operation can be used to rearrange items within a single source, or items can be moved or copied between two sources. User can select whether she wants to copy or move items by pressing the Ctrl button during the operation. If it is pressed, items will be copied, otherwise they will be moved. This behavior can be overwritten programmatically.
 
Constructor takes the same two parameters as the container's selector. It understands more optional parameters and passes the rest to the underlying selector. Following optional parameters are understood by the selector object:
isSource --- a Boolean flag. If it is true, this object can be used to start the DnD operation, otherwise it can serve only as a target. It is true by default.
accept --- an array of strings. It defines what types can be accepted by this object, when it is used as a target. The default is ["text"]. If the array is empty it means that this source cannot be a target.
horizontal --- a flag. If true, the source is based on the horizontally organized list container, otherwise it is based on the vertical one. he default is false.
copyOnly --- a flag. If true, the source doesn't allow to move items out of it, any DnD operation will copy items from such sources. By default it is false.
withHandles --- a flag. If it is true, an item can be dragged only by a predefined node inside the item, otherwise the whole item can be used for dragging. By default it is false. The handle should be a descendant of the item node and should be marked with class dojoDndHandle.

Following public methods are defined (they can be replace to change the DnD behavior):
checkAcceptance(source, nodes) --- returns true, if this object can accept items "nodes" from the "source". The default implementation checks item's types with accepted types of the object, and rejects the operation, if there is no full match. Such objects are marked as disabled targets and they do not participate in the current DnD operation. The source of items can always accept its items regardless of the match. It prevents the situation when user started to drag items and cannot find a suitable target, and cannot return them back. Please take it into consideration when replacing this method. This method is called on all potential targets before the DnD operation.
source --- the source object for the dragged items.
nodes --- a list of nodes 
copyState(keyPressed) --- returns true if the copy operation should be performed, the move will be performed otherwise. The default implementation checks the "copyOnly" parameter described above. If it is set, this method always returns true. This method can be replaced if you want to implement a more complex logic.
keyPressed --- a flag. If true, user pressed the "copy" key.

Following topic listeners are defined: onDndSourceOver, onDndStart, onDndDrop, onDndCancel. These topics are published by the manager. If you want to override topic listeners, please read "Summary of topics" section below.

Following event handlers are overloaded: onMouseDown, onMouseUp, and onMouseMove. They are used to perform additional actions required by the Source.

Following CSS classes are used by the source object in addition to classes assigned by the selector and the container objects:
dojoDndHorizontal --- assigned to the container node during the construction, if this object represents a horizontal list of dndItems --- its "horizontal" property set to true.
dojoDndSource --- assigned to the container node during the construction, if this object can be used as a source of DnD items --- its "isSource" property set to true.
dojoDndSourceCopied --- assigned to the container node during the active DnD operation when user copies items from it, e.g., pressed the Ctrl key while dragging. When this class is assigned to the node, dojoDndSource class is removed.
dojoDndSourceMoved --- assigned to the container node during the active DnD operation when user moves items from it, e.g., the Ctrl key is not pressed while dragging. When this class is assigned to the node, dojoDndSource class is removed.
dojoDndTarget --- assigned to the container node during the construction, if this object can potentially accept DnD items --- its "accept" list is not empty.
dojoDndTargetDisabled --- assigned to the container node during the active DnD operation when this node cannot accept currently dragged items, e.g., because it doesn't accept items of these types. When this class is assigned to the node, dojoDndTarget class is removed.
dojoDndItemBefore --- assigned to the data item node during the active DnD operation if transferred items will be inserted before this item. This class is assigned in addition to all other classes.
dojoDndItemAfter --- assigned to the data item node during the active DnD operation if transferred items will be inserted after this item. This class is assigned in addition to all other classes.
dojoDndHandle --- assigned to handles of item nodes. See the withHandles parameter of Source above.

dojoDndSource, dojoDndSourceCopied, and dojoDndSourceMoved are mutually exclusive. dojoDndTarget, and dojoDndTargetDisabled are mutually exclusive. dojoDndSourceCopied, dojoDndSourceMoved, dojoDndTargetDisabled, dojoDndItemBefore, and dojoDndItemAfter can be assigned only during the active Dnd operation. See the manager's classes below to see what additional classes can be used for custom styling. Use dojoDndHorizontal with dojoDndItemBefore and dojoDndItemAfter to create visually appropriate insertion markers for horizontal (before, after) and vertical (above, below) containers.
Target

Essentially it is the source class wrapped in with isSource set to false. Instances of this class can be created from the HTML markup automatically by dojo.parser using dojoType="dojo.dnd.Target".
Avatar

Avatar is a class for an object that represents dragged items during DnD operations. You can replace it or style it if you need to customize the look of DnD.

Following methods should be implemented:
constructor(manager) --- the constructor of the class takes a single parameter --- the instance of Manager (see below), which is used to reflect the state of the DnD operation in progress visually. The constructor is called (and the avatar object is created) only when the manager decided to start a DnD operation.
destroy() --- this method is called when the DnD operation is finished, the avatar is unneeded, and is about to be recycled.
update() --- this method is called, when the state of the manager changes. It is used to reflect manager's changes visually.

The default implementation of the Avatar class does following:
It creates an absolutely positioned table of up to 6 rows.
The first row (the header) is populated with a text generated by _generateText() method. By default it returns the number of transferred items. You can override this method for localization purposes, or to change the text how you like it.
Next rows are populated with DOM nodes generated by the creator function of the current source with hint "avatar" (see above the description of the creator function) for data items. Up to 5 rows are populated with decreasing opacity.

Following CSS classes are used to style the avatar:
dojoDndAvatar --- assigned to the avatar (the table).
dojoDndAvatarHeader --- assigned to the first row (the header).
dojoDndAvatarItem --- assigned to the avatar item rows.
dojoDndAvatarCanDrop --- added to the avatar (the table) when the mouse is over a target, which can accept transferred items. Otherwise it is removed.
Manager

Manager is a small class, which implements a business logic of DnD and orchestrates the visualization of this process. It accepts events from sources/targets, creates the avatar, and checks the validity of the drop.

At any given moment there is only one instance of this class (the singleton pattern), which can be accessed by dojo.dnd.manager() function.

This class or its instance can be monkey patched or replaced completely, if you want to change its functionality.

Following public methods are defined to be called by sources:
startDrag(source, nodes, copy) --- starts the DnD operations using the supplied source, DOM nodes (their ids will be used by the avatar and future targets), and a copy flag (true for copy, and false for move). The parameters are copied as public member variables of the manager with the same names. This method creates the avatar by calling this.makeAvatar() and assigning it to the "avatar" public member.
stopDrag() --- resets the DnD operation by resetting all public members. It is not enough to call this method to abort the DnD. Before calling it you should publish dnd/cancel topic (or dnd/drop, if you forcing the drop). See more information on topics below.
canDrop(flag) --- called by the current target to notify that it can accept the DnD items, if flag is true. Otherwise it refuses to accept them.

Following methods deal with the avatar and can be replaced, if you want something different:
makeAvatar() --- returns the avatar's node. By default it creates an instance of dojo.dnd.Avatar passing itself as a parameter.
updateAvatar() --- updates avatar to reflect changes in the current DnD operation, e.g., copy vs. move, cannot drop at this point.

If you want to use a custom avatar, you can override these methods to do whatever you like.

Following public properties are defined on the manager (can be overwritten if desired):
OFFSET_X --- the horizontal offset in pixels between the mouse pointer position and the left edge of the avatar.
OFFSET_Y --- the vertical offset in pixels between the mouse pointer position and the top edge of the avatar.

Following public properties are used by the manager during the active DnD operation:
source --- the source of DnD items.
nodes --- the list of transferred DnD items.
copy --- Boolean value to track the copy/move status.
target --- the selected target of the drop.

Following topic events can be generated by the manager:
/dnd/start --- when DnD starts. Current source, nodes, and the copy flag (see startDrag() for more info) are passed as parameters of this event.
/dnd/source/over --- when the mouse moves over a source. The source in question is passed as a parameter. The same event is raised when the mouse goes out of a source. In this case null is passed as a parameter.
/dnd/drop/before --- raised just before the drop. It can be used to capture the drop parameters. Parameters are the same as for /dnd/start, but reflect current values.
/dnd/drop --- raised to perform a drop. Parameters are the same as for /dnd/start. Note that during the processing of this event nodes can be already moved, or reused. If you need the original nodes, use /dnd/drop/before to capture them.
/dnd/cancel --- when DndD was cancelled either by user (by hitting Esc), or by dropping items in illegal location.

Following events are processed by the manager to the body: onMouseMove, onMouseUp, onKeyDown, onKeyUp. These events are attached only during the active DnD operation. Following keys have a special meaning for the manager:
Ctrl key --- when it is pressed the copy semantics is assumed. Otherwise the move is assumed.
Esc key --- when it is pressed the DnD operation is immediately cancelled.

Following CSS classes are used by the manager to style the DnD operation:
dojoDndCopy --- assigned to the body during the copy DnD operations.
dojoDndMove --- assigned to the body during the move DnD operations.

No styles are assigned when there is no DnD in progress.
dojo.dnd.move principals

The DnD move consists of two principal classes and several specific implementations.
Moveable

Moveable is the main class, which is used to give the "moveable" property to a DOM node. Instances of this class can be created from the HTML markup automatically by dojo.parser using dojoType="dojo.dnd.Moveable".

The constructor accepts following parameters:
node --- a DOM node or an id (string) of such node. This node will be made moveable. "Relative" and "absolute" nodes can be moved. Their "left" and "top" are assumed to be in pixels. All other nodes are converted to "absolute" nodes on the first drag.
params --- a dictionary object, which defines optional parameters. Following optional parameters are recognized:
handle --- the node (or its id), which will be used as a drag handle. It should be a descendant of the node. If it is null (the default), the node itself is used for dragging.
delay --- a number in pixels. When user started the drag we should wait for "delay" pixels before starting dragging the node. It is used to prevent accidental drags. The default is 0.
skip --- a Boolean flag, which indicates that we should skip form elements when initiating drags, it is it true. Otherwise we drag the node no matter what. This parameter is used when we want to drag a form, but keep form elements usable, e.g., we can still select text in a text node. The default is false. When working with draggable form, the better usability-wise alternative to skip=true is to define a drag handle instead.
mover --- the class to be used to create a mover (see Mover).

Following public members are available:
node --- the node to be dragged.

Following public methods are defined:
destroy() --- should be call, when you want to remove the "moveable" behavior form the node.

Following public methods/events are defined (they can be used with dojo.connect() or overwritten):
onMoveStart --- called when the move is about to start. The parameter is a mover object (see below) for the current move.
onFirstMove --- called once after processing the first onmousemove event. It uses the same parameters as onMoveStart above.
onMove --- called on every update of node's position. Parameters:
mover --- a mover object (see below) for the current move.
leftTop --- an object which defines the new left and top position of the object by its subobjects "l" and "t" respectively. Both of them are numbers in pixels.
onMoving --- called by the default implementation of onMove() method before updating the node's position. It uses the same parameters as onMove above. You can update leftTop parameter to whatever you want.
onMoved --- called by the default implementation of onMove() method after updating the node's position. It uses the same parameters as onMove above.
onMoveStop --- called when move is finished. It uses the same parameters as onMoveStart above.

The most important methods are onFirstMove() and onMove(). The former can be used to set up some initial parameters for the move, and possibly update some DOM nodes. The latter implements the move itself. By overriding these two methods you can implement a variety of click-drag-release operations, e.g., a resize operation, a draw operation, and so on.

Following mouse event handlers are set up:
onMouseDown
onMouseMove --- can be set up by onMouseDown when executing the non-zero delay.
onMouseUp --- can be set up by onMouseDown to cancel the drag while processing the non-zero delay.

Additionally ondragselect and onselectstart events are cancelled by onSelectStart() method.

Following topic events are raised by Moveable:
/dnd/move/start --- published by the default implementation of onMoveStart() passing a mover as a parameter.
/dnd/move/stop --- published by the default implementation of onMoveStop() passing a mover as a parameter.

Following CSS classes are used by the moveable:
dojoMove --- assigned to the body when the drag is in progress.
dojoMoveItem --- assigned to the dragged node when the drag is in progress.
Mover

Mover is a utility class, which actually handles events to move the node. Instances of this class exist only when the drag is in progress. In some cases you can use it directly.

The constructor accepts following parameters:
node --- a DOM node or an id (string) of such node. This node will be moved.
e --- a mouse event, which actually indicated the start of the move. It is used to extract the coordinates of the mouse using pageX and pageY properties.
host --- a host object, which will be called by the mover during the move. It should define at least two methods: onFirstMove(), and onMove, and possibly two optional methods: onMoveStart() and onMoveStop(). See Moveable for details.

Following public members are available:
node --- the node being dragged.
mouseButton --- a mouse button, which was pressed when starting the drag.
marginBox --- an object with two integer members: "l" and "t". It is initialized by the constructor, updated by the onFirstMove() method on the mover and used later on to add to the mouse coordinates before passing them to moveable's onMove() as leftTop.

Following public methods are defined:
destroy() --- should be call, when you want to stop the move.
onFirstMove() --- called once to finish setting up the marginBox property.

Following mouse event handlers are set up: onMouseMove, onMouseUp. Additionally ondragselect and onselectstart events are cancelled.
Specialized Moveables

Following specialized moveable classes are defined:
dojo.dnd.move.constrainedMoveable --- can be used to constrained a move to a dynamically calculated box. This class is define in the dojo.dnd.move module. It is based on Moveable, and accepts following additional parameters during construction:
constraints --- a function, which is called in the context of this moveable, with a newly created mover object, and returns a rectangle to be used for restrictions. The rectangle is an object, which defines following numeric members: "l" for left, "t" for top, "w" for width, and "h" for height. All numbers are in pixels.
within --- a Boolean flag. When it is true, the dragged node will be moved only within the defined rectangle, and cannot go outside of it. Otherwise, the restriction applies to the left-top corner of the dragged node.
dojo.dnd.move.boxConstrainedMoveable --- can be used to constrain a move to a predefined box. This class is define in the dojo.dnd.move module. It is based on constrainedMoveable and accepts following additional parameters during construction:
box --- a rectangle box (see above), which defines constraint boundaries.
constraints --- this parameter is automatically defined, do not define it yourself.
within --- see above for details.
dojo.dnd.move.parentConstrainedMoveable --- can be used to constrain the move by the boundaries of the node's parent. This class is define in the dojo.dnd.move module. It is based on constrainedMoveable and accepts following additional parameters during construction:
area --- a string, which defines constraint boundaries. Valid values are: "content", "padding", "border", and "margin".
constraints --- this parameter is automatically defined, do not define it yourself.
within --- see above for details.
dojo.dnd.TimedMoveable --- can be used to throttle FPS while moving nodes. It is based on Moveable, and accepts following additional parameters during construction:
timeout --- the time delay number in milliseconds. The node will not be moved for that number of milliseconds, but it will continue to accumulate changes in the mouse position.
Subclassing DnD classes

If you want to subclass dojo.dnd.Container, dojo.dnd.Selector, dojo.dnd.Source, dojo.dnd.Moveable, or their descendants, and you want to use the declarative markup, don't forget to implement the markupFactory() method. The reason for that is dojo.parser, which instantiates the markup, expects a very particular signature from a constructor. Dojo DnD classes predate dojo.parser, and have a non-conformant signature. dojo.parser is smart enough to use a special adapter function in such cases. See the source code for dojo.dnd.Source.markupFactory() (for the Container-Selector-Source chain), and dojo.dnd.Moveable.markupFactory() for details. The key point is to return the instance of your new class there. Otherwise the instance of your base class is going to be created, which is probably not what you want.
Summary of CSS classes

All DnD-related classes can affect 6 types of DOM nodes. All of them are collected in this section for your convenience. Using CSS classes described here you can design extremely sophisticated UI to improve usability and enhance the workflow of your applications.
body

The body node is updated only during active DnD operations. It can be used during the move to deemphasize temporarily the web page and to highlight available targets or a dragged object.

Following CSS classes are used:
dojoDndCopy --- assigned to the body during the copy DnD operations (dojo.dnd).
dojoDndMove --- assigned to the body during the move DnD operations (dojo.dnd).
dojoMove --- assigned to the body when the drag is in progress (dojo.dnd.move).
Source/target (dojo.dnd)

Source can be assigned several classes to reflect its current role. These classes can be used together with the body CSS classes described above to create CSS rules to differentiate containers visually during drags.

Following CSS classes are used:
dojoDndContainer --- assigned to each container node during the construction.
dojoDndContainerOver --- assigned when the mouse hovers over the container.
dojoDndHorizontal --- assigned to the container node during the construction, if this object represents a horizontal list of dndItems --- its "horizontal" property set to true.
dojoDndSource --- assigned to the container node during the construction, if this object can be used as a source of DnD items --- its "isSource" property set to true.
dojoDndSourceCopied --- assigned to the container node during the active DnD operation when user copies items from it, e.g., pressed the Ctrl key while dragging. When this class is assigned to the node, dojoDndSource class is removed.
dojoDndSourceMoved --- assigned to the container node during the active DnD operation when user moves items from it, e.g., the Ctrl key is not pressed while dragging. When this class is assigned to the node, dojoDndSource class is removed.
dojoDndTarget --- assigned to the container node during the construction, if this object can potentially accept DnD items --- its "accept" list is not empty.
dojoDndTargetDisabled --- assigned to the container node during the active DnD operation when this node cannot accept currently dragged items, e.g., because it doesn't accept items of these types. When this class is assigned to the node, dojoDndTarget class is removed.
DnD item (dojo.dnd)

DnD items can be assigned several classes to reflect their current role visually.

Following CSS classes are used:
dojoDndItem --- assigned to every new data item node. It should be assigned to every item before the container construction, if you want it to be added automatically by the constructor.
dojoDndItemOver -- assigned to a data item node when the mouse hovers over the this item. This class is assigned in addition to dojoDndItem class.
dojoDndItemSelected --- assigned if a data item is selected but it is not an anchor (the last selected element). This class is assigned in addition to dojoDndItem class.
dojoDndItemAnchor --- assigned to an anchor data item. At any given time the selector can have zero or one anchor. This class is assigned in addition to dojoDndItem class. Being an anchor means that this item is selected.
dojoDndItemBefore --- assigned to the data item node during the active DnD operation if transferred items will be inserted before this item. This class is assigned in addition to all other classes.
dojoDndItemAfter --- assigned to the data item node during the active DnD operation if transferred items will be inserted after this item. This class is assigned in addition to all other classes.
DnD handles (dojo.dnd)

DnD items can defined special handles on their descendants, which can be used for dragging. In this case the body of the DnD item cannot be used to start the drag.

Following CSS classes are used:
dojoDndHandle --- assigned to handles of item nodes. See the withHandles parameter of Source above.
Avatar (dojo.dnd)

The default avatar can be styled to suit your needs.

Following CSS classes are used:
dojoDndAvatar --- assigned to the avatar node (the table).
dojoDndAvatarHeader --- assigned to the first row/the header (the first tr node).
dojoDndAvatarItem --- assigned to the avatar item rows (tr nodes excluding the very first one).
dojoDndAvatarCanDrop --- added to the avatar node (the table) when the mouse is over a target, which can accept transferred items. Otherwise it is removed.
Dragged node (dojo.dnd.move)

The dragged node can be specially styled while in move.

Following CSS classes are used:
dojoMoveItem --- assigned to the dragged node when the drag is in progress.
Summary of topics

While local events are the preferred way to handle state changes, in some cases topics (named global events) can simplify an application.

Following topic events can be generated by dojo.dnd.Manager:
/dnd/start --- when DnD starts. Current source, nodes, and the copy flag (see Manager.startDrag() for more info) are passed as parameters of this event.
/dnd/source/over --- when the mouse moves over a source. The source in question is passed as a parameter. The same event is raised when the mouse goes out of a source. In this case null is passed as a parameter.
/dnd/drop/before --- raised just before the drop. It can be used to capture the drop parameters. Parameters are the same as for /dnd/drop, but reflect current values.
/dnd/drop --- raised to perform a drop. The first three parameters are the same as for /dnd/start. The fourth parameter is the target object. Note that during the processing of this event nodes can be already moved, or reused. If you need the original nodes, use /dnd/drop/before to capture them.
/dnd/cancel --- when DnD was cancelled either by user (by hitting Esc), or by dropping items in illegal location.

All sources subscribe to dojo.dnd.Manager's topics. Some users fail to understand that if they override, say, onDndDrop() method, which is a /dnd/drop topic listener, it will be called every time /dnd/drop is signaled. It means it will be notified even if your source was not a part of the DnD exchange --- it wasn't a source for the items, and it is not a target of the drop. If you subclass dojo.dnd.Source and override onDndDrop(), your new method will be called for every instance of your class. Do not despair --- it is very easy to filter out unneeded cases. Just use the manager to see what objects are involved.

Following topic events are raised by dojo.dnd.Moveable:
/dnd/move/start --- published by the default implementation of Moveable.onMoveStart() passing a mover as parameter.
/dnd/move/stop --- published by the default implementation of Moveable.onMoveStop() passing a mover as parameter.
Available tests

All tests are located in the dojo/tests/dnd/ sub-directory. They are used by developers to test the conformance, and can be used by users to see how different objects and algorithms can be used. Following tests are available:
test_dnd.html tests general DnD operations including the markup and programmatic creation, pure targets, a special representation of DnD items in the avatar, styling of different objects, complex selection of items, and topics.
test_container.html tests the default creator function with different types of containers created programmatically.
test_container_markup.html tests the default creator function with different types of containers created with the markup.
test_selector.html tests the default creator function with different types of containers created programmatically.
test_selector_markup.html tests the default creator function with different types of containers created with the markup.
test_dnd_handles.html tests DnD handles. All objects are created with the markup.
test_form.html tests skipping form elements.
test_moveable.html tests moveable nodes declared moveable programmatically. Additionally it tests topics.
test_moveable_markup.html tests moveable nodes declared moveable by the markup. Additionally it tests topics.
test_params.html tests delay and skip parameters.
test_box_constraints.html tests dojo.dnd.move.boxConstrainedMoveable using programmatic and markup methods.
test_parent_constraints.html tests dojo.dnd.move.parentConstrainedMoveable with all "area" values.
test_parent_constraints_margins.html tests dojo.dnd.move.parentConstrainedMoveable with all "within" values.
test_custom_constraints.html tests dojo.dnd.move.constrainedMoveable implementing the "grid move" pattern.
test_timed_moveable.html tests dojo.dnd.TimedMoveable with different timeout values.
flickr_viewer.html implements an elaborate demo, which retrieves pictures of three types from Flickr, and allows to sort them into two bins according to their types. It demonstrates many techniques including horizontal vs. vertical containers, different representation of data items in different containers and in the avatar, and so on.

The same directory contains a simple CSS file, which shows how you can style the DnD objects: dndDefault.css. You can see it in action in almost all tests. It can be used as a starting point for your own styling.

Deze pagina bewerken (als u toestemming heeft) | Google Documenten - Online tekstverwerking, presentaties en spreadsheets.
 
