import gleam/result

pub type Player {
  Black
  White
}

pub type Game {
  Game(
    white_captured_stones: Int,
    black_captured_stones: Int,
    player: Player,
    error: String,
  )
}

pub fn apply_rules(
  game: Game,
  rule1: fn(Game) -> Result(Game, String),
  rule2: fn(Game) -> Game,
  rule3: fn(Game) -> Result(Game, String),
  rule4: fn(Game) -> Result(Game, String),
) -> Game {
  case game |> rule1 |> result.try(rule3) |> result.try(rule4) {
    Ok(resulting_game) -> {
      let resulting_game = rule2(resulting_game)
      let next_player = case resulting_game.player {
        Black -> White
        White -> Black
      }
      Game(..resulting_game, player: next_player)
    }
    Error(msg) -> Game(..game, error: msg)
  }
}
