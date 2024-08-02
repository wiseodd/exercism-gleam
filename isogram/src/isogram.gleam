import gleam/list
import gleam/string

pub fn is_isogram(phrase phrase: String) -> Bool {
  let chars: List(String) =
    phrase
    |> string.lowercase
    |> string.to_graphemes
    |> list.filter(keeping: fn(c) { c != "-" && c != " " })
    |> list.sort(string.compare)

  let unique_chars: List(String) = chars |> list.unique

  chars == unique_chars
}
