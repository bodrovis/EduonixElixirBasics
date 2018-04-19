list = [1, "hi",  :atom]
IO.puts length(list)
IO.puts Enum.at(list, 1)
IO.puts hd(list)
IO.inspect tl(list)
IO.puts "==========="
IO.inspect [1 | [2 | [3 | [] ] ]]
IO.inspect [1,2,3]
IO.puts "==========="
list = [ 100 | list ]
IO.inspect list
