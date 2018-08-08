defmodule GameOfStones.Server do
  @moduledoc """
  Documentation for GameOfStones.
  """

  use GenServer, restart: :transient
  @server_name __MODULE__

  @doc """
  Hello world.

  ## Examples

      iex> GameOfStones.hello()
      :world

  """

  # Interface functions
  def start_link(_) do
    # :started
    # :game_in_progress
    # :game_ended
    IO.puts "Starting Game of Stones server..."
    GenServer.start_link @server_name, :started, name: @server_name
  end

  def set_stones(initial_stones_num) do
    GenServer.call @server_name, {:set_stones, initial_stones_num}
  end

  def take(num_stones) do
    GenServer.call @server_name, {:take, num_stones}
  end

  # Callbacks
  def init(:started) do
    state = case GameOfStones.Storage.fetch do
      nil -> {1, 0, :started}
      saved_state -> saved_state
    end
    IO.puts "grabbing the saved state..."
    state |> IO.inspect
    { :ok, state }
  end

  def handle_call({:set_stones, _},  _, {player, num_stones, :game_in_progress} = current_state) do
    {:reply, {player, num_stones, :game_continue}, current_state}
  end

  def handle_call({:set_stones, initial_stones_num},  _, {player, _, :started}) do
    new_state = {player, initial_stones_num, :game_in_progress}
    new_state |> GameOfStones.Storage.store
    { :reply, new_state, new_state }
  end

  def handle_call({:take, num_stones}, _, {player, current_stones, :game_in_progress}) do
    reply = do_take {player, num_stones, current_stones}
    elem(reply, 2) |> GameOfStones.Storage.store
    reply
  end

  #def terminate(_, _)  do
  #  "See you soon!" |> IO.puts
  #end

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
      {player, current_stones, :game_in_progress}
    }
  end

  defp do_take({player, num_stones, current_stones}) when
  num_stones == current_stones do
    GameOfStones.Storage.fetch_all |> IO.inspect
    { :stop, :normal, {:winner, next_player(player)}, {nil, 0, :game_ended} }
  end

  defp do_take({player, num_stones, current_stones}) do
    next_p = next_player(player)
    new_stones = current_stones - num_stones
    { :reply, {:next_turn, next_p, new_stones}, {next_p,  new_stones, :game_in_progress} }
  end

  defp next_player(1), do: 2
  defp next_player(2), do: 1
end
