defmodule Demo do
  def run(str) do
    len = String.length(str)
    cond do
      len > 0 && len < 5 -> "short"
      len >= 5 && len < 10 -> "medium"
      len > 10 -> "long"
      true -> "an empty string..." # fallback clause
    end
  end
end

Demo.run("") |> IO.inspect
