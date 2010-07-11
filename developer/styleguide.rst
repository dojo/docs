#format html

<h1>Dojo Style Guide</h1>

<!--
.. contents::
    :depth: 2
-->

	<p>This document follows the basic outline of the Java Programming Conventions Guide, a copy of which may be found at <a class="reference" href="http://geosoft.no/javastyle.html">http://geosoft.no/javastyle.html</a>.</p> 
 
	<p>Widget authors are expected to adhere to this style guide and also to the <a href="/dijit-a11y-req">Dojo Accessibility Design Requirements</a> guidelines.</p> 
 
	<h2><a id="General" name="General">General</a></h2> 
	<p>Any violation to this guide is allowed if it enhances readability.</p> 
	<p>Guidelines in this document are informed by discussions carried out among the Dojo core developers. The most weight has been given to considerations that impact external developer interaction with Dojo code and APIs. Rules such as whitespace placement are of a much lower order importance for Dojo developers, but should be followed in the main in order to improve developer coordination.</p> 
 
	<h2><a id="Quick_Reference" name="Quick_Reference">Quick Reference</a></h2> 
	<p>Table of core API naming constructs:</p> 
	<table style="border:1px solid #999;" class="docutils"><colgroup /><col width="8%" /><col width="16%" /><col width="75%" /><thead valign="bottom"><tr><th class="head">Construct</th><th class="head">Convention</th><th class="head">Comment</th></tr></thead><tbody valign="top"><tr bgcolor="#ededed"><td>module</td><td><code class="geshifilter">lowercase</code></td><td>never multiple words</td></tr><tr><td>class</td><td><code class="geshifilter">CamelCase</code></td><td> 
			</td></tr><tr bgcolor="#ededed"><td>public method</td><td><code class="geshifilter">mixedCase</code></td><td>whether class or instance method. <code class="geshifilter">lower_case()</code> is acceptable only if the particular function is mimicking another API.</td></tr><tr><td>public var</td><td><code class="geshifilter">mixedCase</code></td><td> 
			</td></tr><tr bgcolor="#ededed"><td>constant</td><td><code class="geshifilter">CamelCase</code> or <code class="geshifilter">UPPER_CASE</code></td><td> 
			</td></tr></tbody></table> 
 
	<p>Table of constructs that are not visible in the API, and therefore carry less weight of enforcement.</p> 
	<table style="border:1px solid #999;" class="docutils"><colgroup /><col width="29%" /><col width="56%" /><thead valign="bottom"><tr><th class="head">Construct</th><th class="head">Convention</th></tr></thead><tbody valign="top"><tr bgcolor="#ededed"><td>private method</td><td><code class="geshifilter">_mixedCase</code></td></tr><tr><td>private var</td><td><code class="geshifilter">_mixedCase</code></td></tr><tr bgcolor="#ededed"><td>method args</td><td><code class="geshifilter">_mixedCase</code>, <code class="geshifilter">mixedCase</code></td></tr><tr><td>local vars</td><td><code class="geshifilter">_mixedCase</code>, <code class="geshifilter">mixedCase</code></td></tr></tbody></table> 
 
	<h2><a id="Naming_Conventions" name="Naming_Conventions">Naming Conventions</a></h2> 
 
	<ol class="upperalpha"> 
		<li> 
			<p>When constructing string IDs or ID prefixes in the code, do not use "dojo", "dijit" or "dojox" in the names. Because we now allow multiple versions of dojo in a page, it is important you use _scopeName instead (dojo._scopeName, dijit._scopeName, dojox._scopeName).</p> 
		</li> 
		<li> 
			<p>Names representing modules SHOULD be in all lower case.</p> 
		</li> 
		<li> 
			<p>Names representing types (classes) MUST be nouns and written using CamelCase capitalization:</p> 
			<div class="geshifilter" style="font-family: monospace;">Account, EventHandler</div> 
		</li> 
		<li> 
			<p>Constants SHOULD be placed within a single object created as a holder for constants, emulating an Enum; the enum SHOULD be named appropriately, and members SHOULD be named using either CamelCase or UPPER_CASE capitalization:</p> 
			<div class="geshifilter" style="font-family: monospace;"><span class="kw2">var</span> NodeTypes = <span class="br0">&#123;</span><br /> 
