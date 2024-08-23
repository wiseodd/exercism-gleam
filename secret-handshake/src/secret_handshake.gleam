import gleam/int
import gleam/list
import gleam/string

pub type Command {
  Wink
  DoubleBlink
  CloseYourEyes
  Jump
}

pub fn commands(encoded_message: Int) -> List(Command) {
  encoded_message
  |> int.to_base2
  |> string.to_graphemes
  |> list.reverse
  |> decode(1, [])
}

fn decode(
  reversed_msg: List(String),
  pos: Int,
  accumulator: List(Command),
) -> List(Command) {
  case reversed_msg {
    [] -> accumulator |> list.reverse
    [bit, ..rest] -> {
      case bit {
        "0" -> decode(rest, pos + 1, accumulator)
        _ -> {
          case pos {
            _ if pos == 1 -> decode(rest, pos + 1, [Wink, ..accumulator])
            _ if pos == 2 -> decode(rest, pos + 1, [DoubleBlink, ..accumulator])
            _ if pos == 3 ->
              decode(rest, pos + 1, [CloseYourEyes, ..accumulator])
            _ if pos == 4 -> decode(rest, pos + 1, [Jump, ..accumulator])
            _ -> decode([], pos + 1, accumulator |> list.reverse)
          }
        }
      }
    }
  }
}
