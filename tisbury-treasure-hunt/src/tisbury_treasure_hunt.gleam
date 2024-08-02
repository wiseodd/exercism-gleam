import gleam/bool
import gleam/list

pub fn place_location_to_treasure_location(
  place_location: #(String, Int),
) -> #(Int, String) {
  let #(str, int) = place_location
  #(int, str)
}

pub fn treasure_location_matches_place_location(
  place_location: #(String, Int),
  treasure_location: #(Int, String),
) -> Bool {
  place_location_to_treasure_location(place_location) == treasure_location
}

pub fn count_place_treasures(
  place: #(String, #(String, Int)),
  treasures: List(#(String, #(Int, String))),
) -> Int {
  treasures
  |> list.fold(from: 0, with: fn(sum, x) {
    sum + bool.to_int(treasure_location_matches_place_location(place.1, x.1))
  })
}

pub fn special_case_swap_possible(
  found_treasure: #(String, #(Int, String)),
  place: #(String, #(String, Int)),
  desired_treasure: #(String, #(Int, String)),
) -> Bool {
  case found_treasure.0, place.0, desired_treasure.0 {
    "Brass Spyglass", "Abandonded Lighthouse", _ -> True
    "Amethyst Octopus", "Stormy Breakwater", x
      if x == "Crystal Crab" || x == "Glass Starfish"
    -> True
    "Vintage Pirate Hat", "Harbor Managers Office", x
      if x == "Antique Glass Fishnet Float" || x == "Model Ship in Large Bottle"
    -> True
    _, _, _ -> False
  }
}
