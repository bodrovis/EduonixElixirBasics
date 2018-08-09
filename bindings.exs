defmodule Demo do
  defmacro work(time) do
    #quote bind_quoted: [time: time] do
    another_var = "value from work outside of macro"

    quoted_code = quote do

      another_var = "value from work inside the macro"

      #time |> IO.inspect
      unquote(time) |> IO.inspect
      :timer.sleep 1000
      unquote(time) |> IO.inspect

      IO.inspect another_var
    end

    IO.inspect another_var
    #quoted_code |> Macro.to_string |> IO.inspect

    quoted_code
  end
end

defmodule Playground do
  require Demo

  def test! do
    another_var = "value from test!"
    :os.system_time |> Demo.work
    IO.inspect another_var
  end
end

Playground.test!
