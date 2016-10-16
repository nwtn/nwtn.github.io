---
layout:     post
title:      "Semantic HTML: The Unbearable Rightness of Being"
date:       2016-07-14
permalink:  semantic-html-the-unbearable-rightness-of-being
excerpt:    Using valid, semantic HTML is one of the most impactful ways to make your site more accessible. Writing semantic HTML means using the HTML element with the most specific, correct meaning for your task.
---

*This is [a cross-post](https://medium.com/shopify-ux/semantic-html-the-unbearable-rightness-of-being-9b3c493e1791#.vvp6v9tcw) from [Shopify’s UX Medium](https://medium.com/shopify-ux).*

*This is the fourth post in a series on accessibility from Shopify’s UX team. We’re publishing posts every two weeks. [Check out the introduction](https://medium.com/shopify-ux/make-commerce-better-for-everyone-b96f0621ddf3#.qkhbxkncz).*

Using valid, semantic HTML is one of the most impactful ways to make your site more accessible. Writing semantic HTML means using the HTML element with the most specific, correct meaning for your task. For example, if you’re building a button, use a `<button>` element. With CSS and JavaScript you could make just about any element, e.g. a `<div>`, *look* like a button, but it won’t *be* a button.

<!--more-->

This *being* is the reason semantic HTML is important for accessibility. Browsers have different behaviour depending on what an element *is*, not what it looks like. These differences can have a big impact on user experience.

## How semantic HTML affects users

Consider this example ([also available as a CodePen](http://codepen.io/newtron/pen/wWqAVv)):

	<div class="btn" onclick="alert('something')">do something</div>
	
	<a href="#" class="btn" onclick="alert('something')">do something</a>
	
	<button type="button" class="btn" onclick="alert('something')">do something</button>

![Three identical buttons](http://davidnewton.ca/img/three-identical-buttons.png)

These three buttons look identical. When you click them, they all produce the desired behaviour — popping up an alert that says “something”. But they are marked up differently — the first as a `<div>` element, the second as an `<a>` element, and the third as a `<button>` element. These markup differences have some effects that may not be obvious:

* breaking keyboard navigation,
* inappropriately shifting browser focus, and
* creating incorrect descriptions in screen readers

The first button uses a `<div>` HTML element:

	<div class="btn" onclick="alert('something')">do something</div>

`<div>`s don’t have much default styling, so the `btn` class is used by our CSS to make it look like a button. The `onclick` attribute tells JavaScript to create the alert when the `<div>` is clicked. (Even though this is called `onclick`, it can be triggered by a mouse click, a touchscreen tap, or hitting `ENTER` on a keyboard. This is also true elsewhere in this post when I mention “clicking”.)

	<a href="#" class="btn" onclick="alert('something')">do something</a>

The second button uses an `<a>` HTML element, a link. As in the first example, the `btn` class and `onclick` attribute provide the styling and behaviour we want. This a has an `href` value of `#`, which means that it is linking to the top of the page. More on that later.

	<button type="button" class="btn" onclick="alert('something')">do something</button>

The third button uses a `<button>` HTML element. Again, the `btn` class and `onclick` attribute provide the styling and behaviour.

We have three buttons that seem to be the same, but are all marked up using different HTML elements. What is the effect that these different elements have?

## Keyboard navigation

![The last button, marked up with a button element, can be focused with the keyboard](http://davidnewton.ca/img/last-button-focus.png)

If you were to try using your `TAB` key to navigate around the example, you’d be able to focus on the third example (`<button>`) and, depending on your browser, maybe the second example (`<a>`), but not the first (`<div>`).

Certain HTML elements are *focusable* by default and others aren’t. Keyboards and some other devices can navigate around the page by focusing on these elements. Being able to focus on an element is necessary to be able to interact with it. You can activate the third (`<button>`) example by hitting `ENTER` or `SPACE`, but you can’t do that with the first (`<div>`) example.

Many people, both disabled and not, use keyboards to navigate web sites. If you use a `<div>` to create a button, keyboard users that are not disabled might get frustrated and resort to using their mouse. Users with motor difficulty may not be able to use a mouse, and will be left unable to use your button at all.

## Focus shifting

	<a href="#" class="btn" onclick="alert('something')">do something</a>

Remember when I said that the `href="#"` on the second (`<a>`) example button creates a link to the top of the page? This can be an accessibility problem if it’s not controlled for, because it can take a user out of their context.

Imagine this button was at the bottom of a long page with lots of content on it. Clicking the button could scroll the user up to the top of the page, and shift the keyboard focus up to the top as well. A non-disabled user might get confused and annoyed, and scroll back down to the bottom. A keyboard user might get confused and very annoyed, because now they need to tab all the way through the entire page to get back where they were. A screen reader user might get very confused; they might not immediately realize the screen reader has shifted focus back to the top of the page.

## Screen reader descriptions and navigation

When visually impaired users navigate with a screen reader, they rely on how it describes HTML elements. It’s the only way they can know what something is and how they can interact with it.

The three example buttons are described differently by VoiceOver in Safari on macOS:

![The first button, marked up with a div, is described as “do something, clickable” by VoiceOver](http://davidnewton.ca/img/do-something-clickable.png)

The first example (`<div>`) is described as “clickable”. That’s not bad, but there’s no sign that this is actually a button. The distinction may seem trivial, but lots of things are clickable — links, buttons, form inputs, and so on. By not being specific, this could leave the user suspicious about what clicking the `<div>` will actually do.

![The second button, marked up with an anchor, is described as “link, do something” by VoiceOver](http://davidnewton.ca/img/link-do-something.png)

The second example (`<a>`) is described as a “link” (because it is, even if it doesn’t look like one!). A screen reader user might expect that clicking this link would take them to another page, not that it would trigger on-page behaviour. Links are *navigation* elements — the expectation is that they take you somewhere.

![The third button, marked up with a button element, is described as “do something, button” by VoiceOver](http://davidnewton.ca/img/do-something-button.png)

The third example (`<button>`) is described as a “button” (because it is!). To a screen reader user, this conveys the appropriate expectation, that clicking the button will *do something*.

These different HTML elements can affect how a screen reader user navigates the page. For example, VoiceOver has a “rotor” that lists different types of elements and lets users skip to a particular one. Amongst other things, the rotor has areas for “links” and “form controls”.

![The VoiceOver rotor lists the second button, marked up with an anchor, in its “Links” area](http://davidnewton.ca/img/rotor-links.png)

![The VoiceOver rotor lists the third button, marked up with a button element, in its “Form Controls” area and says it’s a button](http://davidnewton.ca/img/rotor-form-controls.png)

* the first example (`<div>`) doesn’t get listed in either
* the second example (`<a>`) shows up in the “links” area (setting false expectations for what it will do)
* the third example (`<button>`) shows up in the “form controls” area as a “button” (correctly setting expectations)

## `<button>` is the best choice for a button

To recap:

* `<div>`: has no semantic meaning, is not keyboard focusable, described as “clickable” by VoiceOver, not listed in VoiceOver’s rotor
* `<a>`: has navigational semantics, might be keyboard focusable, might unintentionally shift focus/context, described as a “link” by VoiceOver, listed in the “link” area of VoiceOver’s rotor
* `<button>`: has button semantics, is keyboard focusable, doesn’t shift focus/context, described as a “button” by VoiceOver, listed in the “form controls” area of VoiceOver’s rotor.

Based on this data, using a `<button>` to make a button is the best choice!

It *is* possible to override all this default behaviour and make a `<div>` or an `<a>` work like a button. You could:

* add the aria `role="button"` attribute to them to make them get described properly by screen readers
* add a `tabindex="0"` to the `<div>` to make it focusable
* add a `return false` to the `<a>`’s `onclick` JavaScript to prevent focus shifting

But why bother with that when you get all this behaviour free, out-of-the box with `<button>`? It’s super easy to forget to add these things, especially when the button looks and (for some users) behaves “right” without them. It’s far easier to use the correct HTML element for the job you’re doing.

This example was about buttons, but remember that the same lesson is true for *all* HTML elements. It’s always best to use the most specific, most appropriate HTML element for the task at hand. Let the browser’s built-in functionality do the hard work for you!

## Why valid HTML is important

Now that we’ve gone through why *semantic* HTML is important, I want to briefly touch on the importance of *valid* HTML.

An accessible experience is made up of three layers:

* your code,
* how the browser interprets your code, and
* how an assistive technology or input device interacts with the browser’s interpretation of your code.

Bugs and unexpected behaviour can sneak in at any stage, and a bug at any stage can make a screen reader describe something incorrectly. Browser and screen reader bugs are an unfortunate fact of life. The only part you have control over is the quality of your own code. To minimize problems, it’s crucial to make sure the markup you’re writing is free from bugs.

This is an example of a bug that snuck in at Shopify that was subtle, but had a big accessibility impact:

	<label for="offer_set_offers_attributes_0_price_9999">Offer price</label>
	
	<input min="0" step="any" value="99.99" type="number" name="offer_set[offers_attributes][0][price]" id="offer_set_offers_attributes_0_price" />

Can you spot the problem?

The `<label>`’s `for` attribute doesn’t match the `<input>`’s `id` attribute. The function that generated this markup mistakenly added the `<input>`’s `value` as part of the `<label>`’s `for` attribute. Instead of `offer_set_offers_attributes_0_price`, it used `offer_set_offers_attributes_0_price_9999`.

The result is that the `<label>` and the `<input>` are actually not associated with each other at all. Visually, everything looks right. But the bug introduces two accessibility problems:

* clicking the `<label>` won’t focus the form `<input>` to allow typing
* a screen reader will describe the `<input>` wrong, by not saying the `<input>` is an “offer price”

We caught this bug by running our markup through an [HTML validator](https://checker.html5.org/). The validator told us that “the for attribute of the label element must refer to a non-hidden form control”. In other words, that it was wrong for the `<label>`’s `for` attribute to point to something that didn’t exist. By validating our HTML we were able to squash this accessibility bug.

## Challenges Shopify is facing

“Don’t write bad HTML” seems like a kind of easy thing to do, and “fix our existing bad HTML” doesn’t sound too tricky either. A lot of articles and conference talks will tell you to do this stuff without acknowledging some of the ways it can be hard.

* **Legacy content.** With an organization and product as old and large as Shopify, there’s going to be legacy content. When we identify legacy code as needing cleanup or refactoring, it can be hard to find the people and time needed to update it.
* **Lack of awareness.** Within any large organization there are going to be diverse skillsets. That is *good*. But it means that not everybody will know a lot (or anything) about accessibility, or about semantic HTML.
* **Imperfect tooling.** Shopify has some HTML validation built into its test suite, but it doesn’t check against the whole HTML spec. (That’s how the label bug mentioned above snuck into our code.) We don’t currently have any automated tests checking the semantics of our HTML.

We’re trying a bunch of approaches to solve these problems, including work to level-up both our devs and our tooling. Future articles in this series will touch on some of these approaches.

## Get started now!

If you want to check your existing markup for validity, try the [Nu HTML Checker](https://checker.html5.org/). This tool gets updated frequently so it’s always in sync with current HTML specifications.

Checking the semantics of your markup can be a little trickier, but there are a few things you can try to get things started:

* Unplug your mouse. Can you still use your site? Is anything broken?
* Start to read through parts of [the HTML specification](https://www.w3.org/TR/html5/) — there’s even [a version
specifically for web developers](https://developers.whatwg.org/)!
* Learn to test with a screen reader, like VoiceOver on macOS or NVDA on Windows. It will be very foreign and confusing at first, but hearing how your content gets described by the screen reader can be enlightening.

Like every part of web development, writing valid, semantic HTML can sometimes be tricky, but that doesn’t mean it’s not worth doing. You might be facing some of the same challenges as us, or you might have different barriers. Whatever these may be, don’t let them stand in your way, and don’t get overwhelmed. Dive in and get started writing semantic HTML now. The sooner you do, the quicker you’ll have an impact on your users.
