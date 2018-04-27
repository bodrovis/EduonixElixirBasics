defmodule Calc do
  def fact(0), do: 1
  def fact(a), do: a * fact(a-1)
end

defmodule ListUtils do
  def map([], _fun), do: []

  def map([head | tail], fun) do
    [ fun.(head) | map(tail, fun) ]
  end

  def mult([]), do: 1

  def mult([head | tail]) do
    head * mult(tail)
  end
end

ListUtils.map([2,3,4], &(&1 * 3)) |>
IO.inspect
