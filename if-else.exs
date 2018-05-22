defmodule Demo do
  def run do
    val = 5
    #if nil, do: "positive", else: "negative"
    #if val == 5 do
    unless val == 5 do
      "the value is not 5"
    else
      "the value is 5"
    end
  end
end

Demo.run |> IO.inspect
