defmodule Storage do
  @name {:global, :storage}

  def start_link do
    Agent.start_link fn -> %{} end, name: @name
  end

  def store(result, number) do # 2! = 1 * 2
    Agent.update @name, fn state -> Map.merge(state, %{number => result}) end
  end

  def factorials do
    Agent.get @name, &(&1)
  end

  def factorial_of(number) do
    Map.get factorials(), number
  end
end

defmodule FactorialProducer do
  def products_of(numbers) do # enum
    numbers |>
    Stream.map(fn number -> Task.async(fn -> fact(number) end) end) |>
    Enum.map(&Task.await/1)
  end

  def fact(number) do
    do_fact(1, number) |> Storage.store(number)
  end

  defp do_fact(result, 0), do: result

  defp do_fact(result, a) do
    result * a |>
    do_fact(a - 1)
  end
end

#Storage.start_link
#FactorialProducer.products_of 1..10
#Storage.factorials() |> IO.inspect
#Storage.factorial_of(10) |> IO.inspect
