defmodule GameOfStones.Storage do
  use GenServer, restart: :transient

  @server_name :storage
  @ets_name :game_of_stones_storage

  def start_link(_)  do
    GenServer.start_link __MODULE__, nil, name: @server_name
  end

  def init(_) do
    :ets.new @ets_name, [ :ordered_set, :private, :named_table, {:keypos, 2} ]
    { :ok, nil }
  end

  def store(data) do
    IO.puts "storing data..."
    data |> IO.inspect
    GenServer.call @server_name, {:store, data}
  end

  def fetch do
    GenServer.call @server_name, :fetch
  end

  def fetch_all do
    GenServer.call @server_name, :fetch_all
  end

  def handle_call(:fetch, _, current_state) do
    {:reply, current_state, current_state}
  end

  def handle_call(:fetch_all, _, current_state) do
    { :reply, :ets.tab2list(@ets_name), current_state }
  end

  def handle_call({:store, {:winner, _}}, _, _current_state) do
    IO.puts "deleting..."
    :ets.delete_all_objects @ets_name
    {:reply, nil, nil}
  end

  def handle_call({:store, data}, _, _current_state) do
    :ets.insert @ets_name, data
    {:reply, data, data}
  end
end
