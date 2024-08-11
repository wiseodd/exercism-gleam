pub fn append(first first: List(a), second second: List(a)) -> List(a) {
  first |> reverse |> do_append(second)
}

fn do_append(first_reversed: List(a), second: List(a)) -> List(a) {
  case first_reversed {
    [] -> second
    [x, ..rest] -> do_append(rest, [x, ..second])
  }
}

pub fn concat(lists: List(List(a))) -> List(a) {
  do_concat(lists, [])
}

fn do_concat(lists: List(List(a)), accumulator: List(a)) -> List(a) {
  case lists {
    [] -> accumulator
    [lst, ..rest] -> do_concat(rest, append(accumulator, lst))
  }
}

pub fn filter(list: List(a), function: fn(a) -> Bool) -> List(a) {
  do_filter(list, function, [])
}

fn do_filter(
  list: List(a),
  function: fn(a) -> Bool,
  accumulator: List(a),
) -> List(a) {
  case list {
    [] -> reverse(accumulator)
    [x, ..rest] ->
      case function(x) {
        True -> do_filter(rest, function, [x, ..accumulator])
        False -> do_filter(rest, function, accumulator)
      }
  }
}

pub fn length(list: List(a)) -> Int {
  do_length(list, 0)
}

fn do_length(list: List(a), accumulator: Int) -> Int {
  case list {
    [] -> accumulator
    [_, ..rest] -> do_length(rest, accumulator + 1)
  }
}

pub fn map(list: List(a), function: fn(a) -> b) -> List(b) {
  do_map(list, function, [])
}

fn do_map(list: List(a), function: fn(a) -> b, accumulator: List(b)) -> List(b) {
  case list {
    [] -> reverse(accumulator)
    [x, ..rest] -> do_map(rest, function, [function(x), ..accumulator])
  }
}

pub fn foldl(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  case list {
    [] -> initial
    [x, ..rest] -> foldl(rest, function(initial, x), function)
  }
}

pub fn foldr(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  list |> reverse |> foldl(initial, function)
}

pub fn reverse(list: List(a)) -> List(a) {
  do_reverse(list, [])
}

fn do_reverse(list: List(a), accumulator: List(a)) -> List(a) {
  case list {
    [] -> accumulator
    [x, ..rest] -> do_reverse(rest, [x, ..accumulator])
  }
}
