defmodule Demo do
  use GenServer

  # interface function
  def start(initial_state) do
    GenServer.start(__MODULE__, initial_state, name: __MODULE__)
  end

  def sqrt do
    #GenServer.cast(:calculator, :sqrt)
    GenServer.cast(__MODULE__, :sqrt)
  end

  def add(number) do
    GenServer.cast(__MODULE__, {:add, number})
  end

  def result do
    # timeout is 5 seconds
    GenServer.call __MODULE__, :result
  end

  # Synchronous request
  def handle_call(:result, _,  current_state) do
    { :reply, current_state, current_state }
  end

  def terminate(reason, current_state) do
    IO.puts "TERMINATED!"
    reason |> IO.inspect
    current_state |> IO.inspect
  end

  # Asynchronous request
  def handle_cast(:sqrt, current_state) do
    { :noreply, :math.sqrt(current_state) }
  end

  def handle_cast({:add, number}, current_state) do
    { :noreply, current_state + number }
  end

  # Callback is run when the server is started
  def init(initial_state) when is_number(initial_state) do
    "I am started with the state #{initial_state}" |> IO.puts
    { :ok, initial_state }
  end

  def init(_) do
    { :stop, "The initial state is not a number :(" }
  end
end

{:ok, _} = Demo.start(4)
Demo.sqrt |> IO.inspect
Demo.add(10) |> IO.inspect
Demo.result |> IO.inspect