&nbsp; &nbsp; &nbsp; &nbsp; Element : <span class="nu0">1</span>,<br /> 
&nbsp; &nbsp; &nbsp; &nbsp; DOCUMENT: <span class="nu0">2</span><br /> 
<span class="br0">&#125;</span>;</div> 
		</li> 
		<li> 
			<p>Abbreviations and acronyms SHOULD NOT be UPPERCASE when used as a name:</p> 
<div class="geshifilter" style="font-family: monospace;">getInnerHtml<span class="br0">&#40;</span><span class="br0">&#41;</span>, getXml<span class="br0">&#40;</span><span class="br0">&#41;</span>, XmlDocument</div> 
		</li> 
		<li> 
			<p>Names representing methods SHOULD be verbs or verb phrases:</p> 
			<div class="geshifilter" style="font-family: monospace;">obj.<span class="me1">getSomeValue</span><span class="br0">&#40;</span><span class="br0">&#41;</span></div> 
		</li> 
		<li> 
			<p>Public class variables MUST be written using mixedCase capitalization.</p> 
		</li> 
		<li> 
			<p>CSS variable names SHOULD follow the same conventions as public class variables.</p> 
		</li> 
		<li> 
			<p>Private class variables MAY be written using <code class="geshifilter">_mixedCase</code> (with preceding underscore):</p> 
<div class="geshifilter" style="font-family: monospace;"><span class="kw2">var</span> MyClass = <span class="kw2">function</span><span class="br0">&#40;</span><span class="br0">&#41;</span><span class="br0">&#123;</span><br /> 
&nbsp; &nbsp; &nbsp; &nbsp; <span class="kw2">var</span> _buffer;<br /> 
&nbsp; &nbsp; &nbsp; &nbsp; <span class="kw1">this</span>.<span class="me1">doSomething</span> = <span class="kw2">function</span><span class="br0">&#40;</span><span class="br0">&#41;</span><span class="br0">&#123;</span><br /> 
&nbsp; &nbsp; &nbsp; &nbsp; <span class="br0">&#125;</span>;<br /> 
<span class="br0">&#125;</span></div> 
		</li> 
		<li> 
			<p>Variables that are intended to be private, but are not closure bound, SHOULD be prepended with a &quot;_&quot; (underscore) char:</p> 
			<div class="geshifilter" style="font-family: monospace;"><span class="kw1">this</span>._somePrivateVariable = statement;</div> 
			<p>Note: the above variable also follows the convention for a private variable.</p> 
		</li> 
		<li> 
			<p>Generic variables SHOULD have the same name as their type:</p> 
			<div class="geshifilter" style="font-family: monospace;">setTopic<span class="br0">&#40;</span>topic<span class="br0">&#41;</span> <span class="co1">// where topic is of type Topic</span></div> 
		</li> 
		<li> 
			<p>All names SHOULD be written in English.</p> 
		</li> 
		<li> 
			<p>Variables with a large scope SHOULD have globally unambiguous names; ambiguity MAY be distinguished by module membership. Variables with small or private scope MAY have terse names.</p> 
		</li> 
 
		<li> 
			<p>The name of the return object is implicit, and SHOULD be avoided in a method name:</p> 
			<div class="geshifilter" style="font-family: monospace;">getHandler<span class="br0">&#40;</span><span class="br0">&#41;</span>; <span class="co1">// NOT getEventHandler()</span></div> 
		</li> 
		<li> 
			<p>Public names SHOULD be as clear as necessary and SHOULD avoid unclear shortenings and contractions:</p> 
			<div class="geshifilter" style="font-family: monospace;">MouseEventHandler <span class="co1">// NOT MseEvtHdlr</span></div> 
			<p>Note that, again, any context that can be determined by module membership SHOULD be used when determining if a variable name is clear. For example, a class that represents a mouse event handler:</p> 
			<div class="geshifilter" style="font-family: monospace;">dojo.<span class="me1">events</span>.<span class="me1">mouse</span>.<span class="me1">Handler</span> <span class="co1">// NOT dojo.events.mouse.MouseEventHandler</span></div> 
		</li> 
		<li> 
			<p>Classes/constructors MAY be named based on their inheritance pattern, with the base class to the right of the name:</p> 
<div class="geshifilter" style="font-family: monospace;">EventHandler<br /> 
UIEventHandler<br /> 
MouseEventHandler</div> 
 
			<p>The base class CAN be dropped from a name if it is obviously implicit in the name:</p> 
			<div class="geshifilter" style="font-family: monospace;">MouseEventHandler <span class="co1">// as opposed to MouseUIEventHandler</span></div> 
		</li> 
 
                <li>Functions that act as both getters and setters depending on the number of arguments are named after nouns.  The 'get' and 'set' are implied.   For example:
