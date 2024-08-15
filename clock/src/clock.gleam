import gleam/float
import gleam/int
import gleam/result
import gleam/string

pub type Clock {
  Clock(hour: Int, minute: Int)
}

pub fn create(hour hour: Int, minute minute: Int) -> Clock {
  let minutes: Int = hour * 60 + minute
  case minutes > 0 {
    True -> add(Clock(hour: 0, minute: 0), minutes)
    False -> add(Clock(hour: 24, minute: 0), minutes)
  }
}

pub fn add(clock: Clock, minutes minutes: Int) -> Clock {
  let minutes: Int = clock.hour * 60 + clock.minute + minutes

  Clock(
    hour: int.modulo(
      { { minutes |> int.to_float } /. 60.0 }
        |> float.floor
        |> float.truncate,
      24,
    )
      |> result.unwrap(0),
    minute: int.modulo(minutes, 60) |> result.unwrap(0),
  )
}

pub fn subtract(clock: Clock, minutes minutes: Int) -> Clock {
  let minutes: Int = clock.hour * 60 + clock.minute - minutes
  Clock(
    hour: int.modulo(
      { { minutes |> int.to_float } /. 60.0 }
        |> float.floor
        |> float.truncate,
      24,
    )
      |> result.unwrap(0),
    minute: int.modulo(minutes, 60) |> result.unwrap(0),
  )
}

pub fn display(clock: Clock) -> String {
  { clock.hour |> int.to_string |> string.pad_left(to: 2, with: "0") }
  <> ":"
  <> { clock.minute |> int.to_string |> string.pad_left(to: 2, with: "0") }
}
