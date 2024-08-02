import gleam/list
import gleam/set.{type Set}
import gleam/string

pub fn new_collection(card: String) -> Set(String) {
  [card] |> set.from_list
}

pub fn add_card(collection: Set(String), card: String) -> #(Bool, Set(String)) {
  case collection |> set.contains(card) {
    True -> #(True, collection)
    False -> #(False, collection |> set.insert(card))
  }
}

pub fn trade_card(
  my_card: String,
  their_card: String,
  collection: Set(String),
) -> #(Bool, Set(String)) {
  let can_trade: Bool =
    !{ collection |> set.contains(their_card) }
    && collection |> set.contains(my_card)

  #(can_trade, collection |> set.insert(their_card) |> set.drop([my_card]))
}

pub fn boring_cards(collections: List(Set(String))) -> List(String) {
  case collections {
    [] -> []
    [first, ..rest] -> rest |> list.fold(first, set.intersection) |> set.to_list
  }
}

pub fn total_cards(collections: List(Set(String))) -> Int {
  collections |> list.fold(set.new(), set.union) |> set.size
}

pub fn shiny_cards(collection: Set(String)) -> Set(String) {
  collection
  |> set.filter(fn(card: String) { card |> string.starts_with("Shiny ") })
}
