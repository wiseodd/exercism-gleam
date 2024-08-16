import gleam/dict.{type Dict}
import gleam/list
import gleam/string

pub fn transform(legacy: Dict(Int, List(String))) -> Dict(String, Int) {
  let to_tuple = fn(key: Int, vals: List(String)) -> List(#(String, Int)) {
    vals
    |> list.map(fn(v: String) -> #(String, Int) {
      #(v |> string.lowercase, key)
    })
  }

  list.map2(legacy |> dict.keys, legacy |> dict.values, to_tuple)
  |> list.flatten
  |> dict.from_list
}
