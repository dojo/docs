.. _dojo/string/trim:

================
dojo.string.trim
================

:since: V1.2
:Author: Eugene Lazutkin

.. contents ::
    :depth: 2

This function implements a frequently required functionality: it removes white-spaces from both ends of a string. This functionality is part of ECMAScript 5 standard and implemented by some browsers. In this case dojo.string.trim delegates to the native implementation. More information can be found here: `String.trim() at MDC <https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Global_Objects/String/Trim>`_.

This function is a bigger yet speedier version of :ref:`dojo.trim <dojo/trim>`. Otherwise these two functions are absolutely identical. The main difference is :ref:`dojo.trim <dojo/trim>` is part of the Dojo Base and as such is immediately available as soon as ``dojo.js`` is included, while dojo.string.trim is a part of ``dojo.string`` module, which should be explicitly required (see :ref:`dojo.require <dojo/require>`).

Please refer to :ref:`dojo.trim <dojo/trim>` documentation for code examples. Just substitute ``dojo.trim`` with ``dojo.string.trim``.  (In AMD context, instead of requiring ``dojo/_base/lang`` and invoking ``lang.trim``, you would require ``dojo/string`` and invoke ``string.trim``.)
