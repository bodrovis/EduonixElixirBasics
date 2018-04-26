
salt = "random"

#mad_printer = &(
mad_printer = fn
  ("") -> IO.puts("__NOVAL__")
  (initial_string) ->
    initial_string <> salt |>
    String.reverse |>
    IO.puts
end
#)

salt = "NEW VALUE HERE"

#Enum.each ["hello", "there", "friend"], &IO.puts/1
Enum.each ["hello", "there", "", "friend"], mad_printer
#mad_printer.("hello there friend!")