<div class="geshifilter" style="font-family: monospace;">dojo.<span class="me1">attr</span><span class="br0">&#40;</span>node, <span class="st0">&quot;tabIndex&quot;</span><span class="br0">&#41;</span>;<br /> 
dojo.<span class="me1">attr</span><span class="br0">&#40;</span>node, <span class="st0">&quot;tabIndex&quot;</span>, <span class="st0">&quot;-1&quot;</span><span class="br0">&#41;</span>;</div> 
</li> 
	</ol> 
 
	<h2><a id="Specific_Naming_Conventions" name="Specific_Naming_Conventions">Specific Naming Conventions</a></h2> 
 
	<ol class="upperalpha"> 
		<li> 
			<p>The terms get/set SHOULD NOT used where a field is accessed, unless the variable being accessed is lexically private.</p> 
		</li> 
		<li> 
			<p>The &quot;is&quot; prefix SHOULD be used for boolean variables and methods. Alternatives include &quot;has&quot;, &quot;can&quot; and &quot;should&quot;</p> 
		</li> 
		<li> 
			<p>The term &quot;compute&quot; CAN be used in methods where something is computed.</p> 
		</li> 
		<li> 
			<p>The term &quot;find&quot; CAN be used in methods where something is looked up.</p> 
		</li> 
		<li> 
			<p>The terms &quot;initialize&quot; or &quot;init&quot; CAN be used where an object or a concept is established.</p> 
		</li> 
		<li> 
			<p>UI Control variables SHOULD be suffixed by the control type. Examples: leftComboBox, topScrollPane</p> 
		</li> 
		<li> 
			<p>Plural form MUST be used to name collections.</p> 
		</li> 
		<li> 
			<p>A &quot;num&quot; prefix or &quot;count&quot; postfix SHOULD be used for variables representing a number of objects.</p> 
		</li> 
		<li> 
			<p>Iterator variables SHOULD be called &quot;i&quot;, &quot;j&quot;, &quot;k&quot;, etc.</p> 
		</li> 
		<li> 
			<p>Complement names MUST be used for complement entities. Examples: get/set, add/remove, create/destroy, start/stop, insert/delete, begin/end, etc.</p> 
		</li> 
		<li> 
			<p>Abbreviations in names SHOULD be avoided.</p> 
		</li> 
		<li> 
			<p>Negated boolean variable names MUST be avoided:</p> 
			<pre>isNotError, isNotFound are unacceptable.</pre> 
		</li> 
 
		<li> 
			<p>Exception classes SHOULD be suffixed with &quot;Exception&quot; or &quot;Error&quot; .. FIXME (trt) not sure about this?</p> 
		</li> 
 
		<li> 
			<p>Methods returning an object MAY be named after what they return, and methods returning void after what they do.</p> 
		</li> 
	</ol> 
 
	<h2><a id="Files" name="Files">Files</a></h2> 
 
	<ol class="upperalpha"> 
		<li> 
			<p>Class or object-per-file guidelines are not yet determined.</p> 
		</li> 
		<li> 
			<p>Tabs (set to 4 spaces) SHOULD be used for indentation.</p> 
		</li> 
		<li> 
			<p>If your editor supports &quot;file tags&quot;, please append the appropriate tag at the end of the file to enable others to effortlessly obey the correct indentation guidelines for that file:</p> 
			<pre>// vim:ts=4:noet:tw=0:</pre> 
		</li> 
		<li> 
			<p>The incompleteness of a split line MUST be made obvious :</p> 
