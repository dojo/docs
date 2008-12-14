#format dojo_rst

dojo.setObject
==============

:Status: Draft
:Version: 1.0
:Available: since V?

.. contents::
   :depth: 2

Set a property from a dot-separated string, such as "A.B.C".


=====
Usage
=====

In javascript, a dot separated string like A.B.C refers to an item called C inside an object called B which is itself inside an object called A.

setObject will let you set the value of C, creating the intermediate A and B objects if they don't exist.

Without `dojo.setObject`, we often see code like this:

.. code-block:: javascript

  // ensure that intermediate objects are available
  if(!obj["parent"]){ obj.parent = {}; }
  if(!obj.parent["child"]){ obj.parent.child= {}; }
  
  // now we can safely set the property
  obj.parent.child.prop = "some value";


Wheras with `dojo.setObject`, we can shorten that to:

.. code-block:: javascript

  dojo.setObject("parent.child.prop", "some value", obj);


========
Examples
========

.. cv-compound::

  .. cv:: javascript
        <script>
            dojo.require("dijit.form.Button");

            // This object is initially empty, and we'll use setObject to populate it
            var obj = {};
        </script>

  .. cv:: html

        <button dojoType="dijit.form.Button">
            <script type="dojo/method" event="onClick">
                dojo.setObject('x.y.z', obj);
                 dojo.byId('resultDiv').innerHTML = dojo.toJson(obj, true);
            </script>
            x.y.z
        </button>

        <p>Obj:</p>
        <div id="resultDiv" class="style1">
            {}
        </div>


========
See also
========

* dojo.exists_
* dojo.getObject_
