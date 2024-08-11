import gleam/list

pub type Tree {
  Nil
  Node(data: Int, left: Tree, right: Tree)
}

pub fn to_tree(data: List(Int)) -> Tree {
  do_to_tree(data, Nil)
}

fn do_to_tree(data: List(Int), tree: Tree) -> Tree {
  case data {
    [] -> tree
    [x, ..rest] -> do_to_tree(rest, insert(tree, x))
  }
}

pub fn sorted_data(data: List(Int)) -> List(Int) {
  data |> to_tree |> dfs_inorder
}

fn dfs_inorder(tree: Tree) -> List(Int) {
  case tree {
    Nil -> []
    Node(val, left, right) ->
      list.concat([dfs_inorder(left), [val], dfs_inorder(right)])
  }
}

fn insert(tree: Tree, x: Int) -> Tree {
  case tree {
    Nil -> Node(x, Nil, Nil)
    Node(val, left, right) ->
      case x <= val {
        True -> Node(val, insert(left, x), right)
        False -> Node(val, left, insert(right, x))
      }
  }
}
