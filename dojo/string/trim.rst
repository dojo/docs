#format dojo_rst

dojo.string.trim
================

:Status: Final
:Version: 1.4
:Available: since V1.2
:Author: Eugene Lazutkin

.. contents::
    :depth: 2

This function implements a frequently required functionality: it removes white-spaces from both ends of a string. This functionality is part of ECMAScript 5 standard and implemented by some browsers. In this case dojo.string.trim delegates to the native implementation. More information can be found here: `String.trim() at MDC <https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Global_Objects/String/Trim>`_.

This function is a bigger yet speedier version of `dojo.trim <dojo/trim>`_. Otherwise these two functions are absolutely identical. The main difference is `dojo.trim <dojo/trim>`_ is part of the Dojo Base and as such is immediately available as soon as ``dojo.js`` is included, while dojo.string.trim is a part of ``dojo.string`` module, which should be explicitly required (see `dojo.require <dojo/require>`_).

Please refer to `dojo.trim <dojo/trim>`_ documentation for code examples. Just substitute ``dojo.trim`` with ``dojo.string.trim``.
