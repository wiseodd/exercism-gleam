pub fn equilateral(a: Float, b: Float, c: Float) -> Bool {
  case test_triangle(a, b, c) {
    True -> { a == b } && { b == c }
    False -> False
  }
}

pub fn isosceles(a: Float, b: Float, c: Float) -> Bool {
  case test_triangle(a, b, c) {
    True -> { a == b } || { b == c } || { c == a }
    False -> False
  }
}

pub fn scalene(a: Float, b: Float, c: Float) -> Bool {
  case test_triangle(a, b, c) {
    True -> !isosceles(a, b, c)
    False -> False
  }
}

fn test_triangle(a: Float, b: Float, c: Float) -> Bool {
  { a >. 0.0 }
  && { b >. 0.0 }
  && { c >. 0.0 }
  && { a +. b >=. c }
  && { b +. c >=. a }
  && { a +. c >=. b }
}
