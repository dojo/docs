#format dojo_rst

dojo.rpc.RpcService
===================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

============
Introduction
============

``dojo.rpc.RpcService`` is the base class for RPC services. Currently it uses SMD v.1 descriptors, it will eventually be replaced by `dojox.rpc.Service <dojox/rpc/Service>`_ which uses SMD v.2 as described on the `SMD proposal document <http://groups.google.com/group/json-schema/web/service-mapping-description-proposal>`_.

This class provide SMD v.1 parsing facilities as well as all hooks to implement RPC services.

Dojo ships in with a `JSON RPC Service <dojo/rpc/JsonService>`_ and a `JSONP RPC Service <dojo/rpc/JsonpService>`_.


=====
Usage
=====

.. code-block :: javascript
 :linenos:

  <script type="text/javascript">
    var svc = new dojo.rpc.[ImplementingClass](args)

    var methodDeferred = svc.declaredMethod(declaredArg);
    methodDeferred.addCallback(handlerFunc);
  </script>


============== ================= =======================================
Parameter      Type              Description
============== ================= =======================================
``args``       Object|String|URL If ``args`` is a String or an URL, its location is fetched and treated as JSON describing the SMD. If it is an object and contains a ``smdStr`` property, it is passed to ``eval`` to get the SMD, otherwise we assume that it is an SMD object.
============== ================= =======================================

==========
SMD format
==========

Here is an example SMD v.1 as expected by ``dojo.rpc``.

.. code-block :: javascript
 :linenos:

  <script type="text/javascript">
    var smd = {
      serviceUrl: 'myService.do', // Adress of the RPC service end point
      timeout: 1000, // Only used if an object is passed to the constructor (!)
      // Only used if an object is passed to the constructor (!)
      // if true, parameter count of each method will be checked against the
      // length of its description's 'parameters' attribute
      strictArgChecks: true,
      // Methods descriptions
      methods: [
         name: 'add',
         // Array of parameters
         // Currently, only its size is used, name & type
         // are ignored
         parameters: [
           {
             name: 'p1',
             type: 'INTEGER'
           },
           {
             name: 'p2',
             type: 'INTEGER'
           }
         ]
      ]
    };
  </script>


This SMD describes a single method, ``add``, with two parameters. If ``add`` is called with less than two parameters, an error is thrown. The way method name and parameters are transmitted to the end point depends on the service type

===================
Creating subclasses
===================

TODO

========
See also
========

* `dojo.rpc <dojo/rpc>`_
* `dojox.rpc <dojox/rpc>`_
