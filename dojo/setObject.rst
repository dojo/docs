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

In javascript, a dot separated string like obj.parent.child refers to an item called child inside an object called parent inside of obj.

setObject will let you set the value of child, creating the intermediate parent object(s) if they don't exist.

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
            console.log("in head");
        </script>

  .. cv:: html

        <p>Click button to insert nested value into obj</p>
        <button dojoType="dijit.form.Button">
            <script type="dojo/method" event="onClick">
                dojo.setObject('x.y.z', "hi!", obj);
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
