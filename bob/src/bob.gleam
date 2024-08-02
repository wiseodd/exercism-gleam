import gleam/list
import gleam/string

pub fn hey(remark: String) -> String {
  let remark: String = remark |> string.trim()

  let letters: List(String) = string.to_graphemes("abcdefghijklmnopqrstuvwxyz")
  let no_letter: Bool =
    remark
    |> string.lowercase()
    |> string.to_graphemes
    |> list.all(fn(c) { !{ letters |> list.contains(c) } })

  let is_question: Bool = string.ends_with(remark, "?")
  let is_yell: Bool = { remark == string.uppercase(remark) } && !no_letter
  let is_silence: Bool = remark == ""

  case remark {
    s if is_question ->
      case s {
        _ if is_yell -> "Calm down, I know what I'm doing!"
        _ -> "Sure."
      }
    _ if is_silence -> "Fine. Be that way!"
    _ if is_yell -> "Whoa, chill out!"
    _ -> "Whatever."
  }
}
