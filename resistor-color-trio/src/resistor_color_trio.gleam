import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

pub type Resistance {
  Resistance(unit: String, value: Int)
}

pub fn label(colors: List(String)) -> Result(Resistance, Nil) {
  let colors: List(String) = colors |> list.take(3)
  let vals: List(Int) = colors2vals(colors, [])
  case vals {
    [c1, c2, c3] -> {
      case c1 == -1 || c2 == -1 || c3 == -1 {
        True -> Error(Nil)
        False -> {
          use ohms: Int <- result.map(
            [c1, c2, ..{ 0 |> list.repeat(c3) }]
            |> list.map(fn(x: Int) -> String { int.to_string(x) })
            |> string.join("")
            |> int.parse,
          )

          let #(val, unit): #(Int, String) =
            convert(ohms, ["ohms", "kiloohms", "megaohms", "gigaohms"])

          Resistance(unit: unit, value: val)
        }
      }
    }
    _ -> Error(Nil)
  }
}

fn get_val(color: String) -> Int {
  case color {
    "black" -> 0
    "brown" -> 1
    "red" -> 2
    "orange" -> 3
    "yellow" -> 4
    "green" -> 5
    "blue" -> 6
    "violet" -> 7
    "grey" -> 8
    "white" -> 9
    _ -> -1
  }
}

fn colors2vals(colors: List(String), accumulator: List(Int)) -> List(Int) {
  case colors {
    [] -> accumulator |> list.reverse
    [c, ..rest] -> {
      let val: Int = get_val(c)
      colors2vals(rest, [val, ..accumulator])
    }
  }
}

fn convert(val: Int, units: List(String)) -> #(Int, String) {
  case units {
    [unit, ..] if val % 1000 != 0 -> #(val, unit)
    [_, ..rest] if val % 100 == 0 -> convert(val / 1000, rest)
    _ -> #(val, "ohms")
  }
}
