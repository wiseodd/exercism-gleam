import gleam/list

pub fn wines_of_color(wines: List(Wine), color: Color) -> List(Wine) {
  case wines {
    [] -> []
    [wine, ..rest] ->
      case wine.color == color {
        True -> [wine, ..wines_of_color(rest, color)]
        False -> wines_of_color(rest, color)
      }
  }
}

pub fn wines_from_country(wines: List(Wine), country: String) -> List(Wine) {
  list.filter(wines, keeping: fn(wine: Wine) { wine.country == country })
}

pub fn filter(
  wines: List(Wine),
  color color: Color,
  country country: String,
) -> List(Wine) {
  list.filter(wines, keeping: fn(wine: Wine) {
    wine.color == color && wine.country == country
  })
}

pub type Wine {
  Wine(name: String, year: Int, country: String, color: Color)
}

pub type Color {
  Red
  Rose
  White
}
