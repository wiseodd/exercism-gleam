import gleam/float
import gleam/int
import gleam/result

pub type Error {
  InvalidSquare
}

pub fn square(square: Int) -> Result(Int, Error) {
  case square < 1 || square > 64 {
    True -> Error(InvalidSquare)
    False -> {
      use val: Float <- result.map(
        float.power(2.0, square - 1 |> int.to_float)
        |> result.replace_error(InvalidSquare),
      )
      val |> float.truncate
    }
  }
}

pub fn total() -> Int {
  let val_or_err = float.power(2.0, 64.0)

  case val_or_err {
    Ok(val) -> { val |> float.truncate } - 1
    Error(_) -> 0
  }
}
