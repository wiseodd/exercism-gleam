import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub fn largest_product(digits: String, span: Int) -> Result(Int, Nil) {
  case span == 0 {
    True -> Ok(1)
    False -> {
      case
        span > 1
        && { digits |> string.length } >= span
        && { digits |> int.parse } |> result.is_ok
      {
        True -> {
          let digits: List(Int) =
            digits
            |> string.to_graphemes
            |> list.map(fn(x: String) -> Int {
              let assert Ok(v) = x |> int.parse
              v
            })
          let series: List(List(Int)) = digits |> get_series(span, [])
          let products: List(Int) =
            series
            |> list.map(fn(s: List(Int)) -> Int {
              s |> list.fold(1, int.multiply)
            })
          Ok(products |> list.fold(0, int.max))
        }
        False -> Error(Nil)
      }
    }
  }
}

fn get_series(
  digits: List(Int),
  span: Int,
  accumulator: List(List(Int)),
) -> List(List(Int)) {
  let series: List(Int) = digits |> list.take(span)

  case { series |> list.length } == span {
    True -> get_series(digits |> list.drop(1), span, [series, ..accumulator])
    False -> accumulator
  }
}
