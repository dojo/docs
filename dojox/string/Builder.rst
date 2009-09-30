#format dojo_rst

dojox.string.Builder
=====================

:Status: Draft
:Version: Dojo Toolkit 1.0+
:Author: Tom Trenka

The DojoX String Builder is a constructor designed to make working with large strings, particularly in the context of recursive functions, much more efficient and performant.  The basic idea (borrowed primarily from the .NET Framework and heavily optimized) is that you can pass around a single Builder object (since objects are passed by reference and not by value) to various functions, and have each function *append* string fragments to the Builder; when you are finished, you can simply add the Builder to an existing string or explicitly call the toString method.

A simple example of using the Builder:

.. code-block :: javascript
  :linenos:

  dojo.require("dojox.string.Builder");
  var sb = new dojox.string.Builder();

  function addOne(builder){
      var s = getSomeString();  // imagine this is a function that returns a decent sized string
      builder.append(s);
      return builder;
  }

  function addTwo(builder, str){
      builder.append(str);
      return builder;
  }

  addOne(sb);
  addTwo(sb, "The rain in spain falls mainly on the plain");
  var output = "This is a builder test " + sb;

While the above example is pretty basic, it demonstrates the usage pretty well.

Situations where using a string builder is handy are template systems and serialization systems; for instance, creating a simple table could be written so that it uses the Builder as opposed to recursively calling itself and returning/appending string fragments.  Here's an example:

.. code-block :: javascript
  :linenos:

  dojo.require("dojox.string.Builder");
  function buildRow(builder){
	  builder.append("<tr>");
	  for(var i=0; i<6; i++){
		  buildCell(builder);
	  }
	  builder.append("</tr>");
  }

  function buildCell(builder){
	  builder.append("<td>", "This is some content", "</td>");
  }

  function buildTable(builder){
      builder.append("<table>");
	  for(var i=0; i<6; i++){
		  buildRow(builder);
	  }
	  builder.append("</table>");
  }

  var sb = new dojox.string.Builder();
  buildTable(sb);
  console.log(sb.toString());


The string Builder has the following methods:

 * append
 * concat
 * appendArray
 * clear
 * replace
 * remove
 * insert
 * toString

In general, the only methods used are *append* and *toString*.  *concat* and *appendArray* are basically versions of *append*; *clear* cleans out the internal string buffer.

*replace*, *remove* and *insert* all work on existing internal string buffers; *replace* functions exactly like String.replace.  *remove* will pull N characters beginning at idx:

.. code-block :: javascript
  :linenos:

  sb.remove(index, numChars);

*insert* will place a string at index:

.. code-block :: javascript
  :linenos:

  sb.insert(index, "The rain in Spain falls mainly on the plain");

For a reference on how the Builder was optimized, please see 
 * http://www.sitepen.com/blog/2008/05/09/string-performance-an-analysis/ 
 * http://www.sitepen.com/blog/2008/06/09/string-performance-getting-good-performance-from-internet-explorer/.
