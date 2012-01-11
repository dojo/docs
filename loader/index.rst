.. _loader/index:

===============
The Dojo Loader
===============

:Author: Rawld Gill


Since program complexity tends to increase geometrically as program size increases linearly, the only hope of success when
implementing a large program is to break it into several small programs. From the beginning, the Dojo Toolkit was
designed for use when building large programs which is why Dojo was among the first libraries to include a formal module
system.

The idea of a module system is fairly straight-forward:

  * define an API to use when defining modules

  * construct a loader that implements the API so that modules can be assembled into a complete program at run-time

With these two blocks in place, large JavaScript programs can be divided into many--perhaps hundreds--of small modules,
thereby greatly simplifying program construction. Indeed, the Dojo Toolkit itself is expressed in terms of many smallish
JavaScript resources.

Since each individual resource implies an HTTP transaction to download that resource, bandwidth and latency constraints
can result in sluggish loading performance. Fortunately, this problem is easy to fix. Once the program is constructed,
the modules can be analyzed by a program and aggregated so that only few resources are actually downloaded, with each of
those resources containing several logical modules. Typically, this step occurs when moving from development to
deployment.

Dojo was among the first JavaScript libraries to define a module API and publish a loader and build application to solve
all of these problems. The original API included the functions ``dojo.require`` (request a module), ``dojo.provide``
(define a module), and other supporting functions. This API is now termed the "legacy API".

Since early 2010, there has been a renewed interest in improving JavaScript modules systems. A single API has
emerged: `the Asynchronous Module Definition (AMD) API <https://github.com/amdjs/amdjs-api/wiki/AMD>`_ ("AMD API"). This
API has seen dramatic uptake over 2011 and has become the de facto standard for constructing client-side
JavaScript modules. While keeping the promise of backward compatibility for the 1.x product line, Dojo fully supports
this standard as of v1.7.0. (Note: Dojo will drop support for the legacy API in version 2.0).

In version 1.7.0, the Dojo loader and build system have been completely rewritten to support **both** the AMD API and
full legacy backward compatibility. Several new supporting APIs have also been constructed, including the AMD plugin,
has.js, dojo configuration, dojo loader micro-events, error reporting, and tracing APIs. Lastly, most of the dojo and
dijit trees as well as large parts of the dojox tree have been converted to use the AMD API.

The tutorials and reference manuals listed below describe all of this machinery.

:ref:`The Dojo AMD Loader <loader/amd>`
  Describes the Dojo AMD loader.

:ref:`The Dojo Legacy Module System <loader/legacy>`
  Describes how the Dojo AMD loader works with legacy modules.

:ref:`The Dojo Build System <build/index>`
  The top page for the build system documentation.
