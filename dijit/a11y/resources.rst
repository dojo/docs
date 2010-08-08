## page was renamed from dijit-a11y-resources
#format dojo_rst

Dijit Accessibility Resources
=============================

:Author: Becky Gibson

.. contents::
  :depth: 3

Functions for dealing with accessibility are found in dijit._base.wai.js. The name of the file is derived from the `W3C Web Accessibility Initiative <http://www.w3.org/WAI/>`_ which is hosting the `ARIA <http://www.w3.org/WAI/PF/aria/>`_ specification. The dijit wai APIs are used to manipulate ARIA roles and properties. In addition, the onload function to detect high contrast mode is part of dijit.wai.

The dijit wai module is provided to normalize setting the roles and states. The ARIA properties are designed to be used with XHTML via namespaces Since a content-type of application/xhtml+xml is required to fully support namespaces an alternate solution is needed for the most commonly supported content-type of text/html. In Firefox 2, the roles are set by prefixing the role value with "wairole". In other browsers, no prefix is required. In Firefox 2, states can be manipulated using the DOM namespace apis: getAttributeNS, setAttributeNS, and removeAttributeNS. In other browsers, the generic attribute apis, getAttribute, setAttribute, removeAttribute, are used and the property name is prefixed by "aria-" such as "aria-expanded". The dijit methods for manipulating roles and properties perform the browser detection and make the correct calls. The developer needs to provide only the role or property name and value.

In addition to ARIA roles, a set of navigation roles from the `XHTML Role Attribute Module <http://www.w3.org/TR/2007/WD-xhtml-role-20071004/>`_ are also supported. An element may have a navigation role in addition to an ARIA role. The dijit methods for interacting with roles, only affect ARIA roles, any navigation roles are not modified.

There are separate dijit methods for querying, getting, setting, and removing ARIA roles and states.

Role APIs in Dojo 1.2
---------------------

The role apis were modified in 1.2 to affect only ARIA roles and not any navigation role that may have already been defined on the object. Some of the methods now take an additional parameter but are still compatible with the 1.1 behavior.

The XHTML navigation roles are

- banner
- contentinfo 
- definition
- main
- navigation
- search
- note
- secondary
- seealso

These are NOT WAI roles and are thus ignored by the dijit getWaiRole and setWaiRole apis.

.. code-block :: javascript

  dijit.hasWaiRole(/*Element*/ elem, /*String*/ role)

If the role parameter is provided, returns true if elem has the specified role and false if not. For backwards compatibility with 1.1, if the role parameter is not provided, returns true if any role value exists on elem.

.. code-block :: javascript

  dijit.getWaiRole(/*Element*/ elem)

Returns any role set on elem which is NOT an XHTML Navigation role or an empty string if no role attribute has been set on elem.

.. code-block :: javascript

  dijit.setWaiRole(/*Element*/ elem, /*String*/ role)

Set the provided role on elem. If the current browser is Firefox and the version is prior to release 3,  replace any existing role(s) with "wiarole:" prepended to the role provided. In other browsers, if the element already has an existing WAI role, replace it with the role provided and maintain any existing XHTML Navigation roles.

.. code-block :: javascript

  dijit.removeWaiRole(/*Element*/ elem, /*String*/ role)

Remove the specified role from elem. For backwards compatibility with 1.1, if no role parameter is provided, remove the entire role attribute from elem.

State APIs in Dojo 1.2
----------------------

These dijit methods set the state values onto an element. In Firefox versions previous to 3 the attributes are set in the "http://www.w3.org/2005/07/aaa" namespace using the getAttritbuteNS() and setAttrbuteNS() apis. In other browsers "aria-" is added to the front of the state name and the setAttribute() and setAttribute() apis are used. The state parameter must be a valid ARIA state name and the value the appropriate value for the specified state.

.. code-block :: javascript

  dijit.hasWaiState(/*Element*/ elem, /*String*/ state)