<div class="geshifilter" style="font-family: monospace;"><span class="kw2">var</span> someExpression = Expression1<br /> 
&nbsp; &nbsp; &nbsp; &nbsp; + Expression2<br /> 
&nbsp; &nbsp; &nbsp; &nbsp; + Expression3;<br class="geshibr" /> 
<span class="kw2">var</span> o = someObject.<span class="me1">get</span><span class="br0">&#40;</span><br /> 
&nbsp; &nbsp; &nbsp; &nbsp; Expression1,<br /> 
&nbsp; &nbsp; &nbsp; &nbsp; Expression2,<br /> 
&nbsp; &nbsp; &nbsp; &nbsp; Expression3<br /> 
<span class="br0">&#41;</span>;</div> 
 
			<p>Note the indentation for expression continuation is indented relative to the variable name, while indentation for parameters is relative to the method being called.</p> 
			<p>Note also the position of the parenthesis in the method call; positioning SHOULD be similar to the use of block notation.</p> 
		</li> 
	</ol> 
 
	<h2><a id="Variables" name="Variables">Variables</a></h2> 
	<ol class="upperalpha simple"> 
		<li>Variables SHOULD be initialized where they are declared and they SHOULD be declared in the smallest scope possible. A null initialization is acceptable.</li> 
		<li>Variables MUST never have a dual meaning.</li> 
		<li>Related variables of the same type CAN be declared in a common statement; unrelated variables SHOULD NOT be declared in the same statement.</li> 
		<li>Variables SHOULD be kept alive for as short a time as possible.</li> 
		<li>Loops / iterative declarations
			<ol class="arabic"> 
				<li>Only loop control statements MUST be included in the &quot;for&quot; loop construction.</li> 
				<li>Loop variables SHOULD be initialized immediately before the loop; loop variables in a &quot;for&quot; statement MAY be initialized in the &quot;for&quot; loop construction.</li> 
				<li>The use of &quot;do...while&quot; loops is acceptable (unlike in Java).</li> 
				<li>The use of &quot;break&quot; and &quot;continue&quot; is not discouraged (unlike in Java).</li> 
			</ol> 
		</li> 
		<li>Conditionals
			<ol class="arabic"> 
				<li>Complex conditional expressions SHOULD be avoided; use temporary boolean variables instead.</li> 
				<li>The nominal case SHOULD be put in the &quot;if&quot; part and the exception in the &quot;else&quot; part of an &quot;if&quot; statement.</li> 
				<li>Executable statements in conditionals MUST be avoided.</li> 
			</ol> 
		</li> 
 
		<li>Miscellaneous
			<ol class="arabic"> 
				<li>The use of magic numbers in the code SHOULD be avoided; they SHOULD be declared using named &quot;constants&quot; instead.</li> 
				<li>Floating point constants SHOULD ALWAYS be written with decimal point and at least one decimal.</li> 
				<li>Floating point constants SHOULD ALWAYS be written with a digit before the decimal point.</li> 
			</ol> 
		</li> 
	</ol> 
 
	<h2><a id="Layout" name="Layout">Layout</a></h2> 
	<ol class="upperalpha"> 
		<li> 
			<p>Block statements.</p> 
			<ol class="arabic"> 
				<li>Block layout SHOULD BE as illustrated below:
<div class="geshifilter" style="font-family: monospace;"><span class="kw1">while</span><span class="br0">&#40;</span>!isDone<span class="br0">&#41;</span><span class="br0">&#123;</span><br /> 
&nbsp; &nbsp; &nbsp; &nbsp; doSomething<span class="br0">&#40;</span><span class="br0">&#41;</span>;<br /> 
&nbsp; &nbsp; &nbsp; &nbsp; isDone = moreToDo<span class="br0">&#40;</span><span class="br0">&#41;</span>;<br /> 
<span class="br0">&#125;</span></div> 
				</li> 
				<li> 
					<p><code class="geshifilter">if</code> statements SHOULD have the following form:</p> 
<div class="geshifilter" style="font-family: monospace;"><span class="kw1">if</span><span class="br0">&#40;</span>someCondition<span class="br0">&#41;</span><span class="br0">&#123;</span><br /> 
&nbsp; &nbsp; &nbsp; &nbsp; statements;<br /> 
<span class="br0">&#125;</span><span class="kw1">else</span> <span class="kw1">if</span><span class="br0">&#40;</span>someOtherCondition<span class="br0">&#41;</span><span class="br0">&#123;</span><br /> 
&nbsp; &nbsp; &nbsp; &nbsp; statements;<br /> 
<span class="br0">&#125;</span><span class="kw1">else</span><span class="br0">&#123;</span><br /> 
&nbsp; &nbsp; &nbsp; &nbsp; statements;<br /> 
<span class="br0">&#125;</span></div> 
				</li> 
				<li> 
					<p><code class="geshifilter">for</code> statements SHOULD have the following form:</p> 
