pub fn reply(guess: Int) -> String {
  case guess {
    i if i == 42 -> "Correct"
    i if i == 41 || i == 43 -> "So close"
    i if i < 41 -> "Too low"
    _ -> "Too high"
  }
}
