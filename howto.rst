#format dojo_rst

How to become a dojo doc ninja
==============================


.. image:: http://media.dojocampus.org/images/docs/dojodocninja.png
   :alt: Dojo Doc ninja
   :class: dojoDocNinja

Joining the Dojo doc team is easy, all you need to do is write and get familiar with a few basics you will master fast.

1. Dojo Doc Syntax (reST)

Dojo doc uses the reST syntac to describe all docs, we have implemented a few features of the great reST Sphinx extension to provide cool stuff like inline code demos (Yah, you won't believe it, but your code will just work)

2. Versioning

All you need to to is make sure you target a specific dojo version and note that at the top of the page. This project only aims to cover the latest version of Dojo

3. Fame

Writing docs is a lot of work and we all deserve a little portion of dojo fame. Make sure you create your own page in the Wiki with links to your personal blog, website, twitter or other sites

Documentation basics
--------------------

1. Every doc should start with a header, e.g. the dojo module you are documenting.
2. All docs have to have code examples, what use does a doc have if you can't see examples? ;)
3. Write

Code examples
-------------

1. Non executed code
If you need to give a simple source code example without it being executed use the ".. code-block ::" directive and put the code right into the next line inlined by two spaces

  .. code-block :: javascript
    :linenos:

    .. code-block :: javascript
      :linenos:
      <script type="text/javascript">alert("Your code");</script>
