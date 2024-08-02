import gleam/option
import gleam/regex

pub fn is_valid_line(line: String) -> Bool {
  let assert Ok(re) =
    regex.from_string("^(\\[ERROR\\]|\\[INFO\\]|\\[WARNING\\]|\\[DEBUG\\])")
  regex.check(re, line)
}

pub fn split_line(line: String) -> List(String) {
  let assert Ok(re) = regex.from_string("<[~*=-]*>")
  regex.split(re, line)
}

pub fn tag_with_user_name(line: String) -> String {
  let assert Ok(re) = regex.from_string("User\\s+(\\S+)")
  case regex.scan(re, line) {
    [] -> line
    [regex.Match(_, [option.Some(user)])] -> "[USER] " <> user <> " " <> line
    _ -> ""
  }
}
