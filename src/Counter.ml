open CallbagBasics
open CallbagStore
open Html


let css_module = Css.Module.make @@
  Css.inline ~margin_right:(`em 1.) ()

let stylesheet =
  Css_Stylesheet.make `utf_8 [Css_Stylesheet.css_module css_module]

type state = { counter: int }
type action = Increment | Decrement

let { dispatch; store; get_state } =
  { counter = 0 } |> make @@ fun { counter } ->
  fun action ->
    match action with
    | Increment -> { counter = counter + 1 }
    | Decrement -> { counter = counter - 1 }

let counter =
  store
  |> map (fun { counter } -> span ~css_module [|text @@ string_of_int counter|])
  |> CallbagElement.make

let example =
  div [|
     counter;
     button ~on_click:(fun _ -> dispatch Increment) [|text "Increment"|];
     button ~on_click:(fun _ -> dispatch Decrement) [|text "Decrement"|]
  |]

let _ =
  let body =
    let open Webapi.Dom in
    document
    |> Document.asHtmlDocument
    |> Js.Option.andThen (fun [@bs] e -> HtmlDocument.body e)
    |> Js.Option.getExn
  in
  let style =
    let open Webapi.Dom in
    let style = document |> Document.createElement "style" in
    Element.setInnerHTML style (Css.Stylesheet.show stylesheet);
    style
  in
  Webapi.Dom.Element.appendChild style body;
  Webapi.Dom.Element.appendChild (Html.Node.to_node example) body