Returns true if elem has the specified state, false if not.

.. code-block :: javascript

  dijit.getWaiState(/*Element*/ elem, /*String*/ state)

Returns the value of state set on elem or the empty string if elem has no state set. 

.. code-block :: javascript

  dijit.setWaiState(/*Element*/ elem, /*String*/ state, /*String*/ value)

Sets the specified state and value on elem.

.. code-block :: javascript

  dijit.removeWaiState(/*Element*/ elem, /*String*/ state)

Remove the specified state from elem. 

Examples of setting role and state
----------------------------------

The following will set a role of treeitem onto a DOM node:

.. code-block :: javascript

  dijit.setWaiRole( domNode, “treeitem”);


This example sets the state of the treeitem to expanded:

.. code-block :: javascript

  dijit.setWaiState( focusNode, “expanded”, “true”);

This example removes the valuenow property from an indeterminate progress bar.

.. code-block :: javascript

  dijit.removeWaiState(internalProgress, "valuenow");

Setting Role and State in the Widget Template
---------------------------------------------

The role and state can also be set via the widget template using the waiRole or waiState prefix. Setting the role in the template is the same as setting it via scripting – the dijit.setWaiRole() method will be called during widget instantiation. Simply add the waiRole=”actualrole” or waiState=”state-value” parameters into the template markup for the element. The element will be passed as the nodeObj into the dijit.setWaiRole() and dijit.setWaiState() methods. The state is specified as a state name and value pair, the state is separated from the value using the hyphen character (-): state-value. Multiple states can be set within the template by separating the state-value pairs with a comma. This mechanism is useful when templates are used to create the objects requiring a role value and when the state is known at creation time.

Here is an example of setting the role in the diijt tree template. The domNode is given the “tree” role.

.. code-block :: javascript

  <div class="dijitTreeContainer" style="" waiRole="tree" 
    dojoAttachEvent="onclick:_onClick,onkeypress:_onKeyPress"></div>

The role or state can also be specified via variables. This example shows an excerpt from the dijit button template that sets the role and state on the button element.

.. code-block :: javascript

  <div class="dijit dijitLeft dijitInline dijitButton"
    dojoAttachEvent="onclick:_onButtonClick,onmouseenter:_onMouse,onmouseleave:_onMouse,onmousedown:_onMouse">
    <div class='dijitRight'>
      <button class="dijitStretch dijitButtonNode dijitButtonContents" dojoAttachPoint="focusNode,titleNode"
        type="${type}" waiRole="button" waiState="labelledby-${id}_label">
        <span class="dijitInline ${iconClass}" dojoAttachPoint="iconNode">
          <span class="dijitToggleButtonIconChar">&#10003</span>
        </span>
        <span class="dijitButtonText" id="${id}_label" dojoAttachPoint="containerNode">${label}</span>
      </button>
    </div>
  </div>

High Contrast Mode Detection
----------------------------

As discussed in the `Dijit A11y Strategy <dijit/a11y/strategy>`_ section, dijit performs a check to determine if high contrast mode or images off mode has been set in the browser. When this mode is detected the dijit-a11y class is set onto the body element of the page. Approprite dijit-a11y classes have been defined that make appropriate text alternatives visible for any CSS background images (which are no longer visible when high contrast mode has been set) that have been used within the widgets.

.. code-block :: javascript

  dijit.wai.onload()

This is meant to be called once before the widgets have rendered to detect high contrast mode and set the dijit-a11y className onto the body element of the page. The detection mechanism is to create a temporary div with a background image, set top and bottom borders in one color and left and right borders in another color, and move it offscreen via CSS. Add the div to the body element and check the computed style of the div. If the colors for the top and right borders are computed as the same, then high contrast mode has been set. Also, in Firefox, images off mode can be determined by examining the value of the background image. Currently images off can not be detected in IE unless high contrast mode has also been set. 
