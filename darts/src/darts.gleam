import gleam/float
import gleam/result

pub fn score(x: Float, y: Float) -> Int {
  let r: Float =
    { x *. x +. y *. y } |> float.square_root |> result.unwrap(1000.0)

  case r {
    _ if r <=. 1.0 -> 10
    _ if r <=. 5.0 -> 5
    _ if r <=. 10.0 -> 1
    _ -> 0
  }
}
