defmodule GameOfStones.Client do
  def main(argv) do
    parse(argv) |> play
  end

  def play(initial_stones_num \\ 30) do
    initial_stones_num |> GameOfStones.Server.start
    start_game!()
  end

  defp parse(arguments) do
    {opts, _, _} = OptionParser.parse( arguments, switches: [stones: :integer] )
    opts |> Keyword.get(:stones, 30)
  end

  defp start_game! do
    case GameOfStones.Server.stats do
      {player, current_stones} ->
        IO.puts "Welcome!  It's player #{player} turn. #{current_stones} in the pile." |>
        Colors.green
    end

    take()
  end

  defp take do
    case GameOfStones.Server.take( ask_stones() ) do
      {:next_turn, next_player, stones_count} ->
        IO.puts "\nPlayer #{next_player}  turns next. Stones: #{stones_count}"
        take()
      {:winner, winner} ->
        IO.puts "\nPlayer #{winner} wins!!!"
      {:error, reason} ->
        IO.puts "\nThere was an error: #{reason}"
        take()
    end
  end

  defp ask_stones do
    IO.gets("\nPlease take from 1 to 3 stones:\n") |>
    String.trim |>
    Integer.parse |>
    stones_to_take()
  end

  def stones_to_take({count, _}), do: count
  def stones_to_take(:error), do: 0
end
