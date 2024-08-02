import gleam/dict.{type Dict}
import gleam/option

pub type ScoreBoard =
  Dict(String, Int)

pub fn create_score_board() -> ScoreBoard {
  dict.from_list([#("The Best Ever", 1_000_000)])
}

pub fn add_player(
  score_board: ScoreBoard,
  player: String,
  score: Int,
) -> ScoreBoard {
  dict.insert(score_board, player, score)
}

pub fn remove_player(score_board: ScoreBoard, player: String) -> ScoreBoard {
  score_board |> dict.drop([player])
}

pub fn update_score(
  score_board: ScoreBoard,
  player: String,
  points: Int,
) -> ScoreBoard {
  case score_board |> dict.has_key(player) {
    True ->
      score_board
      |> dict.upsert(update: player, with: fn(p: option.Option(Int)) {
        case p {
          option.Some(current_points) -> current_points + points
          option.None -> points
        }
      })
    False -> score_board
  }
}

pub fn apply_monday_bonus(score_board: ScoreBoard) -> ScoreBoard {
  score_board
  |> dict.map_values(fn(_player: String, points: Int) { points + 100 })
}
