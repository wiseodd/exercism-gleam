import gleam/bit_array
import gleam/io
import gleam/list
import gleam/result

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine -> 0
    Cytosine -> 1
    Guanine -> 2
    Thymine -> 3
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    _ if nucleotide == 0 -> Ok(Adenine)
    _ if nucleotide == 1 -> Ok(Cytosine)
    _ if nucleotide == 2 -> Ok(Guanine)
    _ if nucleotide == 3 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  dna
  |> list.map(fn(nucleotide) { <<encode_nucleotide(nucleotide):2>> })
  |> bit_array.concat
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  let res: List(Result(Nucleotide, Nil)) = map_dna(dna)
  case res |> list.find(fn(x) { x |> result.is_error }) {
    Ok(_) -> Error(Nil)
    Error(_) -> Ok(res |> list.map(fn(x) { x |> result.unwrap(Adenine) }))
  }
}

fn map_dna(dna: BitArray) -> List(Result(Nucleotide, Nil)) {
  case dna {
    <<val:2>> ->
      case decode_nucleotide(val) {
        Ok(nucleotide) -> [Ok(nucleotide)]
        Error(Nil) -> [Error(Nil)]
      }
    <<val:2, rest:bits>> ->
      case decode_nucleotide(val) {
        Ok(nucleotide) -> [Ok(nucleotide), ..map_dna(rest)]
        Error(Nil) -> [Error(Nil), ..map_dna(rest)]
      }
    _ -> [Error(Nil)]
  }
}
