pub type Error {
  NonPositiveNumber
}

pub fn steps(number: Int) -> Result(Int, Error) {
  case number {
    _ if number < 1 -> Error(NonPositiveNumber)
    _ -> Ok(count_steps(number, 0))
  }
}

fn count_steps(number: Int, n: Int) -> Int {
  case number {
    _ if number == 1 -> n
    _ if number % 2 == 0 -> count_steps(number / 2, n + 1)
    _ if number % 2 != 0 -> count_steps(number * 3 + 1, n + 1)
    _ -> todo
  }
}
