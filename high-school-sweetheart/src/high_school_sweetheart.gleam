import gleam/list
import gleam/result
import gleam/string

pub fn first_letter(name: String) {
  name |> string.trim |> string.first |> result.unwrap("")
}

pub fn initial(name: String) {
  first_letter(name) |> string.uppercase <> "."
}

pub fn initials(full_name: String) {
  full_name
  |> string.split(" ")
  |> list.map(fn(name) { initial(name) })
  |> string.join(" ")
}

pub fn pair(full_name1: String, full_name2: String) {
  "\n     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **" <> "
**     " <> full_name1 |> initials <> "  +  " <> full_name2 |> initials <> "     **" <> "
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
"
}
