import gleam/string

pub fn message(log_line: String) -> String {
  case log_line {
    "[INFO]:" <> msg -> string.trim(msg)
    "[WARNING]:" <> msg -> string.trim(msg)
    "[ERROR]:" <> msg -> string.trim(msg)
    _ -> ""
  }
}

pub fn log_level(log_line: String) -> String {
  case log_line {
    "[INFO]:" <> _ -> "info"
    "[WARNING]:" <> _ -> "warning"
    "[ERROR]:" <> _ -> "error"
    _ -> ""
  }
}

pub fn reformat(log_line: String) -> String {
  message(log_line) <> " (" <> log_level(log_line) <> ")"
}
