import gleam/list

pub fn square_of_sum(n: Int) -> Int {
  let sum = list.fold(list.range(1, n), 0, fn(b, a) { b + a })
  sum * sum
}

pub fn sum_of_squares(n: Int) -> Int {
  list.fold(list.range(1, n), 0, fn(x: Int, y: Int) { x + y * y })
}

pub fn difference(n: Int) -> Int {
  square_of_sum(n) - sum_of_squares(n)
}
