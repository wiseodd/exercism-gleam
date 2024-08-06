import gleam/list
import gleam/string

pub fn is_pangram(sentence: String) -> Bool {
  let alphabet_str: String = "abcdefghijklmnopqrstuvwxyz"
  let alphabet_lst: List(String) = alphabet_str |> string.to_graphemes

  alphabet_str
  == sentence
  |> string.trim
  |> string.lowercase
  |> string.to_graphemes
  |> list.sort(string.compare)
  |> list.unique
  |> list.filter(fn(s) { alphabet_lst |> list.contains(s) })
  |> string.join("")
}
