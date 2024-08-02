fn map(result: List(b), list: List(a), fun: fn(a) -> b) -> List(b) {
  case list {
    [] -> result
    [head, ..rest] -> [fun(head), ..map(result, rest, fun)]
  }
}

pub fn accumulate(list: List(a), fun: fn(a) -> b) -> List(b) {
  map([], list, fun)
}
