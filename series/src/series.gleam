import gleam/list
import gleam/string

pub type Error {
  EmptySeries
  SliceLengthNegative
  SliceLengthZero
  SliceLengthTooLarge
}

pub fn slices(input: String, size: Int) -> Result(List(String), Error) {
  let len: Int = input |> string.length

  case len {
    _ if len == 0 -> Error(EmptySeries)
    _ if size < 0 -> Error(SliceLengthNegative)
    _ if size == 0 -> Error(SliceLengthZero)
    _ if size > len -> Error(SliceLengthTooLarge)
    _ if len == size -> Ok([input])
    _ -> Ok(input |> string.to_graphemes |> do_slices(size, []))
  }
}

fn do_slices(
  input: List(String),
  size: Int,
  accumulator: List(String),
) -> List(String) {
  case input {
    [] -> accumulator |> list.reverse
    [_, ..rest] -> {
      let series: String = input |> list.take(size) |> string.join("")
      let series_len: Int = series |> string.length

      case series_len {
        _ if series_len < size -> do_slices([], size, accumulator)
        _ -> do_slices(rest, size, [series, ..accumulator])
      }
    }
  }
}
