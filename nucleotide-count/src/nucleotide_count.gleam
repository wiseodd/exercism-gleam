import gleam/dict.{type Dict}
import gleam/list
import gleam/string

pub fn nucleotide_count(dna: String) -> Result(Dict(String, Int), Nil) {
  let strand: List(String) = dna |> string.to_graphemes
  let ok: Bool =
    strand
    |> list.all(fn(x) { x == "A" || x == "T" || x == "G" || x == "C" })

  case ok {
    True -> Ok(do_count(strand, "ATGC" |> string.to_graphemes, dict.new()))
    False -> Error(Nil)
  }
}

fn do_count(
  dna: List(String),
  nucs: List(String),
  accumulator: Dict(String, Int),
) -> Dict(String, Int) {
  case nucs {
    [] -> accumulator
    [nuc, ..rest] -> {
      let n: Int = dna |> list.count(fn(x) { x == nuc })
      do_count(dna, rest, accumulator |> dict.insert(nuc, n))
    }
  }
}
