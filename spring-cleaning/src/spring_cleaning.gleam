import gleam/string

pub fn extract_error(problem: Result(a, b)) -> b {
  let assert Error(msg) = problem
  msg
}

pub fn remove_team_prefix(team: String) -> String {
  let assert [_, ..rest] = string.split(team, on: " ")
  rest |> string.join(" ")
}

pub fn split_region_and_team(combined: String) -> #(String, String) {
  let assert [region, team] = combined |> string.split(",")
  #(region, remove_team_prefix(team))
}
