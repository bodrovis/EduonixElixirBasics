defmodule MyApp.Calc do
  #import IO
  alias IO, as: DemoIO
  def plus(a, b) do
    a + b
  end

  # def plus(a,b), do: a + b

  def mult(a, b) do
    #MyApp.Calc.do_some_priv_stuff
    do_some_priv_stuff()
    a * b
  end

  defp do_some_priv_stuff do
    # Kernel
    [1,2,3] |> length |> DemoIO.puts
  end
end
