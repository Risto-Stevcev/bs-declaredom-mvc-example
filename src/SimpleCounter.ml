open CallbagBasics
open CallbagEvents
open CallbagOf
open Html


let css_module = Css.Module.make @@
  Css.inline ~margin_right:(`em 1.) ()

let stylesheet =
  Css_Stylesheet.make `utf_8 [Css_Stylesheet.css_module css_module]

type state = { counter: int }

let increment_button = button [|text "Increment"|]
and decrement_button = button [|text "Decrement"|]

let increment_stream =
  increment_button
  |> click
  |> map (fun _ -> { counter = 1 })

let decrement_stream =
  decrement_button
  |> click
  |> map (fun _ -> { counter = -1 })

let initial_state = { counter = 0 }

let counter =
  from initial_state
  |> merge increment_stream
  |> merge decrement_stream
  |> scan (fun acc e -> { counter = acc.counter + e.counter }) { counter = 0 }
  |> map (fun { counter } -> span ~css_module [|text @@ string_of_int counter|])
  |> CallbagElement.make


let example =
  div [|
     counter;
     increment_button;
     decrement_button;
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
