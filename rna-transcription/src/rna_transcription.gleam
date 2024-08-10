import gleam/list
import gleam/string

pub fn to_rna(dna: String) -> Result(String, Nil) {
  let strand: List(String) = dna |> string.to_graphemes
  case strand |> validate(True) {
    True -> Ok(dna |> string.to_graphemes |> map_dna_rna([]))
    False -> Error(Nil)
  }
}

fn map_dna_rna(dna: List(String), accumulator: List(String)) -> String {
  case dna {
    [] -> accumulator |> list.reverse |> string.join("")
    [nucleotide, ..rest] ->
      map_dna_rna(rest, [complement(nucleotide), ..accumulator])
  }
}

fn validate(dna: List(String), accumulator: Bool) -> Bool {
  case dna {
    [] -> accumulator
    [nuc, ..rest] -> {
      case accumulator {
        False -> False
        True ->
          validate(
            rest,
            accumulator
              && { nuc == "A" || nuc == "T" || nuc == "G" || nuc == "C" },
          )
      }
    }
  }
}

fn complement(dna_nucleotide: String) {
  case dna_nucleotide {
    "G" -> "C"
    "C" -> "G"
    "T" -> "A"
    "A" -> "U"
    _ -> ""
  }
}
