import gleam/bool
import gleam/list
import gleam/result

pub fn today(days: List(Int)) -> Int {
  days |> list.first |> result.unwrap(0)
}

pub fn increment_day_count(days: List(Int)) -> List(Int) {
  let increment = 1 + { days |> today }
  case days {
    [] -> [1]
    [_] -> [increment]
    [_, ..rest] -> [increment, ..rest]
  }
}

pub fn has_day_without_birds(days: List(Int)) -> Bool {
  !{ days |> list.fold(from: True, with: fn(truth, x) { truth && { x != 0 } }) }
}

pub fn total(days: List(Int)) -> Int {
  days |> list.fold(from: 0, with: fn(sum, x) { sum + x })
}

pub fn busy_days(days: List(Int)) -> Int {
  days |> list.fold(from: 0, with: fn(count, x) { count + bool.to_int(x >= 5) })
}
