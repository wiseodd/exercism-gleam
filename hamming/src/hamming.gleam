import gleam/list
import gleam/string

pub fn distance(strand1: String, strand2: String) -> Result(Int, Nil) {
  let s1: List(String) = strand1 |> string.to_graphemes
  let s2: List(String) = strand2 |> string.to_graphemes

  case { s1 |> list.length } == { s2 |> list.length } {
    False -> Error(Nil)
    True -> Ok(hamming(s1, s2, 0))
  }
}

fn hamming(s1: List(String), s2: List(String), acc: Int) -> Int {
  case s1, s2 {
    [], [] -> acc
    [c1, ..rest1], [c2, ..rest2] ->
      case c1 == c2 {
        True -> hamming(rest1, rest2, acc)
        False -> hamming(rest1, rest2, acc + 1)
      }
    _, _ -> acc
  }
}
