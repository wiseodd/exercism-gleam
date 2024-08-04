import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn read_emails(path: String) -> Result(List(String), Nil) {
  case simplifile.read(path) {
    Ok(content) ->
      Ok(
        content
        |> string.split("\n")
        |> list.filter(fn(s: String) { !{ s |> string.is_empty } }),
      )
    Error(_) -> Error(Nil)
  }
}

pub fn create_log_file(path: String) -> Result(Nil, Nil) {
  case simplifile.write(to: path, contents: "") {
    Ok(_) -> Ok(Nil)
    Error(_) -> Error(Nil)
  }
}

pub fn log_sent_email(path: String, email: String) -> Result(Nil, Nil) {
  case simplifile.append(to: path, contents: email <> "\n") {
    Ok(_) -> Ok(Nil)
    Error(_) -> Error(Nil)
  }
}

pub fn send_newsletter(
  emails_path: String,
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  use _ <- result.try(create_log_file(log_path))
  use emails: List(String) <- result.map(read_emails(emails_path))
  use email: String <- list.each(emails)
  use _ <- result.try(send_email(email))
  log_sent_email(log_path, email)
}
