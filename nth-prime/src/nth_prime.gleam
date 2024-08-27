import gleam/bool
import gleam/io

pub fn prime(number: Int) -> Result(Int, Nil) {
  use <- bool.guard(number < 1, Error(Nil))
  Ok(get_nth_primes(number, 2, 0))
}

fn get_nth_primes(n: Int, start: Int, count: Int) -> Int {
  case count == n {
    True -> start - 1
    False ->
      case is_prime(start, 2) {
        True -> get_nth_primes(n, start + 1, count + 1)
        False -> get_nth_primes(n, start + 1, count)
      }
  }
}

fn is_prime(number: Int, divisor: Int) -> Bool {
  case number {
    _ if number == 0 || number == 1 -> False
    _ if number == divisor -> True
    _ if number % divisor == 0 -> False
    _ -> is_prime(number, divisor + 1)
  }
}

pub fn main() {
  is_prime(7, 2) |> io.debug
}
