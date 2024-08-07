import gleam/list

const nonexistent: String = "~NA~"

pub fn proteins(rna: String) -> Result(List(String), Nil) {
  let res: List(String) = rna2protein(rna, [])
  case res |> list.contains(nonexistent) {
    True -> Error(Nil)
    False -> Ok(res)
  }
}

fn rna2protein(rna: String, accumulator: List(String)) -> List(String) {
  case rna {
    "" -> accumulator
    "UAA" <> _ | "UAG" <> _ | "UGA" <> _ -> accumulator
    "AUG" <> rest -> ["Methionine", ..rna2protein(rest, accumulator)]
    "UUU" <> rest | "UUC" <> rest -> [
      "Phenylalanine",
      ..rna2protein(rest, accumulator)
    ]
    "UUA" <> rest | "UUG" <> rest -> [
      "Leucine",
      ..rna2protein(rest, accumulator)
    ]
    "UCU" <> rest | "UCC" <> rest | "UCA" <> rest | "UCG" <> rest -> [
      "Serine",
      ..rna2protein(rest, accumulator)
    ]
    "UAU" <> rest | "UAC" <> rest -> [
      "Tyrosine",
      ..rna2protein(rest, accumulator)
    ]
    "UGU" <> rest | "UGC" <> rest -> [
      "Cysteine",
      ..rna2protein(rest, accumulator)
    ]
    "UGG" <> rest -> ["Tryptophan", ..rna2protein(rest, accumulator)]
    _ -> [nonexistent]
  }
}
