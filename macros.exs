defmodule Demo do
  defmacro work(argument) do
    #argument
    quote do
      argument * 10
    end
  end
end

defmodule Playground do
  require Demo

  def test! do
    #Demo.work({1,2,3,4,5}) |> elem(2) |> IO.inspect
    Demo.work(2)|> IO.inspect
  end
end

Playground.test!
