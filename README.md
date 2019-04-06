# bs-declaredom-mvc-example

An example of how to use declaredom as an MVC framework in combination with other tools


# Examples

Declaredom is just a declarative markup library and doesn't have all of the bells and whistles that you would get with a full-blown framework like react or vue.

This is intentional to avoid a large monolithic framework. Only use what you need -- your app should never be more complicated than it needs to be. You can combine declardom with a set of other tools to get all of the same functionality that you would get with a framework.

This repo contains three examples of an increment/decrement counter:

- `npm run example:counter` shows how you can achieve a react-redux style pattern
- `npm run example:counter:jsx` is the JSX version
- `npm run example:simple` is simpler as it only uses streams. It's arguably more declarative since it doesn't have to dispatch (imperative) actions and instead relies on event streams.


# The Tools

The tools that make this work in addition to declaredom:

- [@ristostevcev/bs-callbag-basics][1] is a port of [callbag-basics][6], a highly modular, fast, easy to understand, and customizable streaming library. Streams are a  declarative and purely functional approach to managing changes over time.
- [@ristostevcev/bs-callbag-element][2] is a DOM element that takes a callbag stream of HTML elements and renders them using a virtual DOM ([morphdom][7]). Morphdom is fast, and the advantage of this approach is that you're always using regular HTML elements so there are never any awkward compatibility layers you have to deal with when using 3rd party components. It also means that you can leverage native techniques like [web components][8], or optimizing repaints using [requestAnimationFrame][9].
- [@ristostevcev/bs-callbag-events][3] provides event streams for declaredom elements
- [@ristostevcev/bs-callbag-of][4] is like [callbag-from-iter][10] except that it's a listenable source, which makes it useful for setting an initial state for event streams.
- [@ristostevcev/bs-callbag-store][4] is like a [redux][11] store that also provides a callbag stream of the state changes

 
[1]: https://github.com/Risto-Stevcev/bs-callbag-basics
[2]: https://github.com/Risto-Stevcev/bs-callbag-element
[3]: https://github.com/Risto-Stevcev/bs-callbag-events
[4]: https://github.com/Risto-Stevcev/bs-callbag-of
[5]: https://github.com/Risto-Stevcev/bs-callbag-store
[6]: https://github.com/staltz/callbag-basics
[7]: https://github.com/patrick-steele-idem/morphdom
[8]: https://developers.google.com/web/fundamentals/web-components/customelements
[9]: https://developer.mozilla.org/en-US/docs/Web/API/window/requestAnimationFrame
[10]: https://github.com/staltz/callbag-from-iter
[11]: https://github.com/reduxjs/redux
