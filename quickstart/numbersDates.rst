These widgets augment the functionality of the <code lang="javascript">&lt;INPUT type="text"&gt;</code> tag.   The base widget dijit.form.Textbox by itself can trim, change case, and require input.  dijit.form.ValidationTextbox extends this by validating the input when the box loses focus.  The other widgets further extend the validation function with range and format checking.  Internal to the MappedTextBox widget subclass are two INPUT elements.  One interacts with the user obeying local customs, the other is hidden and represents the named form element to submit data to the server using a normalized serialization.  By default, the widget will discover the appropriate locale and behavior <a href="http://dojotoolkit.org/book/dojo-book-0-9/part-3-programmatic-dijit-and-dojo/i18n/specifying-locale">as specified by Dojo</a>.

For example, when using a NumberTextBox in the United States, an optional comma is used for the thousands separator and a period for a decimal separator when interacting with the user.  For German users, a period is used for the thousands separator and a comma for the decimal separator.  Other locales may have different conventions.  When sending data to the server or interpreting the "value" attribute, numbers are represented simply as JavaScript formats them with a period for decimal and no thousands separators.  This representation is unambiguous, so other applications may interact with this data without assuming any locale-specific behavior.  With DateTextBox, a subset of the ISO-8601 format (e.g. 12-31-2006) is used for the value attribute.  For CurrencyTextBox, a number is transmitted, and it is the responsibility of the developer to associate the ISO-4217 country code with the amount to qualify what type of currency is indicated.  All of these behaviors are considered Dojo and JSON best practices, but may be customized as described below.</p>

=== Constraints ===

<p>To override the defaults, you can use the "constraints" attribute.  "constraints" is an 
object passed to functions responsible for validating, parsing, and formatting the data in the box, and various properties may be provided to override system or locale-specific defaults.  Constraints are handled in Dojo low-level routines in dojo.date, dojo.currency and dojo.number, and you can refer to the API documentation for complete details.  We summarize them here for convenience:</p>

* <b>currency</b>: (currency only) the ISO-4217 currency code, a three letter sequence like "USD"
See http://en.wikipedia.org/wiki/ISO_4217</li>
* <b>fractional</b>:  (currency only) where places are implied by pattern or explicit 'places' parameter, whether to include the fractional portion.</li>
<li><b>locale</b>:  override the locale on this widget only, choosing from djConfig.extraLocale</li>
<li><b>pattern</b>:  override localized convention with this pattern.  As a result, all users will see the same behavior, regardless of locale, and your application may not be globalized.  See http://www.unicode.org/reports/tr35/#Number_Format_Patterns.</li>
<li><b>places</b>:  number of decimal places to accept.</li>
<li><b>strict</b>:  strict parsing, false by default.  When strict mode is false, certain allowances are made to be more tolerant of user input, such as 'am' instead of 'a.m.', some white space may be optional, etc.</li>
<li><b>symbol</b>:  (currency only) override currency symbol. Normally, will be looked up in localized table of supported currencies (dojo.cldr) 3-letter ISO 4217 currency code will
be used if not found.</li>
<li><b>type</b>: choose a format type based on the locale from the following: decimal, scientific (not yet supported), percent, currency. decimal by default.</li>
</ul>

<p>For DateTextBox and TimeTextBox:</p>

<ul>
<li><b>am,pm</b>: override strings for am/pm in times</li>
<li><b>clickableIncrement</b> (TimeTextBox): ISO-8601 string representing the amount by which every clickable element in the time picker increases. Set in non-Zulu time, without a time zone. Example: "T00:15:00" creates 15 minute increments. Must divide visibleIncrement evenly.</li>
<li><b>datePattern,timePattern</b>: override localized convention with this pattern.  As a result, all users will see the same behavior, regardless of locale, and your application may not be globalized.  See http://www.unicode.org/reports/tr35/#Date_Format_Patterns</li>
<li><b>formatLength</b>: choose from formats appropriate to the locale -- long, short, medium or full (plus any custom additions).  Defaults to 'short'</li>
<li><b>locale</b>:  override the locale on this widget only, choosing from djConfig.extraLocale</li>
<li><b>selector</b>: choice of 'time', 'date' (default: date and time)</li>
<li><b>strict</b>: false by default.  If true, parsing matches exactly by regular expression.  If false, more tolerant matching is used for abbreviations and some white space.</li>
<li><b>visibleIncrement</b> (TimeTextBox): ISO-8601-style string representing the amount by which every element with a visible time in the time picker increases.  Set in non Zulu time, without a time zone or date.  Example: "T01:00:00" creates text in every 1 hour increment.</li>
<li><b>visibleRange</b> (TimeTextBox): ISO-8601 string representing the range of this time picker. The time picker will only display times in this range. Example: "T05:00:00" displays 5 hours of options</li>
</ul>
<br/>
