defmodule Demo do
  def run(argv) do
    parsed_args = OptionParser.parse(argv, switches:  [debug: :boolean])
    case Keyword.fetch( elem(parsed_args, 0), :debug ) do
      {:ok, true} -> "debug!"
      {:ok, false} -> "no debug!"
      _ -> "debug option is not set!" # fallback clause
    end
  end
end

Demo.run(System.argv) |> IO.inspect
