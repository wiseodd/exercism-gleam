import gleam/list

pub type Classification {
  Perfect
  Abundant
  Deficient
}

pub type Error {
  NonPositiveInt
}

pub fn classify(number: Int) -> Result(Classification, Error) {
  case number > 0 {
    False -> Error(NonPositiveInt)
    True -> {
      let factors = get_factors(number, 2, [1])
      let sum = factors |> list.fold(0, fn(x, y) { x + y })

      case factors {
        [1] -> Ok(Deficient)
        _ if sum == number -> Ok(Perfect)
        _ if sum > number -> Ok(Abundant)
        _ -> Ok(Deficient)
      }
    }
  }
}

fn get_factors(number: Int, divisor: Int, factors: List(Int)) -> List(Int) {
  case number {
    _ if divisor >= number -> factors
    _ -> {
      case number % divisor == 0 {
        True -> get_factors(number, divisor + 1, [number / divisor, ..factors])
        False -> get_factors(number, divisor + 1, factors)
      }
    }
  }
}
