value = %{ "language" => "Elixir", "platform" => "Eduonix" }
value = %{ language: "Elixir", platform: "Eduonix" }
IO.puts value[:language]
IO.puts value.platform
IO.inspect value[:non_existent]
#IO.inspect value.non_existent
new_value = %{ value | language: "Erlang", platform: "IDK" }
IO.inspect new_value
