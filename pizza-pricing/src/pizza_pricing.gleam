pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  case pizza {
    Margherita -> 7
    Caprese -> 9
    Formaggio -> 10
    ExtraSauce(base) -> 1 + pizza_price(base)
    ExtraToppings(base) -> 2 + pizza_price(base)
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  let total_price: Int = sum_order_price(order, 0)
  case order {
    [_] -> 3 + total_price
    [_, _] -> 2 + total_price
    _ -> total_price
  }
}

fn sum_order_price(order: List(Pizza), accumulator: Int) -> Int {
  case order {
    [] -> accumulator
    [pizza, ..rest] -> sum_order_price(rest, accumulator + pizza_price(pizza))
  }
}
