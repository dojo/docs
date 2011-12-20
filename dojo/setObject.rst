.. _dojo/setObject:

==============
dojo.setObject
==============

:since: V?

.. contents ::
   :depth: 2

Set a property from a dot-separated string, such as "A.B.C".


Usage
=====

In javascript, a dot separated string like obj.parent.child refers to an item called child inside an object called parent inside of obj.

setObject will let you set the value of child, creating the intermediate parent object(s) if they don't exist.

Without `dojo.setObject`, we often see code like this:

.. js ::

  // ensure that intermediate objects are available
  if(!obj["parent"]){ obj.parent ={}; }
  if(!obj.parent["child"]){ obj.parent.child={}; }
  
  // now we can safely set the property
  obj.parent.child.prop = "some value";


Wheras with `dojo.setObject`, we can shorten that to:

.. js ::

  // Dojo 1.7 (AMD)
  require(["dojo/_base/lang"], function(lang){
    lang.setObject("parent.child.prop", "some value", obj);
  });
  // Dojo < 1.7
  dojo.setObject("parent.child.prop", "some value", obj);


Examples
========

.. code-example ::

  .. js ::

            dojo.require("dijit.form.Button");

            // This object is initially empty, and we'll use setObject to populate it
            var obj = {};
            console.log("in head");

  .. html ::

        <p>Click button to insert nested value into obj</p>
        <button data-dojo-type="dijit.form.Button">
            <script type="dojo/method" data-dojo-event="onClick">
                dojo.setObject('x.y.z', "hi!", obj);
                 dojo.byId('resultDiv').innerHTML = dojo.toJson(obj, true);
            </script>
            x.y.z
        </button>
        <button data-dojo-type="dijit.form.Button">
            <script type="dojo/method" data-dojo-event="onClick">
                dojo.setObject('p.d.q', "world!", obj);
                 dojo.byId('resultDiv').innerHTML = dojo.toJson(obj, true);
            </script>
            p.d.q
        </button>

        <p>Obj:</p>
        <div id="resultDiv" class="style1">
            {}
        </div>


See also
========

* :ref:`dojo.exists <dojo/exists>`
* :ref:`dojo.getObject <dojo/getObject>`
