pub fn is_leap_year(year: Int) -> Bool {
  case year {
    i if i % 100 == 0 && i % 400 != 0 -> False
    i if i % 4 == 0 -> True
    _ -> False
  }
}
