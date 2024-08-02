import gleam/list
import gleam/string

pub fn is_paired(value: String) -> Bool {
  // "pub fn() { True }" -> "(){}"
  let just_brackets: String =
    value
    |> string.to_graphemes
    |> list.filter(keeping: fn(c) {
      ["(", ")", "[", "]", "{", "}"] |> list.contains(c)
    })
    |> string.join(with: "")

  // "(){}" -> ""
  // "({))" -> "({))"
  let matching_removed: String =
    just_brackets
    |> string.replace(each: "()", with: "")
    |> string.replace(each: "[]", with: "")
    |> string.replace(each: "{}", with: "")

  // len("()") < len("({})") -> is_paired("()")
  // len("") < len("()") -> all good -> brackets match
  // --------------------------------------------------
  // len("({))") == len("({))") -> can't remove anymore -> brackets don't match
  case matching_removed |> string.length < value |> string.length {
    False -> matching_removed |> string.length == 0
    True -> is_paired(matching_removed)
  }
}