<div class="geshifilter" style="font-family: monospace;"><span class="kw1">for</span><span class="br0">&#40;</span>initialization; condition; update<span class="br0">&#41;</span><span class="br0">&#123;</span><br /> 
&nbsp; &nbsp; &nbsp; &nbsp; statements;<br /> 
<span class="br0">&#125;</span></div> 
				</li> 
			</ol> 
			<ol class="arabic" start="4"> 
				<li> 
					<p><code class="geshifilter">while</code> statements SHOULD have the following form:</p> 
<div class="geshifilter" style="font-family: monospace;"><span class="kw1">while</span><span class="br0">&#40;</span>!isDone<span class="br0">&#41;</span><span class="br0">&#123;</span><br /> 
&nbsp; &nbsp; &nbsp; &nbsp; doSomething<span class="br0">&#40;</span><span class="br0">&#41;</span>;<br /> 
&nbsp; &nbsp; &nbsp; &nbsp; isDone = moreToDo<span class="br0">&#40;</span><span class="br0">&#41;</span>;<br /> 
<span class="br0">&#125;</span></div> 
	</li> 
				<li> 
					<p><code class="geshifilter">do...while</code> statements SHOULD have the following form:</p> 
<div class="geshifilter" style="font-family: monospace;"><span class="kw1">do</span><span class="br0">&#123;</span><br /> 
&nbsp; &nbsp; &nbsp; &nbsp; statements;<br /> 
<span class="br0">&#125;</span><span class="kw1">while</span><span class="br0">&#40;</span>condition<span class="br0">&#41;</span>;</div> 
				</li> 
				<li> 
					<p><code class="geshifilter">switch</code> statements SHOULD have the following form:</p> 
<div class="geshifilter" style="font-family: monospace;"><span class="kw1">switch</span><span class="br0">&#40;</span>condition<span class="br0">&#41;</span><span class="br0">&#123;</span><br /> 
&nbsp; &nbsp; <span class="kw1">case</span> ABC:<br /> 
&nbsp; &nbsp; &nbsp; &nbsp; statements;<br /> 
&nbsp; &nbsp; &nbsp; &nbsp; <span class="co1">//&nbsp; fallthrough</span><br /> 
&nbsp; &nbsp; <span class="kw1">case</span> DEF:<br /> 
&nbsp; &nbsp; &nbsp; &nbsp; statements;<br /> 
&nbsp; &nbsp; &nbsp; &nbsp; <span class="kw1">break</span>;<br /> 
&nbsp; &nbsp; <span class="kw2">default</span>:<br /> 
&nbsp; &nbsp; &nbsp; &nbsp; statements;<br /> 
&nbsp; &nbsp; &nbsp; &nbsp; <span class="co1">// no break keyword on the last case -- it's redundant</span><br /> 
<span class="br0">&#125;</span></div> 
				</li> 
				<li> 
					<p><code class="geshifilter">try...catch...finally</code> statements SHOULD have the following form:</p> 
<div class="geshifilter" style="font-family: monospace;"><span class="kw1">try</span><span class="br0">&#123;</span><br /> 
&nbsp; &nbsp; &nbsp; &nbsp; statements;<br /> 
<span class="br0">&#125;</span><span class="kw1">catch</span><span class="br0">&#40;</span>ex<span class="br0">&#41;</span><span class="br0">&#123;</span><br /> 
&nbsp; &nbsp; &nbsp; &nbsp; statements;<br /> 
<span class="br0">&#125;</span><span class="kw1">finally</span><span class="br0">&#123;</span><br /> 
&nbsp; &nbsp; &nbsp; &nbsp; statements;<br /> 
<span class="br0">&#125;</span></div> 
 
				</li> 
				<li> 
					<p>A single statement if-else, while or for MUST NOT be written without brackets, but CAN be written on the same line:</p> 
