import gleam/string

pub type Robot {
  Robot(direction: Direction, position: Position)
}

pub type Direction {
  North
  East
  South
  West
}

pub type Position {
  Position(x: Int, y: Int)
}

pub fn create(direction: Direction, position: Position) -> Robot {
  Robot(direction:, position:)
}

pub fn move(
  direction: Direction,
  position: Position,
  instructions: String,
) -> Robot {
  do_move(create(direction, position), instructions |> string.to_graphemes)
}

fn do_move(robot: Robot, instructions: List(String)) -> Robot {
  case instructions {
    [] -> robot
    [action, ..rest] ->
      case action {
        "R" -> {
          let new_direction: Direction = case robot.direction {
            North -> East
            East -> South
            South -> West
            West -> North
          }
          do_move(Robot(new_direction, robot.position), rest)
        }
        "L" -> {
          let new_direction: Direction = case robot.direction {
            North -> West
            West -> South
            South -> East
            East -> North
          }
          do_move(Robot(new_direction, robot.position), rest)
        }
        "A" -> {
          let new_position: Position = case robot.direction {
            North -> Position(robot.position.x, robot.position.y + 1)
            East -> Position(robot.position.x + 1, robot.position.y)
            South -> Position(robot.position.x, robot.position.y - 1)
            West -> Position(robot.position.x - 1, robot.position.y)
          }
          do_move(Robot(robot.direction, new_position), rest)
        }
        _ -> do_move(robot, [])
      }
  }
}
