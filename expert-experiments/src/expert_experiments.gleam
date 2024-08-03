import gleam/result

pub fn with_retry(experiment: fn() -> Result(t, e)) -> Result(t, e) {
  case experiment() {
    Ok(res) -> Ok(res)
    Error(_) -> experiment()
  }
}

pub fn record_timing(
  time_logger: fn() -> Nil,
  experiment: fn() -> Result(t, e),
) -> Result(t, e) {
  time_logger()
  let ret = experiment()
  time_logger()
  ret
}

pub fn run_experiment(
  name: String,
  setup: fn() -> Result(t, e),
  action: fn(t) -> Result(u, e),
  record: fn(t, u) -> Result(v, e),
) -> Result(#(String, v), e) {
  use res_setup: t <- result.try(setup())
  use res_action: u <- result.try(action(res_setup))
  use res_record: v <- result.try(record(res_setup, res_action))
  Ok(#(name, res_record))
}