<div class="geshifilter" style="font-family: monospace;"><span class="kw1">if</span><span class="br0">&#40;</span>condition<span class="br0">&#41;</span><span class="br0">&#123;</span> statement; <span class="br0">&#125;</span><br /> 
<span class="kw1">while</span><span class="br0">&#40;</span>condition<span class="br0">&#41;</span><span class="br0">&#123;</span> statement; <span class="br0">&#125;</span><br /> 
<span class="kw1">for</span><span class="br0">&#40;</span>intialization; condition; update<span class="br0">&#41;</span><span class="br0">&#123;</span> statement; <span class="br0">&#125;</span></div> 
				</li> 
			</ol> 
		</li> 
 
		<li> 
			<p>Whitespace</p> 
			<ol class="arabic simple"> 
				<li>Conventional operators MAY be surrounded by a space (including ternary operators).</li> 
				<li>The following reserved words SHOULD NOT be followed by a space:
					<ul> 
						<li><code class="geshifilter">break</code></li> 
						<li><code class="geshifilter">catch</code></li> 
						<li><code class="geshifilter">continue</code></li> 
						<li><code class="geshifilter">do</code></li> 
						<li><code class="geshifilter">else</code></li> 
						<li><code class="geshifilter">finally</code></li> 
						<li><code class="geshifilter">for</code></li> 
						<li><code class="geshifilter">function</code> if anonymous, ex. <code class="geshifilter">var foo = function(){};</code></li> 
						<li><code class="geshifilter">if</code></li> 
						<li><code class="geshifilter">return</code></li> 
						<li><code class="geshifilter">switch</code></li> 
						<li><code class="geshifilter">this</code></li> 
						<li><code class="geshifilter">try</code></li> 
						<li><code class="geshifilter">void</code></li> 
						<li><code class="geshifilter">while</code></li> 
						<li><code class="geshifilter">with</code></li> 
					</ul> 
				</li> 
				<li>The following reserved words SHOULD be followed by a space:
					<ul> 
						<li><code class="geshifilter">case</code></li> 
						<li><code class="geshifilter">default</code></li> 
						<li><code class="geshifilter">delete</code></li> 
						<li><code class="geshifilter">function</code> if named, ex. <code class="geshifilter">function foo(){};</code></li> 
						<li><code class="geshifilter">in</code></li> 
						<li><code class="geshifilter">instanceof</code></li> 
						<li><code class="geshifilter">new</code></li> 
						<li><code class="geshifilter">throw</code></li> 
						<li><code class="geshifilter">typeof</code></li> 
						<li><code class="geshifilter">var</code></li> 
					</ul> 
				</li> 
				<li>Commas SHOULD be followed by a space.</li> 
				<li>Colons MAY be surrounded by a space.</li> 
				<li>Semi-colons in for statements SHOULD be followed by a space.</li> 
				<li>Semi-colons SHOULD NOT be preceded by a space.</li> 
				<li>Function calls and method calls SHOULD NOT be followed by a space. Example: <code class="geshifilter">doSomething(someParameter); // NOT doSomething (someParameter)</code></li> 
				<li>Logical units within a block SHOULD be separated by one blank line.</li> 
				<li>Statements MAY be aligned wherever this enhances readability.</li> 
			</ol> 
		</li> 
 
		<li> 
			<p>Line length</p> 
			<p> 
				There's no line length limit in dojo although 120 characters (treating tabs as 4 spaces) is a guideline.
				In particular code examples embedded into the API documentation may benefit from longer lines,
				since they start out already indented by 4 or 5 tabs.
			</p> 
 
		<li> 
			<p>Comments</p> 
			<ol class="arabic simple"> 
				<li>Tricky code SHOULD not be commented, but rewritten.</li> 
				<li>All comments SHOULD be written in English.</li> 
				<li>Comments SHOULD be indented relative to their position in the code, preceding or to the right of the code in question.</li> 
				<li>The declaration of collection variables SHOULD be followed by a comment stating the common type of the elements in the collection.</li> 
				<li>Comments SHOULD be included to explain BLOCKS of code, to explain the point of the following block.</li> 
				<li>Comments SHOULD NOT be included for every single line of code.</li> 
			</ol> 
		</li> 
	</ol> 
 
<h2><a id="Documentation" name="Documentation">Documentation</a></h2> 
 
<h3>Markup Guidelines</h3> 

Dojo's API documentation is written inline in the code, similar to JavaDoc.  See the <a href="/util/doctools/markup">Dojo Inline Documentation</a> for information on dojo's proprietary format.

<h2><a id="CSS" name="CSS">CSS</a></h2> 
<p>The CSS styling basically inherits all the rules from JavaScript, that means "key: value" looks like in JS, etc. Therefore a CSS file might look like this:</p> 
<pre class="geshifilter">.className1 {
    color: red;
}
 
.className1,
#idName {
    color: blue;
}</pre> 
<p>Mainly the rules are:
<ul> 
  <li>each selector is on a new line</li> 
  <li>the opening curly brace is preceeded by a space</li> 
  <li>the key value pairs have a space after the colon</li> 
  <li>every block is followed by an empty new line</li> 
</ul> 
</p></div> 
 
