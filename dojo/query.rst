#format sphinx_rst

Most content copied from the dojo book chapters ( http://dojotoolkit.org/book/dojo-book-0-9/part-3-programmatic-dijit-and-dojo/selecting-dom-nodes-dojo-query ).

dojo.query
==================

dijit.ColorPalette is a great little tool which provides a color picker for you to use in your application.

Standard CSS3 Selectors
-----------------------

Because dojo.query adopts the CSS3 standard for selecting nodes, you can use any CSS reference guide for help on choosing the right queries. Eric Meyer's CSS: The Definitive Guide is a good resource. For convenience, here's a chart of the standard CSS3 selectors, taken from the current working draft RFC.

====================== ==========
Pattern	               Meaning
====================== ==========
\*	               any element
E	               an element of type E
E[foo]	               an E element with a "foo" attribute
E[foo="bar"]	       an E element whose "foo" attribute value is exactly equal to "bar"
E[foo~="bar"]	       an E element whose "foo" attribute value is a list of space-separated values, one of which is exactly equal to "bar"
E[foo^="bar"]	       an E element whose "foo" attribute value begins exactly with the string "bar"
E[foo$="bar"]	       an E element whose "foo" attribute value ends exactly with the string "bar"
E[foo*="bar"]	       an E element whose "foo" attribute value contains the substring "bar"
E[hreflang|="en"]      an E element whose "hreflang" attribute has a hyphen-separated list of values beginning (from the left) with "en"
E:root	               an E element, root of the document
E:nth-child(n)	       an E element, the n-th child of its parent
E:nth-last-child(n)    an E element, the n-th child of its parent, counting from the last one
E:nth-of-type(n)       an E element, the n-th sibling of its type
E:nth-last-of-type(n)  an E element, the n-th sibling of its type, counting from the last one
E:first-child	       an E element, first child of its parent
E:last-child	       an E element, last child of its parent
E:first-of-type	       an E element, first sibling of its type
E:last-of-type	       an E element, last sibling of its type
E:only-child	       an E element, only child of its parent
E:only-of-type	       an E element, only sibling of its type
E:empty	               an E element that has no children (including text nodes)
E:link
E:visited	       an E element being the source anchor of a hyperlink of which the target is not yet visited (:link) or already visited (:visited)
E:active
E:hover
E:focus	               an E element during certain user actions
E:target	       an E element being the target of the referring URI
E:lang(fr)	       an element of type E in language "fr" (the document language specifies how language is determined)
E:enabled
E:disabled	       a user interface element E which is enabled or disabled
E:checked	       a user interface element E which is checked (for instance a radio-button or checkbox)
E::first-line	       the first formatted line of an E element
E::first-letter	       the first formatted letter of an E element
E::selection	       the portion of an E element that is currently selected/highlighted by the user
E::before	       generated content before an E element
E::after	       generated content after an E element
E.warning	       an E element whose class is "warning" (the document language specifies how class is determined).
E#myid	               an E element with ID equal to "myid".
E:not(s)	       an E element that does not match simple selector s
E F	               an F element descendant of an E element
E > F	               an F element child of an E element
E + F	               an F element immediately preceded by an E element
E ~ F	               an F element preceded by an E element
====================== ==========

Examples
--------
