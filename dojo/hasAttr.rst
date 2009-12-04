#format dojo_rst

dojo.hasAttr
============

:Status: Final
:Version: 1.0
:Available: since 1.2

.. contents::
   :depth: 2

Checks a node for the presence of an attribute.


============
Introduction
============

``dojo.hasAttr()`` is a companion function for `dojo.attr <dojo/attr>`_. It checks if an attribute is present on a DOM node, and returns the truthy value if it is there, and falsy value otherwise. It doesn't check if there is a property with such name, so be careful, when using it.


=====
Usage
=====

.. code-block :: javascript
 :linenos:

 result = dojo.hasAttr(node, attr);

node
  id or reference of the DOM node to get/set style for

attr
  the attribute property name.

result
  truthy, if the attribute is present, falsy otherwise


========
Examples
========

Testing for attributes
----------------------

The following example will check for several attributes.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      function checkAttributes(){
        var node = dojo.query("[name=hasId]")[0];
        var hasId = dojo.hasAttr(node, "id");
        dojo.attr(node, "checked", hasId);
        dojo.style(node.parentNode, "display", "");
      }
    </script>

  .. cv:: html

    <p><button dojoType="dijit.form.Button" id="buttonOne" onClick="checkAttributes();">Check attributes</button></p>
    <p style="display: none;"><input type="checkbox" name="hasId" disabled="disabled"> has id</p>

========
See also
========

* `dojo.attr <dojo/attr>`_
* `dojo.removeAttr <dojo/removeAttr>`_
* `dojo.getNodeProp <dojo/getNodeProp>`_
* `NodeList.attr <NodeList/attr>`_
* `dojo.style <dojo/style>`_
* `DOM Attributes and The Dojo Toolkit 1.2 <http://www.sitepen.com/blog/2008/10/23/dom-attributes-and-the-dojo-toolkit-12/>`_
