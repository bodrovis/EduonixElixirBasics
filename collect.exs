defmodule Demo do
  def work do
    spawn fn ->
      receive do
        {sender, num} ->
          :timer.sleep 5000
          send sender, num * :rand.uniform()
      end
    end
  end

  def run do
    1..5 |> Enum.each(fn(i) ->
      pid = work()
      send pid, {self(), i}
    end)

    1..5 |> Enum.map( fn(_) -> response() end)
  end

  defp response do
    receive do
      result -> result
    end
  end
end

Demo.run |> IO.inspect
