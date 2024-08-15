import gleam/io
import gleam/list
import gleam/string

pub type Student {
  Alice
  Bob
  Charlie
  David
  Eve
  Fred
  Ginny
  Harriet
  Ileana
  Joseph
  Kincaid
  Larry
}

pub type Plant {
  Radishes
  Clover
  Violets
  Grass
}

pub fn plants(diagram: String, student: Student) -> List(Plant) {
  let rows: List(String) = diagram |> string.split("\n")

  case rows {
    [row1, row2] -> {
      let idx: Int = student2index(student)
      [row1 |> string.slice(idx, 2), row2 |> string.slice(idx, 2)]
      |> string.join("")
      |> string.to_graphemes
      |> list.map(string2plant)
    }
    _ -> todo
  }
}

fn student2index(student: Student) -> Int {
  case student {
    Alice -> 0
    Bob -> 2
    Charlie -> 4
    David -> 6
    Eve -> 8
    Fred -> 10
    Ginny -> 12
    Harriet -> 14
    Ileana -> 16
    Joseph -> 18
    Kincaid -> 20
    Larry -> 22
  }
}

fn string2plant(plant_str: String) -> Plant {
  case plant_str {
    "G" -> Grass
    "C" -> Clover
    "R" -> Radishes
    "V" -> Violets
    _ -> todo
  }
}
