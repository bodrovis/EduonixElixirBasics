{ :ok, pid } = Agent.start fn -> 42 end
Agent.get(pid, &(&1)) |> IO.puts
Agent.update(pid, &(&1 * 2))
Agent.get(pid, &(&1)) |> IO.puts
