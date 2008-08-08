#format dojo_rst

UI Development with the Dojo Toolkit
====================================

:Status: Draft
:Version: 1.2

The Dojo Toolkit comes with many amaing modules which all are trying to make your live as a developer many times easier.
This short introduction to UI Development will introduce you to the main Dojo layout and form widgets.

Why use Dojo/Dijit?
-------------------

One of the great features of dijit is the fact that it is all ready for a11y (accesibility) and i18n (internationalisation).
Imagine you are working on a new product, your current market is the one of your country and you are not too concerned with delivering your product in different language. Thinking about making your product accessible for people with disabilities is way down the list of priorities. Now imagine your product becomes really succesful, you want to expand, you want to target a bigger market. Using Dojo you will see that implementing another language is not a matter of rewriting your entire software, making it accessible doesnt' require highly specialized knowledge and even enabling bidi is as simple as adding a few extra bytes of code.
And last but not least, dijit comes with different awesome themes and it is very easy to create your own theme.

Now if you are still doubting, lets go ahead and dive right into a simple UI we will use to retrieve the latest news from a news service provider. What will we use? 

Our ingredients
---------------

dijit.layout
~~~~~~~~~~~~

Dijit includes a sub namespace dijit.layout which contains very powerful layouting widgets. You can use those to create complex window-style (Note, not MS Windows ;) ) UIs but also to just enhance pages with single functionality such as tabs or content panes to load content dynamically.

dijit.form
~~~~~~~~~~

For all your form related needs you are best helped by dijit.form. All native form elements are covered and even more advanced elements such as a ComboBox are available in dijit.form
