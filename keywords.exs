defmodule Demo do
  def access do
    #keyword() |> Keyword.get(:color)
    keyword() |> Keyword.get_values(:size)
  end
  def keyword do
    [color: :red, size: 10, size: 400]
    # [ {:color, :red}, {:size, 10} ]
  end
end

Demo.access |> IO.inspect
