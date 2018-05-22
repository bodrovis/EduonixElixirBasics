defmodule Demo do
  def run do
    try do
      exit :idk
    catch
      :exit, :very_bad -> "exited due smth very bad"
      :exit, _ -> "exited due smth VERY-VERY bad"
    end
  end
end

Demo.run |> IO.inspect
