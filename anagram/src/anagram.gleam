import gleam/list
import gleam/string

pub fn find_anagrams(word: String, candidates: List(String)) -> List(String) {
  let word = word |> string.lowercase
  let sorted_word =
    word
    |> string.to_graphemes
    |> list.sort(string.compare)

  let is_anagram = fn(cand: String) -> Bool {
    let cand = cand |> string.lowercase
    let sorted_cand =
      cand
      |> string.to_graphemes
      |> list.sort(string.compare)
    word != cand && sorted_word == sorted_cand
  }

  candidates |> list.filter(keeping: is_anagram)
}
