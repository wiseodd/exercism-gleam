import gleam/int
import gleam/list
import gleam/string

pub type Color {
  Black
  Brown
  Red
  Orange
  Yellow
  Green
  Blue
  Violet
  Grey
  White
}

pub fn value(colors: List(Color)) -> Result(Int, Nil) {
  let len: Int = colors |> list.length

  case len {
    _ if len < 2 -> Error(Nil)
    _ ->
      colors |> list.take(2) |> get_values([]) |> string.join("") |> int.parse
  }
}

pub fn main() {
  value([Brown, Green])
}

fn get_values(colors: List(Color), accumulator: List(String)) -> List(String) {
  case colors {
    [] -> accumulator |> list.reverse
    [color, ..rest] -> get_values(rest, [get_value(color), ..accumulator])
  }
}

fn get_value(color: Color) -> String {
  case color {
    Black -> "0"
    Brown -> "1"
    Red -> "2"
    Orange -> "3"
    Yellow -> "4"
    Green -> "5"
    Blue -> "6"
    Violet -> "7"
    Grey -> "8"
    White -> "9"
  }
}
