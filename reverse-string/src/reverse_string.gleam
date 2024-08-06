import gleam/string

pub fn reverse(value: String) -> String {
  value |> string.to_graphemes |> list_reverse([]) |> string.join("")
}

fn list_reverse(original: List(String), result: List(String)) -> List(String) {
  case original {
    [] -> result
    [first, ..rest] -> list_reverse(rest, [first, ..result])
  }
}
