tuple = {:ok, "hi", 10}
IO.puts elem(tuple, 0)
new_tuple = put_elem(tuple, 2, 5)
IO.inspect new_tuple
