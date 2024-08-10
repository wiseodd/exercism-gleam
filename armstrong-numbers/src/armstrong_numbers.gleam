import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub fn is_armstrong_number(number: Int) -> Bool {
  let digits: List(String) = number |> int.to_string |> string.to_graphemes
  let n: Int = digits |> list.length
  let res: Int =
    digits
    |> list.fold(0, fn(acc: Int, d: String) {
      let x: Int = d |> int.parse |> result.unwrap(0)
      acc + pow(x, n)
    })
  res == number
}

fn pow(x: Int, n: Int) -> Int {
  case n {
    _ if n == 0 -> 1
    _ -> x * pow(x, n - 1)
  }
}
