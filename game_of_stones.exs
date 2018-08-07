defmodule GameOfStones.GameClient do
  def play(initial_stones_num \\ 30) do
    initial_stones_num |> GameOfStones.GameServer.start
    start_game!()
  end

  defp start_game! do
    case GameOfStones.GameServer.stats do
      {player, current_stones} ->
        IO.puts "Welcome!  It's player #{player} turn. #{current_stones} in the pile."
    end

    take()
  end

  defp take do
    case GameOfStones.GameServer.take( ask_stones() ) do
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

defmodule GameOfStones.GameServer do
  use GenServer
  @server_name __MODULE__

  # Interface functions
  def start(initial_stones_num \\ 30) do
    GenServer.start @server_name, initial_stones_num, name: @server_name
  end

  def stats do
    GenServer.call @server_name, :stats
  end

  def take(num_stones) do
    GenServer.call @server_name, {:take, num_stones}
  end

  # Callbacks
  def init(initial_stones_num) do
    { :ok,  {1, initial_stones_num} }
  end

  def handle_call(:stats,  _, current_state) do
    { :reply, current_state, current_state }
  end

  def handle_call({:take, num_stones}, _, {player, current_stones}) do
    do_take {player, num_stones, current_stones}
  end

  def terminate(_, _)  do
    "See you soon!" |> IO.puts
  end

  # Privates

  defp do_take({player, num_stones, current_stones}) when
  not is_integer(num_stones) or
  num_stones < 1 or
  num_stones > 3 or
  num_stones > current_stones do
    {
      :reply,
      {
        :error,
        "You can take from 1 to 3 stones, and it should exceed the total count of stones!"
      },
      {player, current_stones}
    }
  end

  defp do_take({player, num_stones, current_stones}) when
  num_stones == current_stones do
    { :stop, :normal, {:winner, next_player(player)}, {nil, 0} }
  end

  defp do_take({player, num_stones, current_stones}) do
    next_p = next_player(player)
    new_stones = current_stones - num_stones
    { :reply, {:next_turn, next_p, new_stones}, {next_p,  new_stones} }
  end

  defp next_player(1), do: 2
  defp next_player(2), do: 1
end

GameOfStones.GameClient.play(10)
