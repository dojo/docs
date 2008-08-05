= TextBox =

TextBox provides some neat options, but what if you need none of them?  Can't you just use a plain HTML &lt;input&gt; tag?  You can, but they will not follow the Dijit theme, and will stick out like a sore thumb amongst other nicely-colored widgets.  So a good rule of thumb: if you use any Dijit form controls, you should make every control a Dijit control.  It's simple to do and makes everything look nice.

= ValidatingTextBox =

A ValidatingTextBox by itself '''will not''' prevent invalid entries from submission.  To ensure they're not, simply surround your form with a dijit.form.Form widget
