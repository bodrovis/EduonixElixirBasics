defmodule Calc do
  def fact(0), do: 1
  def fact(a), do: a * fact(a-1)
end

defmodule ListUtils do
  def alt_max([head | tail]), do: alt_max(tail, head)
  def alt_max([head | tail], current_maximum) when current_maximum < head do
    alt_max tail, head
  end
  def alt_max([head | tail], current_maximum) when current_maximum >= head do
    alt_max tail, current_maximum
  end
  def alt_max([], current_maximum), do: current_maximum

  def max([ current_maximum, head | tail ]) when current_maximum < head do
    max [head | tail]
  end

  def max([ current_maximum, head | tail ]) when current_maximum >= head do
    max [current_maximum | tail]
  end

  def max([current_maximum]), do: current_maximum # found maximum value!

  def map([], _fun), do: []

  def map([head | tail], fun) do
    [ fun.(head) | map(tail, fun) ]
  end

  def mult([]), do: 1

  def mult([head | tail]) do
    head * mult(tail)
  end
end




ListUtils.alt_max([2,3,100,1,50,4]) |>
IO.inspect
