open CallbagBasics;
open CallbagStore;
open Html_Jsx;


let css_module = Css.Module.make @@ Css.inline(~margin_right=`em(1.), ());

let stylesheet =
  Css_Stylesheet.make(`utf_8, [Css_Stylesheet.css_module(css_module)]);

type state = {counter: int};

type action = Increment | Decrement;

let {dispatch, store, get_state} =
  {counter: 0} |> make @@ ({counter}, action) =>
  switch (action) {
  | Increment => {counter: counter + 1}
  | Decrement => {counter: counter - 1}
  };

let counter = (~children as _, ()) =>
  store
  |> map(({counter}) => {
      <span>
        <text>{string_of_int(counter)}</text>
      </span>
    })
  |> CallbagElement.make;

let example =
  <div>
    <counter/>
    <button on_click={(_) => dispatch(Increment)}>
      <text>"Increment"</text>
    </button>
    <button on_click={(_) => dispatch(Decrement)}>
      <text>"Decrement"</text>
    </button>
  </div>;


{
  let body =
    Webapi.Dom.(
      document
      |> Document.asHtmlDocument
      |> Js.Option.andThen((. e) => HtmlDocument.body(e))
      |> Js.Option.getExn
    );
  let style = {
    open Webapi.Dom;
    let style = document |> Document.createElement("style");
    Element.setInnerHTML(style, Css.Stylesheet.show(stylesheet));
    style;
  };
  Webapi.Dom.Element.appendChild(style, body);
  Webapi.Dom.Element.appendChild(Html.Node.to_node(example), body);
};
